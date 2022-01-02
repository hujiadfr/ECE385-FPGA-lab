#Folder where is installed Quartus
Q_INST_FOLDER=“C:\ProgramData\intelFPGA_lite"
Q_Version=18.0
NIOS2_DIR=$Q_INST_FOLDER+"\"+$Q_Version+"\"+"nios2eds"

old_path=$path
$env:path+=";C:\ProgramData\intelFPGA_lite\18.0\nios2eds\bin\gnu\H-x86_64-mingw32\bin"
$env:path+=";C:\ProgramData\intelFPGA_lite\18.0\nios2eds\sdk2\bin"
$env:path+=";C:\ProgramData\intelFPGA_lite\18.0\nios2eds\bin"

BSP_NAME="$1_bsp"
APP_NAME=$1
BSP_DIR=../$BSP_NAME
QUARTUS_PROJECT_DIR=$(find "$(cd ..; pwd)" -maxdepth 4 -name *.qpf | sed -r 's|/[^/]+$||' |sort -u)
echo "--Welcome to my super BSP Generator --"
echo "Searching for your Quartus Project ..."
echo
echo "Found project:" $QUARTUS_PROJECT_DIR

if [ -z "${QUARTUS_PROJECT_DIR}" ]; then
    echo "No quartus project found"
    echo "Please check that exactly 1 .qpf file is presents in folder :"
    echo $(cd ..;pwd)
    echo "ERROR 1 --> ABORT"
    exit 1
fi 

if [ -z "${APP_NAME}" ]; then
    echo "Please run commande name of app as first argument"
    echo "ERROR 2 --> ABORT"
    exit 2
fi 

#Creating Folders for bsp and app
mkdir $BSP_NAME
mkdir $APP_NAME

# --Generating BSP
cd $BSP_NAME
nios2-bsp hal . $QUARTUS_PROJECT_DIR --cpu-name nios2_gen2_0
make

if [ $2="-e" ]; then
    nios2-bsp-editor --settings settings.bsp
fi
# --Generating App using template
cd ../$APP_NAME


# Also make sure that the APP has not been created already.  Check for
# existence of Makefile in the app directory
if [ -f ./Makefile ]
then
    echo "Application has already been created!  Delete Makefile if you want to create a new application makefile"
    exit 1
fi

# Now we also need to go copy the sources for this application to the
# local directory.
# find "${NIOS2_DIR}/examples/software/$TEMPLATE_NAME/" -name '*.c' -or -name '*.h' -or -name 'hostfs*' | xargs -i cp -L {} ./ || {
#         echo "failed during copying example source files"
#         exit 1
# }

# find "${NIOS2_DIR}/examples/software/$TEMPLATE_NAME/" -name 'readme.txt' -or -name 'Readme.txt' | xargs -i cp -L {} ./ || {
#         echo "failed copying readme file"
# }

# if [ -d "${NIOS2_DIR}/examples/software/$TEMPLATE_NAME/system" ]
# then
#         cp -RL "${NIOS2_DIR}/examples/software/$TEMPLATE_NAME/system" . || {
#                 echo "failed during copying project support files"
#                 exit 1
#         }
# fi


# chmod -R +w . || {
#         echo "failed during changing file permissions"
#         exit 1
# }


nios2-app-generate-makefile  --bsp-dir ${BSP_DIR} --set QUARTUS_PROJECT_DIR=${QUARTUS_PROJECT_DIR} --elf-name $1.elf --set OBJDUMP_INCLUDE_SOURCE 1  --src-files main.c --src-files camera.h 

# Sinserly don't understand why but seems like we have to manually add .c source file ...
# So automatically adding Wildcard to Makefile to automate it ;-)
echo
echo ""
echo ""
echo ""
echo ""
sed -i '1s/^/SRC_CONSTOM=$(wildcard *.c)\n/' Makefile
sed -i '1s/^/C_SRCS += $(SRC_CONSTOM)\n/' Makefile


echo "  +------------------------+           +--------------------+"
echo "  | APPLICATION GENERATION |           |   MAGICAL TRICKS   |"
echo "  |       COMPLETED !!     |           |      INSERTED      |"
echo "  +------------------------+           +--------------------+"
echo "            +88 "
echo "             +880 "
echo "             ++88 "
echo "             ++88 "
echo "              +880                         ++ "
echo "              +888                        +88 "
echo "              ++880                      +88 "
echo "              ++888     +++88          +++8 "
echo "              ++8888  +++8880++88    +++88 "
echo "              +++8888+++8880++8888  ++888 "
echo "               ++888++8888+++888888++888 "
echo "               ++88++8888++8888888++888 "
echo "               ++++++888888888888888888 "
echo "                ++++++88888888888888888 "
echo "                ++++++++000888888888888 "
echo "                 +++++++000088888888888 "
echo "                  +++++++00088888888888 "
echo "                   +++++++088888888888 "
echo "                   +++++++088888888888 "
echo "                    +++++++8888888888 "
echo "                    +++++++0088888888 "
echo "                    ++++++0088888888 "
echo "                    +++++0008888888 "
echo "                    #############"




cd ..

$env:path=$old_path