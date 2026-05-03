# sections
if {$dispflag} {puts "$np.$pid.$count sections"}; puts $recInput "sections"
set AbD6 [expr $pi*pow(6.35*$mm/2.,2.)]
set AbD16 [expr $pi*pow(15.875*$mm/2.,2.)]
set GJ_ib [expr 0.01*0.38*$Ec*[Jconst [expr 0.1016*$m] [expr 0.1483*$m]]]
set GJ_ob [expr 0.01*0.38*$Ec*[Jconst [expr 0.1016*$m] [expr 0.1829*$m]]]


# Wall1 inner boundary Pier1
if {$dispflag} {puts "$np.$pid.$count Wall1 inner boundary Pier1"}; puts $recInput "Wall1 inner boundary Pier1"
set sec_W1ibP1 [expr $WallTag + 1]
puts $recInput "sec_W1ibP1 $sec_W1ibP1"
puts $recInput "uconc_ibP1 $uconc_ibP1"
puts $recInput "D16 $D16"
puts $recInput "D6v $D6v"
#section Fiber $secTag <-GJ $GJ>
section Fiber $sec_W1ibP1 -GJ $GJ_ib {
#patch rect $matTag $numSubdivY $numSubdivZ $yI $zI $yJ $zJ
patch rect $uconc_ibP1 15 4 [expr -0.0375*$m] [expr -0.0508*$m] [expr  0.1109*$m] [expr  0.0508*$m]
#fiber $yLoc $zLoc $A $matTag 
fiber [expr  0.0895*$m] [expr  0.0342*$m] $AbD6  $D6v
fiber [expr  0.0895*$m] [expr -0.0342*$m] $AbD6  $D6v
fiber [expr -0.0161*$m] [expr  0.0295*$m] $AbD16 $D16
fiber [expr -0.0161*$m] [expr -0.0295*$m] $AbD16 $D16
}
# Wall1 inner boundary Pier2
if {$dispflag} {puts "$np.$pid.$count Wall1 inner boundary Pier2"}; puts $recInput "Wall1 inner boundary Pier2"
set sec_W1ibP2 [expr $WallTag + 2]
puts $recInput "sec_W1ibP2 $sec_W1ibP2"
puts $recInput "uconc_ibP2 $uconc_ibP2"
puts $recInput "D16 $D16"
puts $recInput "D6v $D6v"
#section Fiber $secTag <-GJ $GJ>
section Fiber $sec_W1ibP2 -GJ $GJ_ib {
#patch rect $matTag $numSubdivY $numSubdivZ $yI $zI $yJ $zJ
patch rect $uconc_ibP2 15 4 [expr -0.0375*$m] [expr -0.0508*$m] [expr  0.1109*$m] [expr  0.0508*$m]
#fiber $yLoc $zLoc $A $matTag 
fiber [expr  0.0895*$m] [expr  0.0342*$m] $AbD6  $D6v
fiber [expr  0.0895*$m] [expr -0.0342*$m] $AbD6  $D6v
fiber [expr -0.0161*$m] [expr  0.0295*$m] $AbD16 $D16
fiber [expr -0.0161*$m] [expr -0.0295*$m] $AbD16 $D16
}
# Wall1 inner boundary Panel
if {$dispflag} {puts "$np.$pid.$count Wall1 inner boundary Panel"}; puts $recInput "Wall1 inner boundary Panel"
set sec_W1ibPa [expr $WallTag + 3]
puts $recInput "sec_W1ibPa $sec_W1ibPa"
puts $recInput "uconc_ibPa $uconc_ibPa"
puts $recInput "D16 $D16"
puts $recInput "D6v $D6v"
#section Fiber $secTag <-GJ $GJ>
section Fiber $sec_W1ibPa -GJ $GJ_ib {
#patch rect $matTag $numSubdivY $numSubdivZ $yI $zI $yJ $zJ
patch rect $uconc_ibPa 15 4 [expr -0.0375*$m] [expr -0.0508*$m] [expr  0.1109*$m] [expr  0.0508*$m]
#fiber $yLoc $zLoc $A $matTag 
fiber [expr  0.0895*$m] [expr  0.0342*$m] $AbD6  $D6v
fiber [expr  0.0895*$m] [expr -0.0342*$m] $AbD6  $D6v
fiber [expr -0.0161*$m] [expr  0.0295*$m] $AbD16 $D16
fiber [expr -0.0161*$m] [expr -0.0295*$m] $AbD16 $D16
}
#
#
# Wall1 outer boundary SecA Pier1
if {$dispflag} {puts "$np.$pid.$count Wall1 outer boundary SecA Pier1"}; puts $recInput "Wall1 outer boundary SecA Pier1"
set sec_W1obAP1 [expr $WallTag + 4]
puts $recInput "sec_W1obAP1 $sec_W1obAP1"
puts $recInput "uconc_obAP1 $uconc_obAP1"
puts $recInput "D16 $D16"
#section Fiber $secTag <-GJ $GJ>
section Fiber $sec_W1obAP1 -GJ $GJ_ob {
#patch rect $matTag $numSubdivY $numSubdivZ $yI $zI $yJ $zJ
patch rect $uconc_obAP1 18 4 [expr -0.0914*$m] [expr -0.0508*$m] [expr  0.0914*$m] [expr  0.0508*$m]
#fiber $yLoc $zLoc $A $matTag 
fiber [expr  0.0701*$m] [expr  0.0295*$m] $AbD16 $D16
fiber [expr  0.0701*$m] [expr -0.0295*$m] $AbD16 $D16
fiber [expr  0.0351*$m] [expr  0.0295*$m] $AbD16 $D16
fiber [expr  0.0351*$m] [expr -0.0295*$m] $AbD16 $D16
fiber [expr  0.0000*$m] [expr  0.0295*$m] $AbD16 $D16
fiber [expr  0.0000*$m] [expr -0.0295*$m] $AbD16 $D16
fiber [expr -0.0351*$m] [expr  0.0295*$m] $AbD16 $D16
fiber [expr -0.0351*$m] [expr -0.0295*$m] $AbD16 $D16
fiber [expr -0.0701*$m] [expr  0.0295*$m] $AbD16 $D16
fiber [expr -0.0701*$m] [expr -0.0295*$m] $AbD16 $D16
}
# Wall1 outer boundary SecA Pier2
if {$dispflag} {puts "$np.$pid.$count Wall1 outer boundary SecA Pier2"}; puts $recInput "Wall1 outer boundary SecA Pier2"
set sec_W1obAP2 [expr $WallTag + 5]
puts $recInput "sec_W1obAP2 $sec_W1obAP2"
puts $recInput "uconc_obAP2 $uconc_obAP2"
puts $recInput "D16 $D16"
#section Fiber $secTag <-GJ $GJ>
section Fiber $sec_W1obAP2 -GJ $GJ_ob {
#patch rect $matTag $numSubdivY $numSubdivZ $yI $zI $yJ $zJ
patch rect $uconc_obAP2 18 4 [expr -0.0914*$m] [expr -0.0508*$m] [expr  0.0914*$m] [expr  0.0508*$m]
#fiber $yLoc $zLoc $A $matTag 
fiber [expr  0.0701*$m] [expr  0.0295*$m] $AbD16 $D16
fiber [expr  0.0701*$m] [expr -0.0295*$m] $AbD16 $D16
fiber [expr  0.0351*$m] [expr  0.0295*$m] $AbD16 $D16
fiber [expr  0.0351*$m] [expr -0.0295*$m] $AbD16 $D16
fiber [expr  0.0000*$m] [expr  0.0295*$m] $AbD16 $D16
fiber [expr  0.0000*$m] [expr -0.0295*$m] $AbD16 $D16
fiber [expr -0.0351*$m] [expr  0.0295*$m] $AbD16 $D16
fiber [expr -0.0351*$m] [expr -0.0295*$m] $AbD16 $D16
fiber [expr -0.0701*$m] [expr  0.0295*$m] $AbD16 $D16
fiber [expr -0.0701*$m] [expr -0.0295*$m] $AbD16 $D16
}
# Wall1 outer boundary SecA Panel
if {$dispflag} {puts "$np.$pid.$count Wall1 outer boundary SecA Panel"}; puts $recInput "Wall1 outer boundary SecA Panel"
set sec_W1obAPa [expr $WallTag + 6]
puts $recInput "sec_W1obAPa $sec_W1obAPa"
puts $recInput "uconc_obAPa $uconc_obAPa"
puts $recInput "D16 $D16"
#section Fiber $secTag <-GJ $GJ>
section Fiber $sec_W1obAPa -GJ $GJ_ob {
#patch rect $matTag $numSubdivY $numSubdivZ $yI $zI $yJ $zJ
patch rect $uconc_obAPa 18 4 [expr -0.0914*$m] [expr -0.0508*$m] [expr  0.0914*$m] [expr  0.0508*$m]
#fiber $yLoc $zLoc $A $matTag 
fiber [expr  0.0701*$m] [expr  0.0295*$m] $AbD16 $D16
fiber [expr  0.0701*$m] [expr -0.0295*$m] $AbD16 $D16
fiber [expr  0.0351*$m] [expr  0.0295*$m] $AbD16 $D16
fiber [expr  0.0351*$m] [expr -0.0295*$m] $AbD16 $D16
fiber [expr  0.0000*$m] [expr  0.0295*$m] $AbD16 $D16
fiber [expr  0.0000*$m] [expr -0.0295*$m] $AbD16 $D16
fiber [expr -0.0351*$m] [expr  0.0295*$m] $AbD16 $D16
fiber [expr -0.0351*$m] [expr -0.0295*$m] $AbD16 $D16
fiber [expr -0.0701*$m] [expr  0.0295*$m] $AbD16 $D16
fiber [expr -0.0701*$m] [expr -0.0295*$m] $AbD16 $D16
}
#
#
# Wall1 outer boundary SecB Pier2
if {$dispflag} {puts "$np.$pid.$count Wall1 outer boundary SecB Pier2"}; puts $recInput "Wall1 outer boundary SecB Pier2"
set sec_W1obBP2 [expr $WallTag + 7]
puts $recInput "sec_W1obBP2 $sec_W1obBP2"
puts $recInput "uconc_obBP2 $uconc_obBP2"
puts $recInput "D16 $D16"
#section Fiber $secTag <-GJ $GJ>
section Fiber $sec_W1obBP2 -GJ $GJ_ob {
#patch rect $matTag $numSubdivY $numSubdivZ $yI $zI $yJ $zJ
patch rect $uconc_obBP2 18 4 [expr -0.0914*$m] [expr -0.0508*$m] [expr  0.0914*$m] [expr  0.0508*$m]
#fiber $yLoc $zLoc $A $matTag 
fiber [expr  0.0701*$m] [expr  0.0295*$m] $AbD16 $D16
fiber [expr  0.0701*$m] [expr -0.0295*$m] $AbD16 $D16
fiber [expr  0.0351*$m] [expr  0.0295*$m] $AbD16 $D16
fiber [expr  0.0351*$m] [expr -0.0295*$m] $AbD16 $D16
fiber [expr  0.0000*$m] [expr  0.0295*$m] $AbD16 $D16
fiber [expr  0.0000*$m] [expr -0.0295*$m] $AbD16 $D16
fiber [expr -0.0351*$m] [expr  0.0295*$m] $AbD16 $D16
fiber [expr -0.0351*$m] [expr -0.0295*$m] $AbD16 $D16
}
# Wall1 outer boundary SecB Panel
if {$dispflag} {puts "$np.$pid.$count Wall1 outer boundary SecB Panel"}; puts $recInput "Wall1 outer boundary SecB Panel"
set sec_W1obBPa [expr $WallTag + 8]
puts $recInput "sec_W1obBPa $sec_W1obBPa"
puts $recInput "uconc_obBPa $uconc_obBPa"
puts $recInput "D16 $D16"
#section Fiber $secTag <-GJ $GJ>
section Fiber $sec_W1obBPa -GJ $GJ_ob {
#patch rect $matTag $numSubdivY $numSubdivZ $yI $zI $yJ $zJ
patch rect $uconc_obBPa 18 4 [expr -0.0914*$m] [expr -0.0508*$m] [expr  0.0914*$m] [expr  0.0508*$m]
#fiber $yLoc $zLoc $A $matTag 
fiber [expr  0.0701*$m] [expr  0.0295*$m] $AbD16 $D16
fiber [expr  0.0701*$m] [expr -0.0295*$m] $AbD16 $D16
fiber [expr  0.0351*$m] [expr  0.0295*$m] $AbD16 $D16
fiber [expr  0.0351*$m] [expr -0.0295*$m] $AbD16 $D16
fiber [expr  0.0000*$m] [expr  0.0295*$m] $AbD16 $D16
fiber [expr  0.0000*$m] [expr -0.0295*$m] $AbD16 $D16
fiber [expr -0.0351*$m] [expr  0.0295*$m] $AbD16 $D16
fiber [expr -0.0351*$m] [expr -0.0295*$m] $AbD16 $D16
}
#
#
# Wall1 outer boundary SecC Pier2
if {$dispflag} {puts "$np.$pid.$count Wall1 outer boundary SecC Pier2"}; puts $recInput "Wall1 outer boundary SecC Pier2"
set sec_W1obCP2 [expr $WallTag + 9]
puts $recInput "sec_W1obCP2 $sec_W1obCP2"
puts $recInput "uconc_obCP2 $uconc_obCP2"
puts $recInput "D16 $D16"
#section Fiber $secTag <-GJ $GJ>
section Fiber $sec_W1obCP2 -GJ $GJ_ob {
#patch rect $matTag $numSubdivY $numSubdivZ $yI $zI $yJ $zJ
patch rect $uconc_obCP2 18 4 [expr -0.0914*$m] [expr -0.0508*$m] [expr  0.0914*$m] [expr  0.0508*$m]
#fiber $yLoc $zLoc $A $matTag 
fiber [expr  0.0701*$m] [expr  0.0295*$m] $AbD16 $D16
fiber [expr  0.0701*$m] [expr -0.0295*$m] $AbD16 $D16
fiber [expr  0.0351*$m] [expr  0.0295*$m] $AbD16 $D16
fiber [expr  0.0351*$m] [expr -0.0295*$m] $AbD16 $D16
fiber [expr  0.0000*$m] [expr  0.0295*$m] $AbD16 $D16
fiber [expr  0.0000*$m] [expr -0.0295*$m] $AbD16 $D16
}
# Wall1 outer boundary SecC Panel
if {$dispflag} {puts "$np.$pid.$count Wall1 outer boundary SecC Panel"}; puts $recInput "Wall1 outer boundary SecC Panel"
set sec_W1obCPa [expr $WallTag + 10]
puts $recInput "sec_W1obCPa $sec_W1obCPa"
puts $recInput "uconc_obCPa $uconc_obCPa"
puts $recInput "D16 $D16"
#section Fiber $secTag <-GJ $GJ>
section Fiber $sec_W1obCPa -GJ $GJ_ob {
#patch rect $matTag $numSubdivY $numSubdivZ $yI $zI $yJ $zJ
patch rect $uconc_obCPa 18 4 [expr -0.0914*$m] [expr -0.0508*$m] [expr  0.0914*$m] [expr  0.0508*$m]
#fiber $yLoc $zLoc $A $matTag 
fiber [expr  0.0701*$m] [expr  0.0295*$m] $AbD16 $D16
fiber [expr  0.0701*$m] [expr -0.0295*$m] $AbD16 $D16
fiber [expr  0.0351*$m] [expr  0.0295*$m] $AbD16 $D16
fiber [expr  0.0351*$m] [expr -0.0295*$m] $AbD16 $D16
fiber [expr  0.0000*$m] [expr  0.0295*$m] $AbD16 $D16
fiber [expr  0.0000*$m] [expr -0.0295*$m] $AbD16 $D16
}
#
#
# Wall1 outer boundary SecD Pier2
if {$dispflag} {puts "$np.$pid.$count Wall1 outer boundary SecD Pier2"}; puts $recInput "Wall1 outer boundary SecD Pier2"
set sec_W1obDP2 [expr $WallTag + 11]
puts $recInput "sec_W1obDP2 $sec_W1obDP2"
puts $recInput "uconc_obDP2 $uconc_obDP2"
puts $recInput "D16 $D16"
#section Fiber $secTag <-GJ $GJ>
section Fiber $sec_W1obDP2 -GJ $GJ_ob {
#patch rect $matTag $numSubdivY $numSubdivZ $yI $zI $yJ $zJ
patch rect $uconc_obDP2 18 4 [expr -0.0914*$m] [expr -0.0508*$m] [expr  0.0914*$m] [expr  0.0508*$m]
#fiber $yLoc $zLoc $A $matTag 
fiber [expr  0.0701*$m] [expr  0.0295*$m] $AbD16 $D16
fiber [expr  0.0701*$m] [expr -0.0295*$m] $AbD16 $D16
fiber [expr  0.0351*$m] [expr  0.0295*$m] $AbD16 $D16
fiber [expr  0.0351*$m] [expr -0.0295*$m] $AbD16 $D16
}
# Wall1 outer boundary SecD Panel
if {$dispflag} {puts "$np.$pid.$count Wall1 outer boundary SecD Panel"}; puts $recInput "Wall1 outer boundary SecD Panel"
set sec_W1obDPa [expr $WallTag + 12]
puts $recInput "sec_W1obDPa $sec_W1obDPa"
puts $recInput "uconc_obDPa $uconc_obDPa"
puts $recInput "D16 $D16"
#section Fiber $secTag <-GJ $GJ>
section Fiber $sec_W1obDPa -GJ $GJ_ob {
#patch rect $matTag $numSubdivY $numSubdivZ $yI $zI $yJ $zJ
patch rect $uconc_obDPa 18 4 [expr -0.0914*$m] [expr -0.0508*$m] [expr  0.0914*$m] [expr  0.0508*$m]
#fiber $yLoc $zLoc $A $matTag 
fiber [expr  0.0701*$m] [expr  0.0295*$m] $AbD16 $D16
fiber [expr  0.0701*$m] [expr -0.0295*$m] $AbD16 $D16
fiber [expr  0.0351*$m] [expr  0.0295*$m] $AbD16 $D16
fiber [expr  0.0351*$m] [expr -0.0295*$m] $AbD16 $D16
}




