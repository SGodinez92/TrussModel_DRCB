# recorders
if {$dispflag} {puts "$np.$pid.$count recorders"}; puts $recInput "recorders"
# Nodes
recorder Node -file $outputDir/Disp.txt -time -node $CtrNode -dof 1 disp;
recorder Node -file $outputDir/DispWall1.txt -nodeRange 10001 10144 -dof 1 2 disp;
recorder Node -file $outputDir/DispWall2.txt -nodeRange 20001 20144 -dof 1 2 disp;
recorder Node -file $outputDir/DispCB.txt -nodeRange 30001 30273 -dof 1 2 disp;
# recorder BTM simplified and Equivalent area
recorder Element -file $outputDir/CB_trussforces1.txt -ele [expr 4*$WallTag + 1] [expr 4*$WallTag + 2] [expr 5*$WallTag + 1] [expr 5*$WallTag + 2] [expr 6*$WallTag + 1] [expr 6*$WallTag + 2] -dof 1 2 globalForce;
recorder Element -file $outputDir/CB_trussforces3.txt -ele [expr 4*$WallTag + 5] [expr 4*$WallTag + 6] [expr 5*$WallTag + 5] [expr 5*$WallTag + 6] [expr 6*$WallTag + 5] [expr 6*$WallTag + 6] -dof 1 2 globalForce;
recorder Element -file $outputDir/CB_trussforces5.txt -ele [expr 4*$WallTag + 9] [expr 4*$WallTag + 10] [expr 5*$WallTag + 9] [expr 5*$WallTag + 10] [expr 6*$WallTag + 9] [expr 6*$WallTag + 10] -dof 1 2 globalForce;
recorder Element -file $outputDir/CB_trussforces7.txt -ele [expr 4*$WallTag + 13] [expr 4*$WallTag + 14] [expr 5*$WallTag + 13] [expr 5*$WallTag + 14] [expr 6*$WallTag + 13] [expr 6*$WallTag + 14] -dof 1 2 globalForce;
# recorder complete BTM
#recorder Element -file $outputDir/CB_trussforces1.txt -ele [expr 4*$WallTag + 1] [expr 4*$WallTag + 3] [expr 5*$WallTag + 1] [expr 5*$WallTag + 3] [expr 6*$WallTag + 1] [expr 6*$WallTag + 2] [expr 6*$WallTag + 3] [expr 6*$WallTag + 4] [expr 13*$WallTag + 1] [expr 13*$WallTag + 4] -dof 1 2 globalForce;
#recorder Element -file $outputDir/CB_trussforces7.txt -ele [expr 4*$WallTag + 25] [expr 4*$WallTag + 27] [expr 5*$WallTag + 25] [expr 5*$WallTag + 27] [expr 6*$WallTag + 49] [expr 6*$WallTag + 50] [expr 6*$WallTag + 51] [expr 6*$WallTag + 52] [expr 13*$WallTag + 49] [expr 13*$WallTag + 52] -dof 1 2 globalForce;
# recorder method Hysteretic
#recorder Element -file $outputDir/CB_trussforces1.txt -ele [expr 4*$WallTag + 1] [expr 4*$WallTag + 3] [expr 5*$WallTag + 1] [expr 5*$WallTag + 3] -dof 1 2 globalForce;
#recorder Element -file $outputDir/CB_trussforces7.txt -ele [expr 4*$WallTag + 25] [expr 4*$WallTag + 27] [expr 5*$WallTag + 25] [expr 5*$WallTag + 27] -dof 1 2 globalForce;

recorder Element -file $outputDir/CB_deformation1.txt -ele [expr 4*$WallTag + 1] [expr 4*$WallTag + 2] deformation;
recorder Element -file $outputDir/CB_deformation7.txt -ele [expr 4*$WallTag + 13] [expr 4*$WallTag + 14] deformation;
recorder Node -file $outputDir/DispRigidCB1.txt -node 10112 20004 20006 10114 -dof 1 2 disp
recorder Node -file $outputDir/DispRigidCB3.txt -node 10122 20014 20016 10124 -dof 1 2 disp
recorder Node -file $outputDir/DispRigidCB5.txt -node 10132 20024 20026 10134 -dof 1 2 disp
recorder Node -file $outputDir/DispRigidCB7.txt -node 10142 20034 20036 10144 -dof 1 2 disp

