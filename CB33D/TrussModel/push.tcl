# push
# dcAnalysis
set dof 1
set node $controlNode
set currentDisp [nodeDisp $node $dof]

set recAlgo [open $dataDir/algorithms.txt w]

pattern Plain [incr patternTag] "Linear" {
	load $controlNode 1. 0. 0.
}

# Displacement protocol
set d0p [expr 0.0005*$ln]
set d0n -$d0p
set d1p [expr 0.001*$ln]
set d1n -$d1p
set d2p [expr 0.003*$ln]
set d2n -$d2p
set d3p [expr 0.005*$ln]
set d3n -$d3p
set d4p [expr 0.0075*$ln]
set d4n -$d4p
set d5p [expr 0.01*$ln]
set d5n -$d5p
set d6p [expr 0.015*$ln]
set d6n -$d6p
set d7p [expr 0.02*$ln]
set d7n -$d7p
set d8p [expr 0.03*$ln]
set d8n -$d8p
set d9p [expr 0.04*$ln]
set d9n -$d9p
set d10p [expr 0.06*$ln]
set d10n -$d10p
set d11p [expr 0.08*$ln]
set d11n -$d11p
set d12p [expr 0.10*$ln]
set d12n -$d12p
set d13p [expr 0.12*$ln]
set d13n -$d13p

if {0} {
set peakDisp {$d0p $d0n $d0p $d0n $d0p $d0n \
			  $d1p $d1n $d1p $d1n $d1p $d1n \
			  $d2p $d2n $d2p $d2n $d2p $d2n \
			  $d3p $d3n $d3p $d3n $d3p $d3n \
			  $d4p $d4n $d4p $d4n $d4p $d4n \
			  $d5p $d5n $d5p $d5n $d5p $d5n \
			  $d6p $d6n $d6p $d6n $d6p $d6n \
			  $d7p $d7n $d7p $d7n $d7p $d7n \
			  $d8p $d8n $d8p $d8n $d8p $d8n \
			  $d9p $d9n $d9p $d9n \
			  $d10p $d10n $d10p $d10n \
			  $d11p $d11n $d11p $d11n \
			  $d12p $d12n $d12p $d12n \
			  $d13p $d13n $d13p $d13n \
              0.000}
} else {
set peakDisp {$d0p $d0n $d0p $d0n $d0p $d0n \
			  $d1p $d1n $d1p $d1n $d1p $d1n \
			  $d2p $d2n $d2p $d2n $d2p $d2n \
			  $d3p $d3n $d3p $d3n $d3p $d3n \
			  $d4p $d4n $d4p $d4n $d4p $d4n \
			  $d5p $d5n $d5p $d5n $d5p $d5n \
			  $d6p $d6n $d6p $d6n $d6p $d6n \
			  $d7p $d7n $d7p $d7n $d7p $d7n \
			  $d8p $d8n $d8p $d8n $d8p $d8n \
			  $d9p $d9n $d9p $d9n \
			  $d10p $d10n $d10p $d10n \
			  0.000}
}

set tiTask [clock seconds]
			  
set testType0 EnergyIncr
set tol0 1e-04
set iter0 100
set pFlag 0
set algorithmType0 Newton
set dD [expr $d1p*0.25]
set testType1 EnergyIncr
set tol1 1e-07
set testType2 NormDispIncr
set tol2 1e-06
set testType3 NormUnbalance
set tol3 1e-05
set testType4 RelativeNormDispIncr
set tol4 1e-04
set testType5 RelativeEnergyIncr
set tol5 1e-05
set testType6 RelativeNormUnbalance
set tol6 1e-04
set iterH 1000
set iterM 5000
set iterL 100
set finc 1
set fdec 1

