# coupling3

# Equivalent truss models
# Data of the coupling beam
set bw 	[expr 76.*$mm]			
set h  	[expr 305.*$mm]
set ln 	[expr 381.*$mm]			
set alpha	[expr 30.*$pi/180.]

set incHd [expr 455.9*$mm]
set incVd [expr 268.5*$mm]
 
#Geometry
set d	[expr tan($alpha)*$ln];		# Distance between centroids of diagonal at interface of beam and wall
set I	[expr $bw*pow($h,3)/12];	# Moment of inertia
set r	[expr $ln/$h];				# Aspect ratio
#set D	[expr pow($ln*$ln+$d*$d,0.5)]
set xi	[expr 1+2.88/($r*$r)]
set phi [expr 2*cos($alpha)*pow(sin($alpha),2)*$xi]

set D	[expr pow($incHd*$incHd+$incVd*$incVd,0.5)]

set A_diag [expr 12.*$I/($ln*$ln*$phi)];		# Equivalent truss area

puts "D $D A_diag $A_diag"

# Flag to activate BTM analysis
set flag_BTM 0
#set rD10 0.542
#set rD6 0.570
set rD10 1
set rD6 1

set pinchx 0.3
set pinchy 0.6

# coupling beams materials
# rebar D10cb
set D10cb [expr 3*$WallTag + 7] 
set fy [expr 314.7458*$MPa/$rD10]  
puts "fy D10 $fy"
set fu [expr 431.4051*$MPa/$rD10]
set Es [expr 200000*$MPa]
set epsy [expr $fy/$Es]
set esh [expr 0.022273/$rD10]
set eu [expr 0.2/$rD10]

set lambda [expr 314.7/(1.1*sqrt(30.)*2.5)]
set db [expr 10.*$mm]
set ld [expr $lambda*$db]
set lambda_e [expr 314.74/83.]; #Koorosh
set lambda_i [expr $lambda_e*1.0]
set lambda2 [expr $lambda_e + $lambda_i]
set Ly [expr $ld + $D - 2*$lambda2*$db]

set eps_bar [expr $Ly*$epsy/$D + 2*$lambda2*$db*$epsy/$D]
set eps_bar_u [expr $Ly*$epsy/$D + $lambda2*$db*$eu/$D]

puts "D10cb"
puts "lambda $lambda"
puts "ld $ld"
puts "ey $ey"
puts "eps_bar $eps_bar"
puts "eu $eu"
puts "eps_bar_u $eps_bar_u"
puts "D $D"
puts "Ly $Ly"
puts "lambda2 $lambda2"
puts "db $db"
#prueba

#set e1 [expr $fy/$Es]
#set e2 [expr 0.5*$eu]
set e1 [expr $eps_bar]
set e2 [expr $eps_bar_u]
set e3 $eu
set s1 $fy
set s2 $fu
set s3 $fu

#uniaxialMaterial SteelDRC $matTag $Es $fy $eu $fu $esh <-Psh $Psh> <-shPoint $esh1 $fsh1> <-omegaFactor $omegaFac> <-bausch $bauschType> <-fractStrain $eft> <-stiffOutput $stiffoption>
#uniaxialMaterial SteelDRC $D10cb $Es $fy $eu $fu $esh -Psh 4 -omegaFactor 0.6 -bausch 0 -fractStrain [expr 1.2*$eu] -stiffOutput 0
uniaxialMaterial Hysteretic $D10cb $s1 $e1 $s2 $e2 $s3 $e3 -$s1 -$e1 -$s2 -$e2 -$s3 -$e3 $pinchx $pinchy 0 0

# rebar D6cb
set D6cb [expr 3*$WallTag + 8]
set fy [expr 346.1169*$MPa/$rD6]  
puts "fy D6 $fy"
set fu [expr 486.9079*$MPa/$rD6]
set Es [expr 200000*$MPa]
set epsy [expr $fy/$Es]
set esh [expr 0.0124/$rD6]
set eu [expr 0.2/$rD6]

set lambda [expr 346.1169/(1.1*sqrt(30.)*2.5)]
set db [expr 6.*$mm]
set ld [expr $lambda*$db]
set lambda_e [expr 346.1169/83.]; #Koorosh
set lambda_i [expr $lambda_e*1.0]
set lambda2 [expr $lambda_e + $lambda_i]
set Ly [expr $ld + $D - 2*$lambda2*$db]

set eps_bar [expr $Ly*$epsy/$D + 2*$lambda2*$db*$epsy/$D]
set eps_bar_u [expr $Ly*$epsy/$D + $lambda2*$db*$eu/$D]

puts "D6cb"
puts "ey $ey"
puts "eps_bar $eps_bar"
puts "eu $eu"
puts "eps_bar_u $eps_bar_u"

#prueba

