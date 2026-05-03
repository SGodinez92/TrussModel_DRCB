# test
if {$dispflag} {puts "$np.$pid.$count test"}; puts $recInput "test"

# Control Nodes
#node $nodeTag (ndm $coords) <-mass (ndf $massValues)> 		
node 1  [expr -0.7087*$m] [expr 5.1998*$m]
node 2  [expr -0.7087*$m] [expr 5.2578*$m]
node 3  [expr -0.7087*$m] [expr 5.3340*$m]
node 4  [expr  0.7087*$m] [expr 5.1998*$m]
node 5  [expr  0.7087*$m] [expr 5.2578*$m]
node 6  [expr  0.7087*$m] [expr 5.3340*$m]
set CtrNode 5

#equalDOF $rNodeTag $cNodeTag $dof1 $dof2 ... 
equalDOF 10034 1 1 2
equalDOF 10035 3 1 2
equalDOF 20142 4 1 2
equalDOF 20143 6 1 2

set A_fRig [expr 0.01*0.01]
set E_fRig 29000. 
set I_fRig [expr 1.*pow(1.,3)/12.]
#element elasticBeamColumn $eleTag $iNode $jNode $A $E $Iz $transfTag <-mass $massDens> <-cMass> 	
element elasticBeamColumn 1 1 2 $A_fRig $E_fRig $I_fRig $transfTagVer
element elasticBeamColumn 2 2 3 $A_fRig $E_fRig $I_fRig $transfTagVer
element elasticBeamColumn 3 4 5 $A_fRig $E_fRig $I_fRig $transfTagVer
element elasticBeamColumn 4 5 6 $A_fRig $E_fRig $I_fRig $transfTagVer
