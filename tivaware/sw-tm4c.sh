## TIVAWARE
# Install GNU toolchain for ARM Cortex-M & Cortex-R processors:
#sudo add-apt-repository ppa:team-gcc-arm-embedded/ppa
sudo apt-get update
#sudo apt-get remove gcc-avr # gg-avr conflict with gcc-arm-embedded
#sudo apt-get install gcc-arm-embedded

# Install the ARM GCC Toolchain
sudo apt install gcc-arm-none-eabi

# Get the flashing tool
git clone https://github.com/utzig/lm4tools.git
cd lm4tools/lm4flash/
make
sudo cp lm4flash /usr/local/bin

# Add rules for USB devices:
echo 'ATTRS{idVendor}=="1cbe", ATTRS{idProduct}=="00fd", GROUP="users", MODE="0660"' | \
sudo tee /etc/udev/rules.d/99-stellaris-launchpad.rules

# Download and extract TivaWare
# http://www.ti.com/tool/sw-tm4c
mkdir TivaWare && cd TivaWare
wget https://dr-download.ti.com/software-development/software-development-kit-sdk/MD-oCcDwnGrsI/2.1.1.71/SW-TM4C-2.1.1.71.exe
unzip SW-TM4C-2.1.1.71.exe
rm SW-TM4C-2.1.1.71.exe

# Test cross-compilation and flashing
cd ~/TivaWare/examples/boards/ek-tm4c123gxl/blinky
make
lm4flash gcc/blinky.bin

# Tivaware export
echo "source ~/MySetup/tivaware/alias.bash" >> ~/.bashrc