# testType1 $tol1
set run1a 1;# Newton/iterL
set run2a 0;# Newton Initial/iterH
set run3a 1;# ModifiedNewton Initial/iterH
set run4a 0;# ModifiedNewton/iterH
set run5a 1;# NewtonWithLineSearch/iterM 
set run6a 0;# BFGS/iterM
set run7a 0;# Broyden/iterM
set run8a 1;# KrylovNewton/iterM
# testType2 $tol2
set run1b 1;# Newton/iterL
set run2b 0;# Newton Initial/iterH
set run3b 1;# ModifiedNewton Initial/iterH
set run4b 0;# ModifiedNewton/iterH
set run5b 1;# NewtonWithLineSearch/iterM 
set run6b 0;# BFGS/iterM
set run7b 0;# Broyden/iterM
set run8b 1;# KrylovNewton/iterM
# testType3 $tol3
set run1c 1;# Newton/iterL
set run2c 0;# Newton Initial/iterH
set run3c 1;# ModifiedNewton Initial/iterH
set run4c 0;# ModifiedNewton/iterH
set run5c 1;# NewtonWithLineSearch/iterM 
set run6c 0;# BFGS/iterM
set run7c 0;# Broyden/iterM
set run8c 1;# KrylovNewton/iterM
# testType4 $tol4
set run1d 0;# Newton/iterL
set run2d 0;# Newton Initial/iterH
set run3d 0;# ModifiedNewton Initial/iterH
set run4d 0;# ModifiedNewton/iterH
set run5d 0;# NewtonWithLineSearch/iterM 
set run6d 0;# BFGS/iterM
set run7d 0;# Broyden/iterM
set run8d 0;# KrylovNewton/iterM
# testType5 $tol5
set run1e 1;# Newton/iterL
set run2e 0;# Newton Initial/iterH
set run3e 1;# ModifiedNewton Initial/iterH
set run4e 0;# ModifiedNewton/iterH
set run5e 1;# NewtonWithLineSearch/iterM 
set run6e 0;# BFGS/iterM
set run7e 0;# Broyden/iterM
set run8e 1;# KrylovNewton/iterM
# testType6 $tol6
set run1f 0;# Newton/iterL
set run2f 0;# Newton Initial/iterH
set run3f 0;# ModifiedNewton Initial/iterH
set run4f 0;# ModifiedNewton/iterH
set run5f 0;# NewtonWithLineSearch/iterM 
set run6f 0;# BFGS/iterM
set run7f 0;# Broyden/iterM
set run8f 0;# KrylovNewton/iterM

set constraintsType Transformation
set numbererType RCM
set systemType BandGeneral

