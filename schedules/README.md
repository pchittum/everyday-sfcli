# Scheduling for the Salesforce CLI

## On Mac

Native mac job scheduling is done via `launchd` with configurations going in `.plist` files and then loaded by `launchctl`. 

The plist files in this directory assume the following

- Salesforce CLI is launched using `.sh` scripts
- The `.sh` scripts finish by writing output to stdout
- The scripts have had permissions set using `chmod`
- The scripts are in `/usr/local/bin` or some other location that is in the PATH
- The `.plist` files are located run defining LaunchAgents and placed in `~/Library/LaunchAgents/`
