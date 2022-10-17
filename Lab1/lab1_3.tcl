#Create an instance of the Simulator class.
set ns [new Simulator]

#Add four nodes n0, n1, n2 and n3.

#Fill in

#Export nam traces

set nf [open lab1_3.nam w]
$ns namtrace-all $nf

#Create 3 (duplex) links (n0-n1, n1-n2, n2-n3)
#with 1Mb bandwidth and 10ms delay per link, including a DropTail queue 

#Fill in

#Define a link orientation

$ns duplex-link-op $n0 $n1 orient right
$ns duplex-link-op $n1 $n2 orient right
$ns duplex-link-op $n2 $n3 orient right
 
#Create a TCP connection from node 1 to node 0
#=============================================
#Create a TCP Agent (tcp0) and attach it to node 1

#Fill in

#Create a Telnet traffic source (telnet0) and attach it to tcp0

#Fill in

#Create a Null TCP agent (null0), acting as a traffic sink. Attach the agent to node 0. Null TCP Agents are of the form Agent/TCPSink.

#Fill in

#Connect tcp0 and null0 agents

#Fill in

#Create a TCP connection from node 2 to node 3
#=============================================
#Create a TCP Agent (tcp1) and attach it to node 2

#Fill in

#Create a FTP traffic source (ftp0) and attach it to tcp1

#Fill in

#Create a Null TCP agent (null1), acting as a traffic sink. Attach the agent to node 3.

#Fill in

#Connect tcp1 and null1 agents

#Fill in


#Create a UDP connection from node 1 to node 2
#=============================================
#Create a UDP Agent (udp0) and attach it to node 1

#Fill in

#Create a CBR traffic source (cbr0) and attach it to udp0
#Set packetSize = 48 bytes (stored in ps variable)
#Set interval time = 0.01 secs (stored in int variable)

#Fill in

#Create a Null agent (null2), acting as traffic sink. Attach the agent to node 2.

#Fill in

#Connect udp0 and null2 agents

#Fill in

#Create a UDP connection from node 2 to node 1
#=============================================
#Create a UDP Agent (udp1) and attach it to node 2

#Fill in

#Create a CBR traffic source (cbr1) and attach it to udp1
#Set packetSize = 48 bytes
#Set interval time = 0.01

#Fill in

#Create a Null agent (null3), acting as a traffic sink. Attach the agent to node 1.

#Fill in

#Connect udp1 and null3 agents

#Fill in

#Schedule event ftp0 to start at 0.5 secs and to stop at 3.0 secs

#Fill in

#Schedule event telnet0 to start at 0.5 secs and to stop at 3.0 secs

#Fill in

#Schedule event cbr0 to start at 3.0 secs and to stop at 4.5 secs

#Fill in

#Schedule event cbr1 to start at 3.5 secs and to stop at 5.0 secs

#Fill in

#Call procedure "finish" at 5.0 secs

#Fill in

#Calculate the packet per second rate of cbr0 traffic

#Fill in

#Calculate the bytes per second rate of cbr0 traffic

#Fill in

#Add a procedure, called "finish"
#Execute nam and exit

proc finish {} {
	puts "running nam..."
	global ns nf
	$ns flush-trace
	close $nf
	exec /usr/local/bin/nam lab1_3.nam &
	exit 0
	}

#Set blue color for class 1 (TCP connections) and red color for class 2 (UDP connections)

#Fill in

#Start the simulator

$ns run
