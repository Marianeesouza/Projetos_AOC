vlog -work work Waveform1.vwf.vt
vsim -voptargs=+acc -c -t 1ps -L fiftyfivenm_ver -L altera_ver -L altera_mf_ver -L 220model_ver -L sgate_ver -L altera_lnsim_ver work.MIPS_Monociclo_vlg_vec_tst -voptargs="+acc"
add wave /*
run -all
