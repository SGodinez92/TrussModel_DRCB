# geoWall1
if {$dispflag} {puts "$np.$pid.$count geometry Wall1"}; puts $recInput "geometry Wall1"
# nodes Wall1
if {$dispflag} {puts "$np.$pid.$count nodes Wall1"}; puts $recInput "nodes Wall1"
set LIncV [list $IncVPier1 $IncVPier1 $IncVPier1 $IncVPanel $IncVPanel\
                $IncVPier2 $IncVPier2 $IncVPier2 $IncVPanel $IncVPanel\
				$IncVPier2 $IncVPier2 $IncVPier2 $IncVPanel $IncVPanel\
				$IncVPier2 $IncVPier2 $IncVPier2 $IncVPanel $IncVPanel\
				$IncVPier2 $IncVPier2 $IncVPier2 $IncVPanel $IncVPanel\
				$IncVPier2 $IncVPier2 $IncVPier2 $IncVPanel $IncVPanel\
				$IncVPier2 $IncVPier2 $IncVPier2 $IncVPanel $IncVPanel]
set LIncH [list $IncH1 $IncH1 $IncH1]

set xo [expr -0.7087*$m]
set coordx $xo
set NodeNum 1
for {set VerAxis 1} {$VerAxis <= $NumHorInc + 1} {incr VerAxis} {
	if {$VerAxis == 1} {
		set IncH 0.
	} else {
	    set IncH [lindex $LIncH [expr $VerAxis-2]]
	}	
	set coordx [expr $coordx + $IncH]
	set coordy 0.
	for {set HorAxis 1} {$HorAxis <= $NumVerInc + 1} {incr HorAxis} {
		set nodeTag [expr $WallTag + $NodeNum]		
		if {$HorAxis == 1} {
			set IncV 0.
		} else {
			set IncV [lindex $LIncV [expr $HorAxis-2]]
		}		
		set coordy [expr $coordy + $IncV]
		#node $nodeTag (ndm $coords) <-mass (ndf $massValues)> 		
		node $nodeTag $coordx $coordy
		puts $recInput "node $nodeTag [expr $coordx/$m] [expr $coordy/$m]"		
		incr NodeNum		
	}	
}

# fix Wall1
if {$dispflag} {puts "$np.$pid.$count fix Wall1"}; puts $recInput "fix Wall1"
# fix base
for {set VerAxis 1} {$VerAxis <= $NumHorInc + 1} {incr VerAxis} {
	set nodeTag [expr $WallTag + ($VerAxis-1)*($NumVerInc+1) + 1]
	#fix $nodeTag (ndf $constrValues)
	if {$strainpFlag} {
		fix $nodeTag 1 0 1
		puts $recInput "fix $nodeTag 1 0 1"
    } else {
		fix $nodeTag 1 1 1
		puts $recInput "fix $nodeTag 1 1 1"
	}	
}
# fix trusses
for {set VerAxis 2} {$VerAxis <= $NumHorInc} {incr VerAxis} {
	for {set HorAxis 2} {$HorAxis <= $NumVerInc + 1} {incr HorAxis} {
		#fix $nodeTag (ndf $constrValues)
		set nodeTag [expr $WallTag + ($VerAxis-1)*$NumVerInc + $HorAxis + $VerAxis - 1]
		fix $nodeTag 0 0 1	    
	    puts $recInput "fix $nodeTag 0 0 1"		
	}
}

# elements Wall1
if {$dispflag} {puts "$np.$pid.$count elements Wall1"}; puts $recInput "elements Wall1"
# geotrans
if {$dispflag} {puts "$np.$pid.$count geotrans"}; puts $recInput "geotrans"
set transfTagVer 1
geomTransf Linear $transfTagVer
set transfTagHor 2
geomTransf Linear $transfTagHor
puts $recInput "geomTransf Linear $transfTagVer"
puts $recInput "geomTransf Linear $transfTagHor"

