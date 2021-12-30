$env:path+="C:\ProgramData\intelFPGA_lite\18.0\nios2eds\bin\gnu\H-x86_64-mingw32\bin"

nios2-gdb-server --tcpport 2342
#nios2-gdb-server --tcpport 2342
#nohup nios2-gdb-server --tcpport 2342 --tcpdebug 0<&- &>/dev/null &