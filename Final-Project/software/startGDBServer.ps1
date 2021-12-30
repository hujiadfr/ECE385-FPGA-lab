$env:path+=";C:\ProgramData\intelFPGA_lite\18.0\quartus\bin64"

nios2-gdb-server --tcpport 2342
#nios2-gdb-server --tcpport 2342
#nohup nios2-gdb-server --tcpport 2342 --tcpdebug 0<&- &>/dev/null &