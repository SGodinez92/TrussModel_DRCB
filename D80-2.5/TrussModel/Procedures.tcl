#Procedures 
 
#Calculate value of regularized ultimate strain for confined concrete 
#Units of element length are inches 
proc euReg {fc Ec ec Le} { 
set A [expr $fc/(0.5*($Ec*$ec+$fc))] 
set eu1 [expr (1+$A)*$ec+(600/($Le*25.4))*(-0.002+$A*$ec)] 
set eu [expr min($ec-0.002,$eu1)] 
return $eu 
 } 