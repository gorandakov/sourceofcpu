BASE=../../rtl

obj_dir/fpu_run: obj_dir/Vfun_fpu.cpp fpu.cpp
	cd obj_dir && make -f Vfun_fpu.mk

obj_dir/Vfun_fpu.cpp: ${BASE}/backend/fun_fpu.sv ${BASE}/adder.sv \
${BASE}/math/fpuaddd.sv ${BASE}/math/fpuadds.sv ${BASE}/math/compress.sv \
${BASE}/math/compress_24.sv ${BASE}/math/fpucycladdd.sv \
${BASE}/math/fpumuls.sv
	verilator -cc --language 1800-2005 --top-module fun_fpu -I${BASE} \
-I${BASE}/backend --assert -CFLAGS -g --exe fpu.cpp -o fpu_run \
-Wno-CASEINCOMPLETE -O3 -threads 6  \
fun_fpu.sv adder.sv math/fpuaddd.sv math/fpuadds.sv math/compress.sv \
math/compress_24.sv math/fpucycladdd.sv math/fpumuls.sv