for {set ii 0} {$ii<[llength $peakDisp]} {incr ii} {

	set peak [expr [lindex $peakDisp $ii]]
	set cycleDisp [expr $peak - $currentDisp]
	if {$cycleDisp != 0} {
		set cycleDisp_sig [expr abs($cycleDisp)/$cycleDisp]
		set dDi [expr $dD*$cycleDisp_sig]
		set dDii $dDi
		if {$dispflag} {puts "-------------------------------------------------------------------------------------------------->>"}
		if {$dispflag} {puts "Starting peakDisp [expr $ii + 1]"}
		set dDmax [expr $dDi*10.]
		set dDmin [expr $dDi/100.]  
		set step 1	
		set pushflag 1
		while {$pushflag} {
			set algoType "[expr $ii+1].$step.$dDii [nodeDisp $node $dof] [expr [lindex $peakDisp $ii]]    $algorithmType0..."
			if {$dispflag} {puts $algoType}
			wipeAnalysis; constraints $constraintsType; numberer $numbererType; system $systemType
			test $testType0 $tol0 $iter0 $pFlag
			algorithm $algorithmType0	
			integrator DisplacementControl $node $dof $dDii; analysis Static
			set ok [analyze 1]
	
			#puts "<<-Changing algorithm----------------------"
			
			if {$ok != 0 && $run1a} {
				set algoType "[expr $ii+1].$step.$dDii [nodeDisp $node $dof] [expr [lindex $peakDisp $ii]]    1a. Newton..."
				if {$dispflag} {puts $algoType}
				wipeAnalysis; constraints $constraintsType; numberer $numbererType; system $systemType	  
				test $testType1 $tol1 $iterL 0
				algorithm Newton
				integrator DisplacementControl $node $dof $dDii; analysis Static
				set ok [analyze 1]
			}	
			if {$ok != 0 && $run2a} {
				set algoType "[expr $ii+1].$step.$dDii [nodeDisp $node $dof] [expr [lindex $peakDisp $ii]]    2a. Newton Initial..."
				if {$dispflag} {puts $algoType}
				wipeAnalysis; constraints $constraintsType; numberer $numbererType; system $systemType
				test $testType1 $tol1 $iterH 0
				algorithm Newton -initial
				integrator DisplacementControl $node $dof $dDii; analysis Static
				set ok [analyze 1]
			}
			if {$ok != 0 && $run3a} {
				set algoType "[expr $ii+1].$step.$dDii [nodeDisp $node $dof] [expr [lindex $peakDisp $ii]]    3a. ModifiedNewton Initial..."
				if {$dispflag} {puts $algoType}
				wipeAnalysis; constraints $constraintsType; numberer $numbererType; system $systemType
				test $testType1 $tol1 $iterH 0
				algorithm ModifiedNewton -initial
				integrator DisplacementControl $node $dof $dDii; analysis Static
				set ok [analyze 1]
			}
			if {$ok != 0 && $run4a} {
				set algoType "[expr $ii+1].$step.$dDii [nodeDisp $node $dof] [expr [lindex $peakDisp $ii]]    4a. ModifiedNewton..."
				if {$dispflag} {puts $algoType}
				wipeAnalysis; constraints $constraintsType; numberer $numbererType; system $systemType
				test $testType1 $tol1 $iterH 0
				algorithm ModifiedNewton
				integrator DisplacementControl $node $dof $dDii; analysis Static
				set ok [analyze 1]
			}
			if {$ok != 0 && $run5a} {
				set algoType "[expr $ii+1].$step.$dDii [nodeDisp $node $dof] [expr [lindex $peakDisp $ii]]    5a. NewtonWithLineSearch..."
				if {$dispflag} {puts $algoType}
				wipeAnalysis; constraints $constraintsType; numberer $numbererType; system $systemType
				test $testType1 $tol1 $iterM 0
				algorithm NewtonLineSearch -type InitialInterpoled -tol .8 -maxIter 10 -minEta 0.1 -maxEta 10
				integrator DisplacementControl $node $dof $dDii; analysis Static
				set ok [analyze 1]
			}
			if {$ok != 0 && $run6a} {
				set algoType "[expr $ii+1].$step.$dDii [nodeDisp $node $dof] [expr [lindex $peakDisp $ii]]   6a. BFGS..."
				if {$dispflag} {puts $algoType}
				wipeAnalysis; constraints $constraintsType; numberer $numbererType; system $systemType
				test $testType1 $tol1 $iterM 0
				algorithm BFGS
				integrator DisplacementControl $node $dof $dDii; analysis Static	  
				set ok [analyze 1]
			}
			if {$ok != 0 && $run7a} {
				set algoType "[expr $ii+1].$step.$dDii [nodeDisp $node $dof] [expr [lindex $peakDisp $ii]]   7a. Broyden..."
				if {$dispflag} {puts $algoType}
				wipeAnalysis; constraints $constraintsType; numberer $numbererType; system $systemType
				test $testType1 $tol1 $iterM 0
				algorithm Broyden 8
				integrator DisplacementControl $node $dof $dDii; analysis Static
				set ok [analyze 1]
			}
			if {$ok != 0 && $run8a} {
				set algoType "[expr $ii+1].$step.$dDii [nodeDisp $node $dof] [expr [lindex $peakDisp $ii]]   8a. KrylovNewton..."
				if {$dispflag} {puts $algoType}
				wipeAnalysis; constraints $constraintsType; numberer $numbererType; system $systemType
				test $testType1 $tol1 $iterM 0
				algorithm KrylovNewton
				integrator DisplacementControl $node $dof $dDii; analysis Static
				set ok [analyze 1]
			}
     
     
			if {$ok != 0 && $run1b} {
				set algoType "[expr $ii+1].$step.$dDii [nodeDisp $node $dof] [expr [lindex $peakDisp $ii]]    1b. Newton..."
				if {$dispflag} {puts $algoType}
				wipeAnalysis; constraints $constraintsType; numberer $numbererType; system $systemType
				test $testType2 $tol2 $iterL 0
				algorithm Newton
				integrator DisplacementControl $node $dof $dDii; analysis Static
				set ok [analyze 1]
			}
			if {$ok != 0 && $run2b} {
				set algoType "[expr $ii+1].$step.$dDii [nodeDisp $node $dof] [expr [lindex $peakDisp $ii]]    2b. Newton Initial..."
				if {$dispflag} {puts $algoType}
				wipeAnalysis; constraints $constraintsType; numberer $numbererType; system $systemType
				test $testType2 $tol2 $iterH 0
				algorithm Newton -initial
				integrator DisplacementControl $node $dof $dDii; analysis Static
				set ok [analyze 1]
			}
			if {$ok != 0 && $run3b} {
				set algoType "[expr $ii+1].$step.$dDii [nodeDisp $node $dof] [expr [lindex $peakDisp $ii]]    3b. ModifiedNewton Initial..."
				if {$dispflag} {puts $algoType}
				wipeAnalysis; constraints $constraintsType; numberer $numbererType; system $systemType
				test $testType2 $tol2 $iterH 0
				algorithm ModifiedNewton -initial
				integrator DisplacementControl $node $dof $dDii; analysis Static
				set ok [analyze 1]
			}
			if {$ok != 0 && $run4b} {
				set algoType "[expr $ii+1].$step.$dDii [nodeDisp $node $dof] [expr [lindex $peakDisp $ii]]    4b. ModifiedNewton..."
				if {$dispflag} {puts $algoType}
				wipeAnalysis; constraints $constraintsType; numberer $numbererType; system $systemType
				test $testType2 $tol2 $iterH 0
				algorithm ModifiedNewton
				integrator DisplacementControl $node $dof $dDii; analysis Static
				set ok [analyze 1]
			}
			if {$ok != 0 && $run5b} {
				set algoType "[expr $ii+1].$step.$dDii [nodeDisp $node $dof] [expr [lindex $peakDisp $ii]]    5b. NewtonWithLineSearch..."
				if {$dispflag} {puts $algoType}
				wipeAnalysis; constraints $constraintsType; numberer $numbererType; system $systemType
				test $testType2 $tol2 $iterM 0
				algorithm NewtonLineSearch -type InitialInterpoled -tol .8 -maxIter 10 -minEta 0.1 -maxEta 10
				integrator DisplacementControl $node $dof $dDii; analysis Static
				set ok [analyze 1]
			}
			if {$ok != 0 && $run6b} {
				set algoType "[expr $ii+1].$step.$dDii [nodeDisp $node $dof] [expr [lindex $peakDisp $ii]]    6b. BFGS..."
				if {$dispflag} {puts $algoType}
				wipeAnalysis; constraints $constraintsType; numberer $numbererType; system $systemType
				test $testType2 $tol2 $iterM 0
				algorithm BFGS 
				integrator DisplacementControl $node $dof $dDii; analysis Static
				set ok [analyze 1]
			}
			if {$ok != 0 && $run7b} {
				set algoType "[expr $ii+1].$step.$dDii [nodeDisp $node $dof] [expr [lindex $peakDisp $ii]]    7b. Broyden..."
				if {$dispflag} {puts $algoType}
				wipeAnalysis; constraints $constraintsType; numberer $numbererType; system $systemType
				test $testType2 $tol2 $iterM 0
				algorithm Broyden 8
				integrator DisplacementControl $node $dof $dDii; analysis Static
				set ok [analyze 1]
			}
			if {$ok != 0 && $run8b} {
				set algoType "[expr $ii+1].$step.$dDii [nodeDisp $node $dof] [expr [lindex $peakDisp $ii]]   8b. KrylovNewton..."
				if {$dispflag} {puts $algoType}
				wipeAnalysis; constraints $constraintsType; numberer $numbererType; system $systemType
				test $testType2 $tol2 $iterM 0
				algorithm KrylovNewton
				integrator DisplacementControl $node $dof $dDii; analysis Static
				set ok [analyze 1]
			}

	
			if {$ok != 0 && $run1c} {
				set algoType "[expr $ii+1].$step.$dDii [nodeDisp $node $dof] [expr [lindex $peakDisp $ii]]    1c. Newton..."
				if {$dispflag} {puts $algoType}
				wipeAnalysis; constraints $constraintsType; numberer $numbererType; system $systemType
				test $testType3 $tol3 $iterL 0
				algorithm Newton
				integrator DisplacementControl $node $dof $dDii; analysis Static
				set ok [analyze 1]
			}
			if {$ok != 0 && $run2c} {
				set algoType "[expr $ii+1].$step.$dDii [nodeDisp $node $dof] [expr [lindex $peakDisp $ii]]    2c. Newton Initial..."
				if {$dispflag} {puts $algoType}
				wipeAnalysis; constraints $constraintsType; numberer $numbererType; system $systemType
				test $testType3 $tol3 $iterH 0
				algorithm Newton -initial
				integrator DisplacementControl $node $dof $dDii; analysis Static
				set ok [analyze 1]
			}
			if {$ok != 0 && $run3c} {
				set algoType "[expr $ii+1].$step.$dDii [nodeDisp $node $dof] [expr [lindex $peakDisp $ii]]    3c. ModifiedNewton Initial..."
				if {$dispflag} {puts $algoType}
				wipeAnalysis; constraints $constraintsType; numberer $numbererType; system $systemType
				test $testType3 $tol3 $iterH 0
				algorithm ModifiedNewton -initial
				integrator DisplacementControl $node $dof $dDii; analysis Static
				set ok [analyze 1]
			}
			if {$ok != 0 && $run4c} {
				set algoType "[expr $ii+1].$step.$dDii [nodeDisp $node $dof] [expr [lindex $peakDisp $ii]]    4c. ModifiedNewton..."
				if {$dispflag} {puts $algoType}
				wipeAnalysis; constraints $constraintsType; numberer $numbererType; system $systemType
				test $testType3 $tol3 $iterH 0
				algorithm ModifiedNewton
				integrator DisplacementControl $node $dof $dDii; analysis Static
				set ok [analyze 1]
			}
			if {$ok != 0 && $run5c} {
				set algoType "[expr $ii+1].$step.$dDii [nodeDisp $node $dof] [expr [lindex $peakDisp $ii]]    5c. NewtonWithLineSearch..."
				if {$dispflag} {puts $algoType}
				wipeAnalysis; constraints $constraintsType; numberer $numbererType; system $systemType
				test $testType3 $tol3 $iterM 0
				algorithm NewtonLineSearch -type InitialInterpoled -tol .8 -maxIter 10 -minEta 0.1 -maxEta 10
				integrator DisplacementControl $node $dof $dDii; analysis Static
				set ok [analyze 1]
			}
			if {$ok != 0 && $run6c} {
				set algoType "[expr $ii+1].$step.$dDii [nodeDisp $node $dof] [expr [lindex $peakDisp $ii]]    6c. BFGS..."
				if {$dispflag} {puts $algoType}
				wipeAnalysis; constraints $constraintsType; numberer $numbererType; system $systemType
				test $testType3 $tol3 $iterM 0
				algorithm BFGS
				integrator DisplacementControl $node $dof $dDii; analysis Static	  
				set ok [analyze 1]
			}
			if {$ok != 0 && $run7c} {
				set algoType "[expr $ii+1].$step.$dDii [nodeDisp $node $dof] [expr [lindex $peakDisp $ii]]    7c. Broyden..."
				if {$dispflag} {puts $algoType}
				wipeAnalysis; constraints $constraintsType; numberer $numbererType; system $systemType
				test $testType3 $tol3 $iterM 0
				algorithm Broyden 8
				integrator DisplacementControl $node $dof $dDii; analysis Static
				set ok [analyze 1]
			}
			if {$ok != 0 && $run8c} {
				set algoType "[expr $ii+1].$step.$dDii [nodeDisp $node $dof] [expr [lindex $peakDisp $ii]]   8c. KrylovNewton..."
				if {$dispflag} {puts $algoType}
				wipeAnalysis; constraints $constraintsType; numberer $numbererType; system $systemType
				test $testType3 $tol3 $iterM 0
				algorithm KrylovNewton
				integrator DisplacementControl $node $dof $dDii; analysis Static
				set ok [analyze 1]
			}     
   
   
			if {$ok != 0 && $run1d} {
				set algoType "[expr $ii+1].$step.$dDii [nodeDisp $node $dof] [expr [lindex $peakDisp $ii]]    1d. Newton..."
				if {$dispflag} {puts $algoType}
				wipeAnalysis; constraints $constraintsType; numberer $numbererType; system $systemType
				test $testType4 $tol4 $iterL 0
				algorithm Newton
				integrator DisplacementControl $node $dof $dDii; analysis Static
				set ok [analyze 1]
			}
			if {$ok != 0 && $run2d} {
				set algoType "[expr $ii+1].$step.$dDii [nodeDisp $node $dof] [expr [lindex $peakDisp $ii]]    2d. Newton Initial..."
				if {$dispflag} {puts $algoType}
				wipeAnalysis; constraints $constraintsType; numberer $numbererType; system $systemType
				test $testType4 $tol4 $iterH 0
				algorithm Newton -initial
				integrator DisplacementControl $node $dof $dDii; analysis Static
				set ok [analyze 1]
			}
			if {$ok != 0 && $run3d} {
				set algoType "[expr $ii+1].$step.$dDii [nodeDisp $node $dof] [expr [lindex $peakDisp $ii]]    3d. ModifiedNewton Initial..."
				if {$dispflag} {puts $algoType}
				wipeAnalysis; constraints $constraintsType; numberer $numbererType; system $systemType
				test $testType4 $tol4 $iterH 0
				algorithm ModifiedNewton -initial
				integrator DisplacementControl $node $dof $dDii; analysis Static
				set ok [analyze 1]
			}
			if {$ok != 0 && $run4d} {
				set algoType "[expr $ii+1].$step.$dDii [nodeDisp $node $dof] [expr [lindex $peakDisp $ii]]    4d. ModifiedNewton..."
				if {$dispflag} {puts $algoType}
				wipeAnalysis; constraints $constraintsType; numberer $numbererType; system $systemType
				test $testType4 $tol4 $iterH 0
				algorithm ModifiedNewton
				integrator DisplacementControl $node $dof $dDii; analysis Static
				set ok [analyze 1]
			}
			if {$ok != 0 && $run5d} {
				set algoType "[expr $ii+1].$step.$dDii [nodeDisp $node $dof] [expr [lindex $peakDisp $ii]]    5d. NewtonWithLineSearch..."
				if {$dispflag} {puts $algoType}
				wipeAnalysis; constraints $constraintsType; numberer $numbererType; system $systemType
				test $testType4 $tol4 $iterM 0
				algorithm NewtonLineSearch -type InitialInterpoled -tol .8 -maxIter 10 -minEta 0.1 -maxEta 10
				integrator DisplacementControl $node $dof $dDii; analysis Static
				set ok [analyze 1]
			}
			if {$ok != 0 && $run6d} {
				set algoType "[expr $ii+1].$step.$dDii [nodeDisp $node $dof] [expr [lindex $peakDisp $ii]]    6d. BFGS..."
				if {$dispflag} {puts $algoType}
				wipeAnalysis; constraints $constraintsType; numberer $numbererType; system $systemType
				test $testType4 $tol4 $iterM 0
				algorithm BFGS
				integrator DisplacementControl $node $dof $dDii; analysis Static	  
				set ok [analyze 1]
			}
			if {$ok != 0 && $run7d} {
				set algoType "[expr $ii+1].$step.$dDii [nodeDisp $node $dof] [expr [lindex $peakDisp $ii]]    7d. Broyden..."
				if {$dispflag} {puts $algoType}
				wipeAnalysis; constraints $constraintsType; numberer $numbererType; system $systemType
				test $testType4 $tol4 $iterM 0
				algorithm Broyden 8
				integrator DisplacementControl $node $dof $dDii; analysis Static
				set ok [analyze 1]
			}
			if {$ok != 0 && $run8d} {
				set algoType "[expr $ii+1].$step.$dDii [nodeDisp $node $dof] [expr [lindex $peakDisp $ii]]   8d. KrylovNewton..."
				if {$dispflag} {puts $algoType}
				wipeAnalysis; constraints $constraintsType; numberer $numbererType; system $systemType
				test $testType4 $tol4 $iterM 0
				algorithm KrylovNewton
				integrator DisplacementControl $node $dof $dDii; analysis Static
				set ok [analyze 1]
			}
     
     
			if {$ok != 0 && $run1e} {
				set algoType "[expr $ii+1].$step.$dDii [nodeDisp $node $dof] [expr [lindex $peakDisp $ii]]    1e. Newton..."
				if {$dispflag} {puts $algoType}
				wipeAnalysis; constraints $constraintsType; numberer $numbererType; system $systemType
				test $testType5 $tol5 $iterL 0
				algorithm Newton
				integrator DisplacementControl $node $dof $dDii; analysis Static
				set ok [analyze 1]
			}
			if {$ok != 0 && $run2e} {
				set algoType "[expr $ii+1].$step.$dDii [nodeDisp $node $dof] [expr [lindex $peakDisp $ii]]    2e. Newton Initial..."
				if {$dispflag} {puts $algoType}
				wipeAnalysis; constraints $constraintsType; numberer $numbererType; system $systemType
				test $testType5 $tol5 $iterH 0
				algorithm Newton -initial
				integrator DisplacementControl $node $dof $dDii; analysis Static
				set ok [analyze 1]
			}
			if {$ok != 0 && $run3e} {
				set algoType "[expr $ii+1].$step.$dDii [nodeDisp $node $dof] [expr [lindex $peakDisp $ii]]    3e. ModifiedNewton Initial..."
				if {$dispflag} {puts $algoType}
				wipeAnalysis; constraints $constraintsType; numberer $numbererType; system $systemType
				test $testType5 $tol5 $iterH 0
				algorithm ModifiedNewton -initial
				integrator DisplacementControl $node $dof $dDii; analysis Static
				set ok [analyze 1]
			}
			if {$ok != 0 && $run4e} {
				set algoType "[expr $ii+1].$step.$dDii [nodeDisp $node $dof] [expr [lindex $peakDisp $ii]]    4e. ModifiedNewton..."
				if {$dispflag} {puts $algoType}
				wipeAnalysis; constraints $constraintsType; numberer $numbererType; system $systemType
				test $testType5 $tol5 $iterH 0
				algorithm ModifiedNewton
				integrator DisplacementControl $node $dof $dDii; analysis Static
				set ok [analyze 1]
			}
			if {$ok != 0 && $run5e} {
				set algoType "[expr $ii+1].$step.$dDii [nodeDisp $node $dof] [expr [lindex $peakDisp $ii]]    5e. NewtonWithLineSearch..."
				if {$dispflag} {puts $algoType}
				wipeAnalysis; constraints $constraintsType; numberer $numbererType; system $systemType
				test $testType5 $tol5 $iterM 0
				algorithm NewtonLineSearch -type InitialInterpoled -tol .8 -maxIter 10 -minEta 0.1 -maxEta 10
				integrator DisplacementControl $node $dof $dDii; analysis Static
				set ok [analyze 1]
			}
			if {$ok != 0 && $run6e} {
				set algoType "[expr $ii+1].$step.$dDii [nodeDisp $node $dof] [expr [lindex $peakDisp $ii]]    6e. BFGS..."
				if {$dispflag} {puts $algoType}
				wipeAnalysis; constraints $constraintsType; numberer $numbererType; system $systemType
				test $testType5 $tol5 $iterM 0
				algorithm BFGS
				integrator DisplacementControl $node $dof $dDii; analysis Static	  
				set ok [analyze 1]
			}
			if {$ok != 0 && $run7e} {
				set algoType "[expr $ii+1].$step.$dDii [nodeDisp $node $dof] [expr [lindex $peakDisp $ii]]    7e. Broyden..."
				if {$dispflag} {puts $algoType}
				wipeAnalysis; constraints $constraintsType; numberer $numbererType; system $systemType
				test $testType5 $tol5 $iterM 0
				algorithm Broyden 8
				integrator DisplacementControl $node $dof $dDii; analysis Static
				set ok [analyze 1]
			}
			if {$ok != 0 && $run8e} {
				set algoType "[expr $ii+1].$step.$dDii [nodeDisp $node $dof] [expr [lindex $peakDisp $ii]]   8e. KrylovNewton..."
				if {$dispflag} {puts $algoType}
				wipeAnalysis; constraints $constraintsType; numberer $numbererType; system $systemType
				test $testType5 $tol5 $iterM 0
				algorithm KrylovNewton
				integrator DisplacementControl $node $dof $dDii; analysis Static
				set ok [analyze 1]
			}
     
     
			if {$ok != 0 && $run1f} {
				set algoType "[expr $ii+1].$step.$dDii [nodeDisp $node $dof] [expr [lindex $peakDisp $ii]]    1f. Newton..."
				if {$dispflag} {puts $algoType}
				wipeAnalysis; constraints $constraintsType; numberer $numbererType; system $systemType
				test $testType6 $tol6 $iterL 0
				algorithm Newton
				integrator DisplacementControl $node $dof $dDii; analysis Static
				set ok [analyze 1]
			}
			if {$ok != 0 && $run2f} {
				set algoType "[expr $ii+1].$step.$dDii [nodeDisp $node $dof] [expr [lindex $peakDisp $ii]]    2f. Newton Initial..."
				if {$dispflag} {puts $algoType}
				wipeAnalysis; constraints $constraintsType; numberer $numbererType; system $systemType
				test $testType6 $tol6 $iterH 0
				algorithm Newton -initial
				integrator DisplacementControl $node $dof $dDii; analysis Static
				set ok [analyze 1]
			}
			if {$ok != 0 && $run3f} {
				set algoType "[expr $ii+1].$step.$dDii [nodeDisp $node $dof] [expr [lindex $peakDisp $ii]]    3f. ModifiedNewton Initial..."
				if {$dispflag} {puts $algoType}
				wipeAnalysis; constraints $constraintsType; numberer $numbererType; system $systemType
				test $testType6 $tol6 $iterH 0
				algorithm ModifiedNewton -initial
				integrator DisplacementControl $node $dof $dDii; analysis Static
				set ok [analyze 1]
			}
			if {$ok != 0 && $run4f} {
				set algoType "[expr $ii+1].$step.$dDii [nodeDisp $node $dof] [expr [lindex $peakDisp $ii]]    4f. ModifiedNewton..."
				if {$dispflag} {puts $algoType}
				wipeAnalysis; constraints $constraintsType; numberer $numbererType; system $systemType
				test $testType6 $tol6 $iterH 0
				algorithm ModifiedNewton
				integrator DisplacementControl $node $dof $dDii; analysis Static
				set ok [analyze 1]
			}
			if {$ok != 0 && $run5f} {
				set algoType "[expr $ii+1].$step.$dDii [nodeDisp $node $dof] [expr [lindex $peakDisp $ii]]    5f. NewtonWithLineSearch..."
				if {$dispflag} {puts $algoType}
				wipeAnalysis; constraints $constraintsType; numberer $numbererType; system $systemType
				test $testType6 $tol6 $iterM 0
				algorithm NewtonLineSearch -type InitialInterpoled -tol .8 -maxIter 10 -minEta 0.1 -maxEta 10
				integrator DisplacementControl $node $dof $dDii; analysis Static
				set ok [analyze 1]
			}
			if {$ok != 0 && $run6f} {
				set algoType "[expr $ii+1].$step.$dDii [nodeDisp $node $dof] [expr [lindex $peakDisp $ii]]    6f. BFGS..."
				if {$dispflag} {puts $algoType}
				wipeAnalysis; constraints $constraintsType; numberer $numbererType; system $systemType
				test $testType6 $tol6 $iterM 0
				algorithm BFGS 
				integrator DisplacementControl $node $dof $dDii; analysis Static
				set ok [analyze 1]
			}
			if {$ok != 0 && $run7f} {
				set algoType "[expr $ii+1].$step.$dDii [nodeDisp $node $dof] [expr [lindex $peakDisp $ii]]    7f. Broyden..."
				if {$dispflag} {puts $algoType}
				wipeAnalysis; constraints $constraintsType; numberer $numbererType; system $systemType
				test $testType6 $tol6 $iterM 0
				algorithm Broyden 8
				integrator DisplacementControl $node $dof $dDii; analysis Static
				set ok [analyze 1]
			}
			if {$ok != 0 && $run8f} {
				set algoType "[expr $ii+1].$step.$dDii [nodeDisp $node $dof] [expr [lindex $peakDisp $ii]]   8f. KrylovNewton..."
				if {$dispflag} {puts $algoType}
				wipeAnalysis; constraints $constraintsType; numberer $numbererType; system $systemType
				test $testType6 $tol6 $iterM 0
				algorithm KrylovNewton
				integrator DisplacementControl $node $dof $dDii; analysis Static
				set ok [analyze 1]
			}
			
			#if {$ok == 0} {
			#puts $ok
			#set disp_after_lateral [nodeDisp $node $dof]
			#puts "-It Works!!------------------------------>>"
			#
			#exit
			#}
			
			# Use TaskGeneratorDBE	
			if {$ok == 0} {
				set disp_after_lateral [nodeDisp $node $dof]
				#puts "-It Works!!------------------------------>>"
				#incr gstep
				set finc 1.
				set fdec 1.			
				set dDii $dDi			
				set tfTask [clock seconds]
				set processDuration [expr $tfTask - $tiTask]	  
				puts $recAlgo "$algoType $disp_after_lateral [nodeDisp $node $dof] $processDuration"	  
				flush $recAlgo
				incr step	
			} else {
				set finc [expr $finc*2.]
				set dDii [expr $dDi*$finc]
				if {abs($dDii) <= abs($dDmax)} {
					if {$dispflag} {puts "-Increasing step------------------>>"}
				} else {
					set fdec [expr $fdec*2.]
					set dDii [expr $dDi/$fdec]
					if {abs($dDii) >= abs($dDmin)} {
						if {$dispflag} {puts "-Decreasing step------------------>>"}          
					} else {
						puts "Displacement Control Analysis: Error!"
						puts $recAlgo "Displacement Control Analysis: Error!"
						exit
					}
				}						
			}	
			set currentDisp [nodeDisp $node $dof]
			if {($dDii >= 0 && $currentDisp >= $peak) || ($dDii <= 0 && $currentDisp <= $peak)} {
				set pushflag 0
			}		
		};# while {$pushflag}
	};# if {$cycleDisp != 0}
	
	#puts $recPeak "[expr $ii + 1] $gstep $currentDisp"
};# for {$ii<[llength $peakDisp]}

if {$ok == 0} {
 set tfTask [clock seconds]
 set taskDuration [expr $tfTask - $tiTask]
 puts "Displacement Control Analysis: DONE!"
 puts $recAlgo "Displacement Control Analysis: DONE!"
 puts "Task Duration = $taskDuration sec"
 puts $recAlgo "Task Duration = $taskDuration sec" 
 #close $recInput
 close $recAlgo
 #close $recPeak 
 wipe 
}
