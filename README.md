# Post Launch Scripts

Basic Bash QA scripts for quick endpoint checks.

## Usage

Run scripts with `source` from this directory:

```bash
source 01_hello.sh
source 02_args.sh
source 03_env.sh
source 04_file_write.sh
source 05_file_read.sh
source 06_loop.sh
source 07_condition.sh
source 08_function.sh
source 09_http_check.sh
source 10_ping_check.sh
source 11_process_check.sh
source 12_disk_mem.sh
```

## Scripts

- `01_hello.sh`: prints host, user, and time
- `02_args.sh`: prints script path, current directory, and file count
- `03_env.sh`: prints basic environment variables
- `04_file_write.sh`: writes a QA file in `/tmp`
- `05_file_read.sh`: reads the QA file from `/tmp`
- `06_loop.sh`: simple loop output
- `07_condition.sh`: simple conditional check
- `08_function.sh`: basic function usage
- `09_http_check.sh`: HTTP status check with `curl`
- `10_ping_check.sh`: connectivity check with `ping`
- `11_process_check.sh`: checks if `sshd` process exists
- `12_disk_mem.sh`: prints disk and memory usage

## Git

This folder is already inside a git repository.

Stage and commit:

```bash
git add .
git commit -m "Add QA bash scripts and README"
```
