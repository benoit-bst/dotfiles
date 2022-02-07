# process

- /proc/PID : all process info
- cat /proc/PID/status : process status

## Signals

- catch signal : strace -p <PID>

## core dump

set limit

```sh
ulimit -c unlimited (0 to disable)
```

the core dump file is generate in

- /var/lib/systemd/coredump or /var/crash or /var/lib/apport/coredump

load core file with gdb

```sh
gdb -c <file_name>
 ```
