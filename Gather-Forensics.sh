TIMESTAMP=$(date +"%Y-%m-%d-%H%M")
OUTFILE=$HOME/ForensicDump_$TIMESTAMP.txt

echo "### CURRENT ACTIVE USERS ###" > $OUTFILE
who -a >> $OUTFILE
echo "
### CURRENT NETWORK CONFIGURATION ###" >> $OUTFILE
ip -s addr >> $OUTFILE
echo "
### CURRENT LISTENING PORTS ###" >> $OUTFILE
ss -tupna | grep LIST >> $OUTFILE
echo "
### CURRENT ESTABLISHED CONNECTIONS ###" >> $OUTFILE
ss -tupna | grep EST >> $OUTFILE
echo "
### CURRENT RUNNING PROCESSES ###" >> $OUTFILE
ps axjf >> $OUTFILE
cat << EOF

A forensic dump has been created in ~/

EOF
