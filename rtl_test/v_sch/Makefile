BASE=../../rtl
obj_dir/sch_test: obj_dir/Vfun_sch.cpp
	cd obj_dir && make -f Vfun_sch.mk

obj_dir/Vfun_sch.cpp: ${BASE}/adder.sv ${BASE}/backend/rs_block.sv \
${BASE}/lfsr.sv ${BASE}/struct.sv ${BASE}/operations.sv ${BASE}/bitselect.sv \
${BASE}/popcnt.sv ${BASE}/lru8.sv ${BASE}/backend/fun_sch.sv \
${BASE}/common2.sv ${BASE}/backend/regfile.sv ${BASE}/backend/rrf.sv \
${BASE}/backend/regfile_flags.sv ${BASE}/backend/rrf_flags.sv \
${BASE}/backend/rs_select_fifo.sv ${BASE}/backend/reg_in_flight.sv \
${BASE}/backend/backend_supp.sv ${BASE}/backend/rs.sv \
${BASE}/backend/rs_store.sv ${BASE}/backend/rs_alloc.sv \
${BASE}/backend/rat2.sv ${BASE}/backend/ratS.sv ${BASE}/backend/ratV.sv \
${BASE}/backend/gazump.sv ${BASE}/cntrl/bob_except.sv  ${BASE}/cntrl/bob_indir.sv \
${BASE}/cntrl/bob.sv  ${BASE}/cntrl/cntrl.sv ${BASE}/backend/alu.sv \
${BASE}/frontend/tbuf.sv
	verilator -cc --language 1800-2005 --top-module fun_sch -I${BASE} \
-I${BASE}/backend -I${BASE}/cntrl --exe sch_rs.cpp -o sch_test --assert -CFLAGS -g adder.sv \
rs_block.sv lfsr.sv bitselect.sv popcnt.sv lru8.sv fun_sch.sv common2.sv \
regfile.sv rrf.sv regfile_flags.sv rrf_flags.sv rs_select_fifo.sv frontend/tbuf.sv \
reg_in_flight.sv backend_supp.sv rs.sv rs_store.sv rs_alloc.sv rat2.sv \
ratS.sv ratV.sv gazump.sv bob_except.sv  bob_indir.sv  bob.sv  cntrl.sv alu.sv

