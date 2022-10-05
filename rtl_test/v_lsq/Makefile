BASE=../../rtl

obj_dir/lsq_try: obj_dir/Vfun_lsq.cpp agu.cpp
	+schroot -- make -f Vfun_lsq.mk -C obj_dir

obj_dir/Vfun_lsq.cpp: ${BASE}/adder.sv ${BASE}/lfsr.sv ${BASE}/struct.sv \
${BASE}/operations.sv ${BASE}/bitselect.sv ${BASE}/popcnt.sv ${BASE}/lru8.sv \
${BASE}/lsq/stq.sv ${BASE}/lsq/ldq.sv ${BASE}/lsq/stq_A.sv \
${BASE}/lsq/stq_ram.sv ${BASE}/lsq/ret.sv \
${BASE}/lsq/stq_L.sv ${BASE}/lsq/lsq_req2.sv ${BASE}/lsq/stq_data.sv \
${BASE}/lsq/stq_adata.sv ${BASE}/backend/fun_lsq.sv ${BASE}/shifter.sv \
${BASE}/backend/rs_select_fifo.sv ${BASE}/backend/backend_supp.sv 
	schroot -- verilator -cc --language 1800-2005 --top-module fun_lsq \
-I${BASE} \
-I${BASE}/backend --assert -CFLAGS -g -CFLAGS -O1 --exe agu.cpp -o lsq_try \
adder.sv -Wno-CASEINCOMPLETE -O3 -threads 4  \
fun_lsq.sv lfsr.sv bitselect.sv popcnt.sv lru8.sv \
lsq/stq.sv lsq/ldq.sv lsq/stq_A.sv lsq/lsq_req2.sv \
lsq/stq_L.sv lsq/stq_ram.sv lsq/stq_data.sv lsq/stq_adata.sv shifter.sv \
backend/rs_select_fifo.sv backend/backend_supp.sv lsq/ret.sv 


