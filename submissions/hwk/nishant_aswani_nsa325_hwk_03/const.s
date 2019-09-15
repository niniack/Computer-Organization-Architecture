.text
main: 
  lui $t0, 8193 	# 8193 = 0010000000000001
  ori $t0, $t0, 18724 	# 18724 = 0100100100100100
  li  $t1, 536955172
exit:
  li $v0, 10            # code for exit
  syscall               # exit programs