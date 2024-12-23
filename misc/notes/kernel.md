# Kernel Linux

stored in the /lib/modules/<kernel_version> directory.

- uname -r : kernel version
- cat /boot/config-5.11.0-46-generic : kernel config

## modules

- modprobe - program to add and remove modules from the Linux Kernel
- insmod : load ko modules
- lsmod : list installed kernel modules. Read /proc/modules
- modpost : convert O files into Ko files
- modinfo <module_name> : print module info

modprobe versus insmod : modprobe is the intelligent version of insmod. insmod simply adds a module where modprobe looks for any dependency (if that particular module is dependent on any other module) and loads them
