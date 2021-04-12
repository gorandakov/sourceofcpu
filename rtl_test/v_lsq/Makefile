BASE=../../rtl

obj_dir/lsq_try: obj_dir/Vfun_lsq.cpp agu.cpp
	cd obj_dir && make -f Vfun_lsq.mk

obj_dir/Vfun_lsq.cpp: ${BASE}/adder.sv ${BASE}/lfsr.sv ${BASE}/struct.sv \
${BASE}/operations.sv ${BASE}/bitselect.sv ${BASE}/popcnt.sv ${BASE}/lru8.sv \
${BASE}/lsq/storq.sv ${BASE}/lsq/ldq.sv ${BASE}/lsq/lsq.sv \
${BASE}/lsq/lsfwd.sv ${BASE}/lsq/lsq_req2.sv ${BASE}/lsq/lswalker.sv \
${BASE}/lsq/rqspit.sv ${BASE}/backend/fun_lsq.sv ${BASE}/shifter.sv \
${BASE}/backend/rs_select_fifo.sv ${BASE}/backend/backend_supp.sv \
${BASE}/lsq/stdata.sv ${BASE}/lsq/storq_p1.sv
	verilator -cc --language 1800-2005 --top-module fun_lsq -I${BASE} \
-I${BASE}/backend --assert -CFLAGS -g -CFLAGS -O1 --exe agu.cpp -o lsq_try \
adder.sv -Wno-CASEINCOMPLETE -O3 -threads 6  \
fun_lsq.sv lfsr.sv bitselect.sv popcnt.sv lru8.sv \
lsq/storq.sv lsq/ldq.sv lsq/lsq.sv lsq/lsfwd.sv lsq/lsq_req2.sv \
lsq/lswalker.sv lsq/rqspit.sv shifter.sv backend/rs_select_fifo.sv \
backend/backend_supp.sv lsq/stdata.sv lsq/storq_p1.sv


