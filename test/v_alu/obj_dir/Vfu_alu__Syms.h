// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Symbol table internal header
//
// Internal details; most calling programs do not need this header,
// unless using verilator public meta comments.

#ifndef _VFU_ALU__SYMS_H_
#define _VFU_ALU__SYMS_H_  // guard

#include "verilated.h"

// INCLUDE MODULE CLASSES
#include "Vfu_alu.h"
#include "Vfu_alu_alu_shift.h"
#include "Vfu_alu_adder__W10.h"
#include "Vfu_alu_addsub_alu.h"

// SYMS CLASS
class Vfu_alu__Syms : public VerilatedSyms {
  public:
    
    // LOCAL STATE
    const char* __Vm_namep;
    bool __Vm_didInit;
    
    // SUBCELL STATE
    Vfu_alu*                       TOPp;
    Vfu_alu_addsub_alu             TOP__fu_alu__DOT__alu0__DOT__mainAdder_mod;
    Vfu_alu_addsub_alu             TOP__fu_alu__DOT__alu1__DOT__mainAdder_mod;
    Vfu_alu_addsub_alu             TOP__fu_alu__DOT__alu2__DOT__mainAdder_mod;
    Vfu_alu_addsub_alu             TOP__fu_alu__DOT__alu3__DOT__mainAdder_mod;
    Vfu_alu_addsub_alu             TOP__fu_alu__DOT__alu4__DOT__mainAdder_mod;
    Vfu_alu_addsub_alu             TOP__fu_alu__DOT__alu5__DOT__mainAdder_mod;
    Vfu_alu_adder__W10             TOP__fu_alu__DOT__g2fp_mod__DOT__genblk1__BRA__0__KET____DOT__add_mod;
    Vfu_alu_adder__W10             TOP__fu_alu__DOT__g2fp_mod__DOT__genblk1__BRA__1__KET____DOT__add_mod;
    Vfu_alu_adder__W10             TOP__fu_alu__DOT__g2fp_mod__DOT__genblk1__BRA__2__KET____DOT__add_mod;
    Vfu_alu_adder__W10             TOP__fu_alu__DOT__g2fp_mod__DOT__genblk1__BRA__3__KET____DOT__add_mod;
    Vfu_alu_adder__W10             TOP__fu_alu__DOT__g2fp_mod__DOT__genblk1__BRA__4__KET____DOT__add_mod;
    Vfu_alu_adder__W10             TOP__fu_alu__DOT__g2fp_mod__DOT__genblk1__BRA__5__KET____DOT__add_mod;
    Vfu_alu_adder__W10             TOP__fu_alu__DOT__g2fp_mod__DOT__genblk1__BRA__6__KET____DOT__add_mod;
    Vfu_alu_adder__W10             TOP__fu_alu__DOT__g2fp_mod__DOT__genblk1__BRA__7__KET____DOT__add_mod;
    Vfu_alu_alu_shift              TOP__fu_alu__DOT__sh2_alu;
    Vfu_alu_alu_shift              TOP__fu_alu__DOT__sh4_alu;
    Vfu_alu_alu_shift              TOP__fu_alu__DOT__sh6_alu;
    
    // CREATORS
    Vfu_alu__Syms(Vfu_alu* topp, const char* namep);
    ~Vfu_alu__Syms() {}
    
    // METHODS
    inline const char* name() { return __Vm_namep; }
    
} VL_ATTR_ALIGNED(VL_CACHE_LINE_BYTES);

#endif  // guard