#set e1 [expr $fy/$Es]
#set e2 [expr 0.5*$eu]
set e1 [expr $eps_bar]
set e2 [expr $eps_bar_u]
set e3 $eu
set s1 $fy
set s2 $fu
set s3 $fu
#uniaxialMaterial SteelDRC $matTag $Es $fy $eu $fu $esh <-Psh $Psh> <-shPoint $esh1 $fsh1> <-omegaFactor $omegaFac> <-bausch $bauschType> <-fractStrain $eft> <-stiffOutput $stiffoption>
#uniaxialMaterial SteelDRC $D6cb $Es $fy $eu $fu $esh -Psh 4.5 -omegaFactor 0.6 -bausch 0 -fractStrain [expr 1.2*$eu] -stiffOutput 0
uniaxialMaterial Hysteretic $D6cb $s1 $e1 $s2 $e2 $s3 $e3 -$s1 -$e1 -$s2 -$e2 -$s3 -$e3 $pinchx $pinchy 0 0

# rebar D5cb
set D5cb [expr 3*$WallTag + 12]
set fy [expr 229.5955*$MPa]  
set fu [expr 339.2221*$MPa]
set Es [expr 200000*$MPa]
set ey [expr $fy/$Es]
set esh 0.003924
set eu 0.18
#uniaxialMaterial SteelDRC $matTag $Es $fy $eu $fu $esh <-Psh $Psh> <-shPoint $esh1 $fsh1> <-omegaFactor $omegaFac> <-bausch $bauschType> <-fractStrain $eft> <-stiffOutput $stiffoption>
uniaxialMaterial SteelDRC $D5cb $Es $fy $eu $fu $esh -Psh 4.5 -omegaFactor 0.6 -bausch 0 -fractStrain [expr 1.2*$eu] -stiffOutput 0

# coupling beam section
set AsD10cb [expr $pi*pow(9.525/2.*$mm,2.)*2.*$rD10]
set AsD6cb  [expr $pi*pow(6.35/2.*$mm,2.)*2.*$rD6]
puts "AsD10cb $AsD10cb AsD6cb $AsD6cb"
#exit
set AsD5cb  [expr $pi*pow(4.7625/2.*$mm,2.)*2.]
set A_fRigCB [expr 0.01*0.01]
set E_fRigCB 29000. 
set I_fRigCB [expr 4.*pow(4.,3)/12.*5]
set transfTagCB 3
geomTransf Linear $transfTagCB

#Concrete diagonal geometry
set B [expr 76.2*$mm]
set H [expr 304.8*$mm]
set Ig [expr $B*pow($H,3.)/12.]
set L [expr 455.9*$mm]
set GH [expr 268.5*$mm]
set D [expr sqrt(pow($L,2.)+pow($GH,2.))]
set A_eq [expr 6.*$Ig*pow($D,3.)/(pow($L,3)*(1+3.*pow($H/$L,2.))*pow($GH,2.))]
puts "B $B H $H Ig $Ig L $L GH $GH D $D A_eq $A_eq"

set A_conf [expr 0.0338*$m*0.0338*$m]

if {$flag_BTM} {
	set theta [expr 30.*$pi/180.]
	set A_diag [expr 268.5*$mm*76.2*$mm*cos($theta)]
	set A_hor [expr $GH*$B/2.]
	puts "A_diag $A_diag A_hor $A_hor"
	set A_unconf [expr $A_diag - $A_conf]
	set ft_d [expr $fr*0.01]
	set M_d [expr 75.*(($AsD10cb+$AsD6cb)/$A_diag)/6.35]
} else {
	#set A_diag $A_eq
	set A_unconf [expr $A_eq - $A_conf] 
	set ft_d [expr ($fr*$B*pow($H,2.)/(3.*$L))/(2.*$A_eq*$GH/$D)]
	set M_d [expr 75.*(($AsD10cb+$AsD6cb)/$A_diag)/6.35]
}

# unconfined concrete diagonal
set uconc_diag [expr 3*$WallTag + 9]
set fcres_d [expr $fc*0.2]
set ecres_d [euReg $fc $Ec $ec $D]
set fcint_d [expr ($fc + $fcres_d)/2.]
set ecint_d [expr ($ec + $ecres_d)/2.]
set et_d [expr $ft_d/$Ec]
set ftres_d [expr $ft_d*0.1]
set etres_d [expr 1.2*$et_d]
set ftint_d [expr ($ft_d + $ftres_d)/2.]
set etint_d [expr ($et_d + $etres_d)/2.]
set alpha_d [expr abs(0.03*$fc/$ft_d)]
set eb_d [BetaReg $D]
puts "ecres $ecres_d"
puts "f'c $fc"
puts "ft $ft_d"
puts "fr $fr"
puts "et $et_d"
puts "M $M_d"
#uniaxialMaterial ConcretewBeta $matTag $fpc $ec0 $fcint $ecint $fcres $ecres $ft $ftint $etint $ftres $etres <-lambda $lambda> <-alpha $alpha> <-beta $bint $ebint $bres $ebres> <-M $M> <-E $Ec> <-conf $fcc $ecc>
uniaxialMaterial ConcretewBeta $uconc_diag $fc $ec $fcint_d $ecint_d $fcres_d $ecres_d $ft_d $ftint_d $etint_d $ftres_d $etres_d -alpha $alpha_d -beta 0.4 [lindex $eb_d 0] 0.1 [lindex $eb_d 1] -E $Ec