# Wall1 outer boundary
if {$dispflag} {puts "$np.$pid.$count Wall1 outer boundary"}; puts $recInput "Wall1 outer boundary"   
set Lsec [list $sec_W1obAP1 $sec_W1obAP1 $sec_W1obAP1 $sec_W1obAPa $sec_W1obAPa\
               $sec_W1obAP2 $sec_W1obAP2 $sec_W1obAP2 $sec_W1obAPa $sec_W1obAPa\
               $sec_W1obBP2 $sec_W1obBP2 $sec_W1obBP2 $sec_W1obBPa $sec_W1obBPa\
               $sec_W1obCP2 $sec_W1obCP2 $sec_W1obCP2 $sec_W1obCPa $sec_W1obCPa\
               $sec_W1obCP2 $sec_W1obCP2 $sec_W1obDP2 $sec_W1obDPa $sec_W1obDPa\
               $sec_W1obDP2 $sec_W1obDP2 $sec_W1obDP2 $sec_W1obDPa $sec_W1obDPa\
               $sec_W1obDP2 $sec_W1obDP2 $sec_W1obDP2 $sec_W1obDPa $sec_W1obDPa]
set VerAxis 1
set NodeNum 1
set ElemNum 1
for {set HorAxis 1} {$HorAxis <= $NumVerInc} {incr HorAxis} {
	set eleTag [expr $WallTag + $VerElemTag + ($VerAxis-1)*$NumVerInc + $HorAxis]	
	set iNode [expr $WallTag + ($VerAxis-1)*$NumVerInc + $HorAxis + $VerAxis - 1]
	set jNode [expr $WallTag + ($VerAxis-1)*$NumVerInc + $HorAxis + $VerAxis]
	set secTag [lindex $Lsec [expr $HorAxis-1]]	
	#element dispBeamColumn $eleTag $iNode $jNode $numIntgrPts $secTag $transfTag <-mass $massDens> <-cMass> <-integration $intType> 
	element dispBeamColumn $eleTag $iNode $jNode $NipBound $secTag $transfTagVer -integration Lobatto
	puts $recInput "element dispBeamColumn $eleTag $iNode $jNode $NipBound $secTag $transfTagVer -integration Lobbato"
}

# Wall1 inner boundary
if {$dispflag} {puts "$np.$pid.$count Wall1 inner boundary"}; puts $recInput "Wall1 inner boundary"   
set Lsec [list $sec_W1ibP1 $sec_W1ibP1 $sec_W1ibP1 $sec_W1ibPa $sec_W1ibPa\
               $sec_W1ibP2 $sec_W1ibP2 $sec_W1ibP2 $sec_W1ibPa $sec_W1ibPa\
			   $sec_W1ibP2 $sec_W1ibP2 $sec_W1ibP2 $sec_W1ibPa $sec_W1ibPa\
			   $sec_W1ibP2 $sec_W1ibP2 $sec_W1ibP2 $sec_W1ibPa $sec_W1ibPa\
			   $sec_W1ibP2 $sec_W1ibP2 $sec_W1ibP2 $sec_W1ibPa $sec_W1ibPa\
			   $sec_W1ibP2 $sec_W1ibP2 $sec_W1ibP2 $sec_W1ibPa $sec_W1ibPa\
			   $sec_W1ibP2 $sec_W1ibP2 $sec_W1ibP2 $sec_W1ibPa $sec_W1ibPa]			   