if {$strainpFlag} {
	recorder Node -file $outputDir/ReaY.txt -time -node 10001 10037 10073 10109 20001 20037 20073 20109 -dof 2 reaction;
} else {
	recorder Node -file $outputDir/ReaY.txt -time -node 10001 10037 10073 10109 20001 20037 20073 20109 -dof 2 reaction;
}
recorder Node -file $outputDir/ReaX.txt -time -node 10001 10037 10073 10109 20001 20037 20073 20109 -dof 1 reaction;
recorder Node -file $outputDir/ReaM.txt -time -node 10001 10109 20001 20109 -dof 3 reaction;
# Boundary elements
recorder Element -file $outputDir/StrainRebarFSecI.txt -eleRange [expr $WallTag + $VerElemTag + 1] [expr $WallTag + $VerElemTag + $NumVerInc] section 1 fiber [expr 0.0701*$m] [expr 0.0295*$m] strain;
recorder Element -file $outputDir/StrainRebarFSecF.txt -eleRange [expr $WallTag + $VerElemTag + 1] [expr $WallTag + $VerElemTag + $NumVerInc] section $NipBound fiber [expr 0.0701*$m] [expr 0.0295*$m] strain;
recorder Element -file $outputDir/StrainRebarDSecI.txt -eleRange [expr $WallTag + $VerElemTag + $NumVerInc*$NumHorInc + 1] [expr $WallTag + $VerElemTag + $NumVerInc*($NumHorInc+1)] section 1 fiber [expr -0.0161*$m] [expr 0.0295*$m] strain;  
recorder Element -file $outputDir/StrainRebarDSecF.txt -eleRange [expr $WallTag + $VerElemTag + $NumVerInc*$NumHorInc + 1] [expr $WallTag + $VerElemTag + $NumVerInc*($NumHorInc+1)] section $NipBound fiber [expr -0.0161*$m] [expr 0.0295*$m] strain;	
# Coupling Beams
set listCB {} 
for {set cc 1} {$cc <= 7} {incr cc} {
	set offbeam [expr 84*($cc-1)]
	lappend listCB [expr 3*$WallTag + $offbeam + 41]
	lappend listCB [expr 3*$WallTag + $offbeam + 48]
	lappend listCB [expr 3*$WallTag + $offbeam + 66]
	lappend listCB [expr 3*$WallTag + $offbeam + 71]
}
eval recorder Element -file $outputDir/StrainRebarCB.txt -ele $listCB deformation;

#set listSpring {}
#lappend listSpring 100003
#lappend listSpring 200003
#lappend listSpring 300003
#lappend listSpring 400003
#lappend listSpring 500003
#lappend listSpring 600003
#lappend listSpring 700003
#
#eval recorder Element -file $outputDir/SpringDeformation.txt -ele $listSpring deformation;
#eval recorder Element -file $outputDir/SpringForce.txt -ele $listSpring force;

set listSpring {}
lappend listSpring 100001
lappend listSpring 100002
lappend listSpring 200001
lappend listSpring 200002
lappend listSpring 300001
lappend listSpring 300002
lappend listSpring 400001
lappend listSpring 400002
lappend listSpring 500001
lappend listSpring 500002
lappend listSpring 600001
lappend listSpring 600002
lappend listSpring 700001
lappend listSpring 700002

eval recorder Element -file $outputDir/SpringDeformation.txt -ele $listSpring deformation;
eval recorder Element -file $outputDir/SpringForce.txt -ele $listSpring force;


# STKO
#recorder mpco $outputDir/MPCO -N displacement rotation reactionForce reactionMoment -E globalForce localForce force section.force section.deformation section.fiber.stressStrain
recorder mpco $outputDir/MPCO_disp -N displacement -T nsteps 10
#record 
#exit
if {0} {
# shape
set xmodel $wgrid
set ymodel 0.
set zmodel $hgrid
set prpdis 1000
set pix_wscreen 1920
set xPixels [expr ($pix_wscreen - 5*10)/2];# [expr ($pix_wscreen - 5*10)/4]
set yPixels $xPixels
set xLoc1 10
set yLoc1 10
recorder display "Displaced Shape Plane XY" $xLoc1 $yLoc1 $xPixels $yPixels -wipe
prp [expr $xmodel/2.] [expr $ymodel/2.] $prpdis
vup 0 1 0
vpn 0 0 1
#viewWindow -x x -y y
display 1 2 20
}

if {0} {
puts "Press enter to exit..."
set end [gets stdin line]
wipe
exit
}
