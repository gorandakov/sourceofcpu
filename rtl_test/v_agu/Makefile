
BASE=../../rtl
obj_dir/agu_test: obj_dir/Vagu_block.cpp
	cd obj_dir && make -f Vagu_block.mk

obj_dir/Vagu_block.cpp: ${BASE}/adder.sv ${BASE}/backend/agu.sv \
${BASE}/backend/agu_r.sv ${BASE}/backend/agu_w.sv ${BASE}/backend/fun_agu.sv \
${BASE}/backend/rs_block.sv ${BASE}/cams/agucam.sv ${BASE}/cams/miss_queue.sv \
${BASE}/lfsr.sv ${BASE}/struct.sv ${BASE}/operations.sv ${BASE}/bitselect.sv \
${BASE}/cams/msicam.sv ${BASE}/popcnt.sv ${BASE}/cache/dtlb.sv ${BASE}/lru8.sv \
${BASE}/cams/sttlbmiss.sv ${BASE}/cams/l1dmisscam.sv ${BASE}/spectre/agusec.sv \
${BASE}/shifter.sv ${BASE}/pager/pager.sv
	verilator -cc --language 1800-2005 --top-module agu_block -I${BASE} \
-I${BASE}/backend --exe agu.cpp -o agu_test --assert -CFLAGS -g -CFLAGS -O1 --threads 4 adder.sv \
agu.sv agu_r.sv agu_w.sv fun_agu.sv rs_block.sv cams/agucam.sv \
cams/miss_queue.sv lfsr.sv bitselect.sv cams/msicam.sv pager/pager.sv \
popcnt.sv cache/dtlb.sv lru8.sv cams/sttlbmiss.sv cams/l1dmisscam.sv \
spectre/agusec.sv shifter.sv


