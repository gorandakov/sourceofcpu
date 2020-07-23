// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design internal header
// See Vagu_block.h for the primary calling header

#ifndef _Vagu_block_agu_H_
#define _Vagu_block_agu_H_

#include "verilated_heavy.h"
#include "verilated_threads.h"

class Vagu_block__Syms;
class Vagu_block_dtlb;

//----------

VL_MODULE(Vagu_block_agu) {
  public:
    // CELLS
    Vagu_block_dtlb* __PVT__tlb_mod;
    
    // PORTS
    // Begin mtask footprint all: 1 24 
    VL_OUT8(conflict,0,0);
    // Begin mtask footprint all: 9 24 
    VL_OUT8(faultCode,7,0);
    // Begin mtask footprint all: 
    VL_IN64(cmplxAddr,63,0);
    VL_IN64(mOp_addrEven,43,8);
    VL_IN64(mOp_addrOdd,43,8);
    VL_OUT64(mOp_addrMain,43,0);
    VL_IN64(writeTlb_IP,50,0);
    VL_IN64(writeTlb_data0,40,0);
    VL_IN64(writeTlb_data1,40,0);
    VL_IN64(writeTlb_data2,40,0);
    VL_IN64(csrss_data,63,0);
    VL_OUT64(mOp_addrEven__out,43,8);
    VL_OUT64(mOp_addrEven__en,43,8);
    VL_OUT64(mOp_addrOdd__out,43,8);
    VL_OUT64(mOp_addrOdd__en,43,8);
    VL_IN(other0_banks,31,0);
    VL_IN(other1_banks,31,0);
    VL_IN(otherR_banks,31,0);
    VL_OUT(mOp_noBanks,31,0);
    VL_IN16(op,12,0);
    VL_IN16(regno,8,0);
    VL_IN16(LSQ_no,8,0);
    VL_IN16(II_no,9,0);
    VL_OUT16(faultNo,8,0);
    VL_OUT16(mOp_register,8,0);
    VL_OUT16(mOp_LSQ,8,0);
    VL_OUT16(mOp_II,9,0);
    VL_IN16(csrss_no,15,0);
    VL_IN8(rst,0,0);
    VL_IN8(except,0,0);
    VL_IN8(except_gate,0,0);
    VL_IN8(except_in_vm,0,0);
    VL_IN8(except_in_km,0,0);
    VL_IN8(read_clkEn,0,0);
    VL_OUT8(__PVT__doStall,0,0);
    VL_IN8(bus_hold,0,0);
    VL_IN8(shiftSize,3,0);
    VL_IN8(WQ_no,7,0);
    VL_IN8(thread,0,0);
    VL_IN8(lsflag,0,0);
    VL_IN8(cin_secq,0,0);
    VL_IN8(ptrdiff,0,0);
    VL_IN8(other_flip,0,0);
    VL_OUT8(tlbMiss,0,0);
    VL_OUT8(pageFault,0,0);
    VL_OUT8(mOp_type,1,0);
    VL_OUT8(mOp_WQ,7,0);
    VL_OUT8(mOp_sz,4,0);
    VL_OUT8(__PVT__mOp_st,0,0);
    VL_OUT8(mOp_en,0,0);
    VL_OUT8(mOp_secq,0,0);
    VL_OUT8(mOp_invtlb,0,0);
    VL_OUT8(mOp_rsEn,0,0);
    VL_OUT8(__PVT__mOp_thread,0,0);
    VL_OUT8(mOp_lsflag,0,0);
    VL_OUT8(mOp_bank0,4,0);
    VL_OUT8(mOp_odd,0,0);
    VL_OUT8(mOp_addr_low,1,0);
    VL_IN8(mOp_split,0,0);
    VL_IN8(writeTlb_wen,0,0);
    VL_IN8(writeTlb_force_way,2,0);
    VL_IN8(writeTlb_force_way_en,0,0);
    VL_IN8(csrss_en,0,0);
    VL_IN8(csrss_thr,0,0);
    VL_OUT8(mOp_split__out,0,0);
    VL_OUT8(mOp_split__en,0,0);
    VL_IN8(clk,0,0);
    // Begin mtask footprint all: 9 36 
    VL_OUT(mOp_banks,31,0);
    // Begin mtask footprint all: 29 36 
    VL_OUT(mOp_rsBanks,31,0);
    
    // LOCAL SIGNALS
    // Begin mtask footprint all: 1 2 3 5 9 14 18 19 
    VL_SIG64(__PVT__addrTlb,51,0);
    // Begin mtask footprint all: 1 3 5 18 
    VL_SIG(__PVT__sproc,23,0);
    // Begin mtask footprint all: 1 3 5 
    VL_SIG(__PVT__proc,23,0);
    // Begin mtask footprint all: 1 3 
    VL_SIG(__PVT__pproc,23,0);
    VL_SIG(__PVT__vproc,23,0);
    // Begin mtask footprint all: 1 
    VL_SIG8(__PVT__mOp_type_reg,1,0);
    // Begin mtask footprint all: 1 24 
    VL_SIG8(__PVT__bus_hold_reg,0,0);
    // Begin mtask footprint all: 1 7 24 
    VL_SIG8(__PVT__except_reg,0,0);
    // Begin mtask footprint all: 1 9 24 
    VL_SIG8(__PVT__bus_hold_reg2,0,0);
    VL_SIG8(__PVT__lsflag_reg,0,0);
    VL_SIG8(__PVT__fault_cann_reg,0,0);
    // Begin mtask footprint all: 9 16 24 
    VL_SIG16(__PVT__LSQ_no_reg,8,0);
    VL_SIG16(__PVT__II_no_reg,9,0);
    VL_SIG8(__PVT__WQ_no_reg,7,0);
    // Begin mtask footprint all: 16 24 38 
    VL_SIG16(__PVT__regno_reg,8,0);
    // Begin mtask footprint all: 3 4 9 24 
    VL_SIG16(__PVT__op_reg,12,0);
    // Begin mtask footprint all: 1 2 9 24 
    VL_SIG8(__PVT__read_clkEn_reg2,0,0);
    // Begin mtask footprint all: 2 9 24 
    VL_SIG8(__PVT__pageFault_t_reg,1,0);
    // Begin mtask footprint all: 1 2 3 7 9 24 
    VL_SIG8(__PVT__cout_secq,0,0);
    // Begin mtask footprint all: 1 2 
    VL_SIG(__PVT__bit_confl_reg,31,0);
    // Begin mtask footprint all: 2 36 
    VL_SIG(__PVT__bit_confl,31,0);
    // Begin mtask footprint all: 6 29 36 
    VL_SIG(__PVT__banks0,31,0);
    // Begin mtask footprint all: 1 2 3 19 29 36 
    VL_SIG8(__PVT__read_clkEn_reg,0,0);
    // Begin mtask footprint all: 1 2 29 
    VL_SIG8(__PVT__rcn_mask,1,0);
    // Begin mtask footprint all: 2 8 29 38 
    VL_SIG16(__PVT__addrNext,13,0);
    // Begin mtask footprint all: 8 26 
    VL_SIG16(__PVT__nextCAddr_mod__DOT__P1,13,0);
    VL_SIG16(__PVT__nextCAddr_mod__DOT__G1,13,0);
    VL_SIG16(__PVT__nextCAddr_mod__DOT__nP2,13,0);
    VL_SIG16(__PVT__nextCAddr_mod__DOT__nG2,13,0);
    VL_SIG16(__PVT__nextCAddr_mod__DOT__P3,13,0);
    VL_SIG16(__PVT__nextCAddr_mod__DOT__G3,13,0);
    VL_SIG16(__PVT__nextCAddr_mod__DOT__nG4,13,0);
    VL_SIG16(__PVT__nextCAddr_mod__DOT__nC1,13,0);
    // Begin mtask footprint all: 7 8 
    VL_SIG16(__PVT__rng_mod__DOT__sh_mod__DOT__bits_med,15,0);
    VL_SIG8(__PVT__rng_mod__DOT__bits,7,0);
    VL_SIG8(__PVT__rng_mod__DOT__cmpLow_mod__DOT__nP0,7,0);
    VL_SIG8(__PVT__rng_mod__DOT__cmpLow_mod__DOT__nG0,7,0);
    VL_SIG8(__PVT__rng_mod__DOT__cmpLow_mod__DOT__P1,7,0);
    VL_SIG8(__PVT__rng_mod__DOT__cmpLow_mod__DOT__G1,7,0);
    VL_SIG8(__PVT__rng_mod__DOT__cmpLow_mod__DOT__nP2,7,0);
    VL_SIG8(__PVT__rng_mod__DOT__cmpLow_mod__DOT__nG2,7,0);
    VL_SIG8(__PVT__rng_mod__DOT__cmpLow_mod__DOT__P3,7,0);
    VL_SIG8(__PVT__rng_mod__DOT__cmpLow_mod__DOT__G3,7,0);
    VL_SIG8(__PVT__rng_mod__DOT__cmpHio_mod__DOT__nP0,7,0);
    VL_SIG8(__PVT__rng_mod__DOT__cmpHio_mod__DOT__nG0,7,0);
    VL_SIG8(__PVT__rng_mod__DOT__cmpHio_mod__DOT__P1,7,0);
    VL_SIG8(__PVT__rng_mod__DOT__cmpHio_mod__DOT__G1,7,0);
    VL_SIG8(__PVT__rng_mod__DOT__cmpHio_mod__DOT__nP2,7,0);
    VL_SIG8(__PVT__rng_mod__DOT__cmpHio_mod__DOT__nG2,7,0);
    VL_SIG8(__PVT__rng_mod__DOT__cmpHio_mod__DOT__P3,7,0);
    VL_SIG8(__PVT__rng_mod__DOT__cmpHio_mod__DOT__G3,7,0);
    // Begin mtask footprint all: 7 8 9 
    VL_SIG8(__PVT__rng_mod__DOT__cmpLow_mod__DOT__nC,7,0);
    VL_SIG8(__PVT__rng_mod__DOT__cmpHio_mod__DOT__nC,7,0);
    // Begin mtask footprint all: 2 9 29 
    VL_SIG8(__PVT__fault_tlb,1,0);
    // Begin mtask footprint all: 2 8 9 16 29 
    VL_SIG64(__PVT__mflags,63,0);
    // Begin mtask footprint all: 2 8 16 
    VL_SIG8(__PVT__split,0,0);
    // Begin mtask footprint all: 3 6 8 16 
    VL_SIG8(__PVT__opsize,2,0);
    
    // LOCAL VARIABLES
    // Begin mtask footprint all: 8 26 29 
    VL_SIG16(addrNext__out23,13,0);
    // Begin mtask footprint all: 8 26 
    VL_SIG16(nextCAddr_mod__DOT__out__out__out0,13,0);
    VL_SIG16(nextCAddr_mod__DOT__out__out__out1,13,0);
    VL_SIG16(nextCAddr_mod__DOT__out__out__out2,13,0);
    VL_SIG16(nextCAddr_mod__DOT__out__out__out3,13,0);
    VL_SIG16(nextCAddr_mod__DOT__out__out__out4,13,0);
    VL_SIG16(nextCAddr_mod__DOT__out__out__out5,13,0);
    VL_SIG16(nextCAddr_mod__DOT__out__out__out6,13,0);
    VL_SIG16(nextCAddr_mod__DOT__out__out__out7,13,0);
    VL_SIG16(nextCAddr_mod__DOT__out__out__out8,13,0);
    VL_SIG16(nextCAddr_mod__DOT__out__out__out9,13,0);
    VL_SIG16(nextCAddr_mod__DOT__out__out__out10,13,0);
    VL_SIG16(nextCAddr_mod__DOT__out__out__out11,13,0);
    VL_SIG16(nextCAddr_mod__DOT__out__out__out12,13,0);
    VL_SIG16(nextCAddr_mod__DOT__out__out__out13,13,0);
    VL_SIG16(nextCAddr_mod__DOT__out__out__out14,13,0);
    VL_SIG16(nextCAddr_mod__DOT__out__out__out15,13,0);
    VL_SIG16(nextCAddr_mod__DOT__out__out__out16,13,0);
    VL_SIG16(nextCAddr_mod__DOT__out__out__out17,13,0);
    VL_SIG16(nextCAddr_mod__DOT__out__out__out18,13,0);
    VL_SIG16(nextCAddr_mod__DOT__out__out__out19,13,0);
    VL_SIG16(nextCAddr_mod__DOT__out__out__out20,13,0);
    VL_SIG16(nextCAddr_mod__DOT__out__out__out21,13,0);
    VL_SIG16(nextCAddr_mod__DOT__out__out__out22,13,0);
    VL_SIG16(nextCAddr_mod__DOT__out__out__out23,13,0);
    VL_SIG16(nextCAddr_mod__DOT__out__out__out24,13,0);
    VL_SIG16(nextCAddr_mod__DOT__out__out__out25,13,0);
    VL_SIG16(nextCAddr_mod__DOT__out__out__out26,13,0);
    VL_SIG16(nextCAddr_mod__DOT__out__out__out27,13,0);
    // Begin mtask footprint all: 7 8 
    VL_SIG16(rng_mod__DOT__sh_mod__DOT__bits_med__en,15,0);
    VL_SIG8(rng_mod__DOT__sh_mod__DOT__bits_out__out__en0,7,0);
    VL_SIG8(rng_mod__DOT__sh_mod__DOT__bits_out__out__en1,7,0);
    VL_SIG8(rng_mod__DOT__sh_mod__DOT__bits_out__out__en2,7,0);
    VL_SIG8(rng_mod__DOT__sh_mod__DOT__bits_out__out__en3,7,0);
    VL_SIG8(rng_mod__DOT__sh_mod__DOT__bits_out__out__en4,7,0);
    VL_SIG8(rng_mod__DOT__sh_mod__DOT__bits_out__out__en5,7,0);
    VL_SIG8(rng_mod__DOT__sh_mod__DOT__bits_out__out__en6,7,0);
    VL_SIG8(rng_mod__DOT__sh_mod__DOT__bits_out__out__en7,7,0);
    // Begin mtask footprint all: 8 16 
    VL_SIG8(mOp_split__out__en15,0,0);
    // Begin mtask footprint all: 8 16 38 
    VL_SIG64(mOp_addrEven__out__en3,35,0);
    VL_SIG64(mOp_addrOdd__out__en8,35,0);
    // Begin mtask footprint all: 8 16 29 
    VL_SIG16(__pinNumber3__en0,13,0);
    // Begin mtask footprint all: 8 29 38 
    VL_SIG64(mOp_addrEven__out__out3,35,0);
    VL_SIG64(mOp_addrEven__out__en5,35,0);
    VL_SIG64(mOp_addrEven__out__en6,35,0);
    VL_SIG64(mOp_addrOdd__out__out8,35,0);
    VL_SIG64(mOp_addrOdd__out__en9,35,0);
    VL_SIG64(mOp_addrOdd__out__en10,35,0);
    // Begin mtask footprint all: 29 38 
    VL_SIG64(mOp_addrEven__out__out5,35,0);
    VL_SIG64(mOp_addrEven__out__out6,35,0);
    VL_SIG64(mOp_addrOdd__out__out9,35,0);
    VL_SIG64(mOp_addrOdd__out__out10,35,0);
    // Begin mtask footprint all: 24 38 
    VL_SIG64(mOp_addrEven__out__out4,35,0);
    VL_SIG64(mOp_addrOdd__out__out7,35,0);
    
    // INTERNAL VARIABLES
  private:
    Vagu_block__Syms* __VlSymsp;  // Symbol table
  public:
    
    // PARAMETERS
    
    // CONSTRUCTORS
  private:
    VL_UNCOPYABLE(Vagu_block_agu);  ///< Copying not allowed
  public:
    Vagu_block_agu(const char* name = "TOP");
    ~Vagu_block_agu();
    
    // API METHODS
    
    // INTERNAL METHODS
    void __Vconfigure(Vagu_block__Syms* symsp, bool first);
    void _combo__TOP__agu_block__DOT__agu0__91(Vagu_block__Syms* __restrict vlSymsp);
  private:
    void _ctor_var_reset() VL_ATTR_COLD;
  public:
    void _sequent__TOP__agu_block__DOT__agu0__89(Vagu_block__Syms* __restrict vlSymsp);
    void _sequent__TOP__agu_block__DOT__agu0__90(Vagu_block__Syms* __restrict vlSymsp);
    void _settle__TOP__agu_block__DOT__agu0__1(Vagu_block__Syms* __restrict vlSymsp) VL_ATTR_COLD;
    void _settle__TOP__agu_block__DOT__agu0__11(Vagu_block__Syms* __restrict vlSymsp) VL_ATTR_COLD;
    void _settle__TOP__agu_block__DOT__agu0__13(Vagu_block__Syms* __restrict vlSymsp) VL_ATTR_COLD;
    void _settle__TOP__agu_block__DOT__agu0__15(Vagu_block__Syms* __restrict vlSymsp) VL_ATTR_COLD;
    void _settle__TOP__agu_block__DOT__agu0__17(Vagu_block__Syms* __restrict vlSymsp) VL_ATTR_COLD;
    void _settle__TOP__agu_block__DOT__agu0__19(Vagu_block__Syms* __restrict vlSymsp) VL_ATTR_COLD;
    void _settle__TOP__agu_block__DOT__agu0__21(Vagu_block__Syms* __restrict vlSymsp) VL_ATTR_COLD;
    void _settle__TOP__agu_block__DOT__agu0__23(Vagu_block__Syms* __restrict vlSymsp) VL_ATTR_COLD;
    void _settle__TOP__agu_block__DOT__agu0__25(Vagu_block__Syms* __restrict vlSymsp) VL_ATTR_COLD;
    void _settle__TOP__agu_block__DOT__agu0__27(Vagu_block__Syms* __restrict vlSymsp) VL_ATTR_COLD;
    void _settle__TOP__agu_block__DOT__agu0__3(Vagu_block__Syms* __restrict vlSymsp) VL_ATTR_COLD;
    void _settle__TOP__agu_block__DOT__agu0__30(Vagu_block__Syms* __restrict vlSymsp) VL_ATTR_COLD;
    void _settle__TOP__agu_block__DOT__agu0__31(Vagu_block__Syms* __restrict vlSymsp) VL_ATTR_COLD;
    void _settle__TOP__agu_block__DOT__agu0__33(Vagu_block__Syms* __restrict vlSymsp) VL_ATTR_COLD;
    void _settle__TOP__agu_block__DOT__agu0__35(Vagu_block__Syms* __restrict vlSymsp) VL_ATTR_COLD;
    void _settle__TOP__agu_block__DOT__agu0__37(Vagu_block__Syms* __restrict vlSymsp) VL_ATTR_COLD;
    void _settle__TOP__agu_block__DOT__agu0__39(Vagu_block__Syms* __restrict vlSymsp) VL_ATTR_COLD;
    void _settle__TOP__agu_block__DOT__agu0__41(Vagu_block__Syms* __restrict vlSymsp) VL_ATTR_COLD;
    void _settle__TOP__agu_block__DOT__agu0__43(Vagu_block__Syms* __restrict vlSymsp) VL_ATTR_COLD;
    void _settle__TOP__agu_block__DOT__agu0__45(Vagu_block__Syms* __restrict vlSymsp) VL_ATTR_COLD;
    void _settle__TOP__agu_block__DOT__agu0__47(Vagu_block__Syms* __restrict vlSymsp) VL_ATTR_COLD;
    void _settle__TOP__agu_block__DOT__agu0__49(Vagu_block__Syms* __restrict vlSymsp) VL_ATTR_COLD;
    void _settle__TOP__agu_block__DOT__agu0__5(Vagu_block__Syms* __restrict vlSymsp) VL_ATTR_COLD;
    void _settle__TOP__agu_block__DOT__agu0__51(Vagu_block__Syms* __restrict vlSymsp) VL_ATTR_COLD;
    void _settle__TOP__agu_block__DOT__agu0__53(Vagu_block__Syms* __restrict vlSymsp) VL_ATTR_COLD;
    void _settle__TOP__agu_block__DOT__agu0__55(Vagu_block__Syms* __restrict vlSymsp) VL_ATTR_COLD;
    void _settle__TOP__agu_block__DOT__agu0__57(Vagu_block__Syms* __restrict vlSymsp) VL_ATTR_COLD;
    void _settle__TOP__agu_block__DOT__agu0__59(Vagu_block__Syms* __restrict vlSymsp) VL_ATTR_COLD;
    void _settle__TOP__agu_block__DOT__agu0__61(Vagu_block__Syms* __restrict vlSymsp) VL_ATTR_COLD;
    void _settle__TOP__agu_block__DOT__agu0__63(Vagu_block__Syms* __restrict vlSymsp) VL_ATTR_COLD;
    void _settle__TOP__agu_block__DOT__agu0__65(Vagu_block__Syms* __restrict vlSymsp) VL_ATTR_COLD;
    void _settle__TOP__agu_block__DOT__agu0__67(Vagu_block__Syms* __restrict vlSymsp) VL_ATTR_COLD;
    void _settle__TOP__agu_block__DOT__agu0__69(Vagu_block__Syms* __restrict vlSymsp) VL_ATTR_COLD;
    void _settle__TOP__agu_block__DOT__agu0__7(Vagu_block__Syms* __restrict vlSymsp) VL_ATTR_COLD;
    void _settle__TOP__agu_block__DOT__agu0__71(Vagu_block__Syms* __restrict vlSymsp) VL_ATTR_COLD;
    void _settle__TOP__agu_block__DOT__agu0__73(Vagu_block__Syms* __restrict vlSymsp) VL_ATTR_COLD;
    void _settle__TOP__agu_block__DOT__agu0__75(Vagu_block__Syms* __restrict vlSymsp) VL_ATTR_COLD;
    void _settle__TOP__agu_block__DOT__agu0__77(Vagu_block__Syms* __restrict vlSymsp) VL_ATTR_COLD;
    void _settle__TOP__agu_block__DOT__agu0__79(Vagu_block__Syms* __restrict vlSymsp) VL_ATTR_COLD;
    void _settle__TOP__agu_block__DOT__agu0__81(Vagu_block__Syms* __restrict vlSymsp) VL_ATTR_COLD;
    void _settle__TOP__agu_block__DOT__agu0__83(Vagu_block__Syms* __restrict vlSymsp) VL_ATTR_COLD;
    void _settle__TOP__agu_block__DOT__agu0__85(Vagu_block__Syms* __restrict vlSymsp) VL_ATTR_COLD;
    void _settle__TOP__agu_block__DOT__agu0__87(Vagu_block__Syms* __restrict vlSymsp) VL_ATTR_COLD;
    void _settle__TOP__agu_block__DOT__agu0__9(Vagu_block__Syms* __restrict vlSymsp) VL_ATTR_COLD;
    void _settle__TOP__agu_block__DOT__agu2__10(Vagu_block__Syms* __restrict vlSymsp) VL_ATTR_COLD;
    void _settle__TOP__agu_block__DOT__agu2__12(Vagu_block__Syms* __restrict vlSymsp) VL_ATTR_COLD;
    void _settle__TOP__agu_block__DOT__agu2__14(Vagu_block__Syms* __restrict vlSymsp) VL_ATTR_COLD;
    void _settle__TOP__agu_block__DOT__agu2__18(Vagu_block__Syms* __restrict vlSymsp) VL_ATTR_COLD;
    void _settle__TOP__agu_block__DOT__agu2__2(Vagu_block__Syms* __restrict vlSymsp) VL_ATTR_COLD;
    void _settle__TOP__agu_block__DOT__agu2__20(Vagu_block__Syms* __restrict vlSymsp) VL_ATTR_COLD;
    void _settle__TOP__agu_block__DOT__agu2__22(Vagu_block__Syms* __restrict vlSymsp) VL_ATTR_COLD;
    void _settle__TOP__agu_block__DOT__agu2__24(Vagu_block__Syms* __restrict vlSymsp) VL_ATTR_COLD;
    void _settle__TOP__agu_block__DOT__agu2__28(Vagu_block__Syms* __restrict vlSymsp) VL_ATTR_COLD;
    void _settle__TOP__agu_block__DOT__agu2__34(Vagu_block__Syms* __restrict vlSymsp) VL_ATTR_COLD;
    void _settle__TOP__agu_block__DOT__agu2__38(Vagu_block__Syms* __restrict vlSymsp) VL_ATTR_COLD;
    void _settle__TOP__agu_block__DOT__agu2__44(Vagu_block__Syms* __restrict vlSymsp) VL_ATTR_COLD;
    void _settle__TOP__agu_block__DOT__agu2__46(Vagu_block__Syms* __restrict vlSymsp) VL_ATTR_COLD;
    void _settle__TOP__agu_block__DOT__agu2__54(Vagu_block__Syms* __restrict vlSymsp) VL_ATTR_COLD;
    void _settle__TOP__agu_block__DOT__agu2__6(Vagu_block__Syms* __restrict vlSymsp) VL_ATTR_COLD;
    void _settle__TOP__agu_block__DOT__agu2__64(Vagu_block__Syms* __restrict vlSymsp) VL_ATTR_COLD;
    void _settle__TOP__agu_block__DOT__agu2__72(Vagu_block__Syms* __restrict vlSymsp) VL_ATTR_COLD;
    void _settle__TOP__agu_block__DOT__agu2__8(Vagu_block__Syms* __restrict vlSymsp) VL_ATTR_COLD;
    void _settle__TOP__agu_block__DOT__agu2__80(Vagu_block__Syms* __restrict vlSymsp) VL_ATTR_COLD;
    void _settle__TOP__agu_block__DOT__agu2__82(Vagu_block__Syms* __restrict vlSymsp) VL_ATTR_COLD;
    void _settle__TOP__agu_block__DOT__agu2__84(Vagu_block__Syms* __restrict vlSymsp) VL_ATTR_COLD;
    void _settle__TOP__agu_block__DOT__agu2__86(Vagu_block__Syms* __restrict vlSymsp) VL_ATTR_COLD;
} VL_ATTR_ALIGNED(128);

#endif // guard
