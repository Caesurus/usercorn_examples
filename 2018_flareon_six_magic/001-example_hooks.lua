-- First example of hooking code with a "on code 0xnnnn do"
on code 0x403a06 do
  -- This code will get run when address 0x403a06 is executed
  print 'Executing %#x' %{rip}
end


-- Can also turn off a section, for instance if in a loop
loop_cnt = 0
on code 0x403a27 do
    print 'Executing %#x' %{rip}
    print 'Loop %d' %{loop_cnt}
    loop_cnt = loop_cnt + 1
    if loop_cnt == 3 then
      -- Once we loop 3 times, turn off this 'on code' section
      off
    end
end

-- You can also define functions
func callback_skip_fgets()
  -- This is where fgets() is called,
  --   rdi has the pointer to the buffer
  --   rax is the retun from fgets() which should be the ptr to the buffer

  -- Fill in the buffer with '-'*0x80
  ptr_buffer = string.rep("-", 70)
  -- Write this string to the buffer
  write rdi ptr_buffer

  -- Step over the fgets() instruction by moving rip to point to the next instruction
  rax = rdi
  -- Increment rip to skip this instruction and avoid call to fgets()
  rip = rip + ins.bytes:len()

  -- Proceed without being bothered to enter password
end

table_hook = {}
-- Another, way to define a hook is to call u.hook_add()
hh = u.hook_add(cpu.HOOK_CODE, callback_skip_fgets, 0x403b23, 0x403b23)

-- Maybe add it to a table so we can delete it later with
table.insert(table_hook, hh)


-- Other examples of what you can do dynamically. The application will decode
-- a function into memory and then execute it to validate inputs
-- placing some code here lets us
on code 0x402f06 do
  if 'call' == ins.name then
    -- read disassembly into a table in order to analyze
    -- call rcx
    func_code = u.dis(rcx, 800)

    addr_start = rcx
    addr_end = 0

    -- now loop through it to find the return instruction
    for idx, instruction in pairs(func_code) do
      if 'ret' == instruction.name then
        addr_end = instruction.addr
        break
      end
    end

    print "Decoded function, start %#x - %#x" %{addr_start, addr_end}

    -- print the function
    dis rcx addr_end - addr_start
  end
end
