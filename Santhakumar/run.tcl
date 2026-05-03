# Santhakumar WallB for OpenSeesMP.exe
# Rodolfo Alvarez Sanchez, Spring 2018

# run


# start
#close stderr
set tiTaskMP [clock seconds]
set np [getNP]
set pid [getPID]

set dispflag 1
source procedures.tcl
source units.tcl

set recTask [open Tasks/taskList.txt r]
set taskList [split [read $recTask] \n]
close $recTask
set void [catch {file delete -force {*}[glob Result*]}]


set count 0
foreach taskLine $taskList {# Loop for OpenSeesMP
if {[expr $count % $np] == $pid} {# Assignation of task


set tiTask [clock seconds]
puts "$np.$pid.$count Task: Stared!"
set outputDir Results.$np.$pid.$count
file mkdir $outputDir
set recInput [open $outputDir/Input.txt w]
set recAlgo [open $outputDir/algorithms.txt w]
set recPeak [open $outputDir/peaks.txt w]
set recTaskLine [open $outputDir/taskList.txt w]
puts $recTaskLine $taskLine
close $recTaskLine

# General
set NipBound [lindex $taskLine 1]
set NipField [lindex $taskLine 2]
set prDum [lindex $taskLine 3]
set eIter [lindex $taskLine 4]
set eTol [lindex $taskLine 5] 
set ftest [lindex $taskLine 6]

# Displacement Control Lateral
set constraintsType [lindex $taskLine 7]
set numbererType [lindex $taskLine 8]
set systemType [lindex $taskLine 9]
set testType0 [lindex $taskLine 10];# default
set tol0 [lindex $taskLine 11];# default
set iter0 [lindex $taskLine 12];# default
set algorithmType0 [lindex $taskLine 13];# default
set dD [lindex $taskLine 14]
set testType1 [lindex $taskLine 15]
set testType2 [lindex $taskLine 16]
set testType3 [lindex $taskLine 17]
set testType4 [lindex $taskLine 18]
set testType5 [lindex $taskLine 19]
set testType6 [lindex $taskLine 20]
set tol1 [lindex $taskLine 21]
set tol2 [lindex $taskLine 22]
set tol3 [lindex $taskLine 23]
set tol4 [lindex $taskLine 24]
set tol5 [lindex $taskLine 25]
set tol6 [lindex $taskLine 26]
set iterH [lindex $taskLine 27]
set iterM [lindex $taskLine 28]
set iterL [lindex $taskLine 29]
# testType1 $tol1
set run1a [lindex $taskLine 30];# Newton/iterL
set run2a [lindex $taskLine 31];# Newton Initial/iterH
set run3a [lindex $taskLine 32];# ModifiedNewton Initial/iterH
set run4a [lindex $taskLine 33];# ModifiedNewton/iterH
set run5a [lindex $taskLine 34];# NewtonWithLineSearch/iterM 
set run6a [lindex $taskLine 35];# BFGS/iterM
set run7a [lindex $taskLine 36];# Broyden/iterM
set run8a [lindex $taskLine 37];# KrylovNewton/iterM
# testType2 $tol2
set run1b [lindex $taskLine 38];# Newton/iterL
set run2b [lindex $taskLine 39];# Newton Initial/iterH
set run3b [lindex $taskLine 40];# ModifiedNewton Initial/iterH
set run4b [lindex $taskLine 41];# ModifiedNewton/iterH
set run5b [lindex $taskLine 42];# NewtonWithLineSearch/iterM 
set run6b [lindex $taskLine 43];# BFGS/iterM
set run7b [lindex $taskLine 44];# Broyden/iterM
set run8b [lindex $taskLine 45];# KrylovNewton/iterM
# testType3 $tol3
set run1c [lindex $taskLine 46];# Newton/iterL
set run2c [lindex $taskLine 47];# Newton Initial/iterH
set run3c [lindex $taskLine 48];# ModifiedNewton Initial/iterH
set run4c [lindex $taskLine 49];# ModifiedNewton/iterH
set run5c [lindex $taskLine 50];# NewtonWithLineSearch/iterM 
set run6c [lindex $taskLine 51];# BFGS/iterM
set run7c [lindex $taskLine 52];# Broyden/iterM
set run8c [lindex $taskLine 53];# KrylovNewton/iterM
# testType4 $tol4
set run1d [lindex $taskLine 54];# Newton/iterL
set run2d [lindex $taskLine 55];# Newton Initial/iterH
set run3d [lindex $taskLine 56];# ModifiedNewton Initial/iterH
set run4d [lindex $taskLine 57];# ModifiedNewton/iterH
set run5d [lindex $taskLine 58];# NewtonWithLineSearch/iterM 
set run6d [lindex $taskLine 59];# BFGS/iterM
set run7d [lindex $taskLine 60];# Broyden/iterM
set run8d [lindex $taskLine 61];# KrylovNewton/iterM
# testType5 $tol5
set run1e [lindex $taskLine 62];# Newton/iterL
set run2e [lindex $taskLine 63];# Newton Initial/iterH
set run3e [lindex $taskLine 64];# ModifiedNewton Initial/iterH
set run4e [lindex $taskLine 65];# ModifiedNewton/iterH
set run5e [lindex $taskLine 66];# NewtonWithLineSearch/iterM 
set run6e [lindex $taskLine 67];# BFGS/iterM
set run7e [lindex $taskLine 68];# Broyden/iterM
set run8e [lindex $taskLine 69];# KrylovNewton/iterM
# testType6 $tol6
set run1f [lindex $taskLine 70];# Newton/iterL
set run2f [lindex $taskLine 71];# Newton Initial/iterH
set run3f [lindex $taskLine 72];# ModifiedNewton Initial/iterH
set run4f [lindex $taskLine 73];# ModifiedNewton/iterH
set run5f [lindex $taskLine 74];# NewtonWithLineSearch/iterM 
set run6f [lindex $taskLine 75];# BFGS/iterM
set run7f [lindex $taskLine 76];# Broyden/iterM
set run8f [lindex $taskLine 77];# KrylovNewton/iterM


if {[catch {


wipe
model Basic -ndm 2 -ndf 3

# panel
set wgrid [expr 0.4807*$m] 
set hgrid [expr 5.4682*$m]
set NumHorInc 3; 
set NumVerInc 35;
set WallTag 10000
set DiaElemTag 1000
set VerElemTag 3000
set HorElemTag 5000

set Nnode [expr ($NumVerInc + 1)*($NumHorInc + 1)]
set Ndiag [expr $NumVerInc*$NumHorInc*2]
set Nvbeam [expr $NumVerInc*($NumHorInc + 1)]
set Nhbeam [expr $NumHorInc*($NumVerInc + 1)]
set maxNnode [expr $WallTag + 1]
set maxNdiag [expr $VerElemTag - $DiaElemTag + 1]
set maxNvbeam [expr $HorElemTag - $VerElemTag + 1]
set maxNhbeam [expr $WallTag - $HorElemTag + 1]
if {$Nnode > $maxNnode} {if {$dispflag} {puts "Error: Nnode $Nnode > max $maxNnode"}; error "Error: Nnode $Nnode > max $maxNnode"}
if {$Ndiag > $maxNdiag} {if {$dispflag} {puts "Error: Ndiag $Ndiag > max $maxNdiag"}; error "Error: Ndiag $Ndiag > max $maxNdiag"}
if {$Nvbeam > $maxNvbeam} {if {$dispflag} {puts "Error: Nvbeam $Nvbeam > max $maxNvbeam"}; error "Error: Nvbeam $Nvbeam > max $maxNvbeam"}
if {$Nhbeam > $maxNhbeam} {if {$dispflag} {puts "Error: Nhbeam $Nhbeam > max $maxNhbeam"}; error "Error: Nhbeam $Nhbeam > max $maxNhbeam"}

source materials.tcl
source sections.tcl
set strainpFlag 0
source geoWall1.tcl
source geoWall2.tcl
source coupling3.tcl
#source coupling_shearSpring.tcl
#source coupling_momentSpring.tcl
source test.tcl
if {$strainpFlag} {source strainp.tcl}
source recorders.tcl
#record
source gravity.tcl
record
source push2.tcl

# finish
#puts "Press enter to finish..."
#set end [gets stdin line]
wipe


} errorResult]} {
  
set tfTask [clock seconds]
set taskDuration [expr $tfTask - $tiTask]
puts "$np.$pid.$count Task Duration = $taskDuration sec"
puts $recAlgo "Task Duration = $taskDuration sec" 
  
if {$errorResult == 1} {
  puts "$np.$pid.$count Gravity Analysis: Error!"
  puts $recAlgo "Gravity Analysis: Error!"
} elseif {$errorResult == 2} {
  puts "$np.$pid.$count Vertical Load Analysis (step 1): Error!"
  puts $recAlgo "Vertical Load Analysis (step 1): Error!"
} elseif {$errorResult == 3} {  
  puts "$np.$pid.$count Displacement Control Analysis: Error!"
  puts $recAlgo "Displacement Control Analysis: Error!"  
  } elseif {$errorResult == 4} { 
  puts "$np.$pid.$count Vertical Load Analysis: Error!"
  puts $recAlgo "Vertical Load Analysis: Error!"  
} elseif {$errorResult == 101} {
  puts "$np.$pid.$count Gravity Analysis: Aborted!, maxAnalyzeDuration exceeded $maxAnalyzeDuration sec"
  puts $recAlgo "Gravity Analysis: Aborted!, maxAnalyzeDuration exceeded $maxAnalyzeDuration sec"
} elseif {$errorResult == 102} {
  puts "$np.$pid.$count Gravity Analysis: Aborted!, maxTaskDuration exceeded $maxTaskDuration sec"
  puts $recAlgo "Gravity Analysis: Aborted!, maxTaskDuration exceeded $maxTaskDuration sec"
} elseif {$errorResult == 103} {  
  puts "$np.$pid.$count Gravity Analysis: Aborted!, maxTaskMPDuration exceeded $maxTaskMPDuration sec"
  puts $recAlgo "Gravity Analysis: Aborted!, maxTaskMPDuration exceeded $maxTaskMPDuration sec"  
} elseif {$errorResult == 201} {
  puts "$np.$pid.$count Vertical Load Analysis (step 1): Aborted!, maxAnalyzeDuration exceeded $maxAnalyzeDuration sec"
  puts $recAlgo "Vertical Load Analysis (step 1): Aborted!, maxAnalyzeDuration exceeded $maxAnalyzeDuration sec"
} elseif {$errorResult == 202} {
  puts "$np.$pid.$count Vertical Load Analysis (step 1): Aborted!, maxTaskDuration exceeded $maxTaskDuration sec"
  puts $recAlgo "Vertical Load Analysis (step 1): Aborted!, maxTaskDuration exceeded $maxTaskDuration sec"
} elseif {$errorResult == 203} {  
  puts "$np.$pid.$count Vertical Load Analysis (step 1): Aborted!, maxTaskMPDuration exceeded $maxTaskMPDuration sec"
  puts $recAlgo "Vertical Load Analysis (step 1): Aborted!, maxTaskMPDuration exceeded $maxTaskMPDuration sec"  
} elseif {$errorResult == 301} {
  puts "$np.$pid.$count Displacement Control Analysis: Aborted!, maxAnalyzeDuration exceeded $maxAnalyzeDuration sec"
  puts $recAlgo "Displacement Control Analysis: Aborted!, maxAnalyzeDuration exceeded $maxAnalyzeDuration sec"
} elseif {$errorResult == 302} {
  puts "$np.$pid.$count Displacement Control Analysis: Aborted!, maxTaskDuration exceeded $maxTaskDuration sec"
  puts $recAlgo "Displacement Control Analysis: Aborted!, maxTaskDuration exceeded $maxTaskDuration sec"
} elseif {$errorResult == 303} {  
  puts "$np.$pid.$count Displacement Control Analysis: Aborted!, maxTaskMPDuration exceeded $maxTaskMPDuration sec"
  puts $recAlgo "Displacement Control Analysis: Aborted!, maxTaskMPDuration exceeded $maxTaskMPDuration sec"  
} elseif {$errorResult == 401} {
  puts "$np.$pid.$count Vertical Load Analysis: Aborted!, maxAnalyzeDuration exceeded $maxAnalyzeDuration sec"
  puts $recAlgo "Vertical Load Analysis: Aborted!, maxAnalyzeDuration exceeded $maxAnalyzeDuration sec"
} elseif {$errorResult == 402} {
  puts "$np.$pid.$count Vertical Load Analysis: Aborted!, maxTaskDuration exceeded $maxTaskDuration sec"
  puts $recAlgo "Vertical Load Analysis: Aborted!, maxTaskDuration exceeded $maxTaskDuration sec"
} elseif {$errorResult == 403} {  
  puts "$np.$pid.$count Vertical Load Analysis: Aborted!, maxTaskMPDuration exceeded $maxTaskMPDuration sec"
  puts $recAlgo "Vertical Load Analysis: Aborted!, maxTaskMPDuration exceeded $maxTaskMPDuration sec"  
} else {
  puts "$np.$pid.$count $errorResult"
  puts $recAlgo $errorResult 
}
  
close $recInput
close $recAlgo
close $recPeak
wipe
set tryfile 1
if {$errorResult >= 101} {
  while {[catch {file rename -force $outputDir $outputDir.aborted}] && $tryfile <= 1000} {incr tryfile}
} else {
  while {[catch {file rename -force $outputDir $outputDir.error.[expr $ii+1].$step}] && $tryfile <= 1000} {incr tryfile}  
}
if {$errorResult == 103 || $errorResult == 203 || $errorResult == 303 || $errorResult == 403} {
  exit 
}


};# End catch


};# Assignation of task 
incr count
};# Loop for OpenSeesMP




set recLog [open log.$np.$pid.txt w]
set tfProcess [clock seconds]
set processDuration [expr $tfProcess - $tiTaskMP]
puts "$np.$pid. Process Duration = $processDuration sec"
puts $recLog "$np.$pid. Process Duration = $processDuration sec"
flush $recLog

#barrier

set tfTaskMP [clock seconds]
set taskMPDuration [expr $tfTaskMP - $tiTaskMP]
puts "$np.$pid. TaskMP Duration = $taskMPDuration sec"
puts $recLog "$np.$pid. TaskMP Duration = $taskMPDuration sec"
close $recLog
