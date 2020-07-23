// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design internal header
// See Vfu_alu.h for the primary calling header

#ifndef _Vfu_alu_adder__W10_H_
#define _Vfu_alu_adder__W10_H_

#include "verilated.h"

class Vfu_alu__Syms;

//----------

VL_MODULE(Vfu_alu_adder__W10) {
  public:
    
    // PORTS
    VL_IN8(cin,0,0);
    VL_IN8(en,0,0);
    VL_OUT8(__PVT__cout,0,0);
    VL_OUT8(__PVT__cout8,0,0);
    VL_OUT8(__PVT__cout16,0,0);
    VL_OUT8(__PVT__cout32,0,0);
    VL_IN16(a,15,0);
    VL_IN16(b,15,0);
    VL_IN16(out,15,0);
    VL_OUT16(out__out,15,0);
    VL_OUT16(out__en,15,0);
    
    // LOCAL SIGNALS
    SData/*15:0*/ __PVT__P1;
    SData/*15:0*/ __PVT__G1;
    SData/*15:0*/ __PVT__nP2;
    SData/*15:0*/ __PVT__nG2;
    SData/*15:0*/ __PVT__P3;
    SData/*15:0*/ __PVT__G3;
    SData/*15:0*/ __PVT__nG4;
    SData/*15:0*/ __PVT__nC1;
    
    // LOCAL VARIABLES
    SData/*15:0*/ out__out__out0;
    SData/*15:0*/ out__out__en0;
    SData/*15:0*/ out__out__out1;
    SData/*15:0*/ out__out__en1;
    SData/*15:0*/ out__out__out2;
    SData/*15:0*/ out__out__en2;
    SData/*15:0*/ out__out__out3;
    SData/*15:0*/ out__out__en3;
    SData/*15:0*/ out__out__out4;
    SData/*15:0*/ out__out__en4;
    SData/*15:0*/ out__out__out5;
    SData/*15:0*/ out__out__en5;
    SData/*15:0*/ out__out__out6;
    SData/*15:0*/ out__out__en6;
    SData/*15:0*/ out__out__out7;
    SData/*15:0*/ out__out__en7;
    SData/*15:0*/ out__out__out8;
    SData/*15:0*/ out__out__en8;
    SData/*15:0*/ out__out__out9;
    SData/*15:0*/ out__out__en9;
    SData/*15:0*/ out__out__out10;
    SData/*15:0*/ out__out__en10;
    SData/*15:0*/ out__out__out11;
    SData/*15:0*/ out__out__en11;
    SData/*15:0*/ out__out__out12;
    SData/*15:0*/ out__out__en12;
    SData/*15:0*/ out__out__out13;
    SData/*15:0*/ out__out__en13;
    SData/*15:0*/ out__out__out14;
    SData/*15:0*/ out__out__en14;
    SData/*15:0*/ out__out__out15;
    SData/*15:0*/ out__out__en15;
    SData/*15:0*/ out__out__out16;
    SData/*15:0*/ out__out__en16;
    SData/*15:0*/ out__out__out17;
    SData/*15:0*/ out__out__en17;
    SData/*15:0*/ out__out__out18;
    SData/*15:0*/ out__out__en18;
    SData/*15:0*/ out__out__out19;
    SData/*15:0*/ out__out__en19;
    SData/*15:0*/ out__out__out20;
    SData/*15:0*/ out__out__en20;
    SData/*15:0*/ out__out__out21;
    SData/*15:0*/ out__out__en21;
    SData/*15:0*/ out__out__out22;
    SData/*15:0*/ out__out__en22;
    SData/*15:0*/ out__out__out23;
    SData/*15:0*/ out__out__en23;
    SData/*15:0*/ out__out__out24;
    SData/*15:0*/ out__out__en24;
    SData/*15:0*/ out__out__out25;
    SData/*15:0*/ out__out__en25;
    SData/*15:0*/ out__out__out26;
    SData/*15:0*/ out__out__en26;
    SData/*15:0*/ out__out__out27;
    SData/*15:0*/ out__out__en27;
    SData/*15:0*/ out__out__out28;
    SData/*15:0*/ out__out__en28;
    SData/*15:0*/ out__out__out29;
    SData/*15:0*/ out__out__en29;
    SData/*15:0*/ out__out__out30;
    SData/*15:0*/ out__out__en30;
    SData/*15:0*/ out__out__out31;
    SData/*15:0*/ out__out__en31;
    
    // INTERNAL VARIABLES
  private:
    Vfu_alu__Syms* __VlSymsp;  // Symbol table
  public:
    
    // PARAMETERS
    
    // CONSTRUCTORS
  private:
    VL_UNCOPYABLE(Vfu_alu_adder__W10);  ///< Copying not allowed
  public:
    Vfu_alu_adder__W10(const char* name = "TOP");
    ~Vfu_alu_adder__W10();
    
    // API METHODS
    
    // INTERNAL METHODS
    void __Vconfigure(Vfu_alu__Syms* symsp, bool first);
  private:
    void _ctor_var_reset() VL_ATTR_COLD;
  public:
    void _settle__TOP__fu_alu__DOT__g2fp_mod__DOT__genblk1__BRA__0__KET____DOT__add_mod__1(Vfu_alu__Syms* __restrict vlSymsp);
    void _settle__TOP__fu_alu__DOT__g2fp_mod__DOT__genblk1__BRA__1__KET____DOT__add_mod__2(Vfu_alu__Syms* __restrict vlSymsp);
    void _settle__TOP__fu_alu__DOT__g2fp_mod__DOT__genblk1__BRA__2__KET____DOT__add_mod__3(Vfu_alu__Syms* __restrict vlSymsp);
    void _settle__TOP__fu_alu__DOT__g2fp_mod__DOT__genblk1__BRA__3__KET____DOT__add_mod__4(Vfu_alu__Syms* __restrict vlSymsp);
    void _settle__TOP__fu_alu__DOT__g2fp_mod__DOT__genblk1__BRA__4__KET____DOT__add_mod__5(Vfu_alu__Syms* __restrict vlSymsp);
    void _settle__TOP__fu_alu__DOT__g2fp_mod__DOT__genblk1__BRA__5__KET____DOT__add_mod__6(Vfu_alu__Syms* __restrict vlSymsp);
    void _settle__TOP__fu_alu__DOT__g2fp_mod__DOT__genblk1__BRA__6__KET____DOT__add_mod__7(Vfu_alu__Syms* __restrict vlSymsp);
    void _settle__TOP__fu_alu__DOT__g2fp_mod__DOT__genblk1__BRA__7__KET____DOT__add_mod__8(Vfu_alu__Syms* __restrict vlSymsp);
} VL_ATTR_ALIGNED(128);

#endif // guard