# unconfined concrete horizontal
if {$flag_BTM} {
set uconc_hor [expr 3*$WallTag + 11]
set fcres_h [expr $fc*0.2]
set ecres_h [euReg $fc $Ec $ec $L]
set fcint_h [expr ($fc + $fcres_h)/2.]
set ecint_h [expr ($ec + $ecres_h)/2.]
set ft_h $fr
set et_h [expr $ft_h/$Ec]
set ftres_h [expr $ft_h*0.1]
set etres_h [expr 1.2*$et_h]
set ftint_h [expr ($ft_h + $ftres_h)/2.]
set etint_h [expr ($et_h + $etres_h)/2.]
set alpha_h [expr abs(0.03*$fc/$ft_h)]
set eb_h [BetaReg $L]
set M_dh [expr 75.*(($AsD5cb)/$A_hor)/4.7625]
puts "ecres $ecres_h"
puts "f'c $fc"
puts "ft $ft_h"
puts "fr $fr"
puts "et $et_h"
puts "M $M_dh"
#uniaxialMaterial ConcretewBeta $matTag $fpc $ec0 $fcint $ecint $fcres $ecres $ft $ftint $etint $ftres $etres <-lambda $lambda> <-alpha $alpha> <-beta $bint $ebint $bres $ebres> <-M $M> <-E $Ec> <-conf $fcc $ecc>
uniaxialMaterial ConcretewBeta $uconc_hor $fc $ec $fcint_h $ecint_h $fcres_h $ecres_h $ft_h $ftint_h $etint_h $ftres_h $etres_h -M $M_dh -alpha $alpha_h -beta 0.4 [lindex $eb_h 0] 0.1 [lindex $eb_h 1] -E $Ec
}

# confined concrete diagonal
set fcc [expr -54.0500*$MPa]
set ecc [expr $ec*(1 + 5*($fcc/$fc - 1))]
set ecs [expr -0.031961 + 0.002]
#
set conc_diag [expr 3*$WallTag + 10]
set fcres_dc [expr $fcc*0.2]
set ecres_dc [euReg $fcc $Ec $ecs $D]
set fcint_dc $fcc
set ecint_dc $ecs
set ft_dc $ft_d
set et_dc [expr $ft_dc/$Ec]
set ftres_dc [expr $ft_d*0.]
set etres_dc [expr 1.2*$et_dc]
set ftint_dc [expr ($ft_dc + $ftres_dc)/2.]
set etint_dc [expr ($et_dc + $etres_dc)/2.]
set alpha_dc [expr abs(0.03*$fc/$ft_dc)]
set eb_dc [BetaReg $D]
set M_dc $M_d
#uniaxialMaterial ConcretewBeta $matTag $fpc $ec0 $fcint $ecint $fcres $ecres $ft $ftint $etint $ftres $etres <-lambda $lambda> <-alpha $alpha> <-beta $bint $ebint $bres $ebres> <-M $M> <-E $Ec> <-conf $fcc $ecc>
uniaxialMaterial ConcretewBeta $conc_diag $fc $ec $fcint_dc $ecint_dc $fcres_dc $ecres_dc $ft_dc $ftint_dc $etint_dc $ftres_dc $etres_dc -alpha $alpha_dc -beta 0.4 [lindex $eb_dc 0] 0.1 [lindex $eb_dc 1] -E $Ec -conf $fcc $ecc

#prueba

