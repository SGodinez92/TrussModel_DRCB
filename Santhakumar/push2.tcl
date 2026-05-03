# push
if {$dispflag} {puts "$np.$pid.$count push"}; puts $recInput "push"
# dcAnalysis
#set LatLoadN1 10015 
#set LatLoadN2 10025
#set LatLoadN3 10035
set LatLoadN1 10016 
set LatLoadN2 10026
set LatLoadN3 10036
set LatLoadN4 20123 
set LatLoadN5 20133
set LatLoadN6 20143

set node $CtrNode
pattern Plain [incr patternTag] "Linear" {
	load $LatLoadN1 [expr 1./3.] 0 0 
	load $LatLoadN2 [expr 1./3.] 0 0
	load $LatLoadN3 [expr 1./3.] 0 0
}
set offDisp 0.038446 
set d1  [expr $offDisp +   0.39*$mm]
set d2  [expr $offDisp -   2.14*$mm]
set d3  [expr $offDisp +   4.39*$mm]
set d4  [expr $offDisp -   7.12*$mm]
set d5  [expr $offDisp +  11.50*$mm]
set d6  [expr $offDisp -  15.08*$mm]
set d7  [expr $offDisp +   4.30*$mm]
set d8  [expr $offDisp -  10.23*$mm]
set d9  [expr $offDisp +  60.02*$mm]
set d10 [expr $offDisp -  51.92*$mm]
set d11 [expr $offDisp +  71.02*$mm]
set d12 [expr $offDisp -  65.48*$mm]
set d13 [expr $offDisp + 101.57*$mm]
set d14 [expr $offDisp - 101.69*$mm]
set d15 [expr $offDisp + 129.12*$mm]
set d16 [expr $offDisp - 189.92*$mm]

set peakDisp {
	$d1 $d2 $d3 $d4 $d5 $d6 $d7 $d8 $d9 $d10 $d11 $d12 $d13 $d14 $d15 $d16	
}