set VerAxis [expr $NumHorInc + 1]
set NodeNum 1
set ElemNum 1
set ii 1
set cc 1
set Lyo [list [expr 0.7620*$m] [expr 1.5240*$m] [expr 2.2860*$m] [expr 3.0480*$m] [expr 3.8100*$m] [expr 4.5720*$m] [expr 5.3340*$m]]
for {set HorAxis 1} {$HorAxis <= $NumVerInc} {incr HorAxis} {
	set eleTag [expr $WallTag + $VerElemTag + ($VerAxis-1)*$NumVerInc + $HorAxis]	
	set iNode [expr $WallTag + ($VerAxis-1)*$NumVerInc + $HorAxis + $VerAxis - 1]
	set jNode [expr $WallTag + ($VerAxis-1)*$NumVerInc + $HorAxis + $VerAxis]
	set secTag [lindex $Lsec [expr $HorAxis-1]]
	#if {$HorAxis == 4  || $HorAxis == 5  || \
	#    $HorAxis == 9  || $HorAxis == 10 || \
	#	$HorAxis == 14 || $HorAxis == 15 || \
	#	$HorAxis == 19 || $HorAxis == 20 || \
	#	$HorAxis == 24 || $HorAxis == 25 || \
	#	$HorAxis == 29 || $HorAxis == 30 || \
	#	$HorAxis == 34 || $HorAxis == 35} {
	#	set yo [lindex $Lyo [expr $cc - 1]]
	#	set offnode [expr 39*($cc-1)]
	#	if {$ii == 1} {
	#	    set ijNode [expr 3*$WallTag + $offnode + 2] 
	#		node $ijNode [expr -0.2280*$m] [expr $yo - 0.0671*$m]
	#		set ii 2
	#	} else {
	#		set ijNode [expr 3*$WallTag + $offnode + 5] 
	#		node $ijNode [expr -0.2280*$m] [expr $yo + 0.0671*$m]	
	#		incr cc
	#		set ii 1
	#	}
	#	#element dispBeamColumn $eleTag $iNode $jNode $numIntgrPts $secTag $transfTag <-mass $massDens> <-cMass> <-integration $intType> 
	#	element dispBeamColumn $eleTag $iNode $ijNode $NipBound $secTag $transfTagVer -integration Lobatto
	#	element dispBeamColumn [expr $eleTag + 500] $ijNode $jNode $NipBound $secTag $transfTagVer -integration Lobatto
	#	puts $recInput "element dispBeamColumn $eleTag $iNode $ijNode $NipBound $secTag $transfTagVer -integration Lobatto"
	#	puts $recInput "element dispBeamColumn [expr $eleTag + 500] $ijNode $jNode $NipBound $secTag $transfTagVer -integration Lobatto"			
	#} else {
		#element dispBeamColumn $eleTag $iNode $jNode $numIntgrPts $secTag $transfTag <-mass $massDens> <-cMass> <-integration $intType> 
		element dispBeamColumn $eleTag $iNode $jNode $NipBound $secTag $transfTagVer -integration Lobatto
		puts $recInput "element dispBeamColumn $eleTag $iNode $jNode $NipBound $secTag $transfTagVer -integration Lobbato"
	#}	
}

# Wall1 outer vertical field element
if {$dispflag} {puts "$np.$pid.$count Wall1 outer vertical field element"}; puts $recInput "Wall1 outer vertical field element"
set Lmat [list $uconc_ovP1 $uconc_ovP1 $uconc_ovP1 $uconc_ovPa $uconc_ovPa\
               $uconc_ovP2 $uconc_ovP2 $uconc_ovP2 $uconc_ovPa $uconc_ovPa\
			   $uconc_ovP2 $uconc_ovP2 $uconc_ovP2 $uconc_ovPa $uconc_ovPa\
			   $uconc_ovP2 $uconc_ovP2 $uconc_ovP2 $uconc_ovPa $uconc_ovPa\
			   $uconc_ovP2 $uconc_ovP2 $uconc_ovP2 $uconc_ovPa $uconc_ovPa\
			   $uconc_ovP2 $uconc_ovP2 $uconc_ovP2 $uconc_ovPa $uconc_ovPa\
			   $uconc_ovP2 $uconc_ovP2 $uconc_ovP2 $uconc_ovPa $uconc_ovPa]			   