# coupling beams geometry
if {1} {
if {$dispflag} {puts "$np.$pid.$count coupling beams: geometry"}; puts $recInput "coupling beams: geometry" 
set xp3882 [expr 0.2280*$m + 1*$IncH1]
set xn3882 [expr -0.7087*$m + 2*$IncH1]
set yo1 [expr $IncVPier1*3 + $IncVPier2*0 + $IncVPanel*1]
set yo2 [expr $IncVPier1*3 + $IncVPier2*3 + $IncVPanel*3]
set yo3 [expr $IncVPier1*3 + $IncVPier2*6 + $IncVPanel*5]
set yo4 [expr $IncVPier1*3 + $IncVPier2*9 + $IncVPanel*7]
set yo5 [expr $IncVPier1*3 + $IncVPier2*12 + $IncVPanel*9]
set yo6 [expr $IncVPier1*3 + $IncVPier2*15 + $IncVPanel*11]
set yo7 [expr $IncVPier1*3 + $IncVPier2*18 + $IncVPanel*13]
set Lyo [list $yo1 $yo2 $yo3 $yo4 $yo5 $yo6 $yo7] 
for {set cc 7} {$cc <= 7} {incr cc} {
	#set yo [lindex $Lyo [expr $cc - 1]]
    set offnode [expr 39*($cc-1)]
	#node $nodeTag (ndm $coords) <-mass (ndf $massValues)> 		
	#if {$cc == 1} {
	#	node [expr 3*$WallTag + $offnode + 28] $xn3882 [expr $yo - $IncVPanel - $IncVPier1]
	#} else {
	#	node [expr 3*$WallTag + $offnode + 28] $xn3882 [expr $yo - $IncVPanel - $IncVPier2]
	#}
	#node [expr 3*$WallTag + $offnode + 30]     $xn3882 [expr $yo - $IncVPanel]
	#if {$cc == 1} {
	#	node [expr 3*$WallTag + $offnode + 31] $xp3882 [expr $yo - $IncVPanel - $IncVPier1]
	#} else {
	#	node [expr 3*$WallTag + $offnode + 31] $xp3882 [expr $yo - $IncVPanel - $IncVPier2]
	#}
	#node [expr 3*$WallTag + $offnode + 33]     $xp3882 [expr $yo - $IncVPanel]
	#if {$cc != 7} { 
	#	node [expr 3*$WallTag + $offnode + 34] $xn3882 [expr $yo + $IncVPanel]
	#	node [expr 3*$WallTag + $offnode + 36] $xn3882 [expr $yo + $IncVPanel + $IncVPier2]
	#    node [expr 3*$WallTag + $offnode + 37] $xp3882 [expr $yo + $IncVPanel]		
	#	node [expr 3*$WallTag + $offnode + 39] $xp3882 [expr $yo + $IncVPanel + $IncVPier2]
	#}
	#
	set offlevel [expr 5*($cc-1)]
	##equalDOF $rNodeTag $cNodeTag $dof1 $dof2 ... 
	#equalDOF [expr $WallTag + $offlevel + 72 + 3] [expr 3*$WallTag + $offnode + 28] 1 2
	#equalDOF [expr $WallTag + $offlevel + 72 + 4] [expr 3*$WallTag + $offnode + 30] 1 2	
	#equalDOF [expr 2*$WallTag + $offlevel + 36 + 3] [expr 3*$WallTag + $offnode + 31] 1 2
	#equalDOF [expr 2*$WallTag + $offlevel + 36 + 4] [expr 3*$WallTag + $offnode + 33] 1 2	
	#if {$cc != 7} {
	#	equalDOF [expr $WallTag + $offlevel + 72 + 6] [expr 3*$WallTag + $offnode + 34] 1 2
	#	equalDOF [expr $WallTag + $offlevel + 72 + 7] [expr 3*$WallTag + $offnode + 36] 1 2
	#	equalDOF [expr 2*$WallTag + $offlevel + 36 + 6] [expr 3*$WallTag + $offnode + 37] 1 2
	#	equalDOF [expr 2*$WallTag + $offlevel + 36 + 7] [expr 3*$WallTag + $offnode + 39] 1 2
	#}
		
	set offbeam [expr 84*($cc-1)]
	##element truss $eleTag $iNode $jNode $A $matTag <-rho $rho> <-cMass $cFlag> <-doRayleigh $rFlag> 
	#element truss [expr 3*$WallTag + $offbeam + 2000 + 73] [expr 3*$WallTag + $offnode + 29] [expr $WallTag + $offlevel + 108 + 4] $AsD10cb $D10cb
	#element truss [expr 3*$WallTag + $offbeam + 2000 + 74] [expr 2*$WallTag + $offlevel + 4] [expr 3*$WallTag + $offnode + 32] $AsD10cb $D10cb
	if {$cc != 7} {
		element truss [expr 3*$WallTag + $offbeam + 2000 + 75] [expr 3*$WallTag + $offnode + 35] [expr $WallTag + $offlevel + 108 + 6] $AsD10cb $D10cb
		element truss [expr 3*$WallTag + $offbeam + 2000 + 76] [expr 2*$WallTag + $offlevel + 6] [expr 3*$WallTag + $offnode + 38] $AsD10cb $D10cb
	} else {
		element truss [expr 3*$WallTag + $offbeam + 2000 + 75] [expr $WallTag + $offlevel + 72 + 6] [expr $WallTag + $offlevel + 108 + 6] $AsD10cb $D10cb
		element truss [expr 3*$WallTag + $offbeam + 2000 + 76] [expr 2*$WallTag + $offlevel + 6] [expr 2*$WallTag + $offlevel + 36 + 6] $AsD10cb $D10cb	
	}	
	#element truss [expr 3*$WallTag + $offbeam + 3000 + 73] [expr 3*$WallTag + $offnode + 29] [expr $WallTag + $offlevel + 108 + 4] $AsD6cb $D6cb
	#element truss [expr 3*$WallTag + $offbeam + 3000 + 74] [expr 2*$WallTag + $offlevel + 4] [expr 3*$WallTag + $offnode + 32] $AsD6cb $D6cb
	if {$cc != 7} {
		element truss [expr 3*$WallTag + $offbeam + 3000 + 75] [expr 3*$WallTag + $offnode + 35] [expr $WallTag + $offlevel + 108 + 6] $AsD6cb $D6cb
		element truss [expr 3*$WallTag + $offbeam + 3000 + 76] [expr 2*$WallTag + $offlevel + 6] [expr 3*$WallTag + $offnode + 38] $AsD6cb $D6cb
	} else {
		element truss [expr 3*$WallTag + $offbeam + 3000 + 75] [expr $WallTag + $offlevel + 72 + 6] [expr $WallTag + $offlevel + 108 + 6] $AsD6cb $D6cb
		element truss [expr 3*$WallTag + $offbeam + 3000 + 76] [expr 2*$WallTag + $offlevel + 6] [expr 2*$WallTag + $offlevel + 36 + 6] $AsD6cb $D6cb	
	}
	##element elasticBeamColumn $eleTag $iNode $jNode $A $E $Iz $transfTag <-mass $massDens> <-cMass> 	
	#element elasticBeamColumn [expr 3*$WallTag + $offbeam + 77] [expr 3*$WallTag + $offnode + 28] [expr 3*$WallTag + $offnode + 29] $A_fRigCB $E_fRigCB $I_fRigCB $transfTagCB
	#element elasticBeamColumn [expr 3*$WallTag + $offbeam + 78] [expr 3*$WallTag + $offnode + 29] [expr 3*$WallTag + $offnode + 30] $A_fRigCB $E_fRigCB $I_fRigCB $transfTagCB
	#element elasticBeamColumn [expr 3*$WallTag + $offbeam + 79] [expr 3*$WallTag + $offnode + 31] [expr 3*$WallTag + $offnode + 32] $A_fRigCB $E_fRigCB $I_fRigCB $transfTagCB
	#element elasticBeamColumn [expr 3*$WallTag + $offbeam + 80] [expr 3*$WallTag + $offnode + 32] [expr 3*$WallTag + $offnode + 33] $A_fRigCB $E_fRigCB $I_fRigCB $transfTagCB
	#if {$cc != 7} {
	#	element elasticBeamColumn [expr 3*$WallTag + $offbeam + 81] [expr 3*$WallTag + $offnode + 34] [expr 3*$WallTag + $offnode + 35] $A_fRigCB $E_fRigCB $I_fRigCB $transfTagCB
	#	element elasticBeamColumn [expr 3*$WallTag + $offbeam + 82] [expr 3*$WallTag + $offnode + 35] [expr 3*$WallTag + $offnode + 36] $A_fRigCB $E_fRigCB $I_fRigCB $transfTagCB
	#	element elasticBeamColumn [expr 3*$WallTag + $offbeam + 83] [expr 3*$WallTag + $offnode + 37] [expr 3*$WallTag + $offnode + 38] $A_fRigCB $E_fRigCB $I_fRigCB $transfTagCB
	#	element elasticBeamColumn [expr 3*$WallTag + $offbeam + 84] [expr 3*$WallTag + $offnode + 38] [expr 3*$WallTag + $offnode + 39] $A_fRigCB $E_fRigCB $I_fRigCB $transfTagCB
	#}	
}
}

