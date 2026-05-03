# procedures
if {$dispflag} {puts "procedures"}
# Calculate regularized strain at crushing strength eu
proc euReg {fc Ec ec Le} {
set Lr [expr 600/25.4]
set A [expr $fc/(0.5*($Ec*$ec + $fc))]
set eu1 [expr (1-$A)*$ec + $Lr/$Le*(-0.002 + $A*$ec)]
set eu [expr min($ec-0.002,$eu1*1.00)];# <-- $eu1*1.00 = $eu1
return $eu
}

# Calculates regularized residual strain tension softening etres (ConcretewBeta) 
proc etresReg {etres Le} { 
set Lr [expr 600/25.4]
#set etres_reg [expr max($etres,$Lr/($Le*1.0)*$etres)]
set etres_reg $etres;# eliminate regularization 
return $etres_reg
}

# Calculates regularized factor for biaxial effect Beta (ConcretewBeta)
proc BetaReg {Le} {
set Lr [expr 600/25.4]
set ebint [expr max(0.01,$Lr/($Le*1.0)*0.01)]
set ebres [expr max(0.04,$Lr/($Le*1.0)*0.04)] 
return [list $ebint $ebres]
}

# Calculates polar moment of inertia J for rectangular section
proc Jconst {d1 d2} {
if {$d1 >= $d2} {
	set a $d1
	set b $d2
} else {
    set a $d2
	set b $d1
}
return [expr $a*pow($b,3.)*(1/3.-0.21*$b/$a*(1.-pow($b,4.)/12./pow($a,4.)))]
}

# Launches error if process time is exceeded
set maxAnalyzeDuration [expr 60*60*72];# Step duration (sec)
set maxTaskDuration [expr 60*60*72];# Task duration (sec)
set maxTaskMPDuration [expr 60*60*72];# Total duration for tastks (sec)
proc analyzeMonitor {NStep tiTask tiTaskMP tagLoc} {
variable maxAnalyzeDuration
variable maxTaskDuration
variable maxTaskMPDuration
set tiAnalyze [clock seconds]
set ok [analyze $NStep]
set tfAnalyze [clock seconds]
set AnalyzeDuration [expr $tfAnalyze - $tiAnalyze]
set TaskDuration [expr $tfAnalyze - $tiTask]
set TaskMPDuration [expr $tfAnalyze - $tiTaskMP]
if {$AnalyzeDuration > $maxAnalyzeDuration} {
	error [expr 100*$tagLoc + 1]
} elseif {$TaskDuration > $maxTaskDuration} {
	error [expr 100*$tagLoc + 2]
} elseif {$TaskMPDuration > $maxTaskMPDuration} {
	error [expr 100*$tagLoc + 3]
} else {
return $ok
}
}