set VerAxis 2
for {set HorAxis 1} {$HorAxis <= $NumVerInc} {incr HorAxis} {
	set eleTag [expr $WallTag + $VerElemTag + ($VerAxis-1)*$NumVerInc + $HorAxis]	
	set iNode [expr $WallTag + ($VerAxis-1)*$NumVerInc + $HorAxis + $VerAxis - 1]
	set jNode [expr $WallTag + ($VerAxis-1)*$NumVerInc + $HorAxis + $VerAxis]	
	set matTag [lindex $Lmat [expr $HorAxis-1]]
	#element truss $eleTag $iNode $jNode $A $matTag <-rho $rho> <-cMass $cFlag> <-doRayleigh $rFlag>  
	element truss $eleTag $iNode $jNode $Ac_ov $matTag
	element truss [expr $eleTag + 1000] $iNode $jNode $As_ov $D6v
	puts $recInput "element truss $eleTag $iNode $jNode $Ac_ov $matTag"
	puts $recInput "element truss [expr $eleTag + 1000] $iNode $jNode $As_ov $D6v"
}

# Wall1 inner vertical field element
if {$dispflag} {puts "$np.$pid.$count Wall1 inner vertical field element"}; puts $recInput "Wall1 inner vertical field element"
set Lmat [list $uconc_ivP1 $uconc_ivP1 $uconc_iaP1 $uconc_ivPa $uconc_ivPa\
               $uconc_iaP2 $uconc_ivP2 $uconc_iaP2 $uconc_ivPa $uconc_ivPa\
			   $uconc_iaP2 $uconc_ivP2 $uconc_iaP2 $uconc_ivPa $uconc_ivPa\
			   $uconc_iaP2 $uconc_ivP2 $uconc_iaP2 $uconc_ivPa $uconc_ivPa\
			   $uconc_iaP2 $uconc_ivP2 $uconc_iaP2 $uconc_ivPa $uconc_ivPa\
			   $uconc_iaP2 $uconc_ivP2 $uconc_iaP2 $uconc_ivPa $uconc_ivPa\
			   $uconc_iaP2 $uconc_ivP2 $uconc_iaP2 $uconc_ivPa $uconc_ivPa]
set VerAxis 3
set ii 1
set cc 1
for {set HorAxis 1} {$HorAxis <= $NumVerInc} {incr HorAxis} {
	set eleTag [expr $WallTag + $VerElemTag + ($VerAxis-1)*$NumVerInc + $HorAxis]	
	set iNode [expr $WallTag + ($VerAxis-1)*$NumVerInc + $HorAxis + $VerAxis - 1]
	set jNode [expr $WallTag + ($VerAxis-1)*$NumVerInc + $HorAxis + $VerAxis]	
	set matTag [lindex $Lmat [expr $HorAxis-1]]
	#if {$HorAxis == 3  || $HorAxis == 6  || \
	#    $HorAxis == 8  || $HorAxis == 11 || \
	#	$HorAxis == 13 || $HorAxis == 16 || \
	#	$HorAxis == 18 || $HorAxis == 21 || \
	#	$HorAxis == 23 || $HorAxis == 26 || \
	#	$HorAxis == 28 || $HorAxis == 31 || \
	#	$HorAxis == 33} {
	#	set yo [lindex $Lyo [expr $cc - 1]]
	#	set offnode [expr 39*($cc-1)]
	#	if {$ii == 1} {
	#	    set ijNode [expr 3*$WallTag + $offnode + 29]
	#		node $ijNode [expr -0.3882*$m] [expr $yo - 0.2286*$m]
	#		set ii 2
	#	} elseif {$HorAxis != 36} {
	#		set ijNode [expr 3*$WallTag + $offnode + 35] 
	#		node $ijNode [expr -0.3882*$m] [expr $yo + 0.2286*$m]	
	#		incr cc
	#		set ii 1
	#	}
	#	#element truss $eleTag $iNode $jNode $A $matTag <-rho $rho> <-cMass $cFlag> <-doRayleigh $rFlag>  
	#	element truss $eleTag               $iNode  $ijNode $Ac_iv $matTag
	#	element truss [expr $eleTag + 1000] $iNode  $ijNode $As_iv $D6v
	#	element truss [expr $eleTag + 500]  $ijNode $jNode  $Ac_iv $matTag
	#	element truss [expr $eleTag + 1500] $ijNode $jNode  $As_iv $D6v	
	#	puts $recInput "element truss $eleTag               $iNode  $ijNode $Ac_iv $matTag"
	#	puts $recInput "element truss [expr $eleTag + 1000] $iNode  $ijNode $As_iv $D6v"
	#	puts $recInput "element truss [expr $eleTag + 500]  $ijNode $jNode  $Ac_iv $matTag"
	#	puts $recInput "element truss [expr $eleTag + 1500] $ijNode $jNode  $As_iv $D6v"		
	#} else {
		#element truss $eleTag $iNode $jNode $A $matTag <-rho $rho> <-cMass $cFlag> <-doRayleigh $rFlag>  
		element truss $eleTag $iNode $jNode $Ac_iv $matTag
		element truss [expr $eleTag + 1000] $iNode $jNode $As_iv $D6v
		puts $recInput "element truss $eleTag $iNode $jNode $Ac_iv $matTag"
		puts $recInput "element truss [expr $eleTag + 1000] $iNode $jNode $As_iv $D6v"	
	#}
}

