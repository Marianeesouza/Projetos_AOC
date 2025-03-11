transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Projetos_AOC/Atividades\ 2VA\ -\ AOC/Projeto\ 2VA\ -\ AOC {C:/Projetos_AOC/Atividades 2VA - AOC/Projeto 2VA - AOC/ula_ctrl.v}
vlog -vlog01compat -work work +incdir+C:/Projetos_AOC/Atividades\ 2VA\ -\ AOC/Projeto\ 2VA\ -\ AOC {C:/Projetos_AOC/Atividades 2VA - AOC/Projeto 2VA - AOC/control.v}
vlog -vlog01compat -work work +incdir+C:/Projetos_AOC/Atividades\ 2VA\ -\ AOC/Projeto\ 2VA\ -\ AOC {C:/Projetos_AOC/Atividades 2VA - AOC/Projeto 2VA - AOC/ULA.v}
vlog -vlog01compat -work work +incdir+C:/Projetos_AOC/Atividades\ 2VA\ -\ AOC/Projeto\ 2VA\ -\ AOC {C:/Projetos_AOC/Atividades 2VA - AOC/Projeto 2VA - AOC/somador_PC_4.v}
vlog -vlog01compat -work work +incdir+C:/Projetos_AOC/Atividades\ 2VA\ -\ AOC/Projeto\ 2VA\ -\ AOC {C:/Projetos_AOC/Atividades 2VA - AOC/Projeto 2VA - AOC/somador_PC_jump.v}
vlog -vlog01compat -work work +incdir+C:/Projetos_AOC/Atividades\ 2VA\ -\ AOC/Projeto\ 2VA\ -\ AOC {C:/Projetos_AOC/Atividades 2VA - AOC/Projeto 2VA - AOC/MIPS_Monociclo.v}
vlog -vlog01compat -work work +incdir+C:/Projetos_AOC/Atividades\ 2VA\ -\ AOC/Projeto\ 2VA\ -\ AOC {C:/Projetos_AOC/Atividades 2VA - AOC/Projeto 2VA - AOC/mux2x1.v}
vlog -vlog01compat -work work +incdir+C:/Projetos_AOC/Atividades\ 2VA\ -\ AOC/Projeto\ 2VA\ -\ AOC {C:/Projetos_AOC/Atividades 2VA - AOC/Projeto 2VA - AOC/PC.v}
vlog -vlog01compat -work work +incdir+C:/Projetos_AOC/Atividades\ 2VA\ -\ AOC/Projeto\ 2VA\ -\ AOC {C:/Projetos_AOC/Atividades 2VA - AOC/Projeto 2VA - AOC/extensor_de_sinal.v}
vlog -vlog01compat -work work +incdir+C:/Projetos_AOC/Atividades\ 2VA\ -\ AOC/Projeto\ 2VA\ -\ AOC {C:/Projetos_AOC/Atividades 2VA - AOC/Projeto 2VA - AOC/shift_left_2.v}
vlog -vlog01compat -work work +incdir+C:/Projetos_AOC/Atividades\ 2VA\ -\ AOC/Projeto\ 2VA\ -\ AOC {C:/Projetos_AOC/Atividades 2VA - AOC/Projeto 2VA - AOC/regfile.v}
vlog -vlog01compat -work work +incdir+C:/Projetos_AOC/Atividades\ 2VA\ -\ AOC/Projeto\ 2VA\ -\ AOC {C:/Projetos_AOC/Atividades 2VA - AOC/Projeto 2VA - AOC/d_mem.v}
vlog -vlog01compat -work work +incdir+C:/Projetos_AOC/Atividades\ 2VA\ -\ AOC/Projeto\ 2VA\ -\ AOC {C:/Projetos_AOC/Atividades 2VA - AOC/Projeto 2VA - AOC/i_mem.v}