# Wall2 inner boundary Pier1
if {$dispflag} {puts "$np.$pid.$count Wall2 inner boundary Pier1"}; puts $recInput "Wall2 inner boundary Pier1"
set sec_W2ibP1 [expr 2*$WallTag + 1]
puts $recInput "sec_W2ibP1 $sec_W2ibP1"
puts $recInput "uconc_ibP1 $uconc_ibP1"
puts $recInput "D16 $D16"
puts $recInput "D6v $D6v"
#section Fiber $secTag <-GJ $GJ>
section Fiber $sec_W2ibP1 -GJ $GJ_ib {
#patch rect $matTag $numSubdivY $numSubdivZ $yI $zI $yJ $zJ
patch rect $uconc_ibP1 15 4 [expr -0.1109*$m] [expr -0.0508*$m] [expr  0.0375*$m] [expr  0.0508*$m]
#fiber $yLoc $zLoc $A $matTag 
fiber [expr -0.0895*$m] [expr  0.0342*$m] $AbD6  $D6v
fiber [expr -0.0895*$m] [expr -0.0342*$m] $AbD6  $D6v
fiber [expr  0.0161*$m] [expr  0.0295*$m] $AbD16 $D16
fiber [expr  0.0161*$m] [expr -0.0295*$m] $AbD16 $D16
}
# Wall2 inner boundary Pier2
if {$dispflag} {puts "$np.$pid.$count Wall2 inner boundary Pier2"}; puts $recInput "Wall2 inner boundary Pier2"
set sec_W2ibP2 [expr 2*$WallTag + 2]
puts $recInput "sec_W2ibP2 $sec_W2ibP2"
puts $recInput "uconc_ibP2 $uconc_ibP2"
puts $recInput "D16 $D16"
puts $recInput "D6v $D6v"
#section Fiber $secTag <-GJ $GJ>
section Fiber $sec_W2ibP2 -GJ $GJ_ib {
#patch rect $matTag $numSubdivY $numSubdivZ $yI $zI $yJ $zJ
patch rect $uconc_ibP2 15 4 [expr -0.1109*$m] [expr -0.0508*$m] [expr  0.0375*$m] [expr  0.0508*$m]
#fiber $yLoc $zLoc $A $matTag 
fiber [expr -0.0895*$m] [expr  0.0342*$m] $AbD6  $D6v
fiber [expr -0.0895*$m] [expr -0.0342*$m] $AbD6  $D6v
fiber [expr  0.0161*$m] [expr  0.0295*$m] $AbD16 $D16
fiber [expr  0.0161*$m] [expr -0.0295*$m] $AbD16 $D16
}
# Wall2 inner boundary Panel
if {$dispflag} {puts "$np.$pid.$count Wall2 inner boundary Panel"}; puts $recInput "Wall2 inner boundary Panel"
set sec_W2ibPa [expr 2*$WallTag + 3]
puts $recInput "sec_W2ibPa $sec_W2ibPa"
puts $recInput "uconc_ibPa $uconc_ibPa"
puts $recInput "D16 $D16"
puts $recInput "D6v $D6v"
#section Fiber $secTag <-GJ $GJ>
section Fiber $sec_W2ibPa -GJ $GJ_ib {
#patch rect $matTag $numSubdivY $numSubdivZ $yI $zI $yJ $zJ
patch rect $uconc_ibPa 15 4 [expr -0.1109*$m] [expr -0.0508*$m] [expr  0.0375*$m] [expr  0.0508*$m]
#fiber $yLoc $zLoc $A $matTag 
fiber [expr -0.0895*$m] [expr  0.0342*$m] $AbD6  $D6v
fiber [expr -0.0895*$m] [expr -0.0342*$m] $AbD6  $D6v
fiber [expr  0.0161*$m] [expr  0.0295*$m] $AbD16 $D16
fiber [expr  0.0161*$m] [expr -0.0295*$m] $AbD16 $D16
}
#
#
# Wall2 outer boundary SecA Pier1
if {$dispflag} {puts "$np.$pid.$count Wall2 outer boundary SecA Pier1"}; puts $recInput "Wall2 outer boundary SecA Pier1"
set sec_W2obAP1 [expr 2*$WallTag + 4]
puts $recInput "sec_W2obAP1 $sec_W2obAP1"
puts $recInput "uconc_obAP1 $uconc_obAP1"
puts $recInput "D16 $D16"
#section Fiber $secTag <-GJ $GJ>
section Fiber $sec_W2obAP1 -GJ $GJ_ob {
#patch rect $matTag $numSubdivY $numSubdivZ $yI $zI $yJ $zJ
patch rect $uconc_obAP1 18 4 [expr -0.0914*$m] [expr -0.0508*$m] [expr  0.0914*$m] [expr  0.0508*$m]
#fiber $yLoc $zLoc $A $matTag 
fiber [expr  0.0701*$m] [expr  0.0295*$m] $AbD16 $D16
fiber [expr  0.0701*$m] [expr -0.0295*$m] $AbD16 $D16
fiber [expr  0.0351*$m] [expr  0.0295*$m] $AbD16 $D16
fiber [expr  0.0351*$m] [expr -0.0295*$m] $AbD16 $D16
fiber [expr  0.0000*$m] [expr  0.0295*$m] $AbD16 $D16
fiber [expr  0.0000*$m] [expr -0.0295*$m] $AbD16 $D16
fiber [expr -0.0351*$m] [expr  0.0295*$m] $AbD16 $D16
fiber [expr -0.0351*$m] [expr -0.0295*$m] $AbD16 $D16
fiber [expr -0.0701*$m] [expr  0.0295*$m] $AbD16 $D16
fiber [expr -0.0701*$m] [expr -0.0295*$m] $AbD16 $D16
}
# Wall2 outer boundary SecA Pier2
if {$dispflag} {puts "$np.$pid.$count Wall2 outer boundary SecA Pier2"}; puts $recInput "Wall2 outer boundary SecA Pier2"
set sec_W2obAP2 [expr 2*$WallTag + 5]
puts $recInput "sec_W2obAP2 $sec_W2obAP2"
puts $recInput "uconc_obAP2 $uconc_obAP2"
puts $recInput "D16 $D16"
#section Fiber $secTag <-GJ $GJ>
section Fiber $sec_W2obAP2 -GJ $GJ_ob {
#patch rect $matTag $numSubdivY $numSubdivZ $yI $zI $yJ $zJ
patch rect $uconc_obAP2 18 4 [expr -0.0914*$m] [expr -0.0508*$m] [expr  0.0914*$m] [expr  0.0508*$m]
#fiber $yLoc $zLoc $A $matTag 
fiber [expr  0.0701*$m] [expr  0.0295*$m] $AbD16 $D16
fiber [expr  0.0701*$m] [expr -0.0295*$m] $AbD16 $D16
fiber [expr  0.0351*$m] [expr  0.0295*$m] $AbD16 $D16
fiber [expr  0.0351*$m] [expr -0.0295*$m] $AbD16 $D16
fiber [expr  0.0000*$m] [expr  0.0295*$m] $AbD16 $D16
fiber [expr  0.0000*$m] [expr -0.0295*$m] $AbD16 $D16
fiber [expr -0.0351*$m] [expr  0.0295*$m] $AbD16 $D16
fiber [expr -0.0351*$m] [expr -0.0295*$m] $AbD16 $D16
fiber [expr -0.0701*$m] [expr  0.0295*$m] $AbD16 $D16
fiber [expr -0.0701*$m] [expr -0.0295*$m] $AbD16 $D16
}
# Wall2 outer boundary SecA Panel
if {$dispflag} {puts "$np.$pid.$count Wall2 outer boundary SecA Panel"}; puts $recInput "Wall2 outer boundary SecA Panel"
set sec_W2obAPa [expr 2*$WallTag + 6]
puts $recInput "sec_W2obAPa $sec_W2obAPa"
puts $recInput "uconc_obAPa $uconc_obAPa"
puts $recInput "D16 $D16"
#section Fiber $secTag <-GJ $GJ>
section Fiber $sec_W2obAPa -GJ $GJ_ob {
#patch rect $matTag $numSubdivY $numSubdivZ $yI $zI $yJ $zJ
patch rect $uconc_obAPa 18 4 [expr -0.0914*$m] [expr -0.0508*$m] [expr  0.0914*$m] [expr  0.0508*$m]
#fiber $yLoc $zLoc $A $matTag 
fiber [expr  0.0701*$m] [expr  0.0295*$m] $AbD16 $D16
fiber [expr  0.0701*$m] [expr -0.0295*$m] $AbD16 $D16
fiber [expr  0.0351*$m] [expr  0.0295*$m] $AbD16 $D16
fiber [expr  0.0351*$m] [expr -0.0295*$m] $AbD16 $D16
fiber [expr  0.0000*$m] [expr  0.0295*$m] $AbD16 $D16
fiber [expr  0.0000*$m] [expr -0.0295*$m] $AbD16 $D16
fiber [expr -0.0351*$m] [expr  0.0295*$m] $AbD16 $D16
fiber [expr -0.0351*$m] [expr -0.0295*$m] $AbD16 $D16
fiber [expr -0.0701*$m] [expr  0.0295*$m] $AbD16 $D16
fiber [expr -0.0701*$m] [expr -0.0295*$m] $AbD16 $D16
}
#
#
# Wall2 outer boundary SecB Pier2
if {$dispflag} {puts "$np.$pid.$count Wall2 outer boundary SecB Pier2"}; puts $recInput "Wall2 outer boundary SecB Pier2"
set sec_W2obBP2 [expr 2*$WallTag + 7]
puts $recInput "sec_W2obBP2 $sec_W2obBP2"
puts $recInput "uconc_obBP2 $uconc_obBP2"
puts $recInput "D16 $D16"
#section Fiber $secTag <-GJ $GJ>
section Fiber $sec_W2obBP2 -GJ $GJ_ob {
#patch rect $matTag $numSubdivY $numSubdivZ $yI $zI $yJ $zJ
patch rect $uconc_obBP2 18 4 [expr -0.0914*$m] [expr -0.0508*$m] [expr  0.0914*$m] [expr  0.0508*$m]
#fiber $yLoc $zLoc $A $matTag 
fiber [expr  0.0351*$m] [expr  0.0295*$m] $AbD16 $D16
fiber [expr  0.0351*$m] [expr -0.0295*$m] $AbD16 $D16
fiber [expr  0.0000*$m] [expr  0.0295*$m] $AbD16 $D16
fiber [expr  0.0000*$m] [expr -0.0295*$m] $AbD16 $D16
fiber [expr -0.0351*$m] [expr  0.0295*$m] $AbD16 $D16
fiber [expr -0.0351*$m] [expr -0.0295*$m] $AbD16 $D16
fiber [expr -0.0701*$m] [expr  0.0295*$m] $AbD16 $D16
fiber [expr -0.0701*$m] [expr -0.0295*$m] $AbD16 $D16
}
# Wall2 outer boundary SecB Panel
if {$dispflag} {puts "$np.$pid.$count Wall2 outer boundary SecB Panel"}; puts $recInput "Wall2 outer boundary SecB Panel"
set sec_W2obBPa [expr 2*$WallTag + 8]
puts $recInput "sec_W2obBPa $sec_W2obBPa"
puts $recInput "uconc_obBPa $uconc_obBPa"
puts $recInput "D16 $D16"
#section Fiber $secTag <-GJ $GJ>
section Fiber $sec_W2obBPa -GJ $GJ_ob {
#patch rect $matTag $numSubdivY $numSubdivZ $yI $zI $yJ $zJ
patch rect $uconc_obBPa 18 4 [expr -0.0914*$m] [expr -0.0508*$m] [expr  0.0914*$m] [expr  0.0508*$m]
#fiber $yLoc $zLoc $A $matTag 
fiber [expr  0.0351*$m] [expr  0.0295*$m] $AbD16 $D16
fiber [expr  0.0351*$m] [expr -0.0295*$m] $AbD16 $D16
fiber [expr  0.0000*$m] [expr  0.0295*$m] $AbD16 $D16
fiber [expr  0.0000*$m] [expr -0.0295*$m] $AbD16 $D16
fiber [expr -0.0351*$m] [expr  0.0295*$m] $AbD16 $D16
fiber [expr -0.0351*$m] [expr -0.0295*$m] $AbD16 $D16
fiber [expr -0.0701*$m] [expr  0.0295*$m] $AbD16 $D16
fiber [expr -0.0701*$m] [expr -0.0295*$m] $AbD16 $D16
}
#
#
# Wall2 outer boundary SecC Pier2
if {$dispflag} {puts "$np.$pid.$count Wall2 outer boundary SecC Pier2"}; puts $recInput "Wall2 outer boundary SecC Pier2"
set sec_W2obCP2 [expr 2*$WallTag + 9]
puts $recInput "sec_W2obCP2 $sec_W2obCP2"
puts $recInput "uconc_obCP2 $uconc_obCP2"
puts $recInput "D16 $D16"
#section Fiber $secTag <-GJ $GJ>
section Fiber $sec_W2obCP2 -GJ $GJ_ob {
#patch rect $matTag $numSubdivY $numSubdivZ $yI $zI $yJ $zJ
patch rect $uconc_obCP2 18 4 [expr -0.0914*$m] [expr -0.0508*$m] [expr  0.0914*$m] [expr  0.0508*$m]
#fiber $yLoc $zLoc $A $matTag 
fiber [expr  0.0000*$m] [expr  0.0295*$m] $AbD16 $D16
fiber [expr  0.0000*$m] [expr -0.0295*$m] $AbD16 $D16
fiber [expr -0.0351*$m] [expr  0.0295*$m] $AbD16 $D16
fiber [expr -0.0351*$m] [expr -0.0295*$m] $AbD16 $D16
fiber [expr -0.0701*$m] [expr  0.0295*$m] $AbD16 $D16
fiber [expr -0.0701*$m] [expr -0.0295*$m] $AbD16 $D16
}
# Wall2 outer boundary SecC Panel
if {$dispflag} {puts "$np.$pid.$count Wall2 outer boundary SecC Panel"}; puts $recInput "Wall2 outer boundary SecC Panel"
set sec_W2obCPa [expr 2*$WallTag + 10]
puts $recInput "sec_W2obCPa $sec_W2obCPa"
puts $recInput "uconc_obCPa $uconc_obCPa"
puts $recInput "D16 $D16"
#section Fiber $secTag <-GJ $GJ>
section Fiber $sec_W2obCPa -GJ $GJ_ob {
#patch rect $matTag $numSubdivY $numSubdivZ $yI $zI $yJ $zJ
patch rect $uconc_obCPa 18 4 [expr -0.0914*$m] [expr -0.0508*$m] [expr  0.0914*$m] [expr  0.0508*$m]
#fiber $yLoc $zLoc $A $matTag 
fiber [expr  0.0000*$m] [expr  0.0295*$m] $AbD16 $D16
fiber [expr  0.0000*$m] [expr -0.0295*$m] $AbD16 $D16
fiber [expr -0.0351*$m] [expr  0.0295*$m] $AbD16 $D16
fiber [expr -0.0351*$m] [expr -0.0295*$m] $AbD16 $D16
fiber [expr -0.0701*$m] [expr  0.0295*$m] $AbD16 $D16
fiber [expr -0.0701*$m] [expr -0.0295*$m] $AbD16 $D16
}
#
#
# Wall2 outer boundary SecD Pier2
if {$dispflag} {puts "$np.$pid.$count Wall2 outer boundary SecD Pier2"}; puts $recInput "Wall2 outer boundary SecD Pier2"
set sec_W2obDP2 [expr 2*$WallTag + 11]
puts $recInput "sec_W2obDP2 $sec_W2obDP2"
puts $recInput "uconc_obDP2 $uconc_obDP2"
puts $recInput "D16 $D16"
#section Fiber $secTag <-GJ $GJ>
section Fiber $sec_W2obDP2 -GJ $GJ_ob {
#patch rect $matTag $numSubdivY $numSubdivZ $yI $zI $yJ $zJ
patch rect $uconc_obDP2 18 4 [expr -0.0914*$m] [expr -0.0508*$m] [expr  0.0914*$m] [expr  0.0508*$m]
#fiber $yLoc $zLoc $A $matTag 
fiber [expr -0.0351*$m] [expr  0.0295*$m] $AbD16 $D16
fiber [expr -0.0351*$m] [expr -0.0295*$m] $AbD16 $D16
fiber [expr -0.0701*$m] [expr  0.0295*$m] $AbD16 $D16
fiber [expr -0.0701*$m] [expr -0.0295*$m] $AbD16 $D16
}
# Wall2 outer boundary SecD Panel
if {$dispflag} {puts "$np.$pid.$count Wall2 outer boundary SecD Panel"}; puts $recInput "Wall2 outer boundary SecD Panel"
set sec_W2obDPa [expr 2*$WallTag + 12]
puts $recInput "sec_W2obDPa $sec_W2obDPa"
puts $recInput "uconc_obDPa $uconc_obDPa"
puts $recInput "D16 $D16"
#section Fiber $secTag <-GJ $GJ>
section Fiber $sec_W2obDPa -GJ $GJ_ob {
#patch rect $matTag $numSubdivY $numSubdivZ $yI $zI $yJ $zJ
patch rect $uconc_obDPa 18 4 [expr -0.0914*$m] [expr -0.0508*$m] [expr  0.0914*$m] [expr  0.0508*$m]
#fiber $yLoc $zLoc $A $matTag 
fiber [expr -0.0351*$m] [expr  0.0295*$m] $AbD16 $D16
fiber [expr -0.0351*$m] [expr -0.0295*$m] $AbD16 $D16
fiber [expr -0.0701*$m] [expr  0.0295*$m] $AbD16 $D16
fiber [expr -0.0701*$m] [expr -0.0295*$m] $AbD16 $D16
}




