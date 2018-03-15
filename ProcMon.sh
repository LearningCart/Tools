#!/bin/bash
#--------------------------------------------------------------------
# Name: ProcMon.sh
# Desc: Checks if set of process are running.
# Auth: JATIN GANDHI
#--------------------------------------------------------------------

#--------------------------------------------------------------------
# Name: ProcessIsNotRunning
# Desc: Checks if process is running.
# Arg:  Process name.
#--------------------------------------------------------------------
ProcessIsNotRunning()
{
	if [ $1 == "" ]; then
		printf '%-80s' "ProcessIsNotRunning: Invalid Argument" 
		echo ""
		return;
	fi

	if (( $(ps -ef | grep -v grep | grep $1 | wc -l) > 0 )); then
		return 1; 
	else
		return 0;
	fi
}



#--------------------------------------------------------------------
# Name: ShowProcessThreads
# Desc: Show Process threads.
# Arg:  Process name.
#--------------------------------------------------------------------
ShowProcessThreads()
{
	List=(
			"process1"
			"process2"
			"process3"
			"process4"
			"processN"
	     );

	for Application in "${List[@]}" 
	do
		echo $Application
		ps -T -p `pidof $Application`	
	done

}

PrintProcessNames()
{
	List=(
			"process1"
			"process2"
			"process3"
			"process4"
			"processN"
			"tcp2udp"
	     );

	echo "---------------------------------------------------------"
	for Application in "${List[@]}" 
	do
		printf '%-15s' "$Application"
	done
	echo "";

}

#--------------------------------------------------------------------
# Name: ShowProcessRunState
# Desc: Wait for MooN Simulator process to be stable.
# Arg:  Process name.
#--------------------------------------------------------------------
ShowProcessRunState()
{

	PrintProcessNames;
	count=0;
	while :
	do

		((count++));
		for Application in "${List[@]}" 
		do
			if ProcessIsNotRunning $Application; then
				printf '%-15s' ' '
			else
				printf '%-15s' '|'
			fi
		done

		if [[ "$count" -gt 12 ]]; then
			clear;
			PrintProcessNames;
			count=0;
		fi
		echo "";
		#sleep 1;
	done

}

#ShowProcessThreads;
# Begin:
ShowProcessRunState;

