$old_path=$path
$env:path+=";C:\ProgramData\intelFPGA_lite\18.0\nios2eds\bin\gnu\H-x86_64-mingw32\bin"
$env:path+=";C:\ProgramData\intelFPGA_lite\18.0\nios2eds\sdk2\bin"
$env:path+=";C:\ProgramData\intelFPGA_lite\18.0\nios2eds\bin"

cd $1
echo "make $2"
make $2

$env:path=$old_path