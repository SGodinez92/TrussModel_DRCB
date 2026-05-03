# materials
if {$dispflag} {puts "$np.$pid.$count materials"}; puts $recInput "materials" 
# unconfined concrete
puts $recInput "unconfined concrete"
set fc [expr -30.0060*$MPa]
set ec -0.002
set Ec [expr min(5000.*sqrt(abs($fc)/$MPa)*$MPa,2.*$fc/$ec)]
set fr [expr 0.55*5.3641*$MPa]
set et [expr $fr/$Ec]
set etres [expr 8.*$fr/$Ec]
puts $recInput "fc [expr $fc/$MPa]"
puts $recInput "ec $ec"
puts $recInput "Ec [expr $Ec/$MPa]"
puts $recInput "fr [expr $fr/$MPa]"
puts $recInput "et $et"
puts $recInput "etres $etres"

set IncVPier1 [expr 0.2093*$m]
set IncVPier2 [expr 0.1645*$m]
set IncVPanel [expr 0.1342*$m]
set IncH1 [expr 0.1602*$m]
set IncDPier1 [expr sqrt($IncVPier1*$IncVPier1 + $IncH1*$IncH1)]
set IncDPier2 [expr sqrt($IncVPier2*$IncVPier2 + $IncH1*$IncH1)]
set IncDPanel [expr sqrt($IncVPanel*$IncVPanel + $IncH1*$IncH1)]
#
#
# unconfined concrete inner boundary Pier1
if {$dispflag} {puts "$np.$pid.$count unconfined concrete inner boundary Pier1"}; puts $recInput "unconfined concrete inner boundary Pier1"
set uconc_ibP1 [expr $WallTag + 1]
set fcres [expr $fc*0.2]
set ecres [euReg $fc $Ec $ec $IncVPier1]
set fcint [expr ($fc + $fcres)/2.]
set ecint [expr ($ec + $ecres)/2.]
set ftR [expr $fr*1.]
set etR [expr $et*1.]
set ftresR [expr $fr*0.]
set etresR [etresReg $etres $IncVPier1]
set ftint [expr ($ftR + $ftresR)/2.]
set etint [expr ($etR + $etresR)/2.]
set alpha [expr abs(0.03*$fc/$ftR)]
set M [expr 75*0.030478/14.54]
puts $recInput "uconc_ibP1 $uconc_ibP1"
puts $recInput "fcres [expr $fcres/$MPa]"
puts $recInput "ecres $ecres"
puts $recInput "fcint [expr $fcint/$MPa]"
puts $recInput "ecint $ecint"
puts $recInput "ftR [expr $ftR/$MPa]"
puts $recInput "etR $etR"
puts $recInput "ftresR [expr $ftresR/$MPa]"
puts $recInput "etresR $etresR"
puts $recInput "ftint [expr $ftint/$MPa]"
puts $recInput "etint $etint"
puts $recInput "alpha $alpha"
puts $recInput "M $M"
#uniaxialMaterial ConcretewBeta $matTag $fpc $ec0 $fcint $ecint $fcres $ecres $ft $ftint $etint $ftres $etres <-lambda $lambda> <-alpha $alpha> <-beta $bint $ebint $bres $ebres> <-M $M> <-E $Ec> <-conf $fcc $ecc>
uniaxialMaterial ConcretewBeta $uconc_ibP1 $fc $ec $fcint $ecint $fcres $ecres $ftR $ftint $etint $ftresR $etresR -alpha $alpha -M $M -E $Ec
#
# unconfined concrete inner boundary Pier2
if {$dispflag} {puts "$np.$pid.$count unconfined concrete inner boundary Pier2"}; puts $recInput "unconfined concrete inner boundary Pier2"
set uconc_ibP2 [expr $WallTag + 2]
set fcres [expr $fc*0.2]
set ecres [euReg $fc $Ec $ec $IncVPier2]
set fcint [expr ($fc + $fcres)/2.]
set ecint [expr ($ec + $ecres)/2.]
set ftR [expr $fr*1.]
set etR [expr $et*1.]
set ftresR [expr $fr*0.]
set etresR [etresReg $etres $IncVPier2]
set ftint [expr ($ftR + $ftresR)/2.]
set etint [expr ($etR + $etresR)/2.]
set alpha [expr abs(0.03*$fc/$ftR)]
set M [expr 75*0.030478/14.54]
puts $recInput "uconc_ibP2 $uconc_ibP2"
puts $recInput "fcres [expr $fcres/$MPa]"
puts $recInput "ecres $ecres"
puts $recInput "fcint [expr $fcint/$MPa]"
puts $recInput "ecint $ecint"
puts $recInput "ftR [expr $ftR/$MPa]"
puts $recInput "etR $etR"
puts $recInput "ftresR [expr $ftresR/$MPa]"
puts $recInput "etresR $etresR"
puts $recInput "ftint [expr $ftint/$MPa]"
puts $recInput "etint $etint"
puts $recInput "alpha $alpha"
puts $recInput "M $M"
#uniaxialMaterial ConcretewBeta $matTag $fpc $ec0 $fcint $ecint $fcres $ecres $ft $ftint $etint $ftres $etres <-lambda $lambda> <-alpha $alpha> <-beta $bint $ebint $bres $ebres> <-M $M> <-E $Ec> <-conf $fcc $ecc>
uniaxialMaterial ConcretewBeta $uconc_ibP2 $fc $ec $fcint $ecint $fcres $ecres $ftR $ftint $etint $ftresR $etresR -alpha $alpha -M $M -E $Ec
#
# unconfined concrete inner boundary Panel
if {$dispflag} {puts "$np.$pid.$count unconfined concrete inner boundary Panel"}; puts $recInput "unconfined concrete inner boundary Panel"
set uconc_ibPa [expr $WallTag + 3]
set fcres [expr $fc*0.2]
set ecres [euReg $fc $Ec $ec [expr $IncVPanel/2.]]
set fcint [expr ($fc + $fcres)/2.]
set ecint [expr ($ec + $ecres)/2.]
set ftR [expr $fr*1.]
set etR [expr $et*1.]
set ftresR [expr $fr*0.]
set etresR [etresReg $etres [expr $IncVPanel/2.]]
set ftint [expr ($ftR + $ftresR)/2.]
set etint [expr ($etR + $etresR)/2.]
set alpha [expr abs(0.03*$fc/$ftR)]
set M [expr 75*0.030478/14.54]
puts $recInput "uconc_ibPa $uconc_ibPa"
puts $recInput "fcres [expr $fcres/$MPa]"
puts $recInput "ecres $ecres"
puts $recInput "fcint [expr $fcint/$MPa]"
puts $recInput "ecint $ecint"
puts $recInput "ftR [expr $ftR/$MPa]"
puts $recInput "etR $etR"
puts $recInput "ftresR [expr $ftresR/$MPa]"
puts $recInput "etresR $etresR"
puts $recInput "ftint [expr $ftint/$MPa]"
puts $recInput "etint $etint"
puts $recInput "alpha $alpha"
puts $recInput "M $M"
#uniaxialMaterial ConcretewBeta $matTag $fpc $ec0 $fcint $ecint $fcres $ecres $ft $ftint $etint $ftres $etres <-lambda $lambda> <-alpha $alpha> <-beta $bint $ebint $bres $ebres> <-M $M> <-E $Ec> <-conf $fcc $ecc>
uniaxialMaterial ConcretewBeta $uconc_ibPa $fc $ec $fcint $ecint $fcres $ecres $ftR $ftint $etint $ftresR $etresR -alpha $alpha -M $M -E $Ec
#
#
# boundaryA
# unconfined concrete outer boundaryA Pier1
if {$dispflag} {puts "$np.$pid.$count unconfined concrete outer boundaryA Pier1"}; puts $recInput "unconfined concrete outer boundaryA Pier1"
set uconc_obAP1 [expr $WallTag + 4]
set fcres [expr $fc*0.2]
set ecres [euReg $fc $Ec $ec $IncVPier1]
set fcint [expr ($fc + $fcres)/2.]
set ecint [expr ($ec + $ecres)/2.]
set ftR [expr $fr*1.]
set etR [expr $et*1.]
set ftresR [expr $fr*0.]
set etresR [etresReg $etres $IncVPier1]
set ftint [expr ($ftR + $ftresR)/2.]
set etint [expr ($etR + $etresR)/2.]
set alpha [expr abs(0.03*$fc/$ftR)]
set M [expr 75*0.106516/15.88]
puts $recInput "uconc_obAP1 $uconc_obAP1"
puts $recInput "fcres [expr $fcres/$MPa]"
puts $recInput "ecres $ecres"
puts $recInput "fcint [expr $fcint/$MPa]"
puts $recInput "ecint $ecint"
puts $recInput "ftR [expr $ftR/$MPa]"
puts $recInput "etR $etR"
puts $recInput "ftresR [expr $ftresR/$MPa]"
puts $recInput "etresR $etresR"
puts $recInput "ftint [expr $ftint/$MPa]"
puts $recInput "etint $etint"
puts $recInput "alpha $alpha"
puts $recInput "M $M"
#uniaxialMaterial ConcretewBeta $matTag $fpc $ec0 $fcint $ecint $fcres $ecres $ft $ftint $etint $ftres $etres <-lambda $lambda> <-alpha $alpha> <-beta $bint $ebint $bres $ebres> <-M $M> <-E $Ec> <-conf $fcc $ecc>
uniaxialMaterial ConcretewBeta $uconc_obAP1 $fc $ec $fcint $ecint $fcres $ecres $ftR $ftint $etint $ftresR $etresR -alpha $alpha -M $M -E $Ec
#
# unconfined concrete outer boundaryA Pier2
if {$dispflag} {puts "$np.$pid.$count unconfined concrete outer boundaryA Pier2"}; puts $recInput "unconfined concrete outer boundaryA Pier2"
set uconc_obAP2 [expr $WallTag + 5]
set fcres [expr $fc*0.2]
set ecres [euReg $fc $Ec $ec $IncVPier2]
set fcint [expr ($fc + $fcres)/2.]
set ecint [expr ($ec + $ecres)/2.]
set ftR [expr $fr*1.]
set etR [expr $et*1.]
set ftresR [expr $fr*0.]
set etresR [etresReg $etres $IncVPier2]
set ftint [expr ($ftR + $ftresR)/2.]
set etint [expr ($etR + $etresR)/2.]
set alpha [expr abs(0.03*$fc/$ftR)]
set M [expr 75*0.106516/15.88]
puts $recInput "uconc_obAP2 $uconc_obAP2"
puts $recInput "fcres [expr $fcres/$MPa]"
puts $recInput "ecres $ecres"
puts $recInput "fcint [expr $fcint/$MPa]"
puts $recInput "ecint $ecint"
puts $recInput "ftR [expr $ftR/$MPa]"
puts $recInput "etR $etR"
puts $recInput "ftresR [expr $ftresR/$MPa]"
puts $recInput "etresR $etresR"
puts $recInput "ftint [expr $ftint/$MPa]"
puts $recInput "etint $etint"
puts $recInput "alpha $alpha"
puts $recInput "M $M"
#uniaxialMaterial ConcretewBeta $matTag $fpc $ec0 $fcint $ecint $fcres $ecres $ft $ftint $etint $ftres $etres <-lambda $lambda> <-alpha $alpha> <-beta $bint $ebint $bres $ebres> <-M $M> <-E $Ec> <-conf $fcc $ecc>
uniaxialMaterial ConcretewBeta $uconc_obAP2 $fc $ec $fcint $ecint $fcres $ecres $ftR $ftint $etint $ftresR $etresR -alpha $alpha -M $M -E $Ec
#
# unconfined concrete outer boundaryA Panel
if {$dispflag} {puts "$np.$pid.$count unconfined concrete outer boundaryA Panel"}; puts $recInput "unconfined concrete outer boundaryA Panel"
set uconc_obAPa [expr $WallTag + 6]
set fcres [expr $fc*0.2]
set ecres [euReg $fc $Ec $ec $IncVPanel]
set fcint [expr ($fc + $fcres)/2.]
set ecint [expr ($ec + $ecres)/2.]
set ftR [expr $fr*1.]
set etR [expr $et*1.]
set ftresR [expr $fr*0.]
set etresR [etresReg $etres $IncVPanel]
set ftint [expr ($ftR + $ftresR)/2.]
set etint [expr ($etR + $etresR)/2.]
set alpha [expr abs(0.03*$fc/$ftR)]
set M [expr 75*0.106516/15.88]
puts $recInput "uconc_obAPa $uconc_obAPa"
puts $recInput "fcres [expr $fcres/$MPa]"
puts $recInput "ecres $ecres"
puts $recInput "fcint [expr $fcint/$MPa]"
puts $recInput "ecint $ecint"
puts $recInput "ftR [expr $ftR/$MPa]"
puts $recInput "etR $etR"
puts $recInput "ftresR [expr $ftresR/$MPa]"
puts $recInput "etresR $etresR"
puts $recInput "ftint [expr $ftint/$MPa]"
puts $recInput "etint $etint"
puts $recInput "alpha $alpha"
puts $recInput "M $M"
#uniaxialMaterial ConcretewBeta $matTag $fpc $ec0 $fcint $ecint $fcres $ecres $ft $ftint $etint $ftres $etres <-lambda $lambda> <-alpha $alpha> <-beta $bint $ebint $bres $ebres> <-M $M> <-E $Ec> <-conf $fcc $ecc>
uniaxialMaterial ConcretewBeta $uconc_obAPa $fc $ec $fcint $ecint $fcres $ecres $ftR $ftint $etint $ftresR $etresR -alpha $alpha -M $M -E $Ec
#
# boundaryB
# unconfined concrete outer boundaryB Pier2
if {$dispflag} {puts "$np.$pid.$count unconfined concrete outer boundaryB Pier2"}; puts $recInput "unconfined concrete outer boundaryB Pier2"
set uconc_obBP2 [expr $WallTag + 7]
set fcres [expr $fc*0.2]
set ecres [euReg $fc $Ec $ec $IncVPier2]
set fcint [expr ($fc + $fcres)/2.]
set ecint [expr ($ec + $ecres)/2.]
set ftR [expr $fr*1.]
set etR [expr $et*1.]
set ftresR [expr $fr*0.]
set etresR [etresReg $etres $IncVPier2]
set ftint [expr ($ftR + $ftresR)/2.]
set etint [expr ($etR + $etresR)/2.]
set alpha [expr abs(0.03*$fc/$ftR)]
set M [expr 75*0.085213/15.88]
puts $recInput "uconc_obBP2 $uconc_obBP2"
puts $recInput "fcres [expr $fcres/$MPa]"
puts $recInput "ecres $ecres"
puts $recInput "fcint [expr $fcint/$MPa]"
puts $recInput "ecint $ecint"
puts $recInput "ftR [expr $ftR/$MPa]"
puts $recInput "etR $etR"
puts $recInput "ftresR [expr $ftresR/$MPa]"
puts $recInput "etresR $etresR"
puts $recInput "ftint [expr $ftint/$MPa]"
puts $recInput "etint $etint"
puts $recInput "alpha $alpha"
puts $recInput "M $M"
#uniaxialMaterial ConcretewBeta $matTag $fpc $ec0 $fcint $ecint $fcres $ecres $ft $ftint $etint $ftres $etres <-lambda $lambda> <-alpha $alpha> <-beta $bint $ebint $bres $ebres> <-M $M> <-E $Ec> <-conf $fcc $ecc>
uniaxialMaterial ConcretewBeta $uconc_obBP2 $fc $ec $fcint $ecint $fcres $ecres $ftR $ftint $etint $ftresR $etresR -alpha $alpha -M $M -E $Ec
#
# unconfined concrete outer boundaryB Panel
if {$dispflag} {puts "$np.$pid.$count unconfined concrete outer boundaryB Panel"}; puts $recInput "unconfined concrete outer boundaryB Panel"
set uconc_obBPa [expr $WallTag + 8]
set fcres [expr $fc*0.2]
set ecres [euReg $fc $Ec $ec $IncVPanel]
set fcint [expr ($fc + $fcres)/2.]
set ecint [expr ($ec + $ecres)/2.]
set ftR [expr $fr*1.]
set etR [expr $et*1.]
set ftresR [expr $fr*0.]
set etresR [etresReg $etres $IncVPanel]
set ftint [expr ($ftR + $ftresR)/2.]
set etint [expr ($etR + $etresR)/2.]
set alpha [expr abs(0.03*$fc/$ftR)]
set M [expr 75*0.085213/15.88]
puts $recInput "uconc_obBPa $uconc_obBPa"
puts $recInput "fcres [expr $fcres/$MPa]"
puts $recInput "ecres $ecres"
puts $recInput "fcint [expr $fcint/$MPa]"
puts $recInput "ecint $ecint"
puts $recInput "ftR [expr $ftR/$MPa]"
puts $recInput "etR $etR"
puts $recInput "ftresR [expr $ftresR/$MPa]"
puts $recInput "etresR $etresR"
puts $recInput "ftint [expr $ftint/$MPa]"
puts $recInput "etint $etint"
puts $recInput "alpha $alpha"
puts $recInput "M $M"
#uniaxialMaterial ConcretewBeta $matTag $fpc $ec0 $fcint $ecint $fcres $ecres $ft $ftint $etint $ftres $etres <-lambda $lambda> <-alpha $alpha> <-beta $bint $ebint $bres $ebres> <-M $M> <-E $Ec> <-conf $fcc $ecc>
uniaxialMaterial ConcretewBeta $uconc_obBPa $fc $ec $fcint $ecint $fcres $ecres $ftR $ftint $etint $ftresR $etresR -alpha $alpha -M $M -E $Ec
#
# boundaryC
# unconfined concrete outer boundaryC Pier2
if {$dispflag} {puts "$np.$pid.$count unconfined concrete outer boundaryC Pier2"}; puts $recInput "unconfined concrete outer boundaryC Pier2"
set uconc_obCP2 [expr $WallTag + 9]
set fcres [expr $fc*0.2]
set ecres [euReg $fc $Ec $ec $IncVPier2]
set fcint [expr ($fc + $fcres)/2.]
set ecint [expr ($ec + $ecres)/2.]
set ftR [expr $fr*1.]
set etR [expr $et*1.]
set ftresR [expr $fr*0.]
set etresR [etresReg $etres $IncVPier2]
set ftint [expr ($ftR + $ftresR)/2.]
set etint [expr ($etR + $etresR)/2.]
set alpha [expr abs(0.03*$fc/$ftR)]
set M [expr 75*0.063910/15.88]
puts $recInput "uconc_obCP2 $uconc_obCP2"
puts $recInput "fcres [expr $fcres/$MPa]"
puts $recInput "ecres $ecres"
puts $recInput "fcint [expr $fcint/$MPa]"
puts $recInput "ecint $ecint"
puts $recInput "ftR [expr $ftR/$MPa]"
puts $recInput "etR $etR"
puts $recInput "ftresR [expr $ftresR/$MPa]"
puts $recInput "etresR $etresR"
puts $recInput "ftint [expr $ftint/$MPa]"
puts $recInput "etint $etint"
puts $recInput "alpha $alpha"
puts $recInput "M $M"
#uniaxialMaterial ConcretewBeta $matTag $fpc $ec0 $fcint $ecint $fcres $ecres $ft $ftint $etint $ftres $etres <-lambda $lambda> <-alpha $alpha> <-beta $bint $ebint $bres $ebres> <-M $M> <-E $Ec> <-conf $fcc $ecc>
uniaxialMaterial ConcretewBeta $uconc_obCP2 $fc $ec $fcint $ecint $fcres $ecres $ftR $ftint $etint $ftresR $etresR -alpha $alpha -M $M -E $Ec
#
# unconfined concrete outer boundaryC Panel
if {$dispflag} {puts "$np.$pid.$count unconfined concrete outer boundaryC Panel"}; puts $recInput "unconfined concrete outer boundaryC Panel"
set uconc_obCPa [expr $WallTag + 10]
set fcres [expr $fc*0.2]
set ecres [euReg $fc $Ec $ec $IncVPanel]
set fcint [expr ($fc + $fcres)/2.]
set ecint [expr ($ec + $ecres)/2.]
set ftR [expr $fr*1.]
set etR [expr $et*1.]
set ftresR [expr $fr*0.]
set etresR [etresReg $etres $IncVPanel]
set ftint [expr ($ftR + $ftresR)/2.]
set etint [expr ($etR + $etresR)/2.]
set alpha [expr abs(0.03*$fc/$ftR)]
set M [expr 75*0.063910/15.88]
puts $recInput "uconc_obCPa $uconc_obCPa"
puts $recInput "fcres [expr $fcres/$MPa]"
puts $recInput "ecres $ecres"
puts $recInput "fcint [expr $fcint/$MPa]"
puts $recInput "ecint $ecint"
puts $recInput "ftR [expr $ftR/$MPa]"
puts $recInput "etR $etR"
puts $recInput "ftresR [expr $ftresR/$MPa]"
puts $recInput "etresR $etresR"
puts $recInput "ftint [expr $ftint/$MPa]"
puts $recInput "etint $etint"
puts $recInput "alpha $alpha"
puts $recInput "M $M"
#uniaxialMaterial ConcretewBeta $matTag $fpc $ec0 $fcint $ecint $fcres $ecres $ft $ftint $etint $ftres $etres <-lambda $lambda> <-alpha $alpha> <-beta $bint $ebint $bres $ebres> <-M $M> <-E $Ec> <-conf $fcc $ecc>
uniaxialMaterial ConcretewBeta $uconc_obCPa $fc $ec $fcint $ecint $fcres $ecres $ftR $ftint $etint $ftresR $etresR -alpha $alpha -M $M -E $Ec
#
# boundaryD
# unconfined concrete outer boundaryD Pier2
if {$dispflag} {puts "$np.$pid.$count unconfined concrete outer boundaryD Pier2"}; puts $recInput "unconfined concrete outer boundaryD Pier2"
set uconc_obDP2 [expr $WallTag + 11]
set fcres [expr $fc*0.2]
set ecres [euReg $fc $Ec $ec $IncVPier2]
set fcint [expr ($fc + $fcres)/2.]
set ecint [expr ($ec + $ecres)/2.]
set ftR [expr $fr*1.]
set etR [expr $et*1.]
set ftresR [expr $fr*0.]
set etresR [etresReg $etres $IncVPier2]
set ftint [expr ($ftR + $ftresR)/2.]
set etint [expr ($etR + $etresR)/2.]
set alpha [expr abs(0.03*$fc/$ftR)]
set M [expr 75*0.042606/15.88]
puts $recInput "uconc_obDP2 $uconc_obDP2"
puts $recInput "fcres [expr $fcres/$MPa]"
puts $recInput "ecres $ecres"
puts $recInput "fcint [expr $fcint/$MPa]"
puts $recInput "ecint $ecint"
puts $recInput "ftR [expr $ftR/$MPa]"
puts $recInput "etR $etR"
puts $recInput "ftresR [expr $ftresR/$MPa]"
puts $recInput "etresR $etresR"
puts $recInput "ftint [expr $ftint/$MPa]"
puts $recInput "etint $etint"
puts $recInput "alpha $alpha"
puts $recInput "M $M"
#uniaxialMaterial ConcretewBeta $matTag $fpc $ec0 $fcint $ecint $fcres $ecres $ft $ftint $etint $ftres $etres <-lambda $lambda> <-alpha $alpha> <-beta $bint $ebint $bres $ebres> <-M $M> <-E $Ec> <-conf $fcc $ecc>
uniaxialMaterial ConcretewBeta $uconc_obDP2 $fc $ec $fcint $ecint $fcres $ecres $ftR $ftint $etint $ftresR $etresR -alpha $alpha -M $M -E $Ec
#
# unconfined concrete outer boundaryD Panel
if {$dispflag} {puts "$np.$pid.$count unconfined concrete outer boundaryD Panel"}; puts $recInput "unconfined concrete outer boundaryD Panel"
set uconc_obDPa [expr $WallTag + 12]
set fcres [expr $fc*0.2]
set ecres [euReg $fc $Ec $ec $IncVPanel]
set fcint [expr ($fc + $fcres)/2.]
set ecint [expr ($ec + $ecres)/2.]
set ftR [expr $fr*1.]
set etR [expr $et*1.]
set ftresR [expr $fr*0.]
set etresR [etresReg $etres $IncVPanel]
set ftint [expr ($ftR + $ftresR)/2.]
set etint [expr ($etR + $etresR)/2.]
set alpha [expr abs(0.03*$fc/$ftR)]
set M [expr 75*0.042606/15.88]
puts $recInput "uconc_obDPa $uconc_obDPa"
puts $recInput "fcres [expr $fcres/$MPa]"
puts $recInput "ecres $ecres"
puts $recInput "fcint [expr $fcint/$MPa]"
puts $recInput "ecint $ecint"
puts $recInput "ftR [expr $ftR/$MPa]"
puts $recInput "etR $etR"
puts $recInput "ftresR [expr $ftresR/$MPa]"
puts $recInput "etresR $etresR"
puts $recInput "ftint [expr $ftint/$MPa]"
puts $recInput "etint $etint"
puts $recInput "alpha $alpha"
puts $recInput "M $M"
#uniaxialMaterial ConcretewBeta $matTag $fpc $ec0 $fcint $ecint $fcres $ecres $ft $ftint $etint $ftres $etres <-lambda $lambda> <-alpha $alpha> <-beta $bint $ebint $bres $ebres> <-M $M> <-E $Ec> <-conf $fcc $ecc>
uniaxialMaterial ConcretewBeta $uconc_obDPa $fc $ec $fcint $ecint $fcres $ecres $ftR $ftint $etint $ftresR $etresR -alpha $alpha -M $M -E $Ec
#
#
# vertical inner
# unconfined concrete inner vertical Pier1
if {$dispflag} {puts "$np.$pid.$count unconfined concrete inner vertical Pier1"}; puts $recInput "unconfined concrete inner vertical Pier1"
set uconc_ivP1 [expr $WallTag + 13]
set fcres [expr $fc*0.2]
set ecres [euReg $fc $Ec $ec $IncVPier1]
set fcint [expr ($fc + $fcres)/2.]
set ecint [expr ($ec + $ecres)/2.]
set ftR [expr $fr*1.]
set etR [expr $et*1.]
set ftresR [expr $fr*0.]
set etresR [etresReg $etres $IncVPier1]
set ftint [expr ($ftR + $ftresR)/2.]
set etint [expr ($etR + $etresR)/2.]
set alpha [expr abs(0.03*$fc/$ftR)]
set M [expr 75*0.001689/6.35]
puts $recInput "uconc_ivP1 $uconc_ivP1"
puts $recInput "fcres [expr $fcres/$MPa]"
puts $recInput "ecres $ecres"
puts $recInput "fcint [expr $fcint/$MPa]"
puts $recInput "ecint $ecint"
puts $recInput "ftR [expr $ftR/$MPa]"
puts $recInput "etR $etR"
puts $recInput "ftresR [expr $ftresR/$MPa]"
puts $recInput "etresR $etresR"
puts $recInput "ftint [expr $ftint/$MPa]"
puts $recInput "etint $etint"
puts $recInput "alpha $alpha"
puts $recInput "M $M"
#uniaxialMaterial ConcretewBeta $matTag $fpc $ec0 $fcint $ecint $fcres $ecres $ft $ftint $etint $ftres $etres <-lambda $lambda> <-alpha $alpha> <-beta $bint $ebint $bres $ebres> <-M $M> <-E $Ec> <-conf $fcc $ecc>
uniaxialMaterial ConcretewBeta $uconc_ivP1 $fc $ec $fcint $ecint $fcres $ecres $ftR $ftint $etint $ftresR $etresR -alpha $alpha -M $M -E $Ec
#
# unconfined concrete inner vertical Pier2
if {$dispflag} {puts "$np.$pid.$count unconfined concrete inner vertical Pier2"}; puts $recInput "unconfined concrete inner vertical Pier2"
set uconc_ivP2 [expr $WallTag + 14]
set fcres [expr $fc*0.2]
set ecres [euReg $fc $Ec $ec $IncVPier2]
set fcint [expr ($fc + $fcres)/2.]
set ecint [expr ($ec + $ecres)/2.]
set ftR [expr $fr*1.]
set etR [expr $et*1.]
set ftresR [expr $fr*0.]
set etresR [etresReg $etres $IncVPier2]
set ftint [expr ($ftR + $ftresR)/2.]
set etint [expr ($etR + $etresR)/2.]
set alpha [expr abs(0.03*$fc/$ftR)]
set M [expr 75*0.001689/6.35]
puts $recInput "uconc_ivP2 $uconc_ivP2"
puts $recInput "fcres [expr $fcres/$MPa]"
puts $recInput "ecres $ecres"
puts $recInput "fcint [expr $fcint/$MPa]"
puts $recInput "ecint $ecint"
puts $recInput "ftR [expr $ftR/$MPa]"
puts $recInput "etR $etR"
puts $recInput "ftresR [expr $ftresR/$MPa]"
puts $recInput "etresR $etresR"
puts $recInput "ftint [expr $ftint/$MPa]"
puts $recInput "etint $etint"
puts $recInput "alpha $alpha"
puts $recInput "M $M"
#uniaxialMaterial ConcretewBeta $matTag $fpc $ec0 $fcint $ecint $fcres $ecres $ft $ftint $etint $ftres $etres <-lambda $lambda> <-alpha $alpha> <-beta $bint $ebint $bres $ebres> <-M $M> <-E $Ec> <-conf $fcc $ecc>
uniaxialMaterial ConcretewBeta $uconc_ivP2 $fc $ec $fcint $ecint $fcres $ecres $ftR $ftint $etint $ftresR $etresR -alpha $alpha -M $M -E $Ec
#
# unconfined concrete inner vertical Panel
if {$dispflag} {puts "$np.$pid.$count unconfined concrete inner vertical Panel"}; puts $recInput "unconfined concrete inner vertical Panel"
set uconc_ivPa [expr $WallTag + 15]
set fcres [expr $fc*0.2]
set ecres [euReg $fc $Ec $ec $IncVPanel]
set fcint [expr ($fc + $fcres)/2.]
set ecint [expr ($ec + $ecres)/2.]
set ftR [expr $fr*1.]
set etR [expr $et*1.]
set ftresR [expr $fr*0.]
set etresR [etresReg $etres $IncVPanel]
set ftint [expr ($ftR + $ftresR)/2.]
set etint [expr ($etR + $etresR)/2.]
set alpha [expr abs(0.03*$fc/$ftR)]
set M [expr 75*0.001689/6.35]
puts $recInput "uconc_ivPa $uconc_ivPa"
puts $recInput "fcres [expr $fcres/$MPa]"
puts $recInput "ecres $ecres"
puts $recInput "fcint [expr $fcint/$MPa]"
puts $recInput "ecint $ecint"
puts $recInput "ftR [expr $ftR/$MPa]"
puts $recInput "etR $etR"
puts $recInput "ftresR [expr $ftresR/$MPa]"
puts $recInput "etresR $etresR"
puts $recInput "ftint [expr $ftint/$MPa]"
puts $recInput "etint $etint"
puts $recInput "alpha $alpha"
puts $recInput "M $M"
#uniaxialMaterial ConcretewBeta $matTag $fpc $ec0 $fcint $ecint $fcres $ecres $ft $ftint $etint $ftres $etres <-lambda $lambda> <-alpha $alpha> <-beta $bint $ebint $bres $ebres> <-M $M> <-E $Ec> <-conf $fcc $ecc>
uniaxialMaterial ConcretewBeta $uconc_ivPa $fc $ec $fcint $ecint $fcres $ecres $ftR $ftint $etint $ftresR $etresR -alpha $alpha -M $M -E $Ec
#
# unconfined concrete inner vertical anchor Pier1
if {$dispflag} {puts "$np.$pid.$count unconfined concrete inner vertical anchor Pier1"}; puts $recInput "unconfined concrete inner vertical anchor Pier1"
set uconc_iaP1 [expr $WallTag + 16]
set fcres [expr $fc*0.2]
set ecres [euReg $fc $Ec $ec [expr $IncVPier1/2.]]
set fcint [expr ($fc + $fcres)/2.]
set ecint [expr ($ec + $ecres)/2.]
set ftR [expr $fr*1.]
set etR [expr $et*1.]
set ftresR [expr $fr*0.]
set etresR [etresReg $etres [expr $IncVPier1/2.]]
set ftint [expr ($ftR + $ftresR)/2.]
set etint [expr ($etR + $etresR)/2.]
set alpha [expr abs(0.03*$fc/$ftR)]
set M [expr 75*0.001689/6.35]
puts $recInput "uconc_iaP1 $uconc_iaP1"
puts $recInput "fcres [expr $fcres/$MPa]"
puts $recInput "ecres $ecres"
puts $recInput "fcint [expr $fcint/$MPa]"
puts $recInput "ecint $ecint"
puts $recInput "ftR [expr $ftR/$MPa]"
puts $recInput "etR $etR"
puts $recInput "ftresR [expr $ftresR/$MPa]"
puts $recInput "etresR $etresR"
puts $recInput "ftint [expr $ftint/$MPa]"
puts $recInput "etint $etint"
puts $recInput "alpha $alpha"
puts $recInput "M $M"
#uniaxialMaterial ConcretewBeta $matTag $fpc $ec0 $fcint $ecint $fcres $ecres $ft $ftint $etint $ftres $etres <-lambda $lambda> <-alpha $alpha> <-beta $bint $ebint $bres $ebres> <-M $M> <-E $Ec> <-conf $fcc $ecc>
uniaxialMaterial ConcretewBeta $uconc_iaP1 $fc $ec $fcint $ecint $fcres $ecres $ftR $ftint $etint $ftresR $etresR -alpha $alpha -M $M -E $Ec
#
# unconfined concrete inner vertical anchor Pier2
if {$dispflag} {puts "$np.$pid.$count unconfined concrete inner vertical anchor Pier2"}; puts $recInput "unconfined concrete inner vertical anchor Pier2"
set uconc_iaP2 [expr $WallTag + 17]
set fcres [expr $fc*0.2]
set ecres [euReg $fc $Ec $ec [expr $IncVPier2/2.]]
set fcint [expr ($fc + $fcres)/2.]
set ecint [expr ($ec + $ecres)/2.]
set ftR [expr $fr*1.]
set etR [expr $et*1.]
set ftresR [expr $fr*0.]
set etresR [etresReg $etres [expr $IncVPier2/2.]]
set ftint [expr ($ftR + $ftresR)/2.]
set etint [expr ($etR + $etresR)/2.]
set alpha [expr abs(0.03*$fc/$ftR)]
set M [expr 75*0.001689/6.35]
puts $recInput "uconc_iaP2 $uconc_iaP2"
puts $recInput "fcres [expr $fcres/$MPa]"
puts $recInput "ecres $ecres"
puts $recInput "fcint [expr $fcint/$MPa]"
puts $recInput "ecint $ecint"
puts $recInput "ftR [expr $ftR/$MPa]"
puts $recInput "etR $etR"
puts $recInput "ftresR [expr $ftresR/$MPa]"
puts $recInput "etresR $etresR"
puts $recInput "ftint [expr $ftint/$MPa]"
puts $recInput "etint $etint"
puts $recInput "alpha $alpha"
puts $recInput "M $M"
#uniaxialMaterial ConcretewBeta $matTag $fpc $ec0 $fcint $ecint $fcres $ecres $ft $ftint $etint $ftres $etres <-lambda $lambda> <-alpha $alpha> <-beta $bint $ebint $bres $ebres> <-M $M> <-E $Ec> <-conf $fcc $ecc>
uniaxialMaterial ConcretewBeta $uconc_iaP2 $fc $ec $fcint $ecint $fcres $ecres $ftR $ftint $etint $ftresR $etresR -alpha $alpha -M $M -E $Ec
#
#
# vertical outer
# unconfined concrete outer vertical Pier1
if {$dispflag} {puts "$np.$pid.$count unconfined concrete outer vertical Pier1"}; puts $recInput "unconfined concrete outer vertical Pier1"
set uconc_ovP1 [expr $WallTag + 18]
set fcres [expr $fc*0.2]
set ecres [euReg $fc $Ec $ec $IncVPier1]
set fcint [expr ($fc + $fcres)/2.]
set ecint [expr ($ec + $ecres)/2.]
set ftR [expr $fr*1.]
set etR [expr $et*1.]
set ftresR [expr $fr*0.]
set etresR [etresReg $etres $IncVPier1]
set ftint [expr ($ftR + $ftresR)/2.]
set etint [expr ($etR + $etresR)/2.]
set alpha [expr abs(0.03*$fc/$ftR)]
set M [expr 75*0.002670/6.35]
puts $recInput "uconc_ovP1 $uconc_ovP1"
puts $recInput "fcres [expr $fcres/$MPa]"
puts $recInput "ecres $ecres"
puts $recInput "fcint [expr $fcint/$MPa]"
puts $recInput "ecint $ecint"
puts $recInput "ftR [expr $ftR/$MPa]"
puts $recInput "etR $etR"
puts $recInput "ftresR [expr $ftresR/$MPa]"
puts $recInput "etresR $etresR"
puts $recInput "ftint [expr $ftint/$MPa]"
puts $recInput "etint $etint"
puts $recInput "alpha $alpha"
puts $recInput "M $M"
#uniaxialMaterial ConcretewBeta $matTag $fpc $ec0 $fcint $ecint $fcres $ecres $ft $ftint $etint $ftres $etres <-lambda $lambda> <-alpha $alpha> <-beta $bint $ebint $bres $ebres> <-M $M> <-E $Ec> <-conf $fcc $ecc>
uniaxialMaterial ConcretewBeta $uconc_ovP1 $fc $ec $fcint $ecint $fcres $ecres $ftR $ftint $etint $ftresR $etresR -alpha $alpha -M $M -E $Ec
#
# unconfined concrete outer vertical Pier2
if {$dispflag} {puts "$np.$pid.$count unconfined concrete outer vertical Pier2"}; puts $recInput "unconfined concrete outer vertical Pier2"
set uconc_ovP2 [expr $WallTag + 19]
set fcres [expr $fc*0.2]
set ecres [euReg $fc $Ec $ec $IncVPier2]
set fcint [expr ($fc + $fcres)/2.]
set ecint [expr ($ec + $ecres)/2.]
set ftR [expr $fr*1.]
set etR [expr $et*1.]
set ftresR [expr $fr*0.]
set etresR [etresReg $etres $IncVPier2]
set ftint [expr ($ftR + $ftresR)/2.]
set etint [expr ($etR + $etresR)/2.]
set alpha [expr abs(0.03*$fc/$ftR)]
set M [expr 75*0.002670/6.35]
puts $recInput "uconc_ovP2 $uconc_ovP2"
puts $recInput "fcres [expr $fcres/$MPa]"
puts $recInput "ecres $ecres"
puts $recInput "fcint [expr $fcint/$MPa]"
puts $recInput "ecint $ecint"
puts $recInput "ftR [expr $ftR/$MPa]"
puts $recInput "etR $etR"
puts $recInput "ftresR [expr $ftresR/$MPa]"
puts $recInput "etresR $etresR"
puts $recInput "ftint [expr $ftint/$MPa]"
puts $recInput "etint $etint"
puts $recInput "alpha $alpha"
puts $recInput "M $M"
#uniaxialMaterial ConcretewBeta $matTag $fpc $ec0 $fcint $ecint $fcres $ecres $ft $ftint $etint $ftres $etres <-lambda $lambda> <-alpha $alpha> <-beta $bint $ebint $bres $ebres> <-M $M> <-E $Ec> <-conf $fcc $ecc>
uniaxialMaterial ConcretewBeta $uconc_ovP2 $fc $ec $fcint $ecint $fcres $ecres $ftR $ftint $etint $ftresR $etresR -alpha $alpha -M $M -E $Ec
#
# unconfined concrete outer vertical Panel
if {$dispflag} {puts "$np.$pid.$count unconfined concrete outer vertical Panel"}; puts $recInput "unconfined concrete outer vertical Panel"
set uconc_ovPa [expr $WallTag + 20]
set fcres [expr $fc*0.2]
set ecres [euReg $fc $Ec $ec $IncVPanel]
set fcint [expr ($fc + $fcres)/2.]
set ecint [expr ($ec + $ecres)/2.]
set ftR [expr $fr*1.]
set etR [expr $et*1.]
set ftresR [expr $fr*0.]
set etresR [etresReg $etres $IncVPanel]
set ftint [expr ($ftR + $ftresR)/2.]
set etint [expr ($etR + $etresR)/2.]
set alpha [expr abs(0.03*$fc/$ftR)]
set M [expr 75*0.002670/6.35]
puts $recInput "uconc_ovPa $uconc_ovPa"
puts $recInput "fcres [expr $fcres/$MPa]"
puts $recInput "ecres $ecres"
puts $recInput "fcint [expr $fcint/$MPa]"
puts $recInput "ecint $ecint"
puts $recInput "ftR [expr $ftR/$MPa]"
puts $recInput "etR $etR"
puts $recInput "ftresR [expr $ftresR/$MPa]"
puts $recInput "etresR $etresR"
puts $recInput "ftint [expr $ftint/$MPa]"
puts $recInput "etint $etint"
puts $recInput "alpha $alpha"
puts $recInput "M $M"
#uniaxialMaterial ConcretewBeta $matTag $fpc $ec0 $fcint $ecint $fcres $ecres $ft $ftint $etint $ftres $etres <-lambda $lambda> <-alpha $alpha> <-beta $bint $ebint $bres $ebres> <-M $M> <-E $Ec> <-conf $fcc $ecc>
uniaxialMaterial ConcretewBeta $uconc_ovPa $fc $ec $fcint $ecint $fcres $ecres $ftR $ftint $etint $ftresR $etresR -alpha $alpha -M $M -E $Ec
#
#
# unconfined concrete horizontal
if {$dispflag} {puts "$np.$pid.$count unconfined concrete horizonatal"}; puts $recInput "unconfined concrete horizonatal"
set uconc_h [expr $WallTag + 21]
set fcres [expr $fc*0.2]
set ecres [euReg $fc $Ec $ec $IncH1]
set fcint [expr ($fc + $fcres)/2.]
set ecint [expr ($ec + $ecres)/2.]
set ftR [expr $fr*0.01]
set etR [expr $et*0.01]
set ftresR [expr $fr*0.]
set etresR [etresReg $etres $IncH1]
set ftint [expr ($ftR + $ftresR)/2.]
set etint [expr ($etR + $etresR)/2.]
set alpha [expr abs(0.03*$fc/$ftR)]
puts $recInput "uconc_h $uconc_h"
puts $recInput "fcres [expr $fcres/$MPa]"
puts $recInput "ecres $ecres"
puts $recInput "fcint [expr $fcint/$MPa]"
puts $recInput "ecint $ecint"
puts $recInput "ftR [expr $ftR/$MPa]"
puts $recInput "etR $etR"
puts $recInput "ftresR [expr $ftresR/$MPa]"
puts $recInput "etresR $etresR"
puts $recInput "ftint [expr $ftint/$MPa]"
puts $recInput "etint $etint"
puts $recInput "alpha $alpha"
#uniaxialMaterial ConcretewBeta $matTag $fpc $ec0 $fcint $ecint $fcres $ecres $ft $ftint $etint $ftres $etres <-lambda $lambda> <-alpha $alpha> <-beta $bint $ebint $bres $ebres> <-M $M> <-E $Ec> <-conf $fcc $ecc>
uniaxialMaterial ConcretewBeta $uconc_h $fc $ec $fcint $ecint $fcres $ecres $ftR $ftint $etint $ftresR $etresR -alpha $alpha -E $Ec
#
#
# biaxial concrete diagonal Pier1 
if {$dispflag} {puts "$np.$pid.$count biaxial concrete diagonal Pier1"}; puts $recInput "biaxial concrete diagonal Pier1"
set bconc_dP1 [expr $WallTag + 22]
set fcres [expr $fc*0.2]
set ecres [euReg $fc $Ec $ec $IncDPier1]
set fcint [expr ($fc + $fcres)/2.]
set ecint [expr ($ec + $ecres)/2.]
set ftR [expr $fr*0.01]
set etR [expr $et*0.01]
set ftresR [expr $fr*0.]
set etresR [etresReg $etres $IncDPier1]
set ftint [expr ($ftR + $ftresR)/2.]
set etint [expr ($etR + $etresR)/2.]
set alpha [expr abs(0.03*$fc/$ftR)]
set eb [BetaReg $IncDPier1]
puts $recInput "bconc_dP1 $bconc_dP1"
puts $recInput "fcres [expr $fcres/$MPa]"
puts $recInput "ecres $ecres"
puts $recInput "fcint [expr $fcint/$MPa]"
puts $recInput "ecint $ecint"
puts $recInput "ftR [expr $ftR/$MPa]"
puts $recInput "etR $etR"
puts $recInput "ftresR [expr $ftresR/$MPa]"
puts $recInput "etresR $etresR"
puts $recInput "ftint [expr $ftint/$MPa]"
puts $recInput "etint $etint"
puts $recInput "alpha $alpha"
puts $recInput "eb $eb"
#uniaxialMaterial ConcretewBeta $matTag $fpc $ec0 $fcint $ecint $fcres $ecres $ft $ftint $etint $ftres $etres <-lambda $lambda> <-alpha $alpha> <-beta $bint $ebint $bres $ebres> <-M $M> <-E $Ec> <-conf $fcc $ecc>
uniaxialMaterial ConcretewBeta $bconc_dP1 $fc $ec $fcint $ecint $fcres $ecres $ftR $ftint $etint $ftresR $etresR -alpha $alpha  -beta 0.4 [lindex $eb 0] 0.1 [lindex $eb 1] -E $Ec
#
#
# biaxial concrete diagonal Pier2 
if {$dispflag} {puts "$np.$pid.$count biaxial concrete diagonal Pier2"}; puts $recInput "biaxial concrete diagonal Pier2"
set bconc_dP2 [expr $WallTag + 23]
set fcres [expr $fc*0.2]
set ecres [euReg $fc $Ec $ec $IncDPier2]
set fcint [expr ($fc + $fcres)/2.]
set ecint [expr ($ec + $ecres)/2.]
set ftR [expr $fr*0.01]
set etR [expr $et*0.01]
set ftresR [expr $fr*0.]
set etresR [etresReg $etres $IncDPier2]
set ftint [expr ($ftR + $ftresR)/2.]
set etint [expr ($etR + $etresR)/2.]
set alpha [expr abs(0.03*$fc/$ftR)]
set eb [BetaReg $IncDPier2]
puts $recInput "bconc_dP2 $bconc_dP2"
puts $recInput "fcres [expr $fcres/$MPa]"
puts $recInput "ecres $ecres"
puts $recInput "fcint [expr $fcint/$MPa]"
puts $recInput "ecint $ecint"
puts $recInput "ftR [expr $ftR/$MPa]"
puts $recInput "etR $etR"
puts $recInput "ftresR [expr $ftresR/$MPa]"
puts $recInput "etresR $etresR"
puts $recInput "ftint [expr $ftint/$MPa]"
puts $recInput "etint $etint"
puts $recInput "alpha $alpha"
puts $recInput "eb $eb"
#uniaxialMaterial ConcretewBeta $matTag $fpc $ec0 $fcint $ecint $fcres $ecres $ft $ftint $etint $ftres $etres <-lambda $lambda> <-alpha $alpha> <-beta $bint $ebint $bres $ebres> <-M $M> <-E $Ec> <-conf $fcc $ecc>
uniaxialMaterial ConcretewBeta $bconc_dP2 $fc $ec $fcint $ecint $fcres $ecres $ftR $ftint $etint $ftresR $etresR -alpha $alpha  -beta 0.4 [lindex $eb 0] 0.1 [lindex $eb 1] -E $Ec
#
#
# biaxial concrete diagonal Panel 
if {$dispflag} {puts "$np.$pid.$count biaxial concrete diagonal Panel"}; puts $recInput "biaxial concrete diagonal Panel"
set bconc_dPa [expr $WallTag + 24]
set fcres [expr $fc*0.2]
set ecres [euReg $fc $Ec $ec $IncDPanel]
set fcint [expr ($fc + $fcres)/2.]
set ecint [expr ($ec + $ecres)/2.]
set ftR [expr $fr*0.01]
set etR [expr $et*0.01]
set ftresR [expr $fr*0.]
set etresR [etresReg $etres $IncDPanel]
set ftint [expr ($ftR + $ftresR)/2.]
set etint [expr ($etR + $etresR)/2.]
set alpha [expr abs(0.03*$fc/$ftR)]
set eb [BetaReg $IncDPanel]
puts $recInput "bconc_dPa $bconc_dPa"
puts $recInput "fcres [expr $fcres/$MPa]"
puts $recInput "ecres $ecres"
puts $recInput "fcint [expr $fcint/$MPa]"
puts $recInput "ecint $ecint"
puts $recInput "ftR [expr $ftR/$MPa]"
puts $recInput "etR $etR"
puts $recInput "ftresR [expr $ftresR/$MPa]"
puts $recInput "etresR $etresR"
puts $recInput "ftint [expr $ftint/$MPa]"
puts $recInput "etint $etint"
puts $recInput "alpha $alpha"
puts $recInput "eb $eb"
#uniaxialMaterial ConcretewBeta $matTag $fpc $ec0 $fcint $ecint $fcres $ecres $ft $ftint $etint $ftres $etres <-lambda $lambda> <-alpha $alpha> <-beta $bint $ebint $bres $ebres> <-M $M> <-E $Ec> <-conf $fcc $ecc>
uniaxialMaterial ConcretewBeta $bconc_dPa $fc $ec $fcint $ecint $fcres $ecres $ftR $ftint $etint $ftresR $etresR -alpha $alpha  -beta 0.4 [lindex $eb 0] 0.1 [lindex $eb 1] -E $Ec
#
#
# rebar D16
if {$dispflag} {puts "$np.$pid.$count rebar D16"}; puts $recInput "rebar D16" 
set D16 [expr $WallTag + 25] 
set fy [expr 304.7483*$MPa]  
set fu [expr 471.6014*$MPa]
set Es [expr 200000*$MPa]
set ey [expr $fy/$Es]
set esh 0.024150
set eu 0.2
puts $recInput "D16 $D16"
puts $recInput "fy [expr $fy/$MPa]"
puts $recInput "fu [expr $fu/$MPa]"
puts $recInput "ey $ey"
puts $recInput "Es [expr $Es/$MPa]"
puts $recInput "esh $esh"
puts $recInput "eu $eu"
#uniaxialMaterial SteelDRC $matTag $Es $fy $eu $fu $esh <-Psh $Psh> <-shPoint $esh1 $fsh1> <-omegaFactor $omegaFac> <-bausch $bauschType> <-fractStrain $eft> <-stiffOutput $stiffoption>
uniaxialMaterial SteelDRC $D16 $Es $fy $eu $fu $esh -Psh 4 -omegaFactor 0.6 -bausch 0 -fractStrain [expr 1.2*$eu] -stiffOutput 0
#
# rebar D6h
if {$dispflag} {puts "$np.$pid.$count rebar D6h"}; puts $recInput "rebar D6h"
set D6h [expr $WallTag + 26] 
set fy [expr 351.6327*$MPa]  
set fu [expr 497.8016*$MPa]
set Es [expr 200000*$MPa]
set ey [expr $fy/$Es]
set esh 0.0124
set eu 0.2
puts $recInput "D6h $D6h"
puts $recInput "fy [expr $fy/$MPa]"
puts $recInput "fu [expr $fu/$MPa]"
puts $recInput "ey $ey"
puts $recInput "Es [expr $Es/$MPa]"
puts $recInput "esh $esh"
puts $recInput "eu $eu"
#uniaxialMaterial SteelDRC $matTag $Es $fy $eu $fu $esh <-Psh $Psh> <-shPoint $esh1 $fsh1> <-omegaFactor $omegaFac> <-bausch $bauschType> <-fractStrain $eft> <-stiffOutput $stiffoption>
uniaxialMaterial SteelDRC $D6h $Es $fy $eu $fu $esh -Psh 4.5 -omegaFactor 0.6 -bausch 0 -fractStrain [expr 1.2*$eu] -stiffOutput 0
#
# rebar D6v
if {$dispflag} {puts "$np.$pid.$count rebar D6v"}; puts $recInput "rebar D6v"
set D6v [expr $WallTag + 27]
set fy [expr 343.3589*$MPa]  
set fu [expr 487.4593*$MPa]
set Es [expr 200000*$MPa]
set ey [expr $fy/$Es]
set esh 0.0124
set eu 0.2
puts $recInput "D6v $D6v"
puts $recInput "fy [expr $fy/$MPa]"
puts $recInput "fu [expr $fu/$MPa]"
puts $recInput "ey $ey"
puts $recInput "Es [expr $Es/$MPa]"
puts $recInput "esh $esh"
puts $recInput "eu $eu"
#uniaxialMaterial SteelDRC $matTag $Es $fy $eu $fu $esh <-Psh $Psh> <-shPoint $esh1 $fsh1> <-omegaFactor $omegaFac> <-bausch $bauschType> <-fractStrain $eft> <-stiffOutput $stiffoption>
uniaxialMaterial SteelDRC $D6v $Es $fy $eu $fu $esh -Psh 4.5 -omegaFactor 0.6 -bausch 0 -fractStrain [expr 1.2*$eu] -stiffOutput 0
