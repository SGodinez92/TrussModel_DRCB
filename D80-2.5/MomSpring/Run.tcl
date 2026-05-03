#Run 
wipe 
set dispflag 0
set dispRecorder 0

source Procedures.tcl 
source units.tcl
 
set dataDir Results_momSpring
file mkdir $dataDir/ 
 
model BasicBuilder -ndm 2 -ndf 3 

# Data to change
set bw 	[expr 12.*$in]			
set h  	[expr 18.*$in]
set ln 	[expr 45.*$in]			
set alpha	[expr 14.2*$pi/180.]
set As_diag [expr 3.96*$in2]
 
#Geometry
set d	[expr tan($alpha)*$ln];		# Distance between centroids of diagonal at interface of beam and wall
set I	[expr $bw*pow($h,3)/12];	# Moment of inertia
set r	[expr $ln/$h];				# Aspect ratio
set D	[expr pow($ln*$ln+$d*$d,0.5)]
set xi	[expr 1+2.88/($r*$r)]
set phi [expr 2*cos($alpha)*pow(sin($alpha),2)*$xi]

#set As_diag	[expr 2.2*$in2];				# 1 Diagonal reinforcement area 

set Ieff	[expr $I*0.05*$ln/$h];	# Moment of inertia

set fc [expr -8400.*$psi]
set Ec [expr 33000.*pow((0.14-$fc/1000.),1.5)*pow(-$fc,0.5)]

#puts "I $I xi $xi phi $phi D $D A_diag $A_diag As_diag $As_diag alpha $alpha d $d"

# Nodes to define truss model of coupling beam
#node $nodeTag (ndm $coords) <-mass (ndf $massValues)> 
node 1 0. 	0.
node 2 0.	0.
node 3 0.	$ln
node 4 0.	$ln

# Control Node
set controlNode 4

# Fix supports
fix 1 1 1 1
fix 2 1 1 0
fix 3 0 0 0
fix 4 0 1 1

equalDOF 4 3 1

# ########### Materials
set matCount 1 

# Hysteretic material
set momSpring $matCount
incr matCount

set e1 0.00001
set e2 0.08
set e3 0.10

set s1 [expr 3628.2*$kip*$in]
set s2 [expr 4136.6*$kip*$in]
set s3 [expr 2902.6*$kip*$in]

set pinchx 0.2
set pinchy 0.3

uniaxialMaterial Hysteretic $momSpring $s1 $e1 $s2 $e2 $s3 $e3 -$s1 -$e1 -$s2 -$e2 -$s3 -$e3 $pinchx $pinchy 0 0 0.75
#uniaxialMaterial Hysteretic $momSpring $s1 $e1 $s2 $e2 -$s1 -$e1 -$s2 -$e2 $pinchx $pinchy 0 0 0

#section Fiber $CB_steel {
#fiber 0 0 $As_diag $ReinfSteel
#}

# ########### Geometry
geomTransf Linear 1

element elasticBeamColumn 1 2 3 [expr $bw*$h] $Ec $Ieff 1
element zeroLength 2 1 2 -mat $momSpring -dir 3 
element zeroLength 3 3 4 -mat $momSpring -dir 3

# ########### Gravity
# Gravity analysis 
# set patternTag 0
# set P_block [expr 150.*$pcf*1250.*$mm*600.*$mm*300.*$mm]
# #set P_block 0.
# set P_beam [expr 150.*$pcf*$bw*$h*$ln/2.]
# set P [expr ($P_block + $P_beam)/2.]
# pattern Plain [incr patternTag] "Linear" { 
# load 3 0. -$P 0.
# load 4 0. -$P 0.
#} 

# puts "P $P" 

# constraints Plain
# numberer RCM 
# system BandSPD
# set tol 1e-06 
# set iter 500 
# set pFlag 0 
# test EnergyIncr $tol $iter $pFlag 
# #test NormDispIncr $tol 20 0;
# algorithm Newton
# set NStep 1 
# set lambda [expr 1./$NStep] 
# integrator LoadControl $lambda 
# analysis Static 
# set ok [analyze $NStep] 
# if {$ok == 0} { 
# puts "Gravity Analysis: DONE!" 
# } else { 
# puts "Gravity analysis error" 
# exit 
# } 
# loadConst -time 0.0 

#recorder mpco $dataDir/MPCO -N displacement -E localForce section.fiber.stressStrain -T nsteps 5

# ########### Recorders
recorder Node -file $dataDir/Displacement.txt -time -node 4 -dof 1 disp
#recorder Node -file $dataDir/Displacement_x.txt -node 3 4 -dof 1 disp
recorder Node -file $dataDir/Displacement_y.txt -node 4 -dof 2 disp 
#recorder Node -file $dataDir/Reacciones_y.txt -node 1 2 3 4 -dof 2 reaction 
#recorder Node -file $dataDir/Reacciones_x.txt -node 1 2 -dof 1 reaction
#recorder Node -file $dataDir/Reacciones_x_z2.txt -node 3 4 -dof 1 3 reaction

#recorder Element -file $dataDir/TrussSteel.txt -ele 1 2 axialForce
#recorder Element -file $dataDir/TrussConc.txt -ele 3 4 axialForce
#recorder Element -file $dataDir/Vert.txt -ele 3 4 -dof 1 2 globalForce
#recorder Element -file $dataDir/Hor.txt -ele 5 -dof 1 2 globalForce  

#recorder Element -file $dataDir/Steel_1.txt -ele 1 section $CB fiber 0 0 $ReinfSteel stressStrain
#recorder Element -file $dataDir/Steel_2.txt -ele 2 section $CB fiber 0 0 $ReinfSteel stressStrain
#recorder Element -file $dataDir/Concrete_1.txt -ele 1 section $CB fiber 0 0 $Conc stressStrain
#recorder Element -file $dataDir/Concrete_2.txt -ele 2 section $CB fiber 0 0 $Conc stressStrain

source Push.tcl 