# vertical field sections
if {$dispflag} {puts "$np.$pid.$count vertical field sections"}; puts $recInput "vertical field sections"
# inner vertical element
set As_iv [expr 0.001689*0.1223*$m*0.1016*$m]
set Ac_iv [expr 0.1223*$m*0.1016*$m]
puts $recInput "As_iv [expr $As_iv/$m/$m]"
puts $recInput "Ac_iv [expr $Ac_iv/$m/$m]"
# outer vertical element
set As_ov [expr 0.002670*0.1561*$m*0.1016*$m]
set Ac_ov [expr 0.1561*$m*0.1016*$m]
puts $recInput "As_ov [expr $As_ov/$m/$m]"
puts $recInput "Ac_ov [expr $Ac_ov/$m/$m]"

# horizontal sections
if {$dispflag} {puts "$np.$pid.$count horizontal sections"}; puts $recInput "horizontal sections"
set prhA 0.008181
set prhB 0.006136 
set prhC 0.006136
set prhD 0.004091
set As_hA1 [expr $prhA*0.1016*$m*0.2093*$m]
set As_hA2 [expr $prhA*0.1016*$m*0.1717*$m]
set As_hA3 [expr $prhA*0.1016*$m*0.1342*$m]
set As_hA4 [expr $prhA*0.1016*$m*0.1494*$m]
set As_hA5 [expr $prhA*0.1016*$m*0.1645*$m]
set As_hB1 [expr $prhA*0.1016*$m*0.0823*$m + $prhB*0.1016*$m*0.0671*$m]
set As_hB2 [expr $prhB*0.1016*$m*0.1342*$m]
set As_hB3 [expr $prhB*0.1016*$m*0.1494*$m]
set As_hB4 [expr $prhB*0.1016*$m*0.1645*$m]
set As_hC1 [expr $prhB*0.1016*$m*0.0823*$m + $prhC*0.1016*$m*0.0671*$m]
set As_hC2 [expr $prhC*0.1016*$m*0.1342*$m]
set As_hC3 [expr $prhC*0.1016*$m*0.1494*$m]
set As_hC4 [expr $prhC*0.1016*$m*0.1645*$m]
set As_hD1 [expr $prhC*0.1016*$m*0.0671*$m + $prhD*0.1016*$m*0.0823*$m]
set As_hD2 [expr $prhD*0.1016*$m*0.1645*$m]
set As_hD3 [expr $prhD*0.1016*$m*0.1494*$m]
set As_hD4 [expr $prhD*0.1016*$m*0.1342*$m]
set As_hD5 [expr $prhD*0.1016*$m*0.0671*$m]
#
set Ac_hA1 [expr 0.1016*$m*0.2093*$m]
set Ac_hA2 [expr 0.1016*$m*0.1717*$m]
set Ac_hA3 [expr 0.1016*$m*0.1342*$m]
set Ac_hA4 [expr 0.1016*$m*0.1494*$m]
set Ac_hA5 [expr 0.1016*$m*0.1645*$m]
set Ac_hB1 [expr 0.1016*$m*0.0823*$m + 0.1016*$m*0.0671*$m]
set Ac_hB2 [expr 0.1016*$m*0.1342*$m]
set Ac_hB3 [expr 0.1016*$m*0.1494*$m]
set Ac_hB4 [expr 0.1016*$m*0.1645*$m]
set Ac_hC1 [expr 0.1016*$m*0.0823*$m + 0.1016*$m*0.0671*$m]
set Ac_hC2 [expr 0.1016*$m*0.1342*$m]
set Ac_hC3 [expr 0.1016*$m*0.1494*$m]
set Ac_hC4 [expr 0.1016*$m*0.1645*$m]
set Ac_hD1 [expr 0.1016*$m*0.0671*$m + 0.1016*$m*0.0823*$m]
set Ac_hD2 [expr 0.1016*$m*0.1645*$m]
set Ac_hD3 [expr 0.1016*$m*0.1494*$m]
set Ac_hD4 [expr 0.1016*$m*0.1342*$m]
set Ac_hD5 [expr 0.1016*$m*0.0671*$m]

