
# XM-Sim Command File
# TOOL:	xmsim(64)	19.09-s008
#

set tcl_prompt1 {puts -nonewline "xcelium> "}
set tcl_prompt2 {puts -nonewline "> "}
set vlog_format %h
set vhdl_format %v
set real_precision 6
set display_unit auto
set time_unit module
set heap_garbage_size -200
set heap_garbage_time 0
set assert_report_level note
set assert_stop_level error
set autoscope yes
set assert_1164_warnings yes
set pack_assert_off {}
set severity_pack_assert_off {note warning}
set assert_output_stop_level failed
set tcl_debug_level 0
set relax_path_name 1
set vhdl_vcdmap XX01ZX01X
set intovf_severity_level ERROR
set probe_screen_format 0
set rangecnst_severity_level ERROR
set textio_severity_level ERROR
set vital_timing_checks_on 1
set vlog_code_show_force 0
set assert_count_attempts 1
set tcl_all64 false
set tcl_runerror_exit false
set assert_report_incompletes 0
set show_force 1
set force_reset_by_reinvoke 0
set tcl_relaxed_literal 0
set probe_exclude_patterns {}
set probe_packed_limit 4k
set probe_unpacked_limit 16k
set assert_internal_msg no
set svseed 1
set assert_reporting_mode 0
alias . run
alias quit exit
database -open -shm -into waves.shm waves -default
probe -create -database waves simtop.y simtop.x simtop.start simtop.r simtop.out simtop.g simtop.cy simtop.cx simtop.clk simtop.char simtop.calcend simtop.b
probe -create -database waves simtop.draw0.B simtop.draw0.CHAR simtop.draw0.CLK simtop.draw0.CX simtop.draw0.CY simtop.draw0.G simtop.draw0.KEY simtop.draw0.NRST simtop.draw0.R simtop.draw0.SW simtop.draw0.X simtop.draw0.Y simtop.draw0.addr simtop.draw0.color simtop.draw0.lambda_calcend simtop.draw0.lambda_end simtop.draw0.lambda_out simtop.draw0.lambda_start simtop.draw0.outB simtop.draw0.outG simtop.draw0.outR
probe -create -database waves simtop.draw0.firstclk simtop.draw0.p
probe -create -database waves simtop.draw0.lambda0.a simtop.draw0.lambda0.b simtop.draw0.lambda0.firstclk simtop.draw0.lambda0.iCLK simtop.draw0.lambda0.iP simtop.draw0.lambda0.iS simtop.draw0.lambda0.iStart simtop.draw0.lambda0.iX simtop.draw0.lambda0.iY simtop.draw0.lambda0.index simtop.draw0.lambda0.lambda_last simtop.draw0.lambda0.log_calcend simtop.draw0.lambda0.log_in simtop.draw0.lambda0.log_out simtop.draw0.lambda0.log_start simtop.draw0.lambda0.n simtop.draw0.lambda0.nextx simtop.draw0.lambda0.oCalc_end simtop.draw0.lambda0.oLambda simtop.draw0.lambda0.r_i simtop.draw0.lambda0.r_i_n simtop.draw0.lambda0.temp0 simtop.draw0.lambda0.temp1 simtop.draw0.lambda0.temp2 simtop.draw0.lambda0.x simtop.draw0.lambda0.x1x

simvision -input /home/zengaku24/VGAtest/.simvision/16303_zengaku24_ikedalab-nuc07_autosave.tcl.svcf
