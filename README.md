# iosGenerateCarshLog
The crash and log files are generated based on the dSYM file of the project and the ips file obtained by the mobile phone

1. If you can't find the dSYM file, go to the Build Phases in the TARGETS of your iOS project, click +, select new run script, and copy the contents of the move file in the movedSYM folder into the script. You can see the dSYM file on your computer desktop.

2. Connect the test phone and click Open Recent logs to get the ips file.


3.Put the obtained dSYM and ips files in the corresponding folder, run the sh file on the terminal, and the crash file and log file are generated in the corresponding folder.
