$old_path=$path
$env:path+=";C:\ProgramData\intelFPGA_lite\18.0\nios2eds\bin\gnu\H-x86_64-mingw32\bin"
$env:path+=";C:\ProgramData\intelFPGA_lite\18.0\nios2eds\sdk2\bin"
$env:path+=";C:\ProgramData\intelFPGA_lite\18.0\nios2eds\bin"

nios2-bsp-generate-files --bsp-dir . --settings settings.bsp

$env:path=$old_path