# Wall1 horizontal elements
if {$dispflag} {puts "$np.$pid.$count Wall1 horizontal elements"}; puts $recInput "Wall1 horizontal elements"
set LAs [list $As_hA1 $As_hA1 $As_hA2 $As_hA3 $As_hA4\
              $As_hA5 $As_hA5 $As_hA4 $As_hA3 $As_hA4\
              $As_hA5 $As_hA5 $As_hB1 $As_hB2 $As_hB3\
			  $As_hB4 $As_hB4 $As_hC1 $As_hC2 $As_hC3\
              $As_hC4 $As_hC4 $As_hC3 $As_hC2 $As_hD1\
			  $As_hD2 $As_hD2 $As_hD3 $As_hD4 $As_hD3\
			  $As_hD2 $As_hD2 $As_hD3 $As_hD4 $As_hD5]
set LAc [list $Ac_hA1 $Ac_hA1 $Ac_hA2 $Ac_hA3 $Ac_hA4\
              $Ac_hA5 $Ac_hA5 $Ac_hA4 $Ac_hA3 $Ac_hA4\
              $Ac_hA5 $Ac_hA5 $Ac_hB1 $Ac_hB2 $Ac_hB3\
			  $Ac_hB4 $Ac_hB4 $Ac_hC1 $Ac_hC2 $Ac_hC3\
              $Ac_hC4 $Ac_hC4 $Ac_hC3 $Ac_hC2 $Ac_hD1\
			  $Ac_hD2 $Ac_hD2 $Ac_hD3 $Ac_hD4 $Ac_hD3\
			  $Ac_hD2 $Ac_hD2 $Ac_hD3 $Ac_hD4 $Ac_hD5]			  
for {set HorAxis 2} {$HorAxis <= $NumVerInc + 1} {incr HorAxis} {
	for {set VerAxis 1} {$VerAxis <= $NumHorInc} {incr VerAxis} {
		set eleTag [expr $WallTag + $HorElemTag + ($HorAxis-1)*$NumHorInc + $VerAxis]
		set iNode [expr $WallTag + ($VerAxis-1)*($NumVerInc+1) + $HorAxis]
        set jNode [expr $WallTag + $VerAxis*($NumVerInc+1) + $HorAxis]
		set AsTag [lindex $LAs [expr $HorAxis-2]]
		set AcTag [lindex $LAc [expr $HorAxis-2]]
		#element truss $eleTag $iNode $jNode $A $matTag <-rho $rho> <-cMass $cFlag> <-doRayleigh $rFlag>  
		element truss $eleTag $iNode $jNode $AcTag $uconc_h
		element truss [expr $eleTag + 1000] $iNode $jNode $AsTag $D6h
		puts $recInput "element truss $eleTag $iNode $jNode $AcTag $uconc_h"
		puts $recInput "element truss [expr $eleTag + 1000] $iNode $jNode $AsTag $D6h"
				
	}
}

