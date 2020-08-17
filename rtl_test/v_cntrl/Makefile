BASE=../../rtl

obj_dir/cntrl_: obj_dir/Vcntrl_find_outcome.cpp cntrl.cpp
	cd obj_dir && make -f Vcntrl_find_outcome.mk

obj_dir/Vcntrl_find_outcome.cpp: ${BASE}/adder.sv ${BASE}/lfsr.sv \
${BASE}/struct.sv ${BASE}/bitselect.sv ${BASE}/popcnt.sv \
${BASE}/cntrl/cntrl.sv ${BASE}/cntrl/bob.sv ${BASE}/cntrl/bob_indir.sv \
${BASE}/cntrl/bob_except.sv ${BASE}/backend/alu.sv
	verilator -cc --language 1800-2005 --top-module cntrl_find_outcome \
-I${BASE} -I${BASE}/cntrl --assert -CFLAGS -g -CFLAGS -O1 --exe cntrl.cpp \
-o cntrl_ adder.sv -Wno-CASEINCOMPLETE -O3 -threads 6  \
lfsr.sv bitselect.sv popcnt.sv cntrl.sv bob.sv bob_indir.sv bob_except.sv \
backend/alu.sv




