#Run 
wipe 
set dispflag 0
set dispRecorder 0

source Procedures.tcl 
source units.tcl
 
set dataDir Results 
file mkdir $dataDir/ 
 
model BasicBuilder -ndm 2 -ndf 3 

# Data to change
set bw 	[expr 12.*$in]			
set h  	[expr 18.*$in]
set ln 	[expr 60.*$in]			
set alpha	[expr 12.3*$pi/180.]
set As_diag [expr 3.61*$in2]
 
#Geometry
set d	[expr tan($alpha)*$ln];		# Distance between centroids of diagonal at interface of beam and wall
set I	[expr $bw*pow($h,3)/12];	# Moment of inertia
set r	[expr $ln/$h];				# Aspect ratio
set D	[expr pow($ln*$ln+$d*$d,0.5)]
set xi	[expr 1+2.88/($r*$r)]
set phi [expr 2*cos($alpha)*pow(sin($alpha),2)*$xi]

#set As_diag	[expr 2.2*$in2];				# 1 Diagonal reinforcement area 
set A_diag [expr 12.*$I/($ln*$ln*$phi)];		# Equivalent truss area
#set A_diag [expr 110.63*$in2];		# Equivalent truss area
#set A_diag 0.

puts "I $I xi $xi phi $phi D $D A_diag $A_diag As_diag $As_diag alpha $alpha d $d"

# Nodes to define truss model of coupling beam
#node $nodeTag (ndm $coords) <-mass (ndf $massValues)> 
node 1 0. 	0.
node 2 $d	0.
node 3 0.	$ln
node 4 $d	$ln

#node 11 0. 	0.
#node 21 $d	0.

# Control Node
set controlNode 4

# Fix supports
#fix $nodeTag (ndf $constrValues, 1 means fixed, 0 means released) 
# 2 nodes fixed (interface of base wall)
fix 1 1 1 1
fix 2 1 1 1

#fix 11 0 0 1
#fix 21 0 0 1

#equalDOF 1 11 1
#equalDOF 2 21 1

# 2 nodes restrained to rotate and allowed to move in x and y
fix 3 0 0 1
fix 4 0 0 1

#equalDOF $rNodeTag $cNodeTag $dof1 $dof2
equalDOF 4 3 1 2

# ########### Materials
set matCount 1 

set fc [expr -6850.*$psi]
set Ec [expr 33000.*pow((0.14-$fc/1000.),1.5)*pow(-$fc,0.5)]
set ec [expr 2.*$fc/$Ec]
set ec -0.002
set fcres [expr $fc*0.2]
set ecres [euReg $fc $Ec $ec $D]

set fr [expr 7.5*pow(-$fc*1000.,0.5)*$psi]
set ft_c [expr $fr*$bw*$h*$h/(6*sin($alpha)*$A_diag*$ln)]
set Et [expr 0.1*$Ec]

set lambda 0.25

set Conc $matCount
incr matCount

#uniaxialMaterial Concrete02 $matTag $fpc $epsc0 $fpcu $epsU $lambda $ft $Ets
puts "uniaxialMaterial Concrete02 Conc $Conc fc $fc ec $ec fcres $fcres ecres $ecres lambda $lambda ft_c $ft_c Et $Et"
#prueba
uniaxialMaterial Concrete02 $Conc $fc $ec $fcres $ecres $lambda $ft_c $Et

# Reinforcing steel properties
set fy [expr 70.*$ksi]
set fu [expr 90.*$ksi] 
#set fu [expr 1.15*$fy] 
set epsy [expr $fy/(29000.*$ksi)]
set eu 0.14

set lambda [expr 3.*70000./(40.*sqrt(6850.)*2.5)]
set db [expr 0.875*$in]

set ld [expr $lambda*$db]

set lambda_e [expr 528./70.]; #Koorosh
set lambda_i [expr 0.5*$D/$db]
set lambda2 [expr $lambda_e + $lambda_i]

set Ly [expr $ld + $D - 2*$lambda2*$db]

#set eps_bar [expr $Ly*$fu*$epsy/($D*$fy) + 2*$lambda2*$db*$epsy/$D]
set eps_bar [expr $Ly*$epsy/$D + 2*$lambda2*$db*$epsy/$D]
set eps_bar_u [expr $Ly*$epsy/$D + $lambda2*$db*$eu/$D]
#set eps_bar_u [expr $eu/2.]