#set testType0 EnergyIncr
#set tol0 1e-08
#set iter0 100
set pFlag 0
#set algorithmType0 Newton
set dof 1
set currentDisp [nodeDisp $node $dof]
#set dD 0.01
#set testType1 EnergyIncr
#set tol1 1e-06
#set testType2 NormDispIncr
#set tol2 1e-06
#set testType3 NormUnbalance
#set tol3 1e-06
#set testType4 RelativeNormDispIncr
#set tol4 1e-03
#set testType5 RelativeEnergyIncr
#set tol5 1e-03
#set testType6 RelativeNormUnbalance
#set tol6 1e-03
#set iterH 2000
#set iterM 1000
#set iterL 500
set finc 1
set fdec 1
set PxPast 0.

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
			set ok [analyzeMonitor 1 $tiTask $tiTaskMP 3]
			#if {$ok != 0} {
			#  puts "<<-Changing algorithm----------------------"
			#}
			if {$ok != 0 && $run1a} {
				set algoType "[expr $ii+1].$step.$dDii [nodeDisp $node $dof] [expr [lindex $peakDisp $ii]]    1a. Newton..."
				if {$dispflag} {puts $algoType}
				wipeAnalysis; constraints $constraintsType; numberer $numbererType; system $systemType	  
				test $testType1 $tol1 $iterL 0
				algorithm Newton
				integrator DisplacementControl $node $dof $dDii; analysis Static
				set ok [analyzeMonitor 1 $tiTask $tiTaskMP 3]
			}	
			if {$ok != 0 && $run2a} {
				set algoType "[expr $ii+1].$step.$dDii [nodeDisp $node $dof] [expr [lindex $peakDisp $ii]]    2a. Newton Initial..."
				if {$dispflag} {puts $algoType}
				wipeAnalysis; constraints $constraintsType; numberer $numbererType; system $systemType
				test $testType1 $tol1 $iterH 0
				algorithm Newton -initial
				integrator DisplacementControl $node $dof $dDii; analysis Static
				set ok [analyzeMonitor 1 $tiTask $tiTaskMP 3]
			}
			if {$ok != 0 && $run3a} {
				set algoType "[expr $ii+1].$step.$dDii [nodeDisp $node $dof] [expr [lindex $peakDisp $ii]]    3a. ModifiedNewton Initial..."
				if {$dispflag} {puts $algoType}
				wipeAnalysis; constraints $constraintsType; numberer $numbererType; system $systemType
				test $testType1 $tol1 $iterH 0
				algorithm ModifiedNewton -initial
				integrator DisplacementControl $node $dof $dDii; analysis Static
				set ok [analyzeMonitor 1 $tiTask $tiTaskMP 3]
			}
			if {$ok != 0 && $run4a} {
				set algoType "[expr $ii+1].$step.$dDii [nodeDisp $node $dof] [expr [lindex $peakDisp $ii]]    4a. ModifiedNewton..."
				if {$dispflag} {puts $algoType}
				wipeAnalysis; constraints $constraintsType; numberer $numbererType; system $systemType
				test $testType1 $tol1 $iterH 0
				algorithm ModifiedNewton
				integrator DisplacementControl $node $dof $dDii; analysis Static
				set ok [analyzeMonitor 1 $tiTask $tiTaskMP 3]
			}
			if {$ok != 0 && $run5a} {
				set algoType "[expr $ii+1].$step.$dDii [nodeDisp $node $dof] [expr [lindex $peakDisp $ii]]    5a. NewtonWithLineSearch..."
				if {$dispflag} {puts $algoType}
				wipeAnalysis; constraints $constraintsType; numberer $numbererType; system $systemType
				test $testType1 $tol1 $iterM 0
				algorithm NewtonLineSearch -type InitialInterpoled -tol .8 -maxIter 10 -minEta 0.1 -maxEta 10
				integrator DisplacementControl $node $dof $dDii; analysis Static
				set ok [analyzeMonitor 1 $tiTask $tiTaskMP 3]
			}
			if {$ok != 0 && $run6a} {
				set algoType "[expr $ii+1].$step.$dDii [nodeDisp $node $dof] [expr [lindex $peakDisp $ii]]   6a. BFGS..."
				if {$dispflag} {puts $algoType}
				wipeAnalysis; constraints $constraintsType; numberer $numbererType; system $systemType
				test $testType1 $tol1 $iterM 0
				algorithm BFGS
				integrator DisplacementControl $node $dof $dDii; analysis Static	  
				set ok [analyzeMonitor 1 $tiTask $tiTaskMP 3]
			}
			if {$ok != 0 && $run7a} {
				set algoType "[expr $ii+1].$step.$dDii [nodeDisp $node $dof] [expr [lindex $peakDisp $ii]]   7a. Broyden..."
				if {$dispflag} {puts $algoType}
				wipeAnalysis; constraints $constraintsType; numberer $numbererType; system $systemType
				test $testType1 $tol1 $iterM 0
				algorithm Broyden 8
				integrator DisplacementControl $node $dof $dDii; analysis Static
				set ok [analyzeMonitor 1 $tiTask $tiTaskMP 3]
			}
			if {$ok != 0 && $run8a} {
				set algoType "[expr $ii+1].$step.$dDii [nodeDisp $node $dof] [expr [lindex $peakDisp $ii]]   8a. KrylovNewton..."
				if {$dispflag} {puts $algoType}
				wipeAnalysis; constraints $constraintsType; numberer $numbererType; system $systemType
				test $testType1 $tol1 $iterM 0
				algorithm KrylovNewton
				integrator DisplacementControl $node $dof $dDii; analysis Static
				set ok [analyzeMonitor 1 $tiTask $tiTaskMP 3]
			}
     
     
			if {$ok != 0 && $run1b} {
				set algoType "[expr $ii+1].$step.$dDii [nodeDisp $node $dof] [expr [lindex $peakDisp $ii]]    1b. Newton..."
				if {$dispflag} {puts $algoType}
				wipeAnalysis; constraints $constraintsType; numberer $numbererType; system $systemType
				test $testType2 $tol2 $iterL 0
				algorithm Newton
				integrator DisplacementControl $node $dof $dDii; analysis Static
				set ok [analyzeMonitor 1 $tiTask $tiTaskMP 3]
			}
			if {$ok != 0 && $run2b} {
				set algoType "[expr $ii+1].$step.$dDii [nodeDisp $node $dof] [expr [lindex $peakDisp $ii]]    2b. Newton Initial..."
				if {$dispflag} {puts $algoType}
				wipeAnalysis; constraints $constraintsType; numberer $numbererType; system $systemType
				test $testType2 $tol2 $iterH 0
				algorithm Newton -initial
				integrator DisplacementControl $node $dof $dDii; analysis Static
				set ok [analyzeMonitor 1 $tiTask $tiTaskMP 3]
			}
			if {$ok != 0 && $run3b} {
				set algoType "[expr $ii+1].$step.$dDii [nodeDisp $node $dof] [expr [lindex $peakDisp $ii]]    3b. ModifiedNewton Initial..."
				if {$dispflag} {puts $algoType}
				wipeAnalysis; constraints $constraintsType; numberer $numbererType; system $systemType
				test $testType2 $tol2 $iterH 0
				algorithm ModifiedNewton -initial
				integrator DisplacementControl $node $dof $dDii; analysis Static
				set ok [analyzeMonitor 1 $tiTask $tiTaskMP 3]
			}
			if {$ok != 0 && $run4b} {
				set algoType "[expr $ii+1].$step.$dDii [nodeDisp $node $dof] [expr [lindex $peakDisp $ii]]    4b. ModifiedNewton..."
				if {$dispflag} {puts $algoType}
				wipeAnalysis; constraints $constraintsType; numberer $numbererType; system $systemType
				test $testType2 $tol2 $iterH 0
				algorithm ModifiedNewton
				integrator DisplacementControl $node $dof $dDii; analysis Static
				set ok [analyzeMonitor 1 $tiTask $tiTaskMP 3]
			}
			if {$ok != 0 && $run5b} {
				set algoType "[expr $ii+1].$step.$dDii [nodeDisp $node $dof] [expr [lindex $peakDisp $ii]]    5b. NewtonWithLineSearch..."
				if {$dispflag} {puts $algoType}
				wipeAnalysis; constraints $constraintsType; numberer $numbererType; system $systemType
				test $testType2 $tol2 $iterM 0
				algorithm NewtonLineSearch -type InitialInterpoled -tol .8 -maxIter 10 -minEta 0.1 -maxEta 10
				integrator DisplacementControl $node $dof $dDii; analysis Static
				set ok [analyzeMonitor 1 $tiTask $tiTaskMP 3]
			}
			if {$ok != 0 && $run6b} {
				set algoType "[expr $ii+1].$step.$dDii [nodeDisp $node $dof] [expr [lindex $peakDisp $ii]]    6b. BFGS..."
				if {$dispflag} {puts $algoType}
				wipeAnalysis; constraints $constraintsType; numberer $numbererType; system $systemType
				test $testType2 $tol2 $iterM 0
				algorithm BFGS 
				integrator DisplacementControl $node $dof $dDii; analysis Static
				set ok [analyzeMonitor 1 $tiTask $tiTaskMP 3]
			}
			if {$ok != 0 && $run7b} {
				set algoType "[expr $ii+1].$step.$dDii [nodeDisp $node $dof] [expr [lindex $peakDisp $ii]]    7b. Broyden..."
				if {$dispflag} {puts $algoType}
				wipeAnalysis; constraints $constraintsType; numberer $numbererType; system $systemType
				test $testType2 $tol2 $iterM 0
				algorithm Broyden 8
				integrator DisplacementControl $node $dof $dDii; analysis Static
				set ok [analyzeMonitor 1 $tiTask $tiTaskMP 3]
			}
			if {$ok != 0 && $run8b} {
				set algoType "[expr $ii+1].$step.$dDii [nodeDisp $node $dof] [expr [lindex $peakDisp $ii]]   8a. KrylovNewton..."
				if {$dispflag} {puts $algoType}
				wipeAnalysis; constraints $constraintsType; numberer $numbererType; system $systemType
				test $testType2 $tol2 $iterM 0
				algorithm KrylovNewton
				integrator DisplacementControl $node $dof $dDii; analysis Static
				set ok [analyzeMonitor 1 $tiTask $tiTaskMP 3]
			}

	
			if {$ok != 0 && $run1c} {
				set algoType "[expr $ii+1].$step.$dDii [nodeDisp $node $dof] [expr [lindex $peakDisp $ii]]    1c. Newton..."
				if {$dispflag} {puts $algoType}
				wipeAnalysis; constraints $constraintsType; numberer $numbererType; system $systemType
				test $testType3 $tol3 $iterL 0
				algorithm Newton
				integrator DisplacementControl $node $dof $dDii; analysis Static
				set ok [analyzeMonitor 1 $tiTask $tiTaskMP 3]
			}
			if {$ok != 0 && $run2c} {
				set algoType "[expr $ii+1].$step.$dDii [nodeDisp $node $dof] [expr [lindex $peakDisp $ii]]    2c. Newton Initial..."
				if {$dispflag} {puts $algoType}
				wipeAnalysis; constraints $constraintsType; numberer $numbererType; system $systemType
				test $testType3 $tol3 $iterH 0
				algorithm Newton -initial
				integrator DisplacementControl $node $dof $dDii; analysis Static
				set ok [analyzeMonitor 1 $tiTask $tiTaskMP 3]
			}
			if {$ok != 0 && $run3c} {
				set algoType "[expr $ii+1].$step.$dDii [nodeDisp $node $dof] [expr [lindex $peakDisp $ii]]    3c. ModifiedNewton Initial..."
				if {$dispflag} {puts $algoType}
				wipeAnalysis; constraints $constraintsType; numberer $numbererType; system $systemType
				test $testType3 $tol3 $iterH 0
				algorithm ModifiedNewton -initial
				integrator DisplacementControl $node $dof $dDii; analysis Static
				set ok [analyzeMonitor 1 $tiTask $tiTaskMP 3]
			}
			if {$ok != 0 && $run4c} {
				set algoType "[expr $ii+1].$step.$dDii [nodeDisp $node $dof] [expr [lindex $peakDisp $ii]]    4c. ModifiedNewton..."
				if {$dispflag} {puts $algoType}
				wipeAnalysis; constraints $constraintsType; numberer $numbererType; system $systemType
				test $testType3 $tol3 $iterH 0
				algorithm ModifiedNewton
				integrator DisplacementControl $node $dof $dDii; analysis Static
				set ok [analyzeMonitor 1 $tiTask $tiTaskMP 3]
			}
			if {$ok != 0 && $run5c} {
				set algoType "[expr $ii+1].$step.$dDii [nodeDisp $node $dof] [expr [lindex $peakDisp $ii]]    5c. NewtonWithLineSearch..."
				if {$dispflag} {puts $algoType}
				wipeAnalysis; constraints $constraintsType; numberer $numbererType; system $systemType
				test $testType3 $tol3 $iterM 0
				algorithm NewtonLineSearch -type InitialInterpoled -tol .8 -maxIter 10 -minEta 0.1 -maxEta 10
				integrator DisplacementControl $node $dof $dDii; analysis Static
				set ok [analyzeMonitor 1 $tiTask $tiTaskMP 3]
			}
			if {$ok != 0 && $run6c} {
				set algoType "[expr $ii+1].$step.$dDii [nodeDisp $node $dof] [expr [lindex $peakDisp $ii]]    6c. BFGS..."
				if {$dispflag} {puts $algoType}
				wipeAnalysis; constraints $constraintsType; numberer $numbererType; system $systemType
				test $testType3 $tol3 $iterM 0
				algorithm BFGS
				integrator DisplacementControl $node $dof $dDii; analysis Static	  
				set ok [analyzeMonitor 1 $tiTask $tiTaskMP 3]
			}
			if {$ok != 0 && $run7c} {
				set algoType "[expr $ii+1].$step.$dDii [nodeDisp $node $dof] [expr [lindex $peakDisp $ii]]    7c. Broyden..."
				if {$dispflag} {puts $algoType}
				wipeAnalysis; constraints $constraintsType; numberer $numbererType; system $systemType
				test $testType3 $tol3 $iterM 0
				algorithm Broyden 8
				integrator DisplacementControl $node $dof $dDii; analysis Static
				set ok [analyzeMonitor 1 $tiTask $tiTaskMP 3]
			}
			if {$ok != 0 && $run8c} {
				set algoType "[expr $ii+1].$step.$dDii [nodeDisp $node $dof] [expr [lindex $peakDisp $ii]]   8c. KrylovNewton..."
				if {$dispflag} {puts $algoType}
				wipeAnalysis; constraints $constraintsType; numberer $numbererType; system $systemType
				test $testType3 $tol3 $iterM 0
				algorithm KrylovNewton
				integrator DisplacementControl $node $dof $dDii; analysis Static
				set ok [analyzeMonitor 1 $tiTask $tiTaskMP 3]
			}     
   
   
			if {$ok != 0 && $run1d} {
				set algoType "[expr $ii+1].$step.$dDii [nodeDisp $node $dof] [expr [lindex $peakDisp $ii]]    1d. Newton..."
				if {$dispflag} {puts $algoType}
				wipeAnalysis; constraints $constraintsType; numberer $numbererType; system $systemType
				test $testType4 $tol4 $iterL 0
				algorithm Newton
				integrator DisplacementControl $node $dof $dDii; analysis Static
				set ok [analyzeMonitor 1 $tiTask $tiTaskMP 3]
			}
			if {$ok != 0 && $run2d} {
				set algoType "[expr $ii+1].$step.$dDii [nodeDisp $node $dof] [expr [lindex $peakDisp $ii]]    2d. Newton Initial..."
				if {$dispflag} {puts $algoType}
				wipeAnalysis; constraints $constraintsType; numberer $numbererType; system $systemType
				test $testType4 $tol4 $iterH 0
				algorithm Newton -initial
				integrator DisplacementControl $node $dof $dDii; analysis Static
				set ok [analyzeMonitor 1 $tiTask $tiTaskMP 3]
			}
			if {$ok != 0 && $run3d} {
				set algoType "[expr $ii+1].$step.$dDii [nodeDisp $node $dof] [expr [lindex $peakDisp $ii]]    3d. ModifiedNewton Initial..."
				if {$dispflag} {puts $algoType}
				wipeAnalysis; constraints $constraintsType; numberer $numbererType; system $systemType
				test $testType4 $tol4 $iterH 0
				algorithm ModifiedNewton -initial
				integrator DisplacementControl $node $dof $dDii; analysis Static
				set ok [analyzeMonitor 1 $tiTask $tiTaskMP 3]
			}
			if {$ok != 0 && $run4d} {
				set algoType "[expr $ii+1].$step.$dDii [nodeDisp $node $dof] [expr [lindex $peakDisp $ii]]    4d. ModifiedNewton..."
				if {$dispflag} {puts $algoType}
				wipeAnalysis; constraints $constraintsType; numberer $numbererType; system $systemType
				test $testType4 $tol4 $iterH 0
				algorithm ModifiedNewton
				integrator DisplacementControl $node $dof $dDii; analysis Static
				set ok [analyzeMonitor 1 $tiTask $tiTaskMP 3]
			}
			if {$ok != 0 && $run5d} {
				set algoType "[expr $ii+1].$step.$dDii [nodeDisp $node $dof] [expr [lindex $peakDisp $ii]]    5d. NewtonWithLineSearch..."
				if {$dispflag} {puts $algoType}
				wipeAnalysis; constraints $constraintsType; numberer $numbererType; system $systemType
				test $testType4 $tol4 $iterM 0
				algorithm NewtonLineSearch -type InitialInterpoled -tol .8 -maxIter 10 -minEta 0.1 -maxEta 10
				integrator DisplacementControl $node $dof $dDii; analysis Static
				set ok [analyzeMonitor 1 $tiTask $tiTaskMP 3]
			}
			if {$ok != 0 && $run6d} {
				set algoType "[expr $ii+1].$step.$dDii [nodeDisp $node $dof] [expr [lindex $peakDisp $ii]]    6d. BFGS..."
				if {$dispflag} {puts $algoType}
				wipeAnalysis; constraints $constraintsType; numberer $numbererType; system $systemType
				test $testType4 $tol4 $iterM 0
				algorithm BFGS
				integrator DisplacementControl $node $dof $dDii; analysis Static	  
				set ok [analyzeMonitor 1 $tiTask $tiTaskMP 3]
			}
			if {$ok != 0 && $run7d} {
				set algoType "[expr $ii+1].$step.$dDii [nodeDisp $node $dof] [expr [lindex $peakDisp $ii]]    7d. Broyden..."
				if {$dispflag} {puts $algoType}
				wipeAnalysis; constraints $constraintsType; numberer $numbererType; system $systemType
				test $testType4 $tol4 $iterM 0
				algorithm Broyden 8
				integrator DisplacementControl $node $dof $dDii; analysis Static
				set ok [analyzeMonitor 1 $tiTask $tiTaskMP 3]
			}
			if {$ok != 0 && $run8d} {
				set algoType "[expr $ii+1].$step.$dDii [nodeDisp $node $dof] [expr [lindex $peakDisp $ii]]   8d. KrylovNewton..."
				if {$dispflag} {puts $algoType}
				wipeAnalysis; constraints $constraintsType; numberer $numbererType; system $systemType
				test $testType4 $tol4 $iterM 0
				algorithm KrylovNewton
				integrator DisplacementControl $node $dof $dDii; analysis Static
				set ok [analyzeMonitor 1 $tiTask $tiTaskMP 3]
			}
     
     
			if {$ok != 0 && $run1e} {
				set algoType "[expr $ii+1].$step.$dDii [nodeDisp $node $dof] [expr [lindex $peakDisp $ii]]    1e. Newton..."
				if {$dispflag} {puts $algoType}
				wipeAnalysis; constraints $constraintsType; numberer $numbererType; system $systemType
				test $testType5 $tol5 $iterL 0
				algorithm Newton
				integrator DisplacementControl $node $dof $dDii; analysis Static
				set ok [analyzeMonitor 1 $tiTask $tiTaskMP 3]
			}
			if {$ok != 0 && $run2e} {
				set algoType "[expr $ii+1].$step.$dDii [nodeDisp $node $dof] [expr [lindex $peakDisp $ii]]    2e. Newton Initial..."
				if {$dispflag} {puts $algoType}
				wipeAnalysis; constraints $constraintsType; numberer $numbererType; system $systemType
				test $testType5 $tol5 $iterH 0
				algorithm Newton -initial
				integrator DisplacementControl $node $dof $dDii; analysis Static
				set ok [analyzeMonitor 1 $tiTask $tiTaskMP 3]
			}
			if {$ok != 0 && $run3e} {
				set algoType "[expr $ii+1].$step.$dDii [nodeDisp $node $dof] [expr [lindex $peakDisp $ii]]    3e. ModifiedNewton Initial..."
				if {$dispflag} {puts $algoType}
				wipeAnalysis; constraints $constraintsType; numberer $numbererType; system $systemType
				test $testType5 $tol5 $iterH 0
				algorithm ModifiedNewton -initial
				integrator DisplacementControl $node $dof $dDii; analysis Static
				set ok [analyzeMonitor 1 $tiTask $tiTaskMP 3]
			}
			if {$ok != 0 && $run4e} {
				set algoType "[expr $ii+1].$step.$dDii [nodeDisp $node $dof] [expr [lindex $peakDisp $ii]]    4e. ModifiedNewton..."
				if {$dispflag} {puts $algoType}
				wipeAnalysis; constraints $constraintsType; numberer $numbererType; system $systemType
				test $testType5 $tol5 $iterH 0
				algorithm ModifiedNewton
				integrator DisplacementControl $node $dof $dDii; analysis Static
				set ok [analyzeMonitor 1 $tiTask $tiTaskMP 3]
			}
			if {$ok != 0 && $run5e} {
				set algoType "[expr $ii+1].$step.$dDii [nodeDisp $node $dof] [expr [lindex $peakDisp $ii]]    5e. NewtonWithLineSearch..."
				if {$dispflag} {puts $algoType}
				wipeAnalysis; constraints $constraintsType; numberer $numbererType; system $systemType
				test $testType5 $tol5 $iterM 0
				algorithm NewtonLineSearch -type InitialInterpoled -tol .8 -maxIter 10 -minEta 0.1 -maxEta 10
				integrator DisplacementControl $node $dof $dDii; analysis Static
				set ok [analyzeMonitor 1 $tiTask $tiTaskMP 3]
			}
			if {$ok != 0 && $run6e} {
				set algoType "[expr $ii+1].$step.$dDii [nodeDisp $node $dof] [expr [lindex $peakDisp $ii]]    6e. BFGS..."
				if {$dispflag} {puts $algoType}
				wipeAnalysis; constraints $constraintsType; numberer $numbererType; system $systemType
				test $testType5 $tol5 $iterM 0
				algorithm BFGS
				integrator DisplacementControl $node $dof $dDii; analysis Static	  
				set ok [analyzeMonitor 1 $tiTask $tiTaskMP 3]
			}
			if {$ok != 0 && $run7e} {
				set algoType "[expr $ii+1].$step.$dDii [nodeDisp $node $dof] [expr [lindex $peakDisp $ii]]    7e. Broyden..."
				if {$dispflag} {puts $algoType}
				wipeAnalysis; constraints $constraintsType; numberer $numbererType; system $systemType
				test $testType5 $tol5 $iterM 0
				algorithm Broyden 8
				integrator DisplacementControl $node $dof $dDii; analysis Static
				set ok [analyzeMonitor 1 $tiTask $tiTaskMP 3]
			}
			if {$ok != 0 && $run8e} {
				set algoType "[expr $ii+1].$step.$dDii [nodeDisp $node $dof] [expr [lindex $peakDisp $ii]]   8e. KrylovNewton..."
				if {$dispflag} {puts $algoType}
				wipeAnalysis; constraints $constraintsType; numberer $numbererType; system $systemType
				test $testType5 $tol5 $iterM 0
				algorithm KrylovNewton
				integrator DisplacementControl $node $dof $dDii; analysis Static
				set ok [analyzeMonitor 1 $tiTask $tiTaskMP 3]
			}
     
     
			if {$ok != 0 && $run1f} {
				set algoType "[expr $ii+1].$step.$dDii [nodeDisp $node $dof] [expr [lindex $peakDisp $ii]]    1f. Newton..."
				if {$dispflag} {puts $algoType}
				wipeAnalysis; constraints $constraintsType; numberer $numbererType; system $systemType
				test $testType6 $tol6 $iterL 0
				algorithm Newton
				integrator DisplacementControl $node $dof $dDii; analysis Static
				set ok [analyzeMonitor 1 $tiTask $tiTaskMP 3]
			}
			if {$ok != 0 && $run2f} {
				set algoType "[expr $ii+1].$step.$dDii [nodeDisp $node $dof] [expr [lindex $peakDisp $ii]]    2f. Newton Initial..."
				if {$dispflag} {puts $algoType}
				wipeAnalysis; constraints $constraintsType; numberer $numbererType; system $systemType
				test $testType6 $tol6 $iterH 0
				algorithm Newton -initial
				integrator DisplacementControl $node $dof $dDii; analysis Static
				set ok [analyzeMonitor 1 $tiTask $tiTaskMP 3]
			}
			if {$ok != 0 && $run3f} {
				set algoType "[expr $ii+1].$step.$dDii [nodeDisp $node $dof] [expr [lindex $peakDisp $ii]]    3f. ModifiedNewton Initial..."
				if {$dispflag} {puts $algoType}
				wipeAnalysis; constraints $constraintsType; numberer $numbererType; system $systemType
				test $testType6 $tol6 $iterH 0
				algorithm ModifiedNewton -initial
				integrator DisplacementControl $node $dof $dDii; analysis Static
				set ok [analyzeMonitor 1 $tiTask $tiTaskMP 3]
			}
			if {$ok != 0 && $run4f} {
				set algoType "[expr $ii+1].$step.$dDii [nodeDisp $node $dof] [expr [lindex $peakDisp $ii]]    4f. ModifiedNewton..."
				if {$dispflag} {puts $algoType}
				wipeAnalysis; constraints $constraintsType; numberer $numbererType; system $systemType
				test $testType6 $tol6 $iterH 0
				algorithm ModifiedNewton
				integrator DisplacementControl $node $dof $dDii; analysis Static
				set ok [analyzeMonitor 1 $tiTask $tiTaskMP 3]
			}
			if {$ok != 0 && $run5f} {
				set algoType "[expr $ii+1].$step.$dDii [nodeDisp $node $dof] [expr [lindex $peakDisp $ii]]    5f. NewtonWithLineSearch..."
				if {$dispflag} {puts $algoType}
				wipeAnalysis; constraints $constraintsType; numberer $numbererType; system $systemType
				test $testType6 $tol6 $iterM 0
				algorithm NewtonLineSearch -type InitialInterpoled -tol .8 -maxIter 10 -minEta 0.1 -maxEta 10
				integrator DisplacementControl $node $dof $dDii; analysis Static
				set ok [analyzeMonitor 1 $tiTask $tiTaskMP 3]
			}
			if {$ok != 0 && $run6f} {
				set algoType "[expr $ii+1].$step.$dDii [nodeDisp $node $dof] [expr [lindex $peakDisp $ii]]    6f. BFGS..."
				if {$dispflag} {puts $algoType}
				wipeAnalysis; constraints $constraintsType; numberer $numbererType; system $systemType
				test $testType6 $tol6 $iterM 0
				algorithm BFGS 
				integrator DisplacementControl $node $dof $dDii; analysis Static
				set ok [analyzeMonitor 1 $tiTask $tiTaskMP 3]
			}
			if {$ok != 0 && $run7f} {
				set algoType "[expr $ii+1].$step.$dDii [nodeDisp $node $dof] [expr [lindex $peakDisp $ii]]    7f. Broyden..."
				if {$dispflag} {puts $algoType}
				wipeAnalysis; constraints $constraintsType; numberer $numbererType; system $systemType
				test $testType6 $tol6 $iterM 0
				algorithm Broyden 8
				integrator DisplacementControl $node $dof $dDii; analysis Static
				set ok [analyzeMonitor 1 $tiTask $tiTaskMP 3]
			}
			if {$ok != 0 && $run8f} {
				set algoType "[expr $ii+1].$step.$dDii [nodeDisp $node $dof] [expr [lindex $peakDisp $ii]]   8f. KrylovNewton..."
				if {$dispflag} {puts $algoType}
				wipeAnalysis; constraints $constraintsType; numberer $numbererType; system $systemType
				test $testType6 $tol6 $iterM 0
				algorithm KrylovNewton
				integrator DisplacementControl $node $dof $dDii; analysis Static
				set ok [analyzeMonitor 1 $tiTask $tiTaskMP 3]
			}
			# Use TaskGeneratorDBE	
			if {$ok == 0} {
				set disp_after_lateral [nodeDisp $node $dof]
				#puts "-It Works!!------------------------------>>"
				incr gstep
				set Rx1 [nodeReaction 10001 1]
				set Rx2 [nodeReaction 10037 1]
				set Rx3 [nodeReaction 10073 1]
				set Rx4 [nodeReaction 10109 1]
				set Rx5 [nodeReaction 20001 1]
				set Rx6 [nodeReaction 20037 1]
				set Rx7 [nodeReaction 20073 1]
				set Rx8 [nodeReaction 20109 1]
				set Px [expr -($Rx1 + $Rx2 + $Rx3 +$Rx4 + $Rx5 + $Rx6 + $Rx7 + $Rx8)]
								
				if {1} {;# temporal
				#puts "<<-Changing pattern------------------------"
				if {$Px > 0 && $PxPast < 0} {
					loadConst -time 0.0				
					pattern Plain [incr patternTag] "Linear" {
						load $LatLoadN1 [expr 1./3.] 0 0 
						load $LatLoadN2 [expr 1./3.] 0 0
						load $LatLoadN3 [expr 1./3.] 0 0
					}
				} elseif {$Px < 0 && $PxPast > 0} {
					loadConst -time 0.0				
					pattern Plain [incr patternTag] "Linear" {
						load $LatLoadN4 [expr 1./3.] 0 0 
						load $LatLoadN5 [expr 1./3.] 0 0
						load $LatLoadN6 [expr 1./3.] 0 0
					}				
				}
				set PxPast $Px
				};# temporal				
				
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
						error 3
					}
				}						
			}	
			set currentDisp [nodeDisp $node $dof]
			if {($dDii >= 0 && $currentDisp >= $peak) || ($dDii <= 0 && $currentDisp <= $peak)} {
				set pushflag 0
			}		
		};# while {$pushflag}
	};# if {$cycleDisp != 0}
	
	puts $recPeak "[expr $ii + 1] $gstep $currentDisp"
};# for {$ii<[llength $peakDisp]}

if {$ok == 0} {
 set tfTask [clock seconds]
 set taskDuration [expr $tfTask - $tiTask]
 puts "$np.$pid.$count  Displacement Control Analysis: DONE!"
 puts $recAlgo "Displacement Control Analysis: DONE!"
 puts "$np.$pid.$count Task Duration = $taskDuration sec"
 puts $recAlgo "Task Duration = $taskDuration sec" 
 close $recInput
 close $recAlgo
 close $recPeak 
 wipe 
 set tryfile 1
 while {[catch {file rename -force $outputDir $outputDir.done}] && $tryfile <= 1000} {incr tryfile}
}






