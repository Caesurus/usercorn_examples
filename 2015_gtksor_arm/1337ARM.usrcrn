g_flag = ''

on code 0x8400 do
  g_flag = g_flag .. chr(r3)
  r3 = r1
end

on code 0x8448 do
  print "FLAG: %s" %{g_flag}
end

