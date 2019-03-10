This script can be used to mask Hostnames and IP address from log files before sending to support as some customers do not allow sharing these details with vendor

To use this file, follow the below instructions

1) Create a directory called "logs" in the same location from which script is running
2) Place all the log files in the "logs" directory from which the IPs and Hostnames need to be masked
3) Create a file containing the list of Hostnames that need to be masked
4) Execute:
	perl sendlogs.pl <node list>

Note: This will read all the files in the "logs" directory and mask all the hostnames provided in the node list file. It will also mask all IP addressed irrespective of whether they are mentioned in node list file or not. It will then create a zip file that can be shared with support teams