set Keff [expr $D/($D+$db*$lambda)]
set fact [expr $db*$lambda2/$D]

puts "lambda_e $lambda_e"
puts "lambda_i $lambda_i"
puts "eps_bar $eps_bar"
puts "eps_bar_u $eps_bar_u"
puts "eu $eu"

puts "Keff $Keff"
puts "fact $fact"

puts "lambda2 $lambda2 Keff $Keff"
#prueba


set Es [expr 29000.*$ksi*$Keff]
set b  0.01

set ReinfSteel $matCount
incr matCount

#uniaxialMaterial Steel02 $ReinfSteel $fy $Es $b 20 0.925 0.15
#puts "uniaxialMaterial Steel02 $ReinfSteel fy $fy Es $Es b $b 20 0.925 0.15"

#SteelDRC parameters 
set esh 0.01 
set Psh 3.5
set omegaFac 0.75

uniaxialMaterial SteelDRC $ReinfSteel $Es $fy $eu $fu $esh -Psh $Psh -omegaFactor $omegaFac 
puts "uniaxialMaterial SteelDRC $ReinfSteel $Es $fy $eu $fu $esh -Psh $Psh -omegaFactor $omegaFac"

set steelTakeda $matCount
incr matCount

set e1 [expr $fy/$Es]
#set e2 $esh
#set e2 [expr 0.5*$eu]
set e2 [expr $eu*$fact]
set e3 $eu

set s1 $fy
#set s2 $fy
set s2 $fu
set s3 $fu

set pinchx 0.3
set pinchy 0.5

uniaxialMaterial Hysteretic $steelTakeda $s1 $e1 $s2 $e2 $s3 $e3 -$s1 -$e1 -$s2 -$e2 -$s3 -$e3 $pinchx $pinchy 0 0
#uniaxialMaterial Hysteretic $steelTakeda $s1 $e1 $s3 $e3 -$s1 -$e1 -$s3 -$e3 $pinchx $pinchy 0 0

set steelTakedaEPP $matCount
incr matCount

set e1 $eps_bar
set e2 $eu

set s1 $fu
set s2 $fu

set pinchx 0.3
set pinchy 0.5

set pinchx 0.110697741326361
set pinchy 0.996382426225376

uniaxialMaterial Hysteretic $steelTakedaEPP $s1 $e1 $s2 $e2 -$s1 -$e1 -$s2 -$e2 $pinchx $pinchy 0 0

set steelTakedaTri $matCount
incr matCount

set e1 [expr $eps_bar]
set e2 [expr $eps_bar_u]
set e3 $eu

set s1 $fy
set s2 $fu
set s3 $fu

set pinchx 0.3
set pinchy 0.6
#prueba
uniaxialMaterial Hysteretic $steelTakedaTri $s1 $e1 $s2 $e2 $s3 $e3 -$s1 -$e1 -$s2 -$e2 -$s3 -$e3 $pinchx $pinchy 0 0
#uniaxialMaterial Hysteretic $steelTakeda $s1 $e1 $s3 $e3 -$s1 -$e1 -$s3 -$e3 $pinchx $pinchy 0 0

# Hysteretic material
set sy [expr 0.503*$mm]
set Lb [expr 208.1*$mm]
set ey [expr $fy/$Es]
set costheta 0.963

set slipMat $matCount
incr matCount

set e1 [expr $ey*$Lb/$costheta]
set e2 [expr 0.5*$eu*$Lb/$costheta]
set e3 [expr $eu*$Lb/$costheta]

set s1 [expr $As_diag*$fy*$costheta]
set s2 [expr $As_diag*$fu*$costheta]
set s3 [expr $As_diag*$fu*$costheta]

set pinchx 0.40
set pinchy 0.20

uniaxialMaterial Hysteretic $slipMat $s1 $e1 $s2 $e2 $s3 $e3 -$s1 -$e1 -$s2 -$e2 -$s3 -$e3 $pinchx $pinchy 0 0 0

# Elastic no tension
set rigidComp $matCount
incr matCount

uniaxialMaterial ENT $rigidComp [expr $Es*10000.]

set rigid $matCount
incr matCount

uniaxialMaterial Elastic $rigid [expr $Es*10000.]