# Wall1 diagonal elements 
if {$dispflag} {puts "$np.$pid.$count Wall1 diagonal elements"}; puts $recInput "Wall1 diagonal elements"
set Lare [list $AreaDiaP1 $AreaDiaP1 $AreaDiaP1 $AreaDiaPa $AreaDiaPa\
               $AreaDiaP2 $AreaDiaP2 $AreaDiaP2 $AreaDiaPa $AreaDiaPa\
               $AreaDiaP2 $AreaDiaP2 $AreaDiaP2 $AreaDiaPa $AreaDiaPa\
			   $AreaDiaP2 $AreaDiaP2 $AreaDiaP2 $AreaDiaPa $AreaDiaPa\
			   $AreaDiaP2 $AreaDiaP2 $AreaDiaP2 $AreaDiaPa $AreaDiaPa\
			   $AreaDiaP2 $AreaDiaP2 $AreaDiaP2 $AreaDiaPa $AreaDiaPa\
			   $AreaDiaP2 $AreaDiaP2 $AreaDiaP2 $AreaDiaPa $AreaDiaPa]
set Lmat [list $bconc_dP1 $bconc_dP1 $bconc_dP1 $bconc_dPa $bconc_dPa\
               $bconc_dP2 $bconc_dP2 $bconc_dP2 $bconc_dPa $bconc_dPa\
               $bconc_dP2 $bconc_dP2 $bconc_dP2 $bconc_dPa $bconc_dPa\
               $bconc_dP2 $bconc_dP2 $bconc_dP2 $bconc_dPa $bconc_dPa\
			   $bconc_dP2 $bconc_dP2 $bconc_dP2 $bconc_dPa $bconc_dPa\
			   $bconc_dP2 $bconc_dP2 $bconc_dP2 $bconc_dPa $bconc_dPa\
			   $bconc_dP2 $bconc_dP2 $bconc_dP2 $bconc_dPa $bconc_dPa]			   
set DiaNum 1
for {set HorAxis 1} {$HorAxis <= $NumVerInc} {incr HorAxis} {
	for {set VerAxis 1} {$VerAxis <= $NumHorInc} {incr VerAxis} {
		set areTag [lindex $Lare [expr $HorAxis-1]]
		set matTag [lindex $Lmat [expr $HorAxis-1]]
		set eleTag1 [expr $WallTag + $DiaElemTag + $DiaNum]
		set iNode1 [expr $WallTag + ($VerAxis-1)*($NumVerInc+1) + $HorAxis]
        set jNode1 [expr $WallTag + $VerAxis*($NumVerInc+1) + $HorAxis + 1]
        set mGNode1 [expr $WallTag + ($VerAxis-1)*($NumVerInc+1) + $HorAxis + 1]
        set nGNode1 [expr $WallTag + $VerAxis*($NumVerInc+1) + $HorAxis]
		element Truss2 $eleTag1 $iNode1 $jNode1 $mGNode1 $nGNode1 $areTag $matTag
        incr DiaNum
        set eleTag2 [expr $WallTag + $DiaElemTag + $DiaNum]
		set iNode2 [expr $WallTag + ($VerAxis-1)*($NumVerInc+1) + $HorAxis + 1]
        set jNode2 [expr $WallTag + $VerAxis*($NumVerInc+1) + $HorAxis]
        set mGNode2 [expr $WallTag + ($VerAxis-1)*($NumVerInc+1) + $HorAxis]
        set nGNode2 [expr $WallTag + $VerAxis*($NumVerInc+1) + $HorAxis + 1]
        #element Truss2 $eleTag $iNode $jNode $mGNode $nGNode $A $matTag <-rho $rho> <-rayleigh $rflag>
		#element N4BiaxialTruss $eleTag $iNode $jNode $mGNode $nGNode $A $matTag <-rho $rho> <-rayleigh $rflag>
		element Truss2 $eleTag2 $iNode2 $jNode2 $mGNode2 $nGNode2 $areTag $matTag
        incr DiaNum
		puts $recInput "element Truss2 $eleTag1 $iNode1 $jNode1 $mGNode1 $nGNode1 $areTag $matTag"
        puts $recInput "element Truss2 $eleTag2 $iNode2 $jNode2 $mGNode2 $nGNode2 $areTag $matTag"		
	}
}