if {0} {
if {$dispflag} {puts "$np.$pid.$count coupling beams: geometry"}; puts $recInput "coupling beams: geometry" 
set xp3882 [expr 0.2280*$m + 1*$IncH1]
set xn3882 [expr -0.7087*$m + 2*$IncH1]
set yo1 [expr $IncVPier1*3 + $IncVPier2*0 + $IncVPanel*1]
set yo2 [expr $IncVPier1*3 + $IncVPier2*3 + $IncVPanel*3]
set yo3 [expr $IncVPier1*3 + $IncVPier2*6 + $IncVPanel*5]
set yo4 [expr $IncVPier1*3 + $IncVPier2*9 + $IncVPanel*7]
set yo5 [expr $IncVPier1*3 + $IncVPier2*12 + $IncVPanel*9]
set yo6 [expr $IncVPier1*3 + $IncVPier2*15 + $IncVPanel*11]
set yo7 [expr $IncVPier1*3 + $IncVPier2*18 + $IncVPanel*13]
set Lyo [list $yo1 $yo2 $yo3 $yo4 $yo5 $yo6 $yo7] 
for {set cc 1} {$cc <= 7} {incr cc} {
	set yo [lindex $Lyo [expr $cc - 1]]
    set offnode [expr 39*($cc-1)]
	#node $nodeTag (ndm $coords) <-mass (ndf $massValues)> 		
	if {$cc == 1} {
		node [expr 3*$WallTag + $offnode + 28] $xn3882 [expr $yo - $IncVPanel - $IncVPier1]
	} else {
		node [expr 3*$WallTag + $offnode + 28] $xn3882 [expr $yo - $IncVPanel - $IncVPier2]
	}
	node [expr 3*$WallTag + $offnode + 30]     $xn3882 [expr $yo - $IncVPanel]
	if {$cc == 1} {
		node [expr 3*$WallTag + $offnode + 31] $xp3882 [expr $yo - $IncVPanel - $IncVPier1]
	} else {
		node [expr 3*$WallTag + $offnode + 31] $xp3882 [expr $yo - $IncVPanel - $IncVPier2]
	}
	node [expr 3*$WallTag + $offnode + 33]     $xp3882 [expr $yo - $IncVPanel]
	if {$cc != 7} { 
		node [expr 3*$WallTag + $offnode + 34] $xn3882 [expr $yo + $IncVPanel]
		node [expr 3*$WallTag + $offnode + 36] $xn3882 [expr $yo + $IncVPanel + $IncVPier2]
	    node [expr 3*$WallTag + $offnode + 37] $xp3882 [expr $yo + $IncVPanel]		
		node [expr 3*$WallTag + $offnode + 39] $xp3882 [expr $yo + $IncVPanel + $IncVPier2]
	}
	
	set offlevel [expr 5*($cc-1)]
	#equalDOF $rNodeTag $cNodeTag $dof1 $dof2 ... 
	equalDOF [expr $WallTag + $offlevel + 72 + 3] [expr 3*$WallTag + $offnode + 28] 1 2
	equalDOF [expr $WallTag + $offlevel + 72 + 4] [expr 3*$WallTag + $offnode + 30] 1 2	
	equalDOF [expr 2*$WallTag + $offlevel + 36 + 3] [expr 3*$WallTag + $offnode + 31] 1 2
	equalDOF [expr 2*$WallTag + $offlevel + 36 + 4] [expr 3*$WallTag + $offnode + 33] 1 2	
	if {$cc != 7} {
		equalDOF [expr $WallTag + $offlevel + 72 + 6] [expr 3*$WallTag + $offnode + 34] 1 2
		equalDOF [expr $WallTag + $offlevel + 72 + 7] [expr 3*$WallTag + $offnode + 36] 1 2
		equalDOF [expr 2*$WallTag + $offlevel + 36 + 6] [expr 3*$WallTag + $offnode + 37] 1 2
		equalDOF [expr 2*$WallTag + $offlevel + 36 + 7] [expr 3*$WallTag + $offnode + 39] 1 2
	}
		
	set offbeam [expr 84*($cc-1)]
	#element truss $eleTag $iNode $jNode $A $matTag <-rho $rho> <-cMass $cFlag> <-doRayleigh $rFlag> 
	element truss [expr 3*$WallTag + $offbeam + 2000 + 73] [expr 3*$WallTag + $offnode + 29] [expr $WallTag + $offlevel + 108 + 4] $AsD10cb $D10cb
	element truss [expr 3*$WallTag + $offbeam + 2000 + 74] [expr 2*$WallTag + $offlevel + 4] [expr 3*$WallTag + $offnode + 32] $AsD10cb $D10cb
	if {$cc != 7} {
		element truss [expr 3*$WallTag + $offbeam + 2000 + 75] [expr 3*$WallTag + $offnode + 35] [expr $WallTag + $offlevel + 108 + 6] $AsD10cb $D10cb
		element truss [expr 3*$WallTag + $offbeam + 2000 + 76] [expr 2*$WallTag + $offlevel + 6] [expr 3*$WallTag + $offnode + 38] $AsD10cb $D10cb
	} else {
		element truss [expr 3*$WallTag + $offbeam + 2000 + 75] [expr $WallTag + $offlevel + 72 + 6] [expr $WallTag + $offlevel + 108 + 6] $AsD10cb $D10cb
		element truss [expr 3*$WallTag + $offbeam + 2000 + 76] [expr 2*$WallTag + $offlevel + 6] [expr 2*$WallTag + $offlevel + 36 + 6] $AsD10cb $D10cb	
	}	
	element truss [expr 3*$WallTag + $offbeam + 3000 + 73] [expr 3*$WallTag + $offnode + 29] [expr $WallTag + $offlevel + 108 + 4] $AsD6cb $D6cb
	element truss [expr 3*$WallTag + $offbeam + 3000 + 74] [expr 2*$WallTag + $offlevel + 4] [expr 3*$WallTag + $offnode + 32] $AsD6cb $D6cb
	if {$cc != 7} {
		element truss [expr 3*$WallTag + $offbeam + 3000 + 75] [expr 3*$WallTag + $offnode + 35] [expr $WallTag + $offlevel + 108 + 6] $AsD6cb $D6cb
		element truss [expr 3*$WallTag + $offbeam + 3000 + 76] [expr 2*$WallTag + $offlevel + 6] [expr 3*$WallTag + $offnode + 38] $AsD6cb $D6cb
	} else {
		element truss [expr 3*$WallTag + $offbeam + 3000 + 75] [expr $WallTag + $offlevel + 72 + 6] [expr $WallTag + $offlevel + 108 + 6] $AsD6cb $D6cb
		element truss [expr 3*$WallTag + $offbeam + 3000 + 76] [expr 2*$WallTag + $offlevel + 6] [expr 2*$WallTag + $offlevel + 36 + 6] $AsD6cb $D6cb	
	}
	#element elasticBeamColumn $eleTag $iNode $jNode $A $E $Iz $transfTag <-mass $massDens> <-cMass> 	
	element elasticBeamColumn [expr 3*$WallTag + $offbeam + 77] [expr 3*$WallTag + $offnode + 28] [expr 3*$WallTag + $offnode + 29] $A_fRigCB $E_fRigCB $I_fRigCB $transfTagCB
	element elasticBeamColumn [expr 3*$WallTag + $offbeam + 78] [expr 3*$WallTag + $offnode + 29] [expr 3*$WallTag + $offnode + 30] $A_fRigCB $E_fRigCB $I_fRigCB $transfTagCB
	element elasticBeamColumn [expr 3*$WallTag + $offbeam + 79] [expr 3*$WallTag + $offnode + 31] [expr 3*$WallTag + $offnode + 32] $A_fRigCB $E_fRigCB $I_fRigCB $transfTagCB
	element elasticBeamColumn [expr 3*$WallTag + $offbeam + 80] [expr 3*$WallTag + $offnode + 32] [expr 3*$WallTag + $offnode + 33] $A_fRigCB $E_fRigCB $I_fRigCB $transfTagCB
	if {$cc != 7} {
		element elasticBeamColumn [expr 3*$WallTag + $offbeam + 81] [expr 3*$WallTag + $offnode + 34] [expr 3*$WallTag + $offnode + 35] $A_fRigCB $E_fRigCB $I_fRigCB $transfTagCB
		element elasticBeamColumn [expr 3*$WallTag + $offbeam + 82] [expr 3*$WallTag + $offnode + 35] [expr 3*$WallTag + $offnode + 36] $A_fRigCB $E_fRigCB $I_fRigCB $transfTagCB
		element elasticBeamColumn [expr 3*$WallTag + $offbeam + 83] [expr 3*$WallTag + $offnode + 37] [expr 3*$WallTag + $offnode + 38] $A_fRigCB $E_fRigCB $I_fRigCB $transfTagCB
		element elasticBeamColumn [expr 3*$WallTag + $offbeam + 84] [expr 3*$WallTag + $offnode + 38] [expr 3*$WallTag + $offnode + 39] $A_fRigCB $E_fRigCB $I_fRigCB $transfTagCB
	}	
}
}
# diagonals #3 bars
#element truss $eleTag $iNode $jNode $A $matTag <-rho $rho> <-cMass $cFlag> <-doRayleigh $rFlag>
element truss [expr 4*$WallTag + 1] 10112 20006 $AsD10cb $D10cb
element truss [expr 4*$WallTag + 2] 10114 20004 $AsD10cb $D10cb
element truss [expr 4*$WallTag + 3] 10117 20011 $AsD10cb $D10cb
element truss [expr 4*$WallTag + 4] 10119 20009 $AsD10cb $D10cb
element truss [expr 4*$WallTag + 5] 10122 20016 $AsD10cb $D10cb
element truss [expr 4*$WallTag + 6] 10124 20014 $AsD10cb $D10cb
element truss [expr 4*$WallTag + 7] 10127 20021 $AsD10cb $D10cb
element truss [expr 4*$WallTag + 8] 10129 20019 $AsD10cb $D10cb
element truss [expr 4*$WallTag + 9] 10132 20026 $AsD10cb $D10cb
element truss [expr 4*$WallTag + 10] 10134 20024 $AsD10cb $D10cb
element truss [expr 4*$WallTag + 11] 10137 20031 $AsD10cb $D10cb
element truss [expr 4*$WallTag + 12] 10139 20029 $AsD10cb $D10cb
element truss [expr 4*$WallTag + 13] 10142 20036 $AsD10cb $D10cb
element truss [expr 4*$WallTag + 14] 10144 20034 $AsD10cb $D10cb