puts $recInput "As_hA1 [expr $As_hA1/$m/$m]"
puts $recInput "As_hA2 [expr $As_hA2/$m/$m]"
puts $recInput "As_hA3 [expr $As_hA3/$m/$m]"
puts $recInput "As_hA4 [expr $As_hA4/$m/$m]"
puts $recInput "As_hA5 [expr $As_hA5/$m/$m]"
puts $recInput "As_hB1 [expr $As_hB1/$m/$m]"
puts $recInput "As_hB2 [expr $As_hB2/$m/$m]"
puts $recInput "As_hB3 [expr $As_hB3/$m/$m]"
puts $recInput "As_hB4 [expr $As_hB4/$m/$m]"
puts $recInput "As_hC1 [expr $As_hC1/$m/$m]"
puts $recInput "As_hC2 [expr $As_hC2/$m/$m]"
puts $recInput "As_hC3 [expr $As_hC3/$m/$m]"
puts $recInput "As_hC4 [expr $As_hC4/$m/$m]"
puts $recInput "As_hD1 [expr $As_hD1/$m/$m]"
puts $recInput "As_hD2 [expr $As_hD2/$m/$m]"
puts $recInput "As_hD3 [expr $As_hD3/$m/$m]"
puts $recInput "As_hD4 [expr $As_hD4/$m/$m]"
puts $recInput "As_hD5 [expr $As_hD5/$m/$m]"
# 
puts $recInput "Ac_hA1 [expr $Ac_hA1/$m/$m]"
puts $recInput "Ac_hA2 [expr $Ac_hA2/$m/$m]"
puts $recInput "Ac_hA3 [expr $Ac_hA3/$m/$m]"
puts $recInput "Ac_hA4 [expr $Ac_hA4/$m/$m]"
puts $recInput "Ac_hA5 [expr $Ac_hA5/$m/$m]"
puts $recInput "Ac_hB1 [expr $Ac_hB1/$m/$m]"
puts $recInput "Ac_hB2 [expr $Ac_hB2/$m/$m]"
puts $recInput "Ac_hB3 [expr $Ac_hB3/$m/$m]"
puts $recInput "Ac_hB4 [expr $Ac_hB4/$m/$m]"
puts $recInput "Ac_hC1 [expr $Ac_hC1/$m/$m]"
puts $recInput "Ac_hC2 [expr $Ac_hC2/$m/$m]"
puts $recInput "Ac_hC3 [expr $Ac_hC3/$m/$m]"
puts $recInput "Ac_hC4 [expr $Ac_hC4/$m/$m]"
puts $recInput "Ac_hD1 [expr $Ac_hD1/$m/$m]"
puts $recInput "Ac_hD2 [expr $Ac_hD2/$m/$m]"
puts $recInput "Ac_hD3 [expr $Ac_hD3/$m/$m]"
puts $recInput "Ac_hD4 [expr $Ac_hD4/$m/$m]"
puts $recInput "Ac_hD5 [expr $Ac_hD5/$m/$m]"

# diagonal sections
set tfield [expr 0.1016*$m]
set AreaDiaP1 [expr $IncVPier1*$IncH1/$IncDPier1*$tfield]
set AreaDiaP2 [expr $IncVPier2*$IncH1/$IncDPier2*$tfield]
set AreaDiaPa [expr $IncVPanel*$IncH1/$IncDPanel*$tfield]

puts $recInput "AreaDiaP1 [expr $AreaDiaP1/$m/$m]"
puts $recInput "AreaDiaP2 [expr $AreaDiaP2/$m/$m]"
puts $recInput "AreaDiaPa [expr $AreaDiaPa/$m/$m]"
