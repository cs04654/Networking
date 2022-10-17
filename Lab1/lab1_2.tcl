#Create an instance of the Simulator class.
set ns [new Simulator]

#Add four nodes n0, n1, n2 and n3.

set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]
set n3 [$ns node]

#Export nam traces

set nf [open lab1_2.nam w]
$ns namtrace-all $nf

#Create 3 (duplex) links (n0-n1, n0-n2, n0-n3)
#with 1Mb bandwidth and 10ms delay per link, including a DropTail queue 

$ns duplex-link $n0 $n1 1Mb 10ms DropTail
$ns duplex-link $n0 $n2 1Mb 10ms DropTail
$ns duplex-link $n0 $n3 1Mb 10ms DropTail


#Define a link orientation

$ns duplex-link-op $n0 $n1 orient right
$ns duplex-link-op $n0 $n2 orient down
$ns duplex-link-op $n0 $n3 orient left
 
#Create a TCP connection from node 0 to node 1
#=============================================
#Create a TCP Agent (tcp0) and attach it to node 0

set tcp0 [new Agent/TCP]
$ns attach-agent $n0 $tcp0

#Create a FTP traffic source (ftp0) and attach it to tcp0

set ftp0 [new Application/FTP]
$ftp0 attach-agent $tcp0

#Create a Null TCP agent (null0), acting as a traffic sink. Attach the agent to node 1. Null TCP Agents are of the form Agent/TCPSink.

set null0 [new Agent/TCPSink]
$ns attach-agent $n1 $null0
 
#Connect tcp0 and null0 agents

$ns connect $tcp0 $null0

#Create a TCP connection from node 0 to node 3
#=============================================
#Create a TCP Agent (tcp1) and attach it to node 0

set tcp1 [new Agent/TCP]
$ns attach-agent $n0 $tcp1

#Create a Telnet traffic source (telnet0) and attach it to tcp1

set telnet0 [new Application/Telnet]
$telnet0 attach-agent $tcp1 

#Create a Null TCP agent (null1), acting as traffic sink. Attach the agent to node 3.

set null1 [new Agent/TCPSink]
$ns attach-agent $n3 $null1

#Connect tcp1 and null1 agents

$ns connect $tcp1 $null1

#Create a UDP connection from node 0 to node 2
#=============================================
#Create a UDP Agent (udp0) and attach it to node 0

set udp0 [new Agent/UDP]
$ns attach-agent $n0 $udp0

#Create a CBR traffic source (cbr0) and attach it to udp0
#Set packetSize = 48 bytes (stored in ps variable)
#Set interval time = 0.01 secs (stored in int variable)

set cbr0 [new Application/Traffic/CBR]
$cbr0 attach-agent $udp0
set ps 48
set int 0.01
$cbr0 set packetSize_ $ps
$cbr0 set interval $int

#Create a Null agent (null2), acting as traffic sink. Attach the agent to node 2.

set null2 [new Agent/Null]
$ns attach-agent $n2 $null2

#Connect udp0 and null2 agents

$ns connect $null2 $udp0

#Schedule event ftp0 to start at 0.5 secs and to stop at 3.5 secs

$ns at 0.5 "$ftp0 start"
$ns at 3.5 "$ftp0 stop" 

#Schedule event telnet0 to start at 1.0 secs and to stop at 4.0 secs

$ns at 1.0 "$telnet0 start"
$ns at 4.0 "$telnet0 stop"

#Schedule event cbr0 to start at 1.5 secs and to stop at 5.0 secs

$ns at 1.5 "$cbr0 start"
$ns at 5.0 "$cbr0 stop"

#Call procedure "finish" at 5.0 secs

$ns at 5.0 "finish"

#Calculate the packet per second rate of cbr0 traffic

puts "cbr0 produces [expr (1/$int)] packets per second"

#Calculate the bytes per second rate of cbr0 traffic

puts "cbr0 produces [expr (1/$int)*$ps] bytes per second"

#Add a procedure, called "finish"
#Execute nam and exit

proc finish {} {
	puts "running nam..."
	global ns nf
	$ns flush-trace
	close $nf
	exec /home/usual/nam-1.0a11-prerelease-linux-i386/nam -a  lab1_2.nam &
	exit 0
	}

#Set blue color for class 1 (TCP connections) and red color for class 2 (UDP connections)

$ns color 1 Blue
$tcp0 set class_ 1
$tcp1 set class_ 1

$ns color 2 Red
$udp0 set class_ 2

#Start the simulator

$ns run