# diagonals #2 bars
#element truss $eleTag $iNode $jNode $A $matTag <-rho $rho> <-cMass $cFlag> <-doRayleigh $rFlag>
element truss [expr 5*$WallTag + 1] 10112 20006 $AsD6cb $D6cb
element truss [expr 5*$WallTag + 2] 10114 20004 $AsD6cb $D6cb
element truss [expr 5*$WallTag + 3] 10117 20011 $AsD6cb $D6cb
element truss [expr 5*$WallTag + 4] 10119 20009 $AsD6cb $D6cb
element truss [expr 5*$WallTag + 5] 10122 20016 $AsD6cb $D6cb
element truss [expr 5*$WallTag + 6] 10124 20014 $AsD6cb $D6cb
element truss [expr 5*$WallTag + 7] 10127 20021 $AsD6cb $D6cb
element truss [expr 5*$WallTag + 8] 10129 20019 $AsD6cb $D6cb
element truss [expr 5*$WallTag + 9] 10132 20026 $AsD6cb $D6cb
element truss [expr 5*$WallTag + 10] 10134 20024 $AsD6cb $D6cb
element truss [expr 5*$WallTag + 11] 10137 20031 $AsD6cb $D6cb
element truss [expr 5*$WallTag + 12] 10139 20029 $AsD6cb $D6cb
element truss [expr 5*$WallTag + 13] 10142 20036 $AsD6cb $D6cb
element truss [expr 5*$WallTag + 14] 10144 20034 $AsD6cb $D6cb

