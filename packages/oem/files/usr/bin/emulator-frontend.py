#!/usr/bin/python
import subprocess
subprocess.call("systemd-run /usr/bin/emulator-frontend.sh", shell=True)
