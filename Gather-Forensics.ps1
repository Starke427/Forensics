function Get-CurrentUsers {
  Get-CimInstance -ClassName Win32_ComputerSystem | Select-Object Name, PrimaryOwnerName, Domain
}

function Get-ProcessForensics {
  ps -IncludeUserName | fl Name, ProcessName, Company, StartTime, UserName, Path, Modules
}

$TIMESTAMP = Get-Date -Format "yyyy-MM-dd-HHmm"
$OUTFILE = "C:\ForensicDump_$TIMESTAMP.txt"

echo "### CURRENT ACTIVE USERS ###" > $OUTFILE
Get-CurrentUsers >> $OUTFILE
echo "
### CURRENT NETWORK CONFIGURATION ###" >> $OUTFILE
ipconfig /all >> $OUTFILE
netstat -sp >> $OUTFILE
echo "
### CURRENT LISTENING PORTS ###" >> $OUTFILE
netstat -aon | Select-String LISTENING >> $OUTFILE
echo "
### CURRENT ESTABLISHED CONNECTIONS ###" >> $OUTFILE
netstat -aon | Select-String ESTABLISHED >> $OUTFILE
echo "
### RECENT DNS ENTRIES ###" >> $OUTFILE
ipconfig /displaydns >> $OUTFILE
echo "
### CURRENT RUNNING PROCESSES ###" >> $OUTFILE
Get-ProcessForensics >> $OUTFILE
Write-Host "

A forensic dump has been created in C:\ 
"
