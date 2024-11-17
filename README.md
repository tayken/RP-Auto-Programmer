# RP Auto Programmer

Automatically program your RP2040/RP2350 based boards when they are plugged in
via USB with udev, systemd and bash.

## Usage
1. Copy the `.uf2` file you would like to upload to the project directory.
2. Plug in an RP2040/RP2350 board into your computer and find the partition
name. This will be something like `/dev/sd*1`. Make sure to get the correct
partition name. You can use `dmesg` command to find this information.
3. Test out the script by running `rp-program.sh <partition>` where `<partition>` is
the device name you found in the previous step. If your firmware file gets
copied successfully you can continue. You can unplug the device.
4. Run `make` or `make build` to build the application. This fills the user and
path values in the service template file and bash scripts and copy them to the
`build` folder.
5. Run `sudo make install` to install the polkit rule, the udev rule and the
service template files.
6. When you plug in a new RP2040/RP2350 board into your computer, it'll
automatically get programmed and log files will be put into the `logs` folder.
You can use them to debug any issues.
7. If you need to uninstall, you can do so with `sudo make uninstall`. You can
cleanup the `build` directory with `make clean`.
