# units
#if {$dispflag} {puts "units"}
# Imperial system
set in 1.
set kip 1.
set sec 1.
set ft [expr 12.*$in]
set ksi [expr $kip/pow($in,2)]
set psi [expr $ksi/1000.]
set lbf [expr $psi*$in*$in]
set pcf [expr $lbf/pow($ft,3)]
set psf [expr $lbf/pow($ft,3)]
set in2 [expr $in*$in]
set in4 [expr $in*$in*$in*$in]
# International system (SI)
set cm [expr $in/2.54]
set cmsec2 [expr $cm/pow($sec,2)]
set m [expr $cm*100]
set mm [expr $cm/10]
set mm2 [expr $mm*$mm]
set kN [expr 0.2247*$kip]
set MPa [expr 0.1450*$ksi]
set GPa [expr 1000*$MPa]
# Constants
set pi [expr 2*asin(1.0)]
set g [expr 32.2*$ft/pow($sec,2)]
set Ubig 1.e15
set Usmall [expr 1/$Ubig]