set slip $matCount
incr matCount 

uniaxialMaterial Parallel $slip $slipMat $rigidComp

# ########### Sections
set sectCount 1 
 
#Coupling beam diagonal
set CB $sectCount
incr sectCount

set CB_steel $sectCount
incr sectCount

section Fiber $CB {
# Concrete fiber
fiber 0 0 $A_diag $Conc
#fiber 0 0 $As_diag $ReinfSteel
#fiber 0 0 $As_diag $steelTakeda
#fiber 0 0 $As_diag $steelTakedaEPP
fiber 0 0 $As_diag $steelTakedaTri
}

#section Fiber $CB_steel {
#fiber 0 0 $As_diag $ReinfSteel
#}

# ########### Geometry
element trussSection 1 1 4 $CB
element trussSection 2 2 3 $CB

#element trussSection 3 1 4 $CB
#element trussSection 4 2 3 $CB

#element trussSection 1 11 4 $CB
#element trussSection 2 21 3 $CB

#element zeroLength 11 1 11 -mat $slip $rigid -dir 1 2 -orient 0.2811 1 0 -1 0.2811 0
#element zeroLength 21 2 21 -mat $slip $rigid -dir 1 2 -orient -0.2811 1 0 1 0.2811 0

# ########### Gravity
#Gravity analysis 
set patternTag 0
set P_block [expr 150.*$pcf*1250.*$mm*600.*$mm*300.*$mm]
#set P_block 0.
set P_beam [expr 150.*$pcf*$bw*$h*$ln/2.]
set P [expr ($P_block + $P_beam)/2.]
pattern Plain [incr patternTag] "Linear" { 
load 3 0. -$P 0.
load 4 0. -$P 0.
} 

puts "P $P" 

constraints Plain
numberer RCM 
system BandSPD
set tol 1e-06 
set iter 500 
set pFlag 0 
test EnergyIncr $tol $iter $pFlag 
#test NormDispIncr $tol 20 0;
algorithm Newton
set NStep 1 
set lambda [expr 1./$NStep] 
integrator LoadControl $lambda 
analysis Static 
set ok [analyze $NStep] 
if {$ok == 0} { 
puts "Gravity Analysis: DONE!" 
} else { 
puts "Gravity analysis error" 
exit 
} 
loadConst -time 0.0 

#recorder mpco $dataDir/MPCO -N displacement -E localForce section.fiber.stressStrain -T nsteps 5

# ########### Recorders
recorder Node -file $dataDir/Displacement.txt -time -node 4 -dof 1 disp
#recorder Node -file $dataDir/Displacement_x.txt -node 3 4 -dof 1 disp
recorder Node -file $dataDir/Displacement_y.txt -node 3 4 -dof 2 disp 
#recorder Node -file $dataDir/Reacciones_y.txt -node 1 2 3 4 -dof 2 reaction 
#recorder Node -file $dataDir/Reacciones_x.txt -node 1 2 -dof 1 reaction
#recorder Node -file $dataDir/Reacciones_x_z2.txt -node 3 4 -dof 1 3 reaction

#recorder Element -file $dataDir/TrussSteel.txt -ele 1 2 axialForce
#recorder Element -file $dataDir/TrussConc.txt -ele 3 4 axialForce
#recorder Element -file $dataDir/Vert.txt -ele 3 4 -dof 1 2 globalForce
#recorder Element -file $dataDir/Hor.txt -ele 5 -dof 1 2 globalForce  

#recorder Element -file $dataDir/Steel_1.txt -ele 1 section $CB fiber 0 0 $steelTakeda stressStrain
#recorder Element -file $dataDir/Steel_2.txt -ele 2 section $CB fiber 0 0 $steelTakeda stressStrain
recorder Element -file $dataDir/Steel_1.txt -ele 1 section $CB fiber 0 0 $steelTakedaEPP stressStrain
recorder Element -file $dataDir/Steel_2.txt -ele 2 section $CB fiber 0 0 $steelTakedaEPP stressStrain
recorder Element -file $dataDir/Concrete_1.txt -ele 1 section $CB fiber 0 0 $Conc stressStrain
recorder Element -file $dataDir/Concrete_2.txt -ele 2 section $CB fiber 0 0 $Conc stressStrain

source Push.tcl 