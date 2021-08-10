// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design internal header
// See Vagu_block.h for the primary calling header

#ifndef _VAGU_BLOCK_AGU_H_
#define _VAGU_BLOCK_AGU_H_  // guard

#include "verilated_heavy.h"
#include "verilated_threads.h"

//==========

class Vagu_block__Syms;
class Vagu_block_dtlb;


//----------

VL_MODULE(Vagu_block_agu) {
  public:
    // CELLS
    Vagu_block_dtlb* __PVT__tlb_mod;
    
    // PORTS
    // Begin mtask footprint all: 25 33 35 
    VL_OUT(mOp_rsBanks,31,0);
    // Begin mtask footprint all: 23 25 35 
    VL_OUT(mOp_banks,31,0);
    // Begin mtask footprint all: 9 22 
    VL_OUT8(pageFault,0,0);
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
    VL_IN(wb_banks,31,0);
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
    VL_IN8(wb_en,0,0);
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
    // Begin mtask footprint all: 4 6 9 
    VL_OUT8(conflict,0,0);
    
    // LOCAL SIGNALS
    // Begin mtask footprint all: 8 25 33 35 
    IData/*31:0*/ __PVT__banks0;
    // Begin mtask footprint all: 4 25 35 
    IData/*31:0*/ __PVT__bit_confl;
    // Begin mtask footprint all: 4 25 
    CData/*1:0*/ __PVT__fault_tlb;
    // Begin mtask footprint all: 4 9 25 
    QData/*63:0*/ __PVT__mflags;
    // Begin mtask footprint all: 4 8 9 25 26 
    SData/*13:0*/ __PVT__addrNext;
    // Begin mtask footprint all: 4 9 
    CData/*1:0*/ __PVT__pageFault_t_reg;
    // Begin mtask footprint all: 4 5 6 
    IData/*23:0*/ __PVT__pproc;
    IData/*23:0*/ __PVT__vproc;
    // Begin mtask footprint all: 4 5 
    IData/*23:0*/ __PVT__proc;
    // Begin mtask footprint all: 4 5 12 
    IData/*23:0*/ __PVT__sproc;
    // Begin mtask footprint all: 4 5 9 12 25 26 
    QData/*51:0*/ __PVT__addrTlb;
    // Begin mtask footprint all: 4 5 12 25 33 35 
    CData/*0:0*/ __PVT__read_clkEn_reg;
    // Begin mtask footprint all: 4 5 33 
    CData/*1:0*/ __PVT__rcn_mask;
    // Begin mtask footprint all: 4 8 
    SData/*13:0*/ __PVT__nextCAddr_mod__DOT__P1;
    SData/*13:0*/ __PVT__nextCAddr_mod__DOT__G1;
    SData/*13:0*/ __PVT__nextCAddr_mod__DOT__nP2;
    SData/*13:0*/ __PVT__nextCAddr_mod__DOT__nG2;
    SData/*13:0*/ __PVT__nextCAddr_mod__DOT__P3;
    SData/*13:0*/ __PVT__nextCAddr_mod__DOT__G3;
    CData/*2:0*/ __PVT__opsize;
    CData/*0:0*/ __PVT__split;
    // Begin mtask footprint all: 4 8 12 26 
    SData/*13:0*/ __PVT__nextCAddr_mod__DOT__nG4;
    SData/*13:0*/ __PVT__nextCAddr_mod__DOT__nC1;
    // Begin mtask footprint all: 3 4 22 23 26 
    SData/*12:0*/ __PVT__op_reg;
    // Begin mtask footprint all: 6 22 23 26 
    SData/*8:0*/ __PVT__regno_reg;
    // Begin mtask footprint all: 6 22 26 
    SData/*8:0*/ __PVT__LSQ_no_reg;
    SData/*9:0*/ __PVT__II_no_reg;
    CData/*7:0*/ __PVT__WQ_no_reg;
    // Begin mtask footprint all: 6 22 25 26 
    CData/*0:0*/ __PVT__lsflag_reg;
    // Begin mtask footprint all: 6 9 
    CData/*0:0*/ __PVT__bus_hold_reg;
    CData/*0:0*/ __PVT__bus_hold_reg2;
    // Begin mtask footprint all: 4 6 9 
    CData/*0:0*/ __PVT__read_clkEn_reg2;
    CData/*0:0*/ __PVT__fault_cann_reg;
    // Begin mtask footprint all: 4 6 
    IData/*31:0*/ __PVT__bit_confl_reg;
    // Begin mtask footprint all: 6 
    CData/*1:0*/ __PVT__mOp_type_reg;
    // Begin mtask footprint all: 4 6 11 22 26 
    CData/*0:0*/ __PVT__cout_secq;
    // Begin mtask footprint all: 11 22 26 
    CData/*7:0*/ __PVT__rng_mod__DOT__cmpLow_mod__DOT__nC;
    CData/*7:0*/ __PVT__rng_mod__DOT__cmpHio_mod__DOT__nC;
    // Begin mtask footprint all: 11 26 
    SData/*15:0*/ __PVT__rng_mod__DOT__sh_mod__DOT__bits_med;
    CData/*7:0*/ __PVT__rng_mod__DOT__bits;
    CData/*7:0*/ __PVT__rng_mod__DOT__cmpLow_mod__DOT__nP0;
    CData/*7:0*/ __PVT__rng_mod__DOT__cmpLow_mod__DOT__nG0;
    CData/*7:0*/ __PVT__rng_mod__DOT__cmpLow_mod__DOT__P1;
    CData/*7:0*/ __PVT__rng_mod__DOT__cmpLow_mod__DOT__G1;
    CData/*7:0*/ __PVT__rng_mod__DOT__cmpLow_mod__DOT__nP2;
    CData/*7:0*/ __PVT__rng_mod__DOT__cmpLow_mod__DOT__nG2;
    CData/*7:0*/ __PVT__rng_mod__DOT__cmpLow_mod__DOT__P3;
    CData/*7:0*/ __PVT__rng_mod__DOT__cmpLow_mod__DOT__G3;
    CData/*7:0*/ __PVT__rng_mod__DOT__cmpHio_mod__DOT__nP0;
    CData/*7:0*/ __PVT__rng_mod__DOT__cmpHio_mod__DOT__nG0;
    CData/*7:0*/ __PVT__rng_mod__DOT__cmpHio_mod__DOT__P1;
    CData/*7:0*/ __PVT__rng_mod__DOT__cmpHio_mod__DOT__G1;
    CData/*7:0*/ __PVT__rng_mod__DOT__cmpHio_mod__DOT__nP2;
    CData/*7:0*/ __PVT__rng_mod__DOT__cmpHio_mod__DOT__nG2;
    CData/*7:0*/ __PVT__rng_mod__DOT__cmpHio_mod__DOT__P3;
    CData/*7:0*/ __PVT__rng_mod__DOT__cmpHio_mod__DOT__G3;
    // Begin mtask footprint all: 5 11 26 
    CData/*0:0*/ __PVT__except_reg;
    
    // LOCAL VARIABLES
    // Begin mtask footprint all: 9 25 
    QData/*35:0*/ mOp_addrEven__out__out4;
    QData/*35:0*/ mOp_addrEven__out__out5;
    QData/*35:0*/ mOp_addrEven__out__out6;
    QData/*35:0*/ mOp_addrOdd__out__out7;
    QData/*35:0*/ mOp_addrOdd__out__out9;
    QData/*35:0*/ mOp_addrOdd__out__out10;
    // Begin mtask footprint all: 8 
    CData/*0:0*/ mOp_split__out__en15;
    // Begin mtask footprint all: 8 26 
    SData/*13:0*/ __pinNumber3__en0;
    SData/*13:0*/ addrNext__out23;
    SData/*13:0*/ nextCAddr_mod__DOT__out__out__out0;
    SData/*13:0*/ nextCAddr_mod__DOT__out__out__out2;
    SData/*13:0*/ nextCAddr_mod__DOT__out__out__out4;
    SData/*13:0*/ nextCAddr_mod__DOT__out__out__out6;
    SData/*13:0*/ nextCAddr_mod__DOT__out__out__out8;
    SData/*13:0*/ nextCAddr_mod__DOT__out__out__out10;
    SData/*13:0*/ nextCAddr_mod__DOT__out__out__out12;
    SData/*13:0*/ nextCAddr_mod__DOT__out__out__out14;
    SData/*13:0*/ nextCAddr_mod__DOT__out__out__out15;
    SData/*13:0*/ nextCAddr_mod__DOT__out__out__out17;
    SData/*13:0*/ nextCAddr_mod__DOT__out__out__out19;
    SData/*13:0*/ nextCAddr_mod__DOT__out__out__out21;
    // Begin mtask footprint all: 8 12 26 
    SData/*13:0*/ nextCAddr_mod__DOT__out__out__out1;
    SData/*13:0*/ nextCAddr_mod__DOT__out__out__out3;
    SData/*13:0*/ nextCAddr_mod__DOT__out__out__out5;
    SData/*13:0*/ nextCAddr_mod__DOT__out__out__out7;
    SData/*13:0*/ nextCAddr_mod__DOT__out__out__out9;
    SData/*13:0*/ nextCAddr_mod__DOT__out__out__out11;
    SData/*13:0*/ nextCAddr_mod__DOT__out__out__out13;
    SData/*13:0*/ nextCAddr_mod__DOT__out__out__out16;
    SData/*13:0*/ nextCAddr_mod__DOT__out__out__out18;
    SData/*13:0*/ nextCAddr_mod__DOT__out__out__out20;
    SData/*13:0*/ nextCAddr_mod__DOT__out__out__out22;
    SData/*13:0*/ nextCAddr_mod__DOT__out__out__out23;
    SData/*13:0*/ nextCAddr_mod__DOT__out__out__out24;
    SData/*13:0*/ nextCAddr_mod__DOT__out__out__out25;
    SData/*13:0*/ nextCAddr_mod__DOT__out__out__out26;
    SData/*13:0*/ nextCAddr_mod__DOT__out__out__out27;
    // Begin mtask footprint all: 8 25 26 
    QData/*35:0*/ mOp_addrEven__out__out3;
    QData/*35:0*/ mOp_addrEven__out__en3;
    QData/*35:0*/ mOp_addrEven__out__en5;
    QData/*35:0*/ mOp_addrEven__out__en6;
    QData/*35:0*/ mOp_addrOdd__out__out8;
    QData/*35:0*/ mOp_addrOdd__out__en8;
    QData/*35:0*/ mOp_addrOdd__out__en9;
    QData/*35:0*/ mOp_addrOdd__out__en10;
    // Begin mtask footprint all: 11 26 
    SData/*15:0*/ rng_mod__DOT__sh_mod__DOT__bits_med__en;
    CData/*7:0*/ rng_mod__DOT__sh_mod__DOT__bits_out__out__en0;
    CData/*7:0*/ rng_mod__DOT__sh_mod__DOT__bits_out__out__en1;
    CData/*7:0*/ rng_mod__DOT__sh_mod__DOT__bits_out__out__en2;
    CData/*7:0*/ rng_mod__DOT__sh_mod__DOT__bits_out__out__en3;
    CData/*7:0*/ rng_mod__DOT__sh_mod__DOT__bits_out__out__en4;
    CData/*7:0*/ rng_mod__DOT__sh_mod__DOT__bits_out__out__en5;
    CData/*7:0*/ rng_mod__DOT__sh_mod__DOT__bits_out__out__en6;
    CData/*7:0*/ rng_mod__DOT__sh_mod__DOT__bits_out__out__en7;
    
    // INTERNAL VARIABLES
  private:
    Vagu_block__Syms* __VlSymsp;  // Symbol table
  public:
    
    // CONSTRUCTORS
  private:
    VL_UNCOPYABLE(Vagu_block_agu);  ///< Copying not allowed
  public:
    Vagu_block_agu(const char* name = "TOP");
    ~Vagu_block_agu();
    
    // INTERNAL METHODS
    void __Vconfigure(Vagu_block__Syms* symsp, bool first);
    void _combo__TOP__agu_block__DOT__agu0__91(Vagu_block__Syms* __restrict vlSymsp);
  private:
    void _ctor_var_reset() VL_ATTR_COLD;
  public:
    void _sequent__TOP__agu_block__DOT__agu0__92(Vagu_block__Syms* __restrict vlSymsp);
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
    void _settle__TOP__agu_block__DOT__agu0__29(Vagu_block__Syms* __restrict vlSymsp) VL_ATTR_COLD;
    void _settle__TOP__agu_block__DOT__agu0__3(Vagu_block__Syms* __restrict vlSymsp) VL_ATTR_COLD;
    void _settle__TOP__agu_block__DOT__agu0__32(Vagu_block__Syms* __restrict vlSymsp) VL_ATTR_COLD;
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
    void _settle__TOP__agu_block__DOT__agu0__89(Vagu_block__Syms* __restrict vlSymsp);
    void _settle__TOP__agu_block__DOT__agu0__9(Vagu_block__Syms* __restrict vlSymsp) VL_ATTR_COLD;
    void _settle__TOP__agu_block__DOT__agu2__10(Vagu_block__Syms* __restrict vlSymsp) VL_ATTR_COLD;
    void _settle__TOP__agu_block__DOT__agu2__12(Vagu_block__Syms* __restrict vlSymsp) VL_ATTR_COLD;
    void _settle__TOP__agu_block__DOT__agu2__14(Vagu_block__Syms* __restrict vlSymsp) VL_ATTR_COLD;
    void _settle__TOP__agu_block__DOT__agu2__16(Vagu_block__Syms* __restrict vlSymsp) VL_ATTR_COLD;
    void _settle__TOP__agu_block__DOT__agu2__2(Vagu_block__Syms* __restrict vlSymsp) VL_ATTR_COLD;
    void _settle__TOP__agu_block__DOT__agu2__20(Vagu_block__Syms* __restrict vlSymsp) VL_ATTR_COLD;
    void _settle__TOP__agu_block__DOT__agu2__22(Vagu_block__Syms* __restrict vlSymsp) VL_ATTR_COLD;
    void _settle__TOP__agu_block__DOT__agu2__24(Vagu_block__Syms* __restrict vlSymsp) VL_ATTR_COLD;
    void _settle__TOP__agu_block__DOT__agu2__26(Vagu_block__Syms* __restrict vlSymsp) VL_ATTR_COLD;
    void _settle__TOP__agu_block__DOT__agu2__30(Vagu_block__Syms* __restrict vlSymsp) VL_ATTR_COLD;
    void _settle__TOP__agu_block__DOT__agu2__36(Vagu_block__Syms* __restrict vlSymsp) VL_ATTR_COLD;
    void _settle__TOP__agu_block__DOT__agu2__4(Vagu_block__Syms* __restrict vlSymsp) VL_ATTR_COLD;
    void _settle__TOP__agu_block__DOT__agu2__40(Vagu_block__Syms* __restrict vlSymsp) VL_ATTR_COLD;
    void _settle__TOP__agu_block__DOT__agu2__46(Vagu_block__Syms* __restrict vlSymsp) VL_ATTR_COLD;
    void _settle__TOP__agu_block__DOT__agu2__48(Vagu_block__Syms* __restrict vlSymsp) VL_ATTR_COLD;
    void _settle__TOP__agu_block__DOT__agu2__56(Vagu_block__Syms* __restrict vlSymsp) VL_ATTR_COLD;
    void _settle__TOP__agu_block__DOT__agu2__66(Vagu_block__Syms* __restrict vlSymsp) VL_ATTR_COLD;
    void _settle__TOP__agu_block__DOT__agu2__74(Vagu_block__Syms* __restrict vlSymsp) VL_ATTR_COLD;
    void _settle__TOP__agu_block__DOT__agu2__76(Vagu_block__Syms* __restrict vlSymsp) VL_ATTR_COLD;
    void _settle__TOP__agu_block__DOT__agu2__8(Vagu_block__Syms* __restrict vlSymsp) VL_ATTR_COLD;
    void _settle__TOP__agu_block__DOT__agu2__82(Vagu_block__Syms* __restrict vlSymsp) VL_ATTR_COLD;
    void _settle__TOP__agu_block__DOT__agu2__84(Vagu_block__Syms* __restrict vlSymsp) VL_ATTR_COLD;
    void _settle__TOP__agu_block__DOT__agu2__86(Vagu_block__Syms* __restrict vlSymsp) VL_ATTR_COLD;
    void _settle__TOP__agu_block__DOT__agu2__88(Vagu_block__Syms* __restrict vlSymsp) VL_ATTR_COLD;
} VL_ATTR_ALIGNED(VL_CACHE_LINE_BYTES);

//----------


#endif  // guard