# diagonals complete area unconfined concrete
#element Truss2 [expr 6*$WallTag + 1] 10112 20006 20004 10114 $A_diag $uconc_diag
#element Truss2 [expr 6*$WallTag + 2] 10114 20004 20006 10112 $A_diag $uconc_diag
#element Truss2 [expr 6*$WallTag + 3] 10117 20011 20009 10119 $A_diag $uconc_diag
#element Truss2 [expr 6*$WallTag + 4] 10119 20009 20011 10117 $A_diag $uconc_diag
#element Truss2 [expr 6*$WallTag + 5] 10122 20016 20014 10124 $A_diag $uconc_diag
#element Truss2 [expr 6*$WallTag + 6] 10124 20014 20016 10122 $A_diag $uconc_diag
#element Truss2 [expr 6*$WallTag + 7] 10127 20021 20019 10129 $A_diag $uconc_diag
#element Truss2 [expr 6*$WallTag + 8] 10129 20019 20021 10127 $A_diag $uconc_diag
#element Truss2 [expr 6*$WallTag + 9] 10132 20026 20024 10134 $A_diag $uconc_diag
#element Truss2 [expr 6*$WallTag + 10] 10134 20024 20026 10132 $A_diag $uconc_diag
#element Truss2 [expr 6*$WallTag + 11] 10137 20031 20029 10139 $A_diag $uconc_diag
#element Truss2 [expr 6*$WallTag + 12] 10139 20029 20031 10137 $A_diag $uconc_diag
#element Truss2 [expr 6*$WallTag + 13] 10142 20036 20034 10144 $A_diag $uconc_diag
#element Truss2 [expr 6*$WallTag + 14] 10144 20034 20036 10142 $A_diag $uconc_diag

