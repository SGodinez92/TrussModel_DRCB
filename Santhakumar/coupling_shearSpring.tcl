# coupling3

# Equivalent truss models
# Data of the coupling beam
set bw 	[expr 76.*$mm]			
set h  	[expr 305.*$mm]
set ln 	[expr 381.*$mm]			
set alpha	[expr 30.*$pi/180.]
 
#Geometry
set d	[expr tan($alpha)*$ln];		# Distance between centroids of diagonal at interface of beam and wall
set I	[expr $bw*pow($h,3)/12];	# Moment of inertia
set r	[expr $ln/$h];				# Aspect ratio
set D	[expr pow($ln*$ln+$d*$d,0.5)]
set xi	[expr 1+2.88/($r*$r)]
set phi [expr 2*cos($alpha)*pow(sin($alpha),2)*$xi]

set A_diag [expr 12.*$I/($ln*$ln*$phi)];		# Equivalent truss area

set lambda [expr 314.7/(1.1*sqrt(30.)*2.5)]
set db [expr 10.*$mm]
set Keff [expr $D/($D+$db*$lambda)] 

puts "Keff $Keff D $D A_diag $A_diag"

# Flag to activate BTM analysis
set flag_BTM 0
#set rD10 0.542
#set rD6 0.570
set rD10 1
set rD6 1

# coupling beams materials
# rebar D10cb
set D10cb [expr 3*$WallTag + 7] 
set fy [expr 314.7458*$MPa/$rD10]  
set fu [expr 431.4051*$MPa/$rD10]
set Es [expr 200000*$MPa*$Keff]
set ey [expr $fy/$Es]
set esh [expr 0.022273/$rD10]
set eu [expr 0.2/$rD10]
#uniaxialMaterial SteelDRC $matTag $Es $fy $eu $fu $esh <-Psh $Psh> <-shPoint $esh1 $fsh1> <-omegaFactor $omegaFac> <-bausch $bauschType> <-fractStrain $eft> <-stiffOutput $stiffoption>
uniaxialMaterial SteelDRC $D10cb $Es $fy $eu $fu $esh -Psh 4 -omegaFactor 0.6 -bausch 0 -fractStrain [expr 1.2*$eu] -stiffOutput 0

# rebar D6cb
set D6cb [expr 3*$WallTag + 8]
set fy [expr 346.1169*$MPa/$rD6]  
set fu [expr 486.9079*$MPa/$rD6]
set Es [expr 200000*$MPa*$Keff]
set ey [expr $fy/$Es]
set esh [expr 0.0124/$rD6]
set eu [expr 0.2/$rD6]
#uniaxialMaterial SteelDRC $matTag $Es $fy $eu $fu $esh <-Psh $Psh> <-shPoint $esh1 $fsh1> <-omegaFactor $omegaFac> <-bausch $bauschType> <-fractStrain $eft> <-stiffOutput $stiffoption>
uniaxialMaterial SteelDRC $D6cb $Es $fy $eu $fu $esh -Psh 4.5 -omegaFactor 0.6 -bausch 0 -fractStrain [expr 1.2*$eu] -stiffOutput 0

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

# Hysteretic material
set shearSpring [expr 3*$WallTag + 100]

set e1 [expr 0.045*$in]
set e2 [expr 1.200*$in]
set e3 [expr 1.500*$in]

set s1 [expr 15.02*$kip]
set s2 [expr 18.89*$kip]
set s3 [expr 12.01*$kip]

set pinchx 0.40
set pinchy 0.20

uniaxialMaterial Hysteretic $shearSpring $s1 $e1 $s2 $e2 $s3 $e3 -$s1 -$e1 -$s2 -$e2 -$s3 -$e3 $pinchx $pinchy 0 0 0
#uniaxialMaterial Hysteretic $shearSpring $s1 $e1 $s2 $e2 -$s1 -$e1 -$s2 -$e2 $pinchx $pinchy 0 0 0

uniaxialMaterial Elastic [expr $shearSpring + 1] [expr $Ec*$bw*$h]


# ########### Geometry
set IncVPier1 [expr 0.2093*$m]
set IncVPier2 [expr 0.1645*$m]
set IncVPanel [expr 0.1342*$m]

set xo [expr 0.7087*$m - 3.*$IncH1]

