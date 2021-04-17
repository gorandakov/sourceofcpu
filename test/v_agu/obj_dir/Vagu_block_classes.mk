# Verilated -*- Makefile -*-
# DESCRIPTION: Verilator output: Make include file with class lists
#
# This file lists generated Verilated files, for including in higher level makefiles.
# See Vagu_block.mk for the caller.

### Switches...
# Coverage output mode?  0/1 (from --coverage)
VM_COVERAGE = 0
# Threaded output mode?  0/1/N threads (from --threads)
VM_THREADS = 4
# Tracing output mode?  0/1 (from --trace)
VM_TRACE = 0
# Tracing threaded output mode?  0/1 (from --trace-fst-thread)
VM_TRACE_THREADED = 0

### Object file lists...
# Generated module classes, fast-path, compile with highest optimization
VM_CLASSES_FAST += \
	Vagu_block \
	Vagu_block_add_agu \
	Vagu_block_agu \
	Vagu_block_sagu \
	Vagu_block_dtlb \
	Vagu_block_lru_single0__I7 \
	Vagu_block_lru_single0__I6 \
	Vagu_block_lru_single0__I5 \
	Vagu_block_lru_single0__I4 \
	Vagu_block_lru_single0__I3 \
	Vagu_block_lru_single0__I2 \
	Vagu_block_lru_single0__I1 \
	Vagu_block_lru_single0__I0 \

# Generated module classes, non-fast-path, compile with low/medium optimization
VM_CLASSES_SLOW += \

# Generated support classes, fast-path, compile with highest optimization
VM_SUPPORT_FAST += \

# Generated support classes, non-fast-path, compile with low/medium optimization
VM_SUPPORT_SLOW += \
	Vagu_block__Syms \

# Global classes, need linked once per executable, fast-path, compile with highest optimization
VM_GLOBAL_FAST += \
	verilated \
	verilated_threads \

# Global classes, need linked once per executable, non-fast-path, compile with low/medium optimization
VM_GLOBAL_SLOW += \


# Verilated -*- Makefile -*-
