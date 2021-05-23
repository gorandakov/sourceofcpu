
ROOT=../../rtl

obj_dir/Vfun_alu.cpp: ${ROOT}/backend/fun_alu.sv ${ROOT}/backend/alu.sv \
${ROOT}/struct.sv ${ROOT}/adder.sv ${ROOT}/shifter.sv \
${ROOT}/backend/alu_shift.sv ${ROOT}/backend/rs_block.sv \
${ROOT}/math/ifconvt.sv ${ROOT}/math/imul.sv ${ROOT}/math/icompr.sv \
${ROOT}/math/faha.sv ${ROOT}/bitselect.sv ${ROOT}/spectre/agusec.sv \
${ROOT}/spectre/mul.sv
	verilator --cc --language 1800-2005  --top-module fu_alu -I${ROOT} \
-I${ROOT}/backend --exe alu.cpp -o alu_test --assert -CFLAGS -g \
fun_alu.sv alu.sv adder.sv shifter.sv alu_shift.sv \
rs_block.sv /math/ifconvt.sv math/imul.sv math/icompr.sv math/faha.sv \
bitselect.sv spectre/agusec.sv spectre/mul.sv
