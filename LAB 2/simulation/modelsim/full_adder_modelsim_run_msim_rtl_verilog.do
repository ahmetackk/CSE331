transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/altera/13.1/projects/co_lab2 {C:/altera/13.1/projects/co_lab2/half_adder.v}
vlog -vlog01compat -work work +incdir+C:/altera/13.1/projects/co_lab2 {C:/altera/13.1/projects/co_lab2/full_adder.v}