set y1 [expr 3.*$IncVPier1+2.*$IncVPanel]
set y2 [expr $y1 + 3.*$IncVPier2+2.*$IncVPanel]
set y3 [expr $y2 + 3.*$IncVPier2+2.*$IncVPanel]
set y4 [expr $y3 + 3.*$IncVPier2+2.*$IncVPanel]
set y5 [expr $y4 + 3.*$IncVPier2+2.*$IncVPanel]
set y6 [expr $y5 + 3.*$IncVPier2+2.*$IncVPanel]
set y7 [expr $y6 + 3.*$IncVPier2+2.*$IncVPanel]

node 100001 0 $y1
node 100002 0 $y1
node 200001 0 $y2
node 200002 0 $y2
node 300001 0 $y3
node 300002 0 $y3
node 400001 0 $y4
node 400002 0 $y4
node 500001 0 $y5
node 500002 0 $y5
node 600001 0 $y6
node 600002 0 $y6
#node 700000 -$xo $y7
node 700001 0 $y7
node 700002 0 $y7
#node 700003 $xo $y7

element elasticBeamColumn 100001 10114 100001 [expr $bw*$h] $Ec [expr 0.0625*$I] 1
element elasticBeamColumn 100002 100002 20006 [expr $bw*$h] $Ec [expr 0.0625*$I] 1
element zeroLength 100003 100001 100002 -mat [expr $shearSpring + 1] $shearSpring -dir 1 2

element elasticBeamColumn 200001 10119 200001 [expr $bw*$h] $Ec [expr 0.0625*$I] 1
element elasticBeamColumn 200002 200002 20011 [expr $bw*$h] $Ec [expr 0.0625*$I] 1
element zeroLength 200003 200001 200002 -mat [expr $shearSpring + 1] $shearSpring -dir 1 2

element elasticBeamColumn 300001 10124 300001 [expr $bw*$h] $Ec [expr 0.0625*$I] 1
element elasticBeamColumn 300002 300002 20016 [expr $bw*$h] $Ec [expr 0.0625*$I] 1
element zeroLength 300003 300001 300002 -mat [expr $shearSpring + 1] $shearSpring -dir 1 2

element elasticBeamColumn 400001 10129 400001 [expr $bw*$h] $Ec [expr 0.0625*$I] 1
element elasticBeamColumn 400002 400002 20021 [expr $bw*$h] $Ec [expr 0.0625*$I] 1
element zeroLength 400003 400001 400002 -mat [expr $shearSpring + 1] $shearSpring -dir 1 2

element elasticBeamColumn 500001 10134 500001 [expr $bw*$h] $Ec [expr 0.0625*$I] 1
element elasticBeamColumn 500002 500002 20026 [expr $bw*$h] $Ec [expr 0.0625*$I] 1
element zeroLength 500003 500001 500002 -mat [expr $shearSpring + 1] $shearSpring -dir 1 2

element elasticBeamColumn 600001 10139 600001 [expr $bw*$h] $Ec [expr 0.0625*$I] 1
element elasticBeamColumn 600002 600002 20031 [expr $bw*$h] $Ec [expr 0.0625*$I] 1
element zeroLength 600003 600001 600002 -mat [expr $shearSpring + 1] $shearSpring -dir 1 2

#fix 10036 0 0 1
#fix 10144 0 0 1
#fix 20036 0 0 1
#fix 20144 0 0 1
#element elasticBeamColumn 700010 10036 10072 0.0 $Ec $I 1
#element elasticBeamColumn 700011 10072 10108 0.0 $Ec $I 1
#element elasticBeamColumn 700000 10108 10144 0.0 $Ec $I 1
element elasticBeamColumn 700001 10144 700001 [expr $bw*$h] $Ec [expr 0.0625*$I] 1
#element elasticBeamColumn 700001 700000 700001 [expr $bw*$h] $Ec [expr 0.0625*$I] 1
element elasticBeamColumn 700002 700002 20036 [expr $bw*$h] $Ec [expr 0.0625*$I] 1
#element elasticBeamColumn 700002 700002 700003 [expr $bw*$h] $Ec [expr 0.0625*$I] 1
element zeroLength 700003 700001 700002 -mat [expr $shearSpring + 1] $shearSpring -dir 1 2
#element elasticBeamColumn 700004 20036 20072 0.0 $Ec $I 1
#element elasticBeamColumn 700005 20072 20108 0.0 $Ec $I 1
#element elasticBeamColumn 700006 20108 20144 0.0 $Ec $I 1
element elasticBeamColumn 700005 20035 20036 0.0 $Ec $I 1
element elasticBeamColumn 700006 10143 10144 0.0 $Ec $I 1

#equalDOF 10036 10144 1
#equalDOF 20144 20036 1 