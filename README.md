# usercorn_examples
Example scripts that utilize https://github.com/lunixbochs/usercorn


---

## Examples
### [2018_flareon_six_magic](2018_flareon_six_magic)
 - uses code hooks without `on code <addr> do` directive
 - makes use of instruction count to determine most likely correct input
 - saves and restores register contexts, so that multiple attempts can be made

### [2014_flareon_six](2014_flareon_six)
 - uses instruction count for side channel attack
 - implement local interpreter for reversing asm chunks
 - diff traces to highlight areas of interest
 
### [2015_gtksor_arm](2015_gtksor_arm)
 - ARM: use `on code` to log expected characters in flag
 
### [2018_angstrom_product_key](2018_angstrom_product_key)
 - x86: use `on code` to log expected characters in flag
 
### [ais3_crackme_](ais3_crackme_)
 - x64: use `on code` to log expected characters in flag

