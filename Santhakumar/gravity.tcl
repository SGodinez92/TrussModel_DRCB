# gravity
if {$dispflag} {puts "$np.$pid.$count gravity (selft weight)"}; puts $recInput "gravity (selft weight)"
# lcAnalysis
set Psw [expr 111.2055*$kN];

#set VertLoadN1 [expr $WallTag + ($NumVerInc+1)*2]
#set VertLoadN2 [expr $WallTag + ($NumVerInc+1)*3]
#set VertLoadN3 [expr 2*$WallTag + ($NumVerInc+1)*2]
#set VertLoadN4 [expr 2*$WallTag + ($NumVerInc+1)*3]
#
#set patternTag 1
#pattern Plain [incr patternTag] "Linear" {
#    load $VertLoadN1 0 [expr -$Psw/2.] 0
#	load $VertLoadN2 0 [expr -$Psw/2.] 0
#	load $VertLoadN3 0 [expr -$Psw/2.] 0
#	load $VertLoadN4 0 [expr -$Psw/2.] 0	
#}

set VertLoadN11 [expr $WallTag + ($NumVerInc+1)*1]
set VertLoadN12 [expr $WallTag + ($NumVerInc+1)*2]
set VertLoadN13 [expr $WallTag + ($NumVerInc+1)*3]
set VertLoadN14 [expr $WallTag + ($NumVerInc+1)*4]
set VertLoadN21 [expr 2*$WallTag + ($NumVerInc+1)*1]
set VertLoadN22 [expr 2*$WallTag + ($NumVerInc+1)*2]
set VertLoadN23 [expr 2*$WallTag + ($NumVerInc+1)*3]
set VertLoadN24 [expr 2*$WallTag + ($NumVerInc+1)*4]

set patternTag 1
pattern Plain [incr patternTag] "Linear" {
    load $VertLoadN11 0 [expr -$Psw/4.] 0
	load $VertLoadN12 0 [expr -$Psw/4.] 0
	load $VertLoadN13 0 [expr -$Psw/4.] 0
	load $VertLoadN14 0 [expr -$Psw/4.] 0
	load $VertLoadN21 0 [expr -$Psw/4.] 0
	load $VertLoadN22 0 [expr -$Psw/4.] 0
	load $VertLoadN23 0 [expr -$Psw/4.] 0
	load $VertLoadN24 0 [expr -$Psw/4.] 0
}

#print -file model.txt
#print -file node.txt -node
#print -file element.txt -ele

constraints Transformation
numberer RCM
system SparseSYM
set tol 1e-06
set iter 500
set pFlag 0
test EnergyIncr $tol $iter $pFlag
algorithm Newton
set NStep 1
set lambda [expr 1./$NStep]
integrator LoadControl $lambda
analysis Static
set ok [analyzeMonitor $NStep $tiTask $tiTaskMP 1]

if {$ok == 0} {
    puts "$np.$pid.$count Gravity Analysis: DONE!"
} else {
    error 1
}
set gstep $NStep

loadConst -time 0.0
