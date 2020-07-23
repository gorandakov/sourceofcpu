BASE=../../rtl

obj_dir/fpu_try: obj_dir/Vfun_fpu_add.cpp fpu.cpp
	cd obj_dir && make -f Vfun_fpu_add.mk

obj_dir/Vfun_fpu_add.cpp: ${BASE}/backend/fun_add.sv ${BASE}/adder.sv \
${BASE}/math/fpuaddd.sv ${BASE}/math/compress.sv 
	verilator -cc --language 1800-2005 --top-module fun_fpu_add -I${BASE} \
-I${BASE}/backend --assert -CFLAGS -g --exe fpu.cpp -o fpu_try \
-Wno-CASEINCOMPLETE -O3 -threads 6  fun_add.sv adder.sv math/fpuaddd.sv \
math/compress.sv 



