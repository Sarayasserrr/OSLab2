# Simple Antivirus

## About the Project

This is a simple antivirus project made using Bash in Linux.

The script checks the files in a folder. If it finds a file that may be dangerous, it copies the file to the quarantine folder and deletes it from the original folder.

## Files

- `antivirusd.sh`: Checks the files in the folder.
- `restore.sh`: Shows the files in quarantine and lets the user restore or delete them.
- `Makefile`: Helps us run the scripts with simple commands.

## How It Works

The antivirus checks the files when it starts.

It checks the file extension, like `.exe` and `.bat`. It also searches for words like `virus`, `trojan`, and `malware` inside the files.

After that, it waits for the number of seconds we choose. If the folder changes, it checks the files again.

## How to Run

To run the antivirus, use this command:

`make run DIR=test_files QUARANTINE=quarantine INTERVAL=5`

To check the files in quarantine, use:

`make restore DIR=test_files QUARANTINE=quarantine`

## Restore Script

When we run the restore script, it shows the files in quarantine as a list.

We can choose to:

1. Restore a file.
2. Delete a file permanently.
3. Return to the list.

If the quarantine folder is empty, the script shows a message.