element truss [expr 6*$WallTag + 1] 10112 20006 $A_diag $uconc_diag
element truss [expr 6*$WallTag + 2] 10114 20004 $A_diag $uconc_diag
element truss [expr 6*$WallTag + 3] 10117 20011 $A_diag $uconc_diag
element truss [expr 6*$WallTag + 4] 10119 20009 $A_diag $uconc_diag
element truss [expr 6*$WallTag + 5] 10122 20016 $A_diag $uconc_diag
element truss [expr 6*$WallTag + 6] 10124 20014 $A_diag $uconc_diag
element truss [expr 6*$WallTag + 7] 10127 20021 $A_diag $uconc_diag
element truss [expr 6*$WallTag + 8] 10129 20019 $A_diag $uconc_diag
element truss [expr 6*$WallTag + 9] 10132 20026 $A_diag $uconc_diag
element truss [expr 6*$WallTag + 10] 10134 20024 $A_diag $uconc_diag
element truss [expr 6*$WallTag + 11] 10137 20031 $A_diag $uconc_diag
element truss [expr 6*$WallTag + 12] 10139 20029 $A_diag $uconc_diag
element truss [expr 6*$WallTag + 13] 10142 20036 $A_diag $uconc_diag
element truss [expr 6*$WallTag + 14] 10144 20034 $A_diag $uconc_diag

# horizontal unconfined concrete
#element truss $eleTag $iNode $jNode $A $matTag <-rho $rho> <-cMass $cFlag> <-doRayleigh $rFlag>
if {$flag_BTM} {
element truss [expr 8*$WallTag + 1] 10112 20004 $A_hor $uconc_hor
element truss [expr 8*$WallTag + 2] 10114 20006 $A_hor $uconc_hor
element truss [expr 8*$WallTag + 3] 10117 20009 $A_hor $uconc_hor
element truss [expr 8*$WallTag + 4] 10119 20011 $A_hor $uconc_hor
element truss [expr 8*$WallTag + 5] 10122 20014 $A_hor $uconc_hor
element truss [expr 8*$WallTag + 6] 10124 20016 $A_hor $uconc_hor
element truss [expr 8*$WallTag + 7] 10127 20019 $A_hor $uconc_hor
element truss [expr 8*$WallTag + 8] 10129 20021 $A_hor $uconc_hor
element truss [expr 8*$WallTag + 9] 10132 20024 $A_hor $uconc_hor
element truss [expr 8*$WallTag + 10] 10134 20026 $A_hor $uconc_hor
element truss [expr 8*$WallTag + 11] 10137 20029 $A_hor $uconc_hor
element truss [expr 8*$WallTag + 12] 10139 20031 $A_hor $uconc_hor
element truss [expr 8*$WallTag + 13] 10142 20034 $A_hor $uconc_hor
element truss [expr 8*$WallTag + 14] 10144 20036 $A_hor $uconc_hor
}

# horizontal rebar members
#element truss $eleTag $iNode $jNode $A $matTag <-rho $rho> <-cMass $cFlag> <-doRayleigh $rFlag>
if {$flag_BTM} {
element truss [expr 9*$WallTag + 1] 10112 20004 $AsD5cb $D5cb
element truss [expr 9*$WallTag + 2] 10114 20006 $AsD5cb $D5cb
element truss [expr 9*$WallTag + 3] 10117 20009 $AsD5cb $D5cb
element truss [expr 9*$WallTag + 4] 10119 20011 $AsD5cb $D5cb
element truss [expr 9*$WallTag + 5] 10122 20014 $AsD5cb $D5cb
element truss [expr 9*$WallTag + 6] 10124 20016 $AsD5cb $D5cb
element truss [expr 9*$WallTag + 7] 10127 20019 $AsD5cb $D5cb
element truss [expr 9*$WallTag + 8] 10129 20021 $AsD5cb $D5cb
element truss [expr 9*$WallTag + 9] 10132 20024 $AsD5cb $D5cb
element truss [expr 9*$WallTag + 10] 10134 20026 $AsD5cb $D5cb
element truss [expr 9*$WallTag + 11] 10137 20029 $AsD5cb $D5cb
element truss [expr 9*$WallTag + 12] 10139 20031 $AsD5cb $D5cb
element truss [expr 9*$WallTag + 13] 10142 20034 $AsD5cb $D5cb
element truss [expr 9*$WallTag + 14] 10144 20036 $AsD5cb $D5cb
}