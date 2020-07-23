BASE=../../rtl

obj_dir/lsq_try: obj_dir/Vstorq_p1.cpp agu.cpp
	cd obj_dir && make -f Vstorq_p1.mk

obj_dir/Vstorq_p1.cpp: ${BASE}/adder.sv ${BASE}/lfsr.sv ${BASE}/struct.sv \
${BASE}/operations.sv ${BASE}/bitselect.sv ${BASE}/popcnt.sv ${BASE}/lru8.sv \
${BASE}/lsq/storq_p1.sv ${BASE}/lsq/storq.sv ${BASE}/lsq/lsfwd.sv \
${BASE}/lsq/lswalker.sv ${BASE}/shifter.sv 
	verilator -cc --language 1800-2005 --top-module storq_p1 -I${BASE} \
-I${BASE}/backend --assert -CFLAGS -g -CFLAGS -O1 --exe agu.cpp -o lsq_try1 \
adder.sv -Wno-CASEINCOMPLETE -O3 -CFLAGS -march=native  \
lfsr.sv bitselect.sv popcnt.sv lru8.sv shifter.sv \
lsq/storq_p1.sv lsq/storq.sv lsq/lsfwd.sv lsq/lswalker.sv


