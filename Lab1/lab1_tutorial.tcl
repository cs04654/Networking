#Create an instance of the Simulator class.
set ns [new Simulator]

#Add two nodes n0, n1
set n0 [$ns node]
set n1 [$ns node]

#Set red color for connection
$ns color 1 Red

#Print id of each node
puts n0=[$n0 id]
puts n1=[$n1 id]

#Export nam traces
set nf [open lab1_tutorial.nam w]
$ns namtrace-all $nf

#Create 1 (duplex) link, connecting n0 and n1
#with 1Mb bandwidth and 10ms delay per link, including a DropTail queue 
$ns duplex-link $n0 $n1 1Mb 10ms DropTail


#Create a CBR traffic source (cbr0)
#Set packetSize = 48 bytes (stored in ps variable)
#Set interval time = 0.01 secs (stored in int variable)
set cbr0 [new Application/Traffic/CBR]
set ps 48
set int 0.01
$cbr0 set packetSize_ $ps
$cbr0 set interval_ $int


#Create a UDP agent and connect cbr application to it
set udp0 [new Agent/UDP]
$cbr0 attach-agent $udp0
$udp0 set class_ 1


#Create a Null agent (null0), acting as traffic sink
set null0 [new Agent/Null]


#Connect agents to nodes
$ns attach-agent $n0 $udp0
$ns attach-agent $n1 $null0


#Connect udp0 and null0 agents
$ns connect $udp0 $null0 

#Schedule event cbr0 to start at 1.0 secs and to stop at 4.0 secs
$ns at 1.0 "$cbr0 start"
$ns at 4.0 "$cbr0 stop"


#Calculate the packet per second rate of cbr0 traffic
puts "cbr0 produces [expr (1 / $int)] packets per second"


#Calculate the bytes per second rate of cbr0 traffic
puts "cbr0 produces [expr (1 / $int) * $ps] bytes per second"


#Call procedure "finish" at 5.0 secs
$ns at 5.0 "finish"


#Add a procedure, called "finish"
#Execute nam and exit
proc finish {} {
	puts "running nam..."
	global ns nf
	$ns flush-trace
	close $nf
	exec nam lab1_tutorial.nam &
	exit 0
	}


#Start the simulator
$ns run
