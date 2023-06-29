Heptane CPU.
See copying.txt for derrivative works.
Note there are some spurious extra files which aren't needed but i havent deleted them.
L1 caches in rtl/cache
L2 cache in rtl/l2cache
cams and other similar things int rtl/cams (but not all cams are there).
load/store cams in rtl/lsq
reservation station, main backend, regfiles in rtl/backend
control unit in rtl/cntrl
frontend+decoder in rtl/frontend
NOTE: Architectrual changes pending. The ISA on the website is out of date.
The isa is no longer vliw based its risc like since the instructions can cross bundles of 32 bytes and pages.


