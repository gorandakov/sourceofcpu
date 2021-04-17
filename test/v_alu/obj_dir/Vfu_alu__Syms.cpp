// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Symbol table implementation internals

#include "Vfu_alu__Syms.h"
#include "Vfu_alu.h"
#include "Vfu_alu_alu_shift.h"
#include "Vfu_alu_adder__W10.h"
#include "Vfu_alu_addsub_alu.h"



// FUNCTIONS
Vfu_alu__Syms::Vfu_alu__Syms(Vfu_alu* topp, const char* namep)
    // Setup locals
    : __Vm_namep(namep)
    , __Vm_didInit(false)
    // Setup submodule names
    , TOP__fu_alu__DOT__alu0__DOT__mainAdder_mod(Verilated::catName(topp->name(), "fu_alu.alu0.mainAdder_mod"))
    , TOP__fu_alu__DOT__alu1__DOT__mainAdder_mod(Verilated::catName(topp->name(), "fu_alu.alu1.mainAdder_mod"))
    , TOP__fu_alu__DOT__alu2__DOT__mainAdder_mod(Verilated::catName(topp->name(), "fu_alu.alu2.mainAdder_mod"))
    , TOP__fu_alu__DOT__alu3__DOT__mainAdder_mod(Verilated::catName(topp->name(), "fu_alu.alu3.mainAdder_mod"))
    , TOP__fu_alu__DOT__alu4__DOT__mainAdder_mod(Verilated::catName(topp->name(), "fu_alu.alu4.mainAdder_mod"))
    , TOP__fu_alu__DOT__alu5__DOT__mainAdder_mod(Verilated::catName(topp->name(), "fu_alu.alu5.mainAdder_mod"))
    , TOP__fu_alu__DOT__g2fp_mod__DOT__genblk1__BRA__0__KET____DOT__add_mod(Verilated::catName(topp->name(), "fu_alu.g2fp_mod.genblk1[0].add_mod"))
    , TOP__fu_alu__DOT__g2fp_mod__DOT__genblk1__BRA__1__KET____DOT__add_mod(Verilated::catName(topp->name(), "fu_alu.g2fp_mod.genblk1[1].add_mod"))
    , TOP__fu_alu__DOT__g2fp_mod__DOT__genblk1__BRA__2__KET____DOT__add_mod(Verilated::catName(topp->name(), "fu_alu.g2fp_mod.genblk1[2].add_mod"))
    , TOP__fu_alu__DOT__g2fp_mod__DOT__genblk1__BRA__3__KET____DOT__add_mod(Verilated::catName(topp->name(), "fu_alu.g2fp_mod.genblk1[3].add_mod"))
    , TOP__fu_alu__DOT__g2fp_mod__DOT__genblk1__BRA__4__KET____DOT__add_mod(Verilated::catName(topp->name(), "fu_alu.g2fp_mod.genblk1[4].add_mod"))
    , TOP__fu_alu__DOT__g2fp_mod__DOT__genblk1__BRA__5__KET____DOT__add_mod(Verilated::catName(topp->name(), "fu_alu.g2fp_mod.genblk1[5].add_mod"))
    , TOP__fu_alu__DOT__g2fp_mod__DOT__genblk1__BRA__6__KET____DOT__add_mod(Verilated::catName(topp->name(), "fu_alu.g2fp_mod.genblk1[6].add_mod"))
    , TOP__fu_alu__DOT__g2fp_mod__DOT__genblk1__BRA__7__KET____DOT__add_mod(Verilated::catName(topp->name(), "fu_alu.g2fp_mod.genblk1[7].add_mod"))
    , TOP__fu_alu__DOT__sh2_alu(Verilated::catName(topp->name(), "fu_alu.sh2_alu"))
    , TOP__fu_alu__DOT__sh4_alu(Verilated::catName(topp->name(), "fu_alu.sh4_alu"))
    , TOP__fu_alu__DOT__sh6_alu(Verilated::catName(topp->name(), "fu_alu.sh6_alu"))
{
    // Pointer to top level
    TOPp = topp;
    // Setup each module's pointers to their submodules
    TOPp->__PVT__fu_alu__DOT__alu0__DOT__mainAdder_mod = &TOP__fu_alu__DOT__alu0__DOT__mainAdder_mod;
    TOPp->__PVT__fu_alu__DOT__alu1__DOT__mainAdder_mod = &TOP__fu_alu__DOT__alu1__DOT__mainAdder_mod;
    TOPp->__PVT__fu_alu__DOT__alu2__DOT__mainAdder_mod = &TOP__fu_alu__DOT__alu2__DOT__mainAdder_mod;
    TOPp->__PVT__fu_alu__DOT__alu3__DOT__mainAdder_mod = &TOP__fu_alu__DOT__alu3__DOT__mainAdder_mod;
    TOPp->__PVT__fu_alu__DOT__alu4__DOT__mainAdder_mod = &TOP__fu_alu__DOT__alu4__DOT__mainAdder_mod;
    TOPp->__PVT__fu_alu__DOT__alu5__DOT__mainAdder_mod = &TOP__fu_alu__DOT__alu5__DOT__mainAdder_mod;
    TOPp->__PVT__fu_alu__DOT__g2fp_mod__DOT__genblk1__BRA__0__KET____DOT__add_mod = &TOP__fu_alu__DOT__g2fp_mod__DOT__genblk1__BRA__0__KET____DOT__add_mod;
    TOPp->__PVT__fu_alu__DOT__g2fp_mod__DOT__genblk1__BRA__1__KET____DOT__add_mod = &TOP__fu_alu__DOT__g2fp_mod__DOT__genblk1__BRA__1__KET____DOT__add_mod;
    TOPp->__PVT__fu_alu__DOT__g2fp_mod__DOT__genblk1__BRA__2__KET____DOT__add_mod = &TOP__fu_alu__DOT__g2fp_mod__DOT__genblk1__BRA__2__KET____DOT__add_mod;
    TOPp->__PVT__fu_alu__DOT__g2fp_mod__DOT__genblk1__BRA__3__KET____DOT__add_mod = &TOP__fu_alu__DOT__g2fp_mod__DOT__genblk1__BRA__3__KET____DOT__add_mod;
    TOPp->__PVT__fu_alu__DOT__g2fp_mod__DOT__genblk1__BRA__4__KET____DOT__add_mod = &TOP__fu_alu__DOT__g2fp_mod__DOT__genblk1__BRA__4__KET____DOT__add_mod;
    TOPp->__PVT__fu_alu__DOT__g2fp_mod__DOT__genblk1__BRA__5__KET____DOT__add_mod = &TOP__fu_alu__DOT__g2fp_mod__DOT__genblk1__BRA__5__KET____DOT__add_mod;
    TOPp->__PVT__fu_alu__DOT__g2fp_mod__DOT__genblk1__BRA__6__KET____DOT__add_mod = &TOP__fu_alu__DOT__g2fp_mod__DOT__genblk1__BRA__6__KET____DOT__add_mod;
    TOPp->__PVT__fu_alu__DOT__g2fp_mod__DOT__genblk1__BRA__7__KET____DOT__add_mod = &TOP__fu_alu__DOT__g2fp_mod__DOT__genblk1__BRA__7__KET____DOT__add_mod;
    TOPp->__PVT__fu_alu__DOT__sh2_alu = &TOP__fu_alu__DOT__sh2_alu;
    TOPp->__PVT__fu_alu__DOT__sh4_alu = &TOP__fu_alu__DOT__sh4_alu;
    TOPp->__PVT__fu_alu__DOT__sh6_alu = &TOP__fu_alu__DOT__sh6_alu;
    // Setup each module's pointer back to symbol table (for public functions)
    TOPp->__Vconfigure(this, true);
    TOP__fu_alu__DOT__alu0__DOT__mainAdder_mod.__Vconfigure(this, true);
    TOP__fu_alu__DOT__alu1__DOT__mainAdder_mod.__Vconfigure(this, false);
    TOP__fu_alu__DOT__alu2__DOT__mainAdder_mod.__Vconfigure(this, false);
    TOP__fu_alu__DOT__alu3__DOT__mainAdder_mod.__Vconfigure(this, false);
    TOP__fu_alu__DOT__alu4__DOT__mainAdder_mod.__Vconfigure(this, false);
    TOP__fu_alu__DOT__alu5__DOT__mainAdder_mod.__Vconfigure(this, false);
    TOP__fu_alu__DOT__g2fp_mod__DOT__genblk1__BRA__0__KET____DOT__add_mod.__Vconfigure(this, true);
    TOP__fu_alu__DOT__g2fp_mod__DOT__genblk1__BRA__1__KET____DOT__add_mod.__Vconfigure(this, false);
    TOP__fu_alu__DOT__g2fp_mod__DOT__genblk1__BRA__2__KET____DOT__add_mod.__Vconfigure(this, false);
    TOP__fu_alu__DOT__g2fp_mod__DOT__genblk1__BRA__3__KET____DOT__add_mod.__Vconfigure(this, false);
    TOP__fu_alu__DOT__g2fp_mod__DOT__genblk1__BRA__4__KET____DOT__add_mod.__Vconfigure(this, false);
    TOP__fu_alu__DOT__g2fp_mod__DOT__genblk1__BRA__5__KET____DOT__add_mod.__Vconfigure(this, false);
    TOP__fu_alu__DOT__g2fp_mod__DOT__genblk1__BRA__6__KET____DOT__add_mod.__Vconfigure(this, false);
    TOP__fu_alu__DOT__g2fp_mod__DOT__genblk1__BRA__7__KET____DOT__add_mod.__Vconfigure(this, false);
    TOP__fu_alu__DOT__sh2_alu.__Vconfigure(this, true);
    TOP__fu_alu__DOT__sh4_alu.__Vconfigure(this, false);
    TOP__fu_alu__DOT__sh6_alu.__Vconfigure(this, false);
}
