// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Vfu_alu.h for the primary calling header

#include "Vfu_alu_adder__W10.h"
#include "Vfu_alu__Syms.h"

//==========

VL_CTOR_IMP(Vfu_alu_adder__W10) {
    // Reset internal values
    // Reset structure values
    _ctor_var_reset();
}

void Vfu_alu_adder__W10::__Vconfigure(Vfu_alu__Syms* vlSymsp, bool first) {
    if (0 && first) {}  // Prevent unused
    this->__VlSymsp = vlSymsp;
}

Vfu_alu_adder__W10::~Vfu_alu_adder__W10() {
}

VL_INLINE_OPT void Vfu_alu_adder__W10::_settle__TOP__fu_alu__DOT__g2fp_mod__DOT__genblk1__BRA__0__KET____DOT__add_mod__1(Vfu_alu__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+          Vfu_alu_adder__W10::_settle__TOP__fu_alu__DOT__g2fp_mod__DOT__genblk1__BRA__0__KET____DOT__add_mod__1\n"); );
    Vfu_alu* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->out__out__out0 = ((0xfffeU & (IData)(this->out__out__out0)) 
                            | (1U & ((~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__0__KET____DOT__add_mod____pinNumber1)) 
                                     & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg))));
    this->out__out__en0 = (1U & ((~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__0__KET____DOT__add_mod____pinNumber1)) 
                                 & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg)));
    this->out__out__en1 = (1U & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__0__KET____DOT__add_mod____pinNumber1) 
                                 & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg)));
    this->out__out__en2 = (2U & ((0x7ffeU ^ (0xfffffffeU 
                                             & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__0__KET____DOT__add_mod____pinNumber1))) 
                                 & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                    << 1U)));
    this->out__out__en3 = (2U & (((IData)(0x7fffU) 
                                  ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__0__KET____DOT__add_mod____pinNumber1)) 
                                 & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                    << 1U)));
    this->out__out__en4 = (4U & ((0x7ffcU ^ (0xfffffffcU 
                                             & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__0__KET____DOT__add_mod____pinNumber1))) 
                                 & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                    << 2U)));
    this->out__out__en5 = (4U & (((IData)(0x7fffU) 
                                  ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__0__KET____DOT__add_mod____pinNumber1)) 
                                 & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                    << 2U)));
    this->out__out__en6 = (8U & ((0x7ff8U ^ (0xfffffff8U 
                                             & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__0__KET____DOT__add_mod____pinNumber1))) 
                                 & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                    << 3U)));
    this->out__out__en7 = (8U & (((IData)(0x7fffU) 
                                  ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__0__KET____DOT__add_mod____pinNumber1)) 
                                 & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                    << 3U)));
    this->out__out__en8 = (0x10U & ((0x7ff0U ^ (0xfffffff0U 
                                                & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__0__KET____DOT__add_mod____pinNumber1))) 
                                    & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                       << 4U)));
    this->out__out__en9 = (0x10U & (((IData)(0x7fffU) 
                                     ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__0__KET____DOT__add_mod____pinNumber1)) 
                                    & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                       << 4U)));
    this->out__out__en10 = (0x20U & ((0x7fe0U ^ (0xffffffe0U 
                                                 & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__0__KET____DOT__add_mod____pinNumber1))) 
                                     & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                        << 5U)));
    this->out__out__en11 = (0x20U & (((IData)(0x7fffU) 
                                      ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__0__KET____DOT__add_mod____pinNumber1)) 
                                     & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                        << 5U)));
    this->out__out__en12 = (0x40U & ((0x7fc0U ^ (0xffffffc0U 
                                                 & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__0__KET____DOT__add_mod____pinNumber1))) 
                                     & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                        << 6U)));
    this->out__out__en13 = (0x40U & (((IData)(0x7fffU) 
                                      ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__0__KET____DOT__add_mod____pinNumber1)) 
                                     & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                        << 6U)));
    this->out__out__en14 = (0x80U & ((0x7f80U ^ (0xffffff80U 
                                                 & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__0__KET____DOT__add_mod____pinNumber1))) 
                                     & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                        << 7U)));
    this->out__out__en15 = (0x80U & (((IData)(0x7fffU) 
                                      ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__0__KET____DOT__add_mod____pinNumber1)) 
                                     & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                        << 7U)));
    this->out__out__en16 = (0x100U & ((0x7f00U ^ (0xffffff00U 
                                                  & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__0__KET____DOT__add_mod____pinNumber1))) 
                                      & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                         << 8U)));
    this->out__out__en17 = (0x100U & (((IData)(0x7fffU) 
                                       ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__0__KET____DOT__add_mod____pinNumber1)) 
                                      & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                         << 8U)));
    this->out__out__en18 = (0x200U & ((0x7e00U ^ (0xfffffe00U 
                                                  & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__0__KET____DOT__add_mod____pinNumber1))) 
                                      & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                         << 9U)));
    this->out__out__en19 = (0x200U & (((IData)(0x7fffU) 
                                       ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__0__KET____DOT__add_mod____pinNumber1)) 
                                      & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                         << 9U)));
    this->out__out__en20 = (0x400U & ((0x7c00U ^ (0xfffffc00U 
                                                  & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__0__KET____DOT__add_mod____pinNumber1))) 
                                      & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                         << 0xaU)));
    this->out__out__en21 = (0x400U & (((IData)(0x7fffU) 
                                       ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__0__KET____DOT__add_mod____pinNumber1)) 
                                      & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                         << 0xaU)));
    this->out__out__en22 = (0x800U & ((0x7800U ^ (0xfffff800U 
                                                  & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__0__KET____DOT__add_mod____pinNumber1))) 
                                      & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                         << 0xbU)));
    this->out__out__en23 = (0x800U & (((IData)(0x7fffU) 
                                       ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__0__KET____DOT__add_mod____pinNumber1)) 
                                      & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                         << 0xbU)));
    this->out__out__en24 = (0x1000U & ((0x7000U ^ (0xfffff000U 
                                                   & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__0__KET____DOT__add_mod____pinNumber1))) 
                                       & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                          << 0xcU)));
    this->out__out__en25 = (0x1000U & (((IData)(0x7fffU) 
                                        ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__0__KET____DOT__add_mod____pinNumber1)) 
                                       & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                          << 0xcU)));
    this->out__out__en26 = (0x2000U & ((0x6000U ^ (0xffffe000U 
                                                   & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__0__KET____DOT__add_mod____pinNumber1))) 
                                       & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                          << 0xdU)));
    this->out__out__en27 = (0x2000U & (((IData)(0x7fffU) 
                                        ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__0__KET____DOT__add_mod____pinNumber1)) 
                                       & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                          << 0xdU)));
    this->out__out__en28 = (0x4000U & ((0x4000U ^ (0xffffc000U 
                                                   & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__0__KET____DOT__add_mod____pinNumber1))) 
                                       & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                          << 0xeU)));
    this->out__out__en29 = (0x4000U & (((IData)(0x7fffU) 
                                        ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__0__KET____DOT__add_mod____pinNumber1)) 
                                       & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                          << 0xeU)));
    this->out__out__en30 = (0x8000U & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__0__KET____DOT__add_mod____pinNumber1) 
                                       & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                          << 0xfU)));
    this->out__out__en31 = (0x8000U & (((IData)(0x7fffU) 
                                        ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__0__KET____DOT__add_mod____pinNumber1)) 
                                       & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                          << 0xfU)));
    this->__PVT__G1 = ((0xfffeU & ((~ (((~ (0x3fffU 
                                            | ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__0__KET____DOT__add_mod____pinNumber1) 
                                               >> 1U))) 
                                        | (~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__0__KET____DOT__add_mod____pinNumber1))) 
                                       & (~ (0x3fffU 
                                             & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__0__KET____DOT__add_mod____pinNumber1) 
                                                >> 1U))))) 
                                   << 1U)) | (1U & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__0__KET____DOT__add_mod____pinNumber1)));
    this->__PVT__P1 = (1U | (0xfffeU & (0x7ffeU | (0xfffffffeU 
                                                   & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__0__KET____DOT__add_mod____pinNumber1)))));
    this->out__en = ((((((((((((((((((((((((((((((((IData)(this->out__out__en0) 
                                                   | (IData)(this->out__out__en1)) 
                                                  | (IData)(this->out__out__en2)) 
                                                 | (IData)(this->out__out__en3)) 
                                                | (IData)(this->out__out__en4)) 
                                               | (IData)(this->out__out__en5)) 
                                              | (IData)(this->out__out__en6)) 
                                             | (IData)(this->out__out__en7)) 
                                            | (IData)(this->out__out__en8)) 
                                           | (IData)(this->out__out__en9)) 
                                          | (IData)(this->out__out__en10)) 
                                         | (IData)(this->out__out__en11)) 
                                        | (IData)(this->out__out__en12)) 
                                       | (IData)(this->out__out__en13)) 
                                      | (IData)(this->out__out__en14)) 
                                     | (IData)(this->out__out__en15)) 
                                    | (IData)(this->out__out__en16)) 
                                   | (IData)(this->out__out__en17)) 
                                  | (IData)(this->out__out__en18)) 
                                 | (IData)(this->out__out__en19)) 
                                | (IData)(this->out__out__en20)) 
                               | (IData)(this->out__out__en21)) 
                              | (IData)(this->out__out__en22)) 
                             | (IData)(this->out__out__en23)) 
                            | (IData)(this->out__out__en24)) 
                           | (IData)(this->out__out__en25)) 
                          | (IData)(this->out__out__en26)) 
                         | (IData)(this->out__out__en27)) 
                        | (IData)(this->out__out__en28)) 
                       | (IData)(this->out__out__en29)) 
                      | (IData)(this->out__out__en30)) 
                     | (IData)(this->out__out__en31));
    this->__PVT__nG2 = ((0xfffcU & ((~ ((((IData)(this->__PVT__P1) 
                                          >> 2U) & (IData)(this->__PVT__G1)) 
                                        | ((IData)(this->__PVT__G1) 
                                           >> 2U))) 
                                    << 2U)) | (3U & 
                                               (~ (IData)(this->__PVT__G1))));
    this->__PVT__nP2 = ((0xfffcU & ((~ (((IData)(this->__PVT__P1) 
                                         >> 2U) & (IData)(this->__PVT__P1))) 
                                    << 2U)) | (3U & 
                                               (~ (IData)(this->__PVT__P1))));
    this->__PVT__P3 = ((0xfff0U & ((~ (((IData)(this->__PVT__nP2) 
                                        >> 4U) | (IData)(this->__PVT__nP2))) 
                                   << 4U)) | (0xfU 
                                              & (~ (IData)(this->__PVT__nP2))));
    this->__PVT__G3 = ((0xfff0U & ((~ ((((IData)(this->__PVT__nP2) 
                                         >> 4U) | (IData)(this->__PVT__nG2)) 
                                       & ((IData)(this->__PVT__nG2) 
                                          >> 4U))) 
                                   << 4U)) | (0xfU 
                                              & (~ (IData)(this->__PVT__nG2))));
    this->__PVT__nG4 = ((0xff00U & ((~ ((((IData)(this->__PVT__P3) 
                                          >> 8U) & (IData)(this->__PVT__G3)) 
                                        | ((IData)(this->__PVT__G3) 
                                           >> 8U))) 
                                    << 8U)) | (0xffU 
                                               & (~ (IData)(this->__PVT__G3))));
    this->out__out__out2 = ((0xfffdU & (IData)(this->out__out__out2)) 
                            | (2U & (((0x7ffeU ^ (0xfffffffeU 
                                                  & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__0__KET____DOT__add_mod____pinNumber1))) 
                                      & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                         << 1U)) & 
                                     ((IData)(this->__PVT__nG4) 
                                      << 1U))));
    this->out__out__out4 = ((0xfffbU & (IData)(this->out__out__out4)) 
                            | (4U & (((0x7ffcU ^ (0xfffffffcU 
                                                  & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__0__KET____DOT__add_mod____pinNumber1))) 
                                      & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                         << 2U)) & 
                                     ((IData)(this->__PVT__nG4) 
                                      << 1U))));
    this->out__out__out6 = ((0xfff7U & (IData)(this->out__out__out6)) 
                            | (8U & (((0x7ff8U ^ (0xfffffff8U 
                                                  & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__0__KET____DOT__add_mod____pinNumber1))) 
                                      & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                         << 3U)) & 
                                     ((IData)(this->__PVT__nG4) 
                                      << 1U))));
    this->out__out__out8 = ((0xffefU & (IData)(this->out__out__out8)) 
                            | (0x10U & (((0x7ff0U ^ 
                                          (0xfffffff0U 
                                           & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__0__KET____DOT__add_mod____pinNumber1))) 
                                         & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                            << 4U)) 
                                        & ((IData)(this->__PVT__nG4) 
                                           << 1U))));
    this->out__out__out10 = ((0xffdfU & (IData)(this->out__out__out10)) 
                             | (0x20U & (((0x7fe0U 
                                           ^ (0xffffffe0U 
                                              & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__0__KET____DOT__add_mod____pinNumber1))) 
                                          & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                             << 5U)) 
                                         & ((IData)(this->__PVT__nG4) 
                                            << 1U))));
    this->out__out__out12 = ((0xffbfU & (IData)(this->out__out__out12)) 
                             | (0x40U & (((0x7fc0U 
                                           ^ (0xffffffc0U 
                                              & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__0__KET____DOT__add_mod____pinNumber1))) 
                                          & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                             << 6U)) 
                                         & ((IData)(this->__PVT__nG4) 
                                            << 1U))));
    this->out__out__out14 = ((0xff7fU & (IData)(this->out__out__out14)) 
                             | (0x80U & (((0x7f80U 
                                           ^ (0xffffff80U 
                                              & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__0__KET____DOT__add_mod____pinNumber1))) 
                                          & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                             << 7U)) 
                                         & ((IData)(this->__PVT__nG4) 
                                            << 1U))));
    this->out__out__out16 = ((0xfeffU & (IData)(this->out__out__out16)) 
                             | (0x100U & (((0x7f00U 
                                            ^ (0xffffff00U 
                                               & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__0__KET____DOT__add_mod____pinNumber1))) 
                                           & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                              << 8U)) 
                                          & ((IData)(this->__PVT__nG4) 
                                             << 1U))));
    this->out__out__out18 = ((0xfdffU & (IData)(this->out__out__out18)) 
                             | (0x200U & (((0x7e00U 
                                            ^ (0xfffffe00U 
                                               & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__0__KET____DOT__add_mod____pinNumber1))) 
                                           & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                              << 9U)) 
                                          & ((IData)(this->__PVT__nG4) 
                                             << 1U))));
    this->out__out__out20 = ((0xfbffU & (IData)(this->out__out__out20)) 
                             | (0x400U & (((0x7c00U 
                                            ^ (0xfffffc00U 
                                               & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__0__KET____DOT__add_mod____pinNumber1))) 
                                           & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                              << 0xaU)) 
                                          & ((IData)(this->__PVT__nG4) 
                                             << 1U))));
    this->out__out__out22 = ((0xf7ffU & (IData)(this->out__out__out22)) 
                             | (0x800U & (((0x7800U 
                                            ^ (0xfffff800U 
                                               & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__0__KET____DOT__add_mod____pinNumber1))) 
                                           & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                              << 0xbU)) 
                                          & ((IData)(this->__PVT__nG4) 
                                             << 1U))));
    this->out__out__out24 = ((0xefffU & (IData)(this->out__out__out24)) 
                             | (0x1000U & (((0x7000U 
                                             ^ (0xfffff000U 
                                                & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__0__KET____DOT__add_mod____pinNumber1))) 
                                            & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                               << 0xcU)) 
                                           & ((IData)(this->__PVT__nG4) 
                                              << 1U))));
    this->out__out__out26 = ((0xdfffU & (IData)(this->out__out__out26)) 
                             | (0x2000U & (((0x6000U 
                                             ^ (0xffffe000U 
                                                & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__0__KET____DOT__add_mod____pinNumber1))) 
                                            & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                               << 0xdU)) 
                                           & ((IData)(this->__PVT__nG4) 
                                              << 1U))));
    this->out__out__out28 = ((0xbfffU & (IData)(this->out__out__out28)) 
                             | (0x4000U & (((0x4000U 
                                             ^ (0xffffc000U 
                                                & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__0__KET____DOT__add_mod____pinNumber1))) 
                                            & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                               << 0xeU)) 
                                           & ((IData)(this->__PVT__nG4) 
                                              << 1U))));
    this->out__out__out30 = ((0x7fffU & (IData)(this->out__out__out30)) 
                             | (0x8000U & (((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__0__KET____DOT__add_mod____pinNumber1) 
                                            & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                               << 0xfU)) 
                                           & ((IData)(this->__PVT__nG4) 
                                              << 1U))));
    this->__PVT__nC1 = (1U | (0xfffeU & ((IData)(this->__PVT__nG4) 
                                         << 1U)));
    this->out__out__out1 = ((0xfffeU & (IData)(this->out__out__out1)) 
                            | (1U & (((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__0__KET____DOT__add_mod____pinNumber1) 
                                      & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg)) 
                                     & (~ (IData)(this->__PVT__nC1)))));
    this->out__out__out3 = ((0xfffdU & (IData)(this->out__out__out3)) 
                            | (2U & ((((IData)(0x7fffU) 
                                       ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__0__KET____DOT__add_mod____pinNumber1)) 
                                      & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                         << 1U)) & 
                                     ((~ ((IData)(this->__PVT__nC1) 
                                          >> 1U)) << 1U))));
    this->out__out__out5 = ((0xfffbU & (IData)(this->out__out__out5)) 
                            | (4U & ((((IData)(0x7fffU) 
                                       ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__0__KET____DOT__add_mod____pinNumber1)) 
                                      & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                         << 2U)) & 
                                     ((~ ((IData)(this->__PVT__nC1) 
                                          >> 2U)) << 2U))));
    this->out__out__out7 = ((0xfff7U & (IData)(this->out__out__out7)) 
                            | (8U & ((((IData)(0x7fffU) 
                                       ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__0__KET____DOT__add_mod____pinNumber1)) 
                                      & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                         << 3U)) & 
                                     ((~ ((IData)(this->__PVT__nC1) 
                                          >> 3U)) << 3U))));
    this->out__out__out9 = ((0xffefU & (IData)(this->out__out__out9)) 
                            | (0x10U & ((((IData)(0x7fffU) 
                                          ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__0__KET____DOT__add_mod____pinNumber1)) 
                                         & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                            << 4U)) 
                                        & ((~ ((IData)(this->__PVT__nC1) 
                                               >> 4U)) 
                                           << 4U))));
    this->out__out__out11 = ((0xffdfU & (IData)(this->out__out__out11)) 
                             | (0x20U & ((((IData)(0x7fffU) 
                                           ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__0__KET____DOT__add_mod____pinNumber1)) 
                                          & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                             << 5U)) 
                                         & ((~ ((IData)(this->__PVT__nC1) 
                                                >> 5U)) 
                                            << 5U))));
    this->out__out__out13 = ((0xffbfU & (IData)(this->out__out__out13)) 
                             | (0x40U & ((((IData)(0x7fffU) 
                                           ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__0__KET____DOT__add_mod____pinNumber1)) 
                                          & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                             << 6U)) 
                                         & ((~ ((IData)(this->__PVT__nC1) 
                                                >> 6U)) 
                                            << 6U))));
    this->out__out__out15 = ((0xff7fU & (IData)(this->out__out__out15)) 
                             | (0x80U & ((((IData)(0x7fffU) 
                                           ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__0__KET____DOT__add_mod____pinNumber1)) 
                                          & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                             << 7U)) 
                                         & ((~ ((IData)(this->__PVT__nC1) 
                                                >> 7U)) 
                                            << 7U))));
    this->out__out__out17 = ((0xfeffU & (IData)(this->out__out__out17)) 
                             | (0x100U & ((((IData)(0x7fffU) 
                                            ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__0__KET____DOT__add_mod____pinNumber1)) 
                                           & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                              << 8U)) 
                                          & ((~ ((IData)(this->__PVT__nC1) 
                                                 >> 8U)) 
                                             << 8U))));
    this->out__out__out19 = ((0xfdffU & (IData)(this->out__out__out19)) 
                             | (0x200U & ((((IData)(0x7fffU) 
                                            ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__0__KET____DOT__add_mod____pinNumber1)) 
                                           & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                              << 9U)) 
                                          & ((~ ((IData)(this->__PVT__nC1) 
                                                 >> 9U)) 
                                             << 9U))));
    this->out__out__out21 = ((0xfbffU & (IData)(this->out__out__out21)) 
                             | (0x400U & ((((IData)(0x7fffU) 
                                            ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__0__KET____DOT__add_mod____pinNumber1)) 
                                           & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                              << 0xaU)) 
                                          & ((~ ((IData)(this->__PVT__nC1) 
                                                 >> 0xaU)) 
                                             << 0xaU))));
    this->out__out__out23 = ((0xf7ffU & (IData)(this->out__out__out23)) 
                             | (0x800U & ((((IData)(0x7fffU) 
                                            ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__0__KET____DOT__add_mod____pinNumber1)) 
                                           & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                              << 0xbU)) 
                                          & ((~ ((IData)(this->__PVT__nC1) 
                                                 >> 0xbU)) 
                                             << 0xbU))));
    this->out__out__out25 = ((0xefffU & (IData)(this->out__out__out25)) 
                             | (0x1000U & ((((IData)(0x7fffU) 
                                             ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__0__KET____DOT__add_mod____pinNumber1)) 
                                            & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                               << 0xcU)) 
                                           & ((~ ((IData)(this->__PVT__nC1) 
                                                  >> 0xcU)) 
                                              << 0xcU))));
    this->out__out__out27 = ((0xdfffU & (IData)(this->out__out__out27)) 
                             | (0x2000U & ((((IData)(0x7fffU) 
                                             ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__0__KET____DOT__add_mod____pinNumber1)) 
                                            & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                               << 0xdU)) 
                                           & ((~ ((IData)(this->__PVT__nC1) 
                                                  >> 0xdU)) 
                                              << 0xdU))));
    this->out__out__out29 = ((0xbfffU & (IData)(this->out__out__out29)) 
                             | (0x4000U & ((((IData)(0x7fffU) 
                                             ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__0__KET____DOT__add_mod____pinNumber1)) 
                                            & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                               << 0xeU)) 
                                           & ((~ ((IData)(this->__PVT__nC1) 
                                                  >> 0xeU)) 
                                              << 0xeU))));
    this->out__out__out31 = ((0x7fffU & (IData)(this->out__out__out31)) 
                             | (0x8000U & ((((IData)(0x7fffU) 
                                             ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__0__KET____DOT__add_mod____pinNumber1)) 
                                            & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                               << 0xfU)) 
                                           & ((~ ((IData)(this->__PVT__nC1) 
                                                  >> 0xfU)) 
                                              << 0xfU))));
    this->out__out = ((((((((((((((((((((((((((((((
                                                   (((IData)(this->out__out__out0) 
                                                     & (IData)(this->out__out__en0)) 
                                                    | ((IData)(this->out__out__out1) 
                                                       & (IData)(this->out__out__en1))) 
                                                   | ((IData)(this->out__out__out2) 
                                                      & (IData)(this->out__out__en2))) 
                                                  | ((IData)(this->out__out__out3) 
                                                     & (IData)(this->out__out__en3))) 
                                                 | ((IData)(this->out__out__out4) 
                                                    & (IData)(this->out__out__en4))) 
                                                | ((IData)(this->out__out__out5) 
                                                   & (IData)(this->out__out__en5))) 
                                               | ((IData)(this->out__out__out6) 
                                                  & (IData)(this->out__out__en6))) 
                                              | ((IData)(this->out__out__out7) 
                                                 & (IData)(this->out__out__en7))) 
                                             | ((IData)(this->out__out__out8) 
                                                & (IData)(this->out__out__en8))) 
                                            | ((IData)(this->out__out__out9) 
                                               & (IData)(this->out__out__en9))) 
                                           | ((IData)(this->out__out__out10) 
                                              & (IData)(this->out__out__en10))) 
                                          | ((IData)(this->out__out__out11) 
                                             & (IData)(this->out__out__en11))) 
                                         | ((IData)(this->out__out__out12) 
                                            & (IData)(this->out__out__en12))) 
                                        | ((IData)(this->out__out__out13) 
                                           & (IData)(this->out__out__en13))) 
                                       | ((IData)(this->out__out__out14) 
                                          & (IData)(this->out__out__en14))) 
                                      | ((IData)(this->out__out__out15) 
                                         & (IData)(this->out__out__en15))) 
                                     | ((IData)(this->out__out__out16) 
                                        & (IData)(this->out__out__en16))) 
                                    | ((IData)(this->out__out__out17) 
                                       & (IData)(this->out__out__en17))) 
                                   | ((IData)(this->out__out__out18) 
                                      & (IData)(this->out__out__en18))) 
                                  | ((IData)(this->out__out__out19) 
                                     & (IData)(this->out__out__en19))) 
                                 | ((IData)(this->out__out__out20) 
                                    & (IData)(this->out__out__en20))) 
                                | ((IData)(this->out__out__out21) 
                                   & (IData)(this->out__out__en21))) 
                               | ((IData)(this->out__out__out22) 
                                  & (IData)(this->out__out__en22))) 
                              | ((IData)(this->out__out__out23) 
                                 & (IData)(this->out__out__en23))) 
                             | ((IData)(this->out__out__out24) 
                                & (IData)(this->out__out__en24))) 
                            | ((IData)(this->out__out__out25) 
                               & (IData)(this->out__out__en25))) 
                           | ((IData)(this->out__out__out26) 
                              & (IData)(this->out__out__en26))) 
                          | ((IData)(this->out__out__out27) 
                             & (IData)(this->out__out__en27))) 
                         | ((IData)(this->out__out__out28) 
                            & (IData)(this->out__out__en28))) 
                        | ((IData)(this->out__out__out29) 
                           & (IData)(this->out__out__en29))) 
                       | ((IData)(this->out__out__out30) 
                          & (IData)(this->out__out__en30))) 
                      | ((IData)(this->out__out__out31) 
                         & (IData)(this->out__out__en31)));
}

VL_INLINE_OPT void Vfu_alu_adder__W10::_settle__TOP__fu_alu__DOT__g2fp_mod__DOT__genblk1__BRA__1__KET____DOT__add_mod__2(Vfu_alu__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+          Vfu_alu_adder__W10::_settle__TOP__fu_alu__DOT__g2fp_mod__DOT__genblk1__BRA__1__KET____DOT__add_mod__2\n"); );
    Vfu_alu* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->out__out__out0 = ((0xfffeU & (IData)(this->out__out__out0)) 
                            | (1U & ((~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__1__KET____DOT__add_mod____pinNumber1)) 
                                     & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                        >> 1U))));
    this->out__out__en0 = (1U & ((~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__1__KET____DOT__add_mod____pinNumber1)) 
                                 & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                    >> 1U)));
    this->out__out__en1 = (1U & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__1__KET____DOT__add_mod____pinNumber1) 
                                 & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                    >> 1U)));
    this->out__out__en2 = (2U & ((0x7ffeU ^ (0xfffffffeU 
                                             & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__1__KET____DOT__add_mod____pinNumber1))) 
                                 & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg)));
    this->out__out__en3 = (2U & (((IData)(0x7fffU) 
                                  ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__1__KET____DOT__add_mod____pinNumber1)) 
                                 & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg)));
    this->out__out__en4 = (4U & ((0x7ffcU ^ (0xfffffffcU 
                                             & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__1__KET____DOT__add_mod____pinNumber1))) 
                                 & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                    << 1U)));
    this->out__out__en5 = (4U & (((IData)(0x7fffU) 
                                  ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__1__KET____DOT__add_mod____pinNumber1)) 
                                 & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                    << 1U)));
    this->out__out__en6 = (8U & ((0x7ff8U ^ (0xfffffff8U 
                                             & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__1__KET____DOT__add_mod____pinNumber1))) 
                                 & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                    << 2U)));
    this->out__out__en7 = (8U & (((IData)(0x7fffU) 
                                  ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__1__KET____DOT__add_mod____pinNumber1)) 
                                 & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                    << 2U)));
    this->out__out__en8 = (0x10U & ((0x7ff0U ^ (0xfffffff0U 
                                                & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__1__KET____DOT__add_mod____pinNumber1))) 
                                    & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                       << 3U)));
    this->out__out__en9 = (0x10U & (((IData)(0x7fffU) 
                                     ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__1__KET____DOT__add_mod____pinNumber1)) 
                                    & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                       << 3U)));
    this->out__out__en10 = (0x20U & ((0x7fe0U ^ (0xffffffe0U 
                                                 & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__1__KET____DOT__add_mod____pinNumber1))) 
                                     & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                        << 4U)));
    this->out__out__en11 = (0x20U & (((IData)(0x7fffU) 
                                      ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__1__KET____DOT__add_mod____pinNumber1)) 
                                     & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                        << 4U)));
    this->out__out__en12 = (0x40U & ((0x7fc0U ^ (0xffffffc0U 
                                                 & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__1__KET____DOT__add_mod____pinNumber1))) 
                                     & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                        << 5U)));
    this->out__out__en13 = (0x40U & (((IData)(0x7fffU) 
                                      ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__1__KET____DOT__add_mod____pinNumber1)) 
                                     & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                        << 5U)));
    this->out__out__en14 = (0x80U & ((0x7f80U ^ (0xffffff80U 
                                                 & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__1__KET____DOT__add_mod____pinNumber1))) 
                                     & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                        << 6U)));
    this->out__out__en15 = (0x80U & (((IData)(0x7fffU) 
                                      ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__1__KET____DOT__add_mod____pinNumber1)) 
                                     & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                        << 6U)));
    this->out__out__en16 = (0x100U & ((0x7f00U ^ (0xffffff00U 
                                                  & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__1__KET____DOT__add_mod____pinNumber1))) 
                                      & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                         << 7U)));
    this->out__out__en17 = (0x100U & (((IData)(0x7fffU) 
                                       ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__1__KET____DOT__add_mod____pinNumber1)) 
                                      & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                         << 7U)));
    this->out__out__en18 = (0x200U & ((0x7e00U ^ (0xfffffe00U 
                                                  & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__1__KET____DOT__add_mod____pinNumber1))) 
                                      & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                         << 8U)));
    this->out__out__en19 = (0x200U & (((IData)(0x7fffU) 
                                       ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__1__KET____DOT__add_mod____pinNumber1)) 
                                      & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                         << 8U)));
    this->out__out__en20 = (0x400U & ((0x7c00U ^ (0xfffffc00U 
                                                  & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__1__KET____DOT__add_mod____pinNumber1))) 
                                      & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                         << 9U)));
    this->out__out__en21 = (0x400U & (((IData)(0x7fffU) 
                                       ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__1__KET____DOT__add_mod____pinNumber1)) 
                                      & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                         << 9U)));
    this->out__out__en22 = (0x800U & ((0x7800U ^ (0xfffff800U 
                                                  & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__1__KET____DOT__add_mod____pinNumber1))) 
                                      & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                         << 0xaU)));
    this->out__out__en23 = (0x800U & (((IData)(0x7fffU) 
                                       ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__1__KET____DOT__add_mod____pinNumber1)) 
                                      & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                         << 0xaU)));
    this->out__out__en24 = (0x1000U & ((0x7000U ^ (0xfffff000U 
                                                   & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__1__KET____DOT__add_mod____pinNumber1))) 
                                       & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                          << 0xbU)));
    this->out__out__en25 = (0x1000U & (((IData)(0x7fffU) 
                                        ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__1__KET____DOT__add_mod____pinNumber1)) 
                                       & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                          << 0xbU)));
    this->out__out__en26 = (0x2000U & ((0x6000U ^ (0xffffe000U 
                                                   & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__1__KET____DOT__add_mod____pinNumber1))) 
                                       & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                          << 0xcU)));
    this->out__out__en27 = (0x2000U & (((IData)(0x7fffU) 
                                        ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__1__KET____DOT__add_mod____pinNumber1)) 
                                       & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                          << 0xcU)));
    this->out__out__en28 = (0x4000U & ((0x4000U ^ (0xffffc000U 
                                                   & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__1__KET____DOT__add_mod____pinNumber1))) 
                                       & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                          << 0xdU)));
    this->out__out__en29 = (0x4000U & (((IData)(0x7fffU) 
                                        ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__1__KET____DOT__add_mod____pinNumber1)) 
                                       & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                          << 0xdU)));
    this->out__out__en30 = (0x8000U & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__1__KET____DOT__add_mod____pinNumber1) 
                                       & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                          << 0xeU)));
    this->out__out__en31 = (0x8000U & (((IData)(0x7fffU) 
                                        ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__1__KET____DOT__add_mod____pinNumber1)) 
                                       & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                          << 0xeU)));
    this->__PVT__G1 = ((0xfffeU & ((~ (((~ (0x3fffU 
                                            | ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__1__KET____DOT__add_mod____pinNumber1) 
                                               >> 1U))) 
                                        | (~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__1__KET____DOT__add_mod____pinNumber1))) 
                                       & (~ (0x3fffU 
                                             & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__1__KET____DOT__add_mod____pinNumber1) 
                                                >> 1U))))) 
                                   << 1U)) | (1U & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__1__KET____DOT__add_mod____pinNumber1)));
    this->__PVT__P1 = (1U | (0xfffeU & (0x7ffeU | (0xfffffffeU 
                                                   & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__1__KET____DOT__add_mod____pinNumber1)))));
    this->out__en = ((((((((((((((((((((((((((((((((IData)(this->out__out__en0) 
                                                   | (IData)(this->out__out__en1)) 
                                                  | (IData)(this->out__out__en2)) 
                                                 | (IData)(this->out__out__en3)) 
                                                | (IData)(this->out__out__en4)) 
                                               | (IData)(this->out__out__en5)) 
                                              | (IData)(this->out__out__en6)) 
                                             | (IData)(this->out__out__en7)) 
                                            | (IData)(this->out__out__en8)) 
                                           | (IData)(this->out__out__en9)) 
                                          | (IData)(this->out__out__en10)) 
                                         | (IData)(this->out__out__en11)) 
                                        | (IData)(this->out__out__en12)) 
                                       | (IData)(this->out__out__en13)) 
                                      | (IData)(this->out__out__en14)) 
                                     | (IData)(this->out__out__en15)) 
                                    | (IData)(this->out__out__en16)) 
                                   | (IData)(this->out__out__en17)) 
                                  | (IData)(this->out__out__en18)) 
                                 | (IData)(this->out__out__en19)) 
                                | (IData)(this->out__out__en20)) 
                               | (IData)(this->out__out__en21)) 
                              | (IData)(this->out__out__en22)) 
                             | (IData)(this->out__out__en23)) 
                            | (IData)(this->out__out__en24)) 
                           | (IData)(this->out__out__en25)) 
                          | (IData)(this->out__out__en26)) 
                         | (IData)(this->out__out__en27)) 
                        | (IData)(this->out__out__en28)) 
                       | (IData)(this->out__out__en29)) 
                      | (IData)(this->out__out__en30)) 
                     | (IData)(this->out__out__en31));
    this->__PVT__nG2 = ((0xfffcU & ((~ ((((IData)(this->__PVT__P1) 
                                          >> 2U) & (IData)(this->__PVT__G1)) 
                                        | ((IData)(this->__PVT__G1) 
                                           >> 2U))) 
                                    << 2U)) | (3U & 
                                               (~ (IData)(this->__PVT__G1))));
    this->__PVT__nP2 = ((0xfffcU & ((~ (((IData)(this->__PVT__P1) 
                                         >> 2U) & (IData)(this->__PVT__P1))) 
                                    << 2U)) | (3U & 
                                               (~ (IData)(this->__PVT__P1))));
    this->__PVT__P3 = ((0xfff0U & ((~ (((IData)(this->__PVT__nP2) 
                                        >> 4U) | (IData)(this->__PVT__nP2))) 
                                   << 4U)) | (0xfU 
                                              & (~ (IData)(this->__PVT__nP2))));
    this->__PVT__G3 = ((0xfff0U & ((~ ((((IData)(this->__PVT__nP2) 
                                         >> 4U) | (IData)(this->__PVT__nG2)) 
                                       & ((IData)(this->__PVT__nG2) 
                                          >> 4U))) 
                                   << 4U)) | (0xfU 
                                              & (~ (IData)(this->__PVT__nG2))));
    this->__PVT__nG4 = ((0xff00U & ((~ ((((IData)(this->__PVT__P3) 
                                          >> 8U) & (IData)(this->__PVT__G3)) 
                                        | ((IData)(this->__PVT__G3) 
                                           >> 8U))) 
                                    << 8U)) | (0xffU 
                                               & (~ (IData)(this->__PVT__G3))));
    this->out__out__out2 = ((0xfffdU & (IData)(this->out__out__out2)) 
                            | (2U & (((0x7ffeU ^ (0xfffffffeU 
                                                  & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__1__KET____DOT__add_mod____pinNumber1))) 
                                      & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg)) 
                                     & ((IData)(this->__PVT__nG4) 
                                        << 1U))));
    this->out__out__out4 = ((0xfffbU & (IData)(this->out__out__out4)) 
                            | (4U & (((0x7ffcU ^ (0xfffffffcU 
                                                  & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__1__KET____DOT__add_mod____pinNumber1))) 
                                      & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                         << 1U)) & 
                                     ((IData)(this->__PVT__nG4) 
                                      << 1U))));
    this->out__out__out6 = ((0xfff7U & (IData)(this->out__out__out6)) 
                            | (8U & (((0x7ff8U ^ (0xfffffff8U 
                                                  & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__1__KET____DOT__add_mod____pinNumber1))) 
                                      & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                         << 2U)) & 
                                     ((IData)(this->__PVT__nG4) 
                                      << 1U))));
    this->out__out__out8 = ((0xffefU & (IData)(this->out__out__out8)) 
                            | (0x10U & (((0x7ff0U ^ 
                                          (0xfffffff0U 
                                           & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__1__KET____DOT__add_mod____pinNumber1))) 
                                         & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                            << 3U)) 
                                        & ((IData)(this->__PVT__nG4) 
                                           << 1U))));
    this->out__out__out10 = ((0xffdfU & (IData)(this->out__out__out10)) 
                             | (0x20U & (((0x7fe0U 
                                           ^ (0xffffffe0U 
                                              & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__1__KET____DOT__add_mod____pinNumber1))) 
                                          & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                             << 4U)) 
                                         & ((IData)(this->__PVT__nG4) 
                                            << 1U))));
    this->out__out__out12 = ((0xffbfU & (IData)(this->out__out__out12)) 
                             | (0x40U & (((0x7fc0U 
                                           ^ (0xffffffc0U 
                                              & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__1__KET____DOT__add_mod____pinNumber1))) 
                                          & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                             << 5U)) 
                                         & ((IData)(this->__PVT__nG4) 
                                            << 1U))));
    this->out__out__out14 = ((0xff7fU & (IData)(this->out__out__out14)) 
                             | (0x80U & (((0x7f80U 
                                           ^ (0xffffff80U 
                                              & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__1__KET____DOT__add_mod____pinNumber1))) 
                                          & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                             << 6U)) 
                                         & ((IData)(this->__PVT__nG4) 
                                            << 1U))));
    this->out__out__out16 = ((0xfeffU & (IData)(this->out__out__out16)) 
                             | (0x100U & (((0x7f00U 
                                            ^ (0xffffff00U 
                                               & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__1__KET____DOT__add_mod____pinNumber1))) 
                                           & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                              << 7U)) 
                                          & ((IData)(this->__PVT__nG4) 
                                             << 1U))));
    this->out__out__out18 = ((0xfdffU & (IData)(this->out__out__out18)) 
                             | (0x200U & (((0x7e00U 
                                            ^ (0xfffffe00U 
                                               & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__1__KET____DOT__add_mod____pinNumber1))) 
                                           & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                              << 8U)) 
                                          & ((IData)(this->__PVT__nG4) 
                                             << 1U))));
    this->out__out__out20 = ((0xfbffU & (IData)(this->out__out__out20)) 
                             | (0x400U & (((0x7c00U 
                                            ^ (0xfffffc00U 
                                               & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__1__KET____DOT__add_mod____pinNumber1))) 
                                           & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                              << 9U)) 
                                          & ((IData)(this->__PVT__nG4) 
                                             << 1U))));
    this->out__out__out22 = ((0xf7ffU & (IData)(this->out__out__out22)) 
                             | (0x800U & (((0x7800U 
                                            ^ (0xfffff800U 
                                               & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__1__KET____DOT__add_mod____pinNumber1))) 
                                           & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                              << 0xaU)) 
                                          & ((IData)(this->__PVT__nG4) 
                                             << 1U))));
    this->out__out__out24 = ((0xefffU & (IData)(this->out__out__out24)) 
                             | (0x1000U & (((0x7000U 
                                             ^ (0xfffff000U 
                                                & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__1__KET____DOT__add_mod____pinNumber1))) 
                                            & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                               << 0xbU)) 
                                           & ((IData)(this->__PVT__nG4) 
                                              << 1U))));
    this->out__out__out26 = ((0xdfffU & (IData)(this->out__out__out26)) 
                             | (0x2000U & (((0x6000U 
                                             ^ (0xffffe000U 
                                                & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__1__KET____DOT__add_mod____pinNumber1))) 
                                            & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                               << 0xcU)) 
                                           & ((IData)(this->__PVT__nG4) 
                                              << 1U))));
    this->out__out__out28 = ((0xbfffU & (IData)(this->out__out__out28)) 
                             | (0x4000U & (((0x4000U 
                                             ^ (0xffffc000U 
                                                & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__1__KET____DOT__add_mod____pinNumber1))) 
                                            & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                               << 0xdU)) 
                                           & ((IData)(this->__PVT__nG4) 
                                              << 1U))));
    this->out__out__out30 = ((0x7fffU & (IData)(this->out__out__out30)) 
                             | (0x8000U & (((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__1__KET____DOT__add_mod____pinNumber1) 
                                            & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                               << 0xeU)) 
                                           & ((IData)(this->__PVT__nG4) 
                                              << 1U))));
    this->__PVT__nC1 = (1U | (0xfffeU & ((IData)(this->__PVT__nG4) 
                                         << 1U)));
    this->out__out__out1 = ((0xfffeU & (IData)(this->out__out__out1)) 
                            | (1U & (((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__1__KET____DOT__add_mod____pinNumber1) 
                                      & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                         >> 1U)) & 
                                     (~ (IData)(this->__PVT__nC1)))));
    this->out__out__out3 = ((0xfffdU & (IData)(this->out__out__out3)) 
                            | (2U & ((((IData)(0x7fffU) 
                                       ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__1__KET____DOT__add_mod____pinNumber1)) 
                                      & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg)) 
                                     & ((~ ((IData)(this->__PVT__nC1) 
                                            >> 1U)) 
                                        << 1U))));
    this->out__out__out5 = ((0xfffbU & (IData)(this->out__out__out5)) 
                            | (4U & ((((IData)(0x7fffU) 
                                       ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__1__KET____DOT__add_mod____pinNumber1)) 
                                      & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                         << 1U)) & 
                                     ((~ ((IData)(this->__PVT__nC1) 
                                          >> 2U)) << 2U))));
    this->out__out__out7 = ((0xfff7U & (IData)(this->out__out__out7)) 
                            | (8U & ((((IData)(0x7fffU) 
                                       ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__1__KET____DOT__add_mod____pinNumber1)) 
                                      & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                         << 2U)) & 
                                     ((~ ((IData)(this->__PVT__nC1) 
                                          >> 3U)) << 3U))));
    this->out__out__out9 = ((0xffefU & (IData)(this->out__out__out9)) 
                            | (0x10U & ((((IData)(0x7fffU) 
                                          ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__1__KET____DOT__add_mod____pinNumber1)) 
                                         & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                            << 3U)) 
                                        & ((~ ((IData)(this->__PVT__nC1) 
                                               >> 4U)) 
                                           << 4U))));
    this->out__out__out11 = ((0xffdfU & (IData)(this->out__out__out11)) 
                             | (0x20U & ((((IData)(0x7fffU) 
                                           ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__1__KET____DOT__add_mod____pinNumber1)) 
                                          & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                             << 4U)) 
                                         & ((~ ((IData)(this->__PVT__nC1) 
                                                >> 5U)) 
                                            << 5U))));
    this->out__out__out13 = ((0xffbfU & (IData)(this->out__out__out13)) 
                             | (0x40U & ((((IData)(0x7fffU) 
                                           ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__1__KET____DOT__add_mod____pinNumber1)) 
                                          & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                             << 5U)) 
                                         & ((~ ((IData)(this->__PVT__nC1) 
                                                >> 6U)) 
                                            << 6U))));
    this->out__out__out15 = ((0xff7fU & (IData)(this->out__out__out15)) 
                             | (0x80U & ((((IData)(0x7fffU) 
                                           ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__1__KET____DOT__add_mod____pinNumber1)) 
                                          & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                             << 6U)) 
                                         & ((~ ((IData)(this->__PVT__nC1) 
                                                >> 7U)) 
                                            << 7U))));
    this->out__out__out17 = ((0xfeffU & (IData)(this->out__out__out17)) 
                             | (0x100U & ((((IData)(0x7fffU) 
                                            ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__1__KET____DOT__add_mod____pinNumber1)) 
                                           & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                              << 7U)) 
                                          & ((~ ((IData)(this->__PVT__nC1) 
                                                 >> 8U)) 
                                             << 8U))));
    this->out__out__out19 = ((0xfdffU & (IData)(this->out__out__out19)) 
                             | (0x200U & ((((IData)(0x7fffU) 
                                            ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__1__KET____DOT__add_mod____pinNumber1)) 
                                           & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                              << 8U)) 
                                          & ((~ ((IData)(this->__PVT__nC1) 
                                                 >> 9U)) 
                                             << 9U))));
    this->out__out__out21 = ((0xfbffU & (IData)(this->out__out__out21)) 
                             | (0x400U & ((((IData)(0x7fffU) 
                                            ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__1__KET____DOT__add_mod____pinNumber1)) 
                                           & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                              << 9U)) 
                                          & ((~ ((IData)(this->__PVT__nC1) 
                                                 >> 0xaU)) 
                                             << 0xaU))));
    this->out__out__out23 = ((0xf7ffU & (IData)(this->out__out__out23)) 
                             | (0x800U & ((((IData)(0x7fffU) 
                                            ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__1__KET____DOT__add_mod____pinNumber1)) 
                                           & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                              << 0xaU)) 
                                          & ((~ ((IData)(this->__PVT__nC1) 
                                                 >> 0xbU)) 
                                             << 0xbU))));
    this->out__out__out25 = ((0xefffU & (IData)(this->out__out__out25)) 
                             | (0x1000U & ((((IData)(0x7fffU) 
                                             ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__1__KET____DOT__add_mod____pinNumber1)) 
                                            & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                               << 0xbU)) 
                                           & ((~ ((IData)(this->__PVT__nC1) 
                                                  >> 0xcU)) 
                                              << 0xcU))));
    this->out__out__out27 = ((0xdfffU & (IData)(this->out__out__out27)) 
                             | (0x2000U & ((((IData)(0x7fffU) 
                                             ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__1__KET____DOT__add_mod____pinNumber1)) 
                                            & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                               << 0xcU)) 
                                           & ((~ ((IData)(this->__PVT__nC1) 
                                                  >> 0xdU)) 
                                              << 0xdU))));
    this->out__out__out29 = ((0xbfffU & (IData)(this->out__out__out29)) 
                             | (0x4000U & ((((IData)(0x7fffU) 
                                             ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__1__KET____DOT__add_mod____pinNumber1)) 
                                            & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                               << 0xdU)) 
                                           & ((~ ((IData)(this->__PVT__nC1) 
                                                  >> 0xeU)) 
                                              << 0xeU))));
    this->out__out__out31 = ((0x7fffU & (IData)(this->out__out__out31)) 
                             | (0x8000U & ((((IData)(0x7fffU) 
                                             ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__1__KET____DOT__add_mod____pinNumber1)) 
                                            & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                               << 0xeU)) 
                                           & ((~ ((IData)(this->__PVT__nC1) 
                                                  >> 0xfU)) 
                                              << 0xfU))));
    this->out__out = ((((((((((((((((((((((((((((((
                                                   (((IData)(this->out__out__out0) 
                                                     & (IData)(this->out__out__en0)) 
                                                    | ((IData)(this->out__out__out1) 
                                                       & (IData)(this->out__out__en1))) 
                                                   | ((IData)(this->out__out__out2) 
                                                      & (IData)(this->out__out__en2))) 
                                                  | ((IData)(this->out__out__out3) 
                                                     & (IData)(this->out__out__en3))) 
                                                 | ((IData)(this->out__out__out4) 
                                                    & (IData)(this->out__out__en4))) 
                                                | ((IData)(this->out__out__out5) 
                                                   & (IData)(this->out__out__en5))) 
                                               | ((IData)(this->out__out__out6) 
                                                  & (IData)(this->out__out__en6))) 
                                              | ((IData)(this->out__out__out7) 
                                                 & (IData)(this->out__out__en7))) 
                                             | ((IData)(this->out__out__out8) 
                                                & (IData)(this->out__out__en8))) 
                                            | ((IData)(this->out__out__out9) 
                                               & (IData)(this->out__out__en9))) 
                                           | ((IData)(this->out__out__out10) 
                                              & (IData)(this->out__out__en10))) 
                                          | ((IData)(this->out__out__out11) 
                                             & (IData)(this->out__out__en11))) 
                                         | ((IData)(this->out__out__out12) 
                                            & (IData)(this->out__out__en12))) 
                                        | ((IData)(this->out__out__out13) 
                                           & (IData)(this->out__out__en13))) 
                                       | ((IData)(this->out__out__out14) 
                                          & (IData)(this->out__out__en14))) 
                                      | ((IData)(this->out__out__out15) 
                                         & (IData)(this->out__out__en15))) 
                                     | ((IData)(this->out__out__out16) 
                                        & (IData)(this->out__out__en16))) 
                                    | ((IData)(this->out__out__out17) 
                                       & (IData)(this->out__out__en17))) 
                                   | ((IData)(this->out__out__out18) 
                                      & (IData)(this->out__out__en18))) 
                                  | ((IData)(this->out__out__out19) 
                                     & (IData)(this->out__out__en19))) 
                                 | ((IData)(this->out__out__out20) 
                                    & (IData)(this->out__out__en20))) 
                                | ((IData)(this->out__out__out21) 
                                   & (IData)(this->out__out__en21))) 
                               | ((IData)(this->out__out__out22) 
                                  & (IData)(this->out__out__en22))) 
                              | ((IData)(this->out__out__out23) 
                                 & (IData)(this->out__out__en23))) 
                             | ((IData)(this->out__out__out24) 
                                & (IData)(this->out__out__en24))) 
                            | ((IData)(this->out__out__out25) 
                               & (IData)(this->out__out__en25))) 
                           | ((IData)(this->out__out__out26) 
                              & (IData)(this->out__out__en26))) 
                          | ((IData)(this->out__out__out27) 
                             & (IData)(this->out__out__en27))) 
                         | ((IData)(this->out__out__out28) 
                            & (IData)(this->out__out__en28))) 
                        | ((IData)(this->out__out__out29) 
                           & (IData)(this->out__out__en29))) 
                       | ((IData)(this->out__out__out30) 
                          & (IData)(this->out__out__en30))) 
                      | ((IData)(this->out__out__out31) 
                         & (IData)(this->out__out__en31)));
}

VL_INLINE_OPT void Vfu_alu_adder__W10::_settle__TOP__fu_alu__DOT__g2fp_mod__DOT__genblk1__BRA__2__KET____DOT__add_mod__3(Vfu_alu__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+          Vfu_alu_adder__W10::_settle__TOP__fu_alu__DOT__g2fp_mod__DOT__genblk1__BRA__2__KET____DOT__add_mod__3\n"); );
    Vfu_alu* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->out__out__out0 = ((0xfffeU & (IData)(this->out__out__out0)) 
                            | (1U & ((~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__2__KET____DOT__add_mod____pinNumber1)) 
                                     & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                        >> 2U))));
    this->out__out__en0 = (1U & ((~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__2__KET____DOT__add_mod____pinNumber1)) 
                                 & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                    >> 2U)));
    this->out__out__en1 = (1U & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__2__KET____DOT__add_mod____pinNumber1) 
                                 & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                    >> 2U)));
    this->out__out__en2 = (2U & ((0x7ffeU ^ (0xfffffffeU 
                                             & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__2__KET____DOT__add_mod____pinNumber1))) 
                                 & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                    >> 1U)));
    this->out__out__en3 = (2U & (((IData)(0x7fffU) 
                                  ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__2__KET____DOT__add_mod____pinNumber1)) 
                                 & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                    >> 1U)));
    this->out__out__en4 = (4U & ((0x7ffcU ^ (0xfffffffcU 
                                             & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__2__KET____DOT__add_mod____pinNumber1))) 
                                 & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg)));
    this->out__out__en5 = (4U & (((IData)(0x7fffU) 
                                  ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__2__KET____DOT__add_mod____pinNumber1)) 
                                 & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg)));
    this->out__out__en6 = (8U & ((0x7ff8U ^ (0xfffffff8U 
                                             & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__2__KET____DOT__add_mod____pinNumber1))) 
                                 & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                    << 1U)));
    this->out__out__en7 = (8U & (((IData)(0x7fffU) 
                                  ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__2__KET____DOT__add_mod____pinNumber1)) 
                                 & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                    << 1U)));
    this->out__out__en8 = (0x10U & ((0x7ff0U ^ (0xfffffff0U 
                                                & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__2__KET____DOT__add_mod____pinNumber1))) 
                                    & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                       << 2U)));
    this->out__out__en9 = (0x10U & (((IData)(0x7fffU) 
                                     ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__2__KET____DOT__add_mod____pinNumber1)) 
                                    & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                       << 2U)));
    this->out__out__en10 = (0x20U & ((0x7fe0U ^ (0xffffffe0U 
                                                 & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__2__KET____DOT__add_mod____pinNumber1))) 
                                     & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                        << 3U)));
    this->out__out__en11 = (0x20U & (((IData)(0x7fffU) 
                                      ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__2__KET____DOT__add_mod____pinNumber1)) 
                                     & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                        << 3U)));
    this->out__out__en12 = (0x40U & ((0x7fc0U ^ (0xffffffc0U 
                                                 & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__2__KET____DOT__add_mod____pinNumber1))) 
                                     & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                        << 4U)));
    this->out__out__en13 = (0x40U & (((IData)(0x7fffU) 
                                      ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__2__KET____DOT__add_mod____pinNumber1)) 
                                     & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                        << 4U)));
    this->out__out__en14 = (0x80U & ((0x7f80U ^ (0xffffff80U 
                                                 & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__2__KET____DOT__add_mod____pinNumber1))) 
                                     & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                        << 5U)));
    this->out__out__en15 = (0x80U & (((IData)(0x7fffU) 
                                      ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__2__KET____DOT__add_mod____pinNumber1)) 
                                     & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                        << 5U)));
    this->out__out__en16 = (0x100U & ((0x7f00U ^ (0xffffff00U 
                                                  & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__2__KET____DOT__add_mod____pinNumber1))) 
                                      & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                         << 6U)));
    this->out__out__en17 = (0x100U & (((IData)(0x7fffU) 
                                       ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__2__KET____DOT__add_mod____pinNumber1)) 
                                      & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                         << 6U)));
    this->out__out__en18 = (0x200U & ((0x7e00U ^ (0xfffffe00U 
                                                  & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__2__KET____DOT__add_mod____pinNumber1))) 
                                      & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                         << 7U)));
    this->out__out__en19 = (0x200U & (((IData)(0x7fffU) 
                                       ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__2__KET____DOT__add_mod____pinNumber1)) 
                                      & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                         << 7U)));
    this->out__out__en20 = (0x400U & ((0x7c00U ^ (0xfffffc00U 
                                                  & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__2__KET____DOT__add_mod____pinNumber1))) 
                                      & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                         << 8U)));
    this->out__out__en21 = (0x400U & (((IData)(0x7fffU) 
                                       ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__2__KET____DOT__add_mod____pinNumber1)) 
                                      & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                         << 8U)));
    this->out__out__en22 = (0x800U & ((0x7800U ^ (0xfffff800U 
                                                  & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__2__KET____DOT__add_mod____pinNumber1))) 
                                      & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                         << 9U)));
    this->out__out__en23 = (0x800U & (((IData)(0x7fffU) 
                                       ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__2__KET____DOT__add_mod____pinNumber1)) 
                                      & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                         << 9U)));
    this->out__out__en24 = (0x1000U & ((0x7000U ^ (0xfffff000U 
                                                   & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__2__KET____DOT__add_mod____pinNumber1))) 
                                       & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                          << 0xaU)));
    this->out__out__en25 = (0x1000U & (((IData)(0x7fffU) 
                                        ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__2__KET____DOT__add_mod____pinNumber1)) 
                                       & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                          << 0xaU)));
    this->out__out__en26 = (0x2000U & ((0x6000U ^ (0xffffe000U 
                                                   & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__2__KET____DOT__add_mod____pinNumber1))) 
                                       & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                          << 0xbU)));
    this->out__out__en27 = (0x2000U & (((IData)(0x7fffU) 
                                        ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__2__KET____DOT__add_mod____pinNumber1)) 
                                       & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                          << 0xbU)));
    this->out__out__en28 = (0x4000U & ((0x4000U ^ (0xffffc000U 
                                                   & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__2__KET____DOT__add_mod____pinNumber1))) 
                                       & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                          << 0xcU)));
    this->out__out__en29 = (0x4000U & (((IData)(0x7fffU) 
                                        ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__2__KET____DOT__add_mod____pinNumber1)) 
                                       & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                          << 0xcU)));
    this->out__out__en30 = (0x8000U & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__2__KET____DOT__add_mod____pinNumber1) 
                                       & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                          << 0xdU)));
    this->out__out__en31 = (0x8000U & (((IData)(0x7fffU) 
                                        ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__2__KET____DOT__add_mod____pinNumber1)) 
                                       & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                          << 0xdU)));
    this->__PVT__G1 = ((0xfffeU & ((~ (((~ (0x3fffU 
                                            | ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__2__KET____DOT__add_mod____pinNumber1) 
                                               >> 1U))) 
                                        | (~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__2__KET____DOT__add_mod____pinNumber1))) 
                                       & (~ (0x3fffU 
                                             & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__2__KET____DOT__add_mod____pinNumber1) 
                                                >> 1U))))) 
                                   << 1U)) | (1U & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__2__KET____DOT__add_mod____pinNumber1)));
    this->__PVT__P1 = (1U | (0xfffeU & (0x7ffeU | (0xfffffffeU 
                                                   & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__2__KET____DOT__add_mod____pinNumber1)))));
    this->out__en = ((((((((((((((((((((((((((((((((IData)(this->out__out__en0) 
                                                   | (IData)(this->out__out__en1)) 
                                                  | (IData)(this->out__out__en2)) 
                                                 | (IData)(this->out__out__en3)) 
                                                | (IData)(this->out__out__en4)) 
                                               | (IData)(this->out__out__en5)) 
                                              | (IData)(this->out__out__en6)) 
                                             | (IData)(this->out__out__en7)) 
                                            | (IData)(this->out__out__en8)) 
                                           | (IData)(this->out__out__en9)) 
                                          | (IData)(this->out__out__en10)) 
                                         | (IData)(this->out__out__en11)) 
                                        | (IData)(this->out__out__en12)) 
                                       | (IData)(this->out__out__en13)) 
                                      | (IData)(this->out__out__en14)) 
                                     | (IData)(this->out__out__en15)) 
                                    | (IData)(this->out__out__en16)) 
                                   | (IData)(this->out__out__en17)) 
                                  | (IData)(this->out__out__en18)) 
                                 | (IData)(this->out__out__en19)) 
                                | (IData)(this->out__out__en20)) 
                               | (IData)(this->out__out__en21)) 
                              | (IData)(this->out__out__en22)) 
                             | (IData)(this->out__out__en23)) 
                            | (IData)(this->out__out__en24)) 
                           | (IData)(this->out__out__en25)) 
                          | (IData)(this->out__out__en26)) 
                         | (IData)(this->out__out__en27)) 
                        | (IData)(this->out__out__en28)) 
                       | (IData)(this->out__out__en29)) 
                      | (IData)(this->out__out__en30)) 
                     | (IData)(this->out__out__en31));
    this->__PVT__nG2 = ((0xfffcU & ((~ ((((IData)(this->__PVT__P1) 
                                          >> 2U) & (IData)(this->__PVT__G1)) 
                                        | ((IData)(this->__PVT__G1) 
                                           >> 2U))) 
                                    << 2U)) | (3U & 
                                               (~ (IData)(this->__PVT__G1))));
    this->__PVT__nP2 = ((0xfffcU & ((~ (((IData)(this->__PVT__P1) 
                                         >> 2U) & (IData)(this->__PVT__P1))) 
                                    << 2U)) | (3U & 
                                               (~ (IData)(this->__PVT__P1))));
    this->__PVT__P3 = ((0xfff0U & ((~ (((IData)(this->__PVT__nP2) 
                                        >> 4U) | (IData)(this->__PVT__nP2))) 
                                   << 4U)) | (0xfU 
                                              & (~ (IData)(this->__PVT__nP2))));
    this->__PVT__G3 = ((0xfff0U & ((~ ((((IData)(this->__PVT__nP2) 
                                         >> 4U) | (IData)(this->__PVT__nG2)) 
                                       & ((IData)(this->__PVT__nG2) 
                                          >> 4U))) 
                                   << 4U)) | (0xfU 
                                              & (~ (IData)(this->__PVT__nG2))));
    this->__PVT__nG4 = ((0xff00U & ((~ ((((IData)(this->__PVT__P3) 
                                          >> 8U) & (IData)(this->__PVT__G3)) 
                                        | ((IData)(this->__PVT__G3) 
                                           >> 8U))) 
                                    << 8U)) | (0xffU 
                                               & (~ (IData)(this->__PVT__G3))));
    this->out__out__out2 = ((0xfffdU & (IData)(this->out__out__out2)) 
                            | (2U & (((0x7ffeU ^ (0xfffffffeU 
                                                  & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__2__KET____DOT__add_mod____pinNumber1))) 
                                      & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                         >> 1U)) & 
                                     ((IData)(this->__PVT__nG4) 
                                      << 1U))));
    this->out__out__out4 = ((0xfffbU & (IData)(this->out__out__out4)) 
                            | (4U & (((0x7ffcU ^ (0xfffffffcU 
                                                  & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__2__KET____DOT__add_mod____pinNumber1))) 
                                      & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg)) 
                                     & ((IData)(this->__PVT__nG4) 
                                        << 1U))));
    this->out__out__out6 = ((0xfff7U & (IData)(this->out__out__out6)) 
                            | (8U & (((0x7ff8U ^ (0xfffffff8U 
                                                  & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__2__KET____DOT__add_mod____pinNumber1))) 
                                      & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                         << 1U)) & 
                                     ((IData)(this->__PVT__nG4) 
                                      << 1U))));
    this->out__out__out8 = ((0xffefU & (IData)(this->out__out__out8)) 
                            | (0x10U & (((0x7ff0U ^ 
                                          (0xfffffff0U 
                                           & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__2__KET____DOT__add_mod____pinNumber1))) 
                                         & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                            << 2U)) 
                                        & ((IData)(this->__PVT__nG4) 
                                           << 1U))));
    this->out__out__out10 = ((0xffdfU & (IData)(this->out__out__out10)) 
                             | (0x20U & (((0x7fe0U 
                                           ^ (0xffffffe0U 
                                              & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__2__KET____DOT__add_mod____pinNumber1))) 
                                          & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                             << 3U)) 
                                         & ((IData)(this->__PVT__nG4) 
                                            << 1U))));
    this->out__out__out12 = ((0xffbfU & (IData)(this->out__out__out12)) 
                             | (0x40U & (((0x7fc0U 
                                           ^ (0xffffffc0U 
                                              & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__2__KET____DOT__add_mod____pinNumber1))) 
                                          & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                             << 4U)) 
                                         & ((IData)(this->__PVT__nG4) 
                                            << 1U))));
    this->out__out__out14 = ((0xff7fU & (IData)(this->out__out__out14)) 
                             | (0x80U & (((0x7f80U 
                                           ^ (0xffffff80U 
                                              & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__2__KET____DOT__add_mod____pinNumber1))) 
                                          & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                             << 5U)) 
                                         & ((IData)(this->__PVT__nG4) 
                                            << 1U))));
    this->out__out__out16 = ((0xfeffU & (IData)(this->out__out__out16)) 
                             | (0x100U & (((0x7f00U 
                                            ^ (0xffffff00U 
                                               & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__2__KET____DOT__add_mod____pinNumber1))) 
                                           & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                              << 6U)) 
                                          & ((IData)(this->__PVT__nG4) 
                                             << 1U))));
    this->out__out__out18 = ((0xfdffU & (IData)(this->out__out__out18)) 
                             | (0x200U & (((0x7e00U 
                                            ^ (0xfffffe00U 
                                               & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__2__KET____DOT__add_mod____pinNumber1))) 
                                           & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                              << 7U)) 
                                          & ((IData)(this->__PVT__nG4) 
                                             << 1U))));
    this->out__out__out20 = ((0xfbffU & (IData)(this->out__out__out20)) 
                             | (0x400U & (((0x7c00U 
                                            ^ (0xfffffc00U 
                                               & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__2__KET____DOT__add_mod____pinNumber1))) 
                                           & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                              << 8U)) 
                                          & ((IData)(this->__PVT__nG4) 
                                             << 1U))));
    this->out__out__out22 = ((0xf7ffU & (IData)(this->out__out__out22)) 
                             | (0x800U & (((0x7800U 
                                            ^ (0xfffff800U 
                                               & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__2__KET____DOT__add_mod____pinNumber1))) 
                                           & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                              << 9U)) 
                                          & ((IData)(this->__PVT__nG4) 
                                             << 1U))));
    this->out__out__out24 = ((0xefffU & (IData)(this->out__out__out24)) 
                             | (0x1000U & (((0x7000U 
                                             ^ (0xfffff000U 
                                                & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__2__KET____DOT__add_mod____pinNumber1))) 
                                            & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                               << 0xaU)) 
                                           & ((IData)(this->__PVT__nG4) 
                                              << 1U))));
    this->out__out__out26 = ((0xdfffU & (IData)(this->out__out__out26)) 
                             | (0x2000U & (((0x6000U 
                                             ^ (0xffffe000U 
                                                & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__2__KET____DOT__add_mod____pinNumber1))) 
                                            & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                               << 0xbU)) 
                                           & ((IData)(this->__PVT__nG4) 
                                              << 1U))));
    this->out__out__out28 = ((0xbfffU & (IData)(this->out__out__out28)) 
                             | (0x4000U & (((0x4000U 
                                             ^ (0xffffc000U 
                                                & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__2__KET____DOT__add_mod____pinNumber1))) 
                                            & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                               << 0xcU)) 
                                           & ((IData)(this->__PVT__nG4) 
                                              << 1U))));
    this->out__out__out30 = ((0x7fffU & (IData)(this->out__out__out30)) 
                             | (0x8000U & (((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__2__KET____DOT__add_mod____pinNumber1) 
                                            & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                               << 0xdU)) 
                                           & ((IData)(this->__PVT__nG4) 
                                              << 1U))));
    this->__PVT__nC1 = (1U | (0xfffeU & ((IData)(this->__PVT__nG4) 
                                         << 1U)));
    this->out__out__out1 = ((0xfffeU & (IData)(this->out__out__out1)) 
                            | (1U & (((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__2__KET____DOT__add_mod____pinNumber1) 
                                      & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                         >> 2U)) & 
                                     (~ (IData)(this->__PVT__nC1)))));
    this->out__out__out3 = ((0xfffdU & (IData)(this->out__out__out3)) 
                            | (2U & ((((IData)(0x7fffU) 
                                       ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__2__KET____DOT__add_mod____pinNumber1)) 
                                      & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                         >> 1U)) & 
                                     ((~ ((IData)(this->__PVT__nC1) 
                                          >> 1U)) << 1U))));
    this->out__out__out5 = ((0xfffbU & (IData)(this->out__out__out5)) 
                            | (4U & ((((IData)(0x7fffU) 
                                       ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__2__KET____DOT__add_mod____pinNumber1)) 
                                      & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg)) 
                                     & ((~ ((IData)(this->__PVT__nC1) 
                                            >> 2U)) 
                                        << 2U))));
    this->out__out__out7 = ((0xfff7U & (IData)(this->out__out__out7)) 
                            | (8U & ((((IData)(0x7fffU) 
                                       ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__2__KET____DOT__add_mod____pinNumber1)) 
                                      & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                         << 1U)) & 
                                     ((~ ((IData)(this->__PVT__nC1) 
                                          >> 3U)) << 3U))));
    this->out__out__out9 = ((0xffefU & (IData)(this->out__out__out9)) 
                            | (0x10U & ((((IData)(0x7fffU) 
                                          ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__2__KET____DOT__add_mod____pinNumber1)) 
                                         & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                            << 2U)) 
                                        & ((~ ((IData)(this->__PVT__nC1) 
                                               >> 4U)) 
                                           << 4U))));
    this->out__out__out11 = ((0xffdfU & (IData)(this->out__out__out11)) 
                             | (0x20U & ((((IData)(0x7fffU) 
                                           ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__2__KET____DOT__add_mod____pinNumber1)) 
                                          & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                             << 3U)) 
                                         & ((~ ((IData)(this->__PVT__nC1) 
                                                >> 5U)) 
                                            << 5U))));
    this->out__out__out13 = ((0xffbfU & (IData)(this->out__out__out13)) 
                             | (0x40U & ((((IData)(0x7fffU) 
                                           ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__2__KET____DOT__add_mod____pinNumber1)) 
                                          & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                             << 4U)) 
                                         & ((~ ((IData)(this->__PVT__nC1) 
                                                >> 6U)) 
                                            << 6U))));
    this->out__out__out15 = ((0xff7fU & (IData)(this->out__out__out15)) 
                             | (0x80U & ((((IData)(0x7fffU) 
                                           ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__2__KET____DOT__add_mod____pinNumber1)) 
                                          & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                             << 5U)) 
                                         & ((~ ((IData)(this->__PVT__nC1) 
                                                >> 7U)) 
                                            << 7U))));
    this->out__out__out17 = ((0xfeffU & (IData)(this->out__out__out17)) 
                             | (0x100U & ((((IData)(0x7fffU) 
                                            ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__2__KET____DOT__add_mod____pinNumber1)) 
                                           & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                              << 6U)) 
                                          & ((~ ((IData)(this->__PVT__nC1) 
                                                 >> 8U)) 
                                             << 8U))));
    this->out__out__out19 = ((0xfdffU & (IData)(this->out__out__out19)) 
                             | (0x200U & ((((IData)(0x7fffU) 
                                            ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__2__KET____DOT__add_mod____pinNumber1)) 
                                           & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                              << 7U)) 
                                          & ((~ ((IData)(this->__PVT__nC1) 
                                                 >> 9U)) 
                                             << 9U))));
    this->out__out__out21 = ((0xfbffU & (IData)(this->out__out__out21)) 
                             | (0x400U & ((((IData)(0x7fffU) 
                                            ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__2__KET____DOT__add_mod____pinNumber1)) 
                                           & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                              << 8U)) 
                                          & ((~ ((IData)(this->__PVT__nC1) 
                                                 >> 0xaU)) 
                                             << 0xaU))));
    this->out__out__out23 = ((0xf7ffU & (IData)(this->out__out__out23)) 
                             | (0x800U & ((((IData)(0x7fffU) 
                                            ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__2__KET____DOT__add_mod____pinNumber1)) 
                                           & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                              << 9U)) 
                                          & ((~ ((IData)(this->__PVT__nC1) 
                                                 >> 0xbU)) 
                                             << 0xbU))));
    this->out__out__out25 = ((0xefffU & (IData)(this->out__out__out25)) 
                             | (0x1000U & ((((IData)(0x7fffU) 
                                             ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__2__KET____DOT__add_mod____pinNumber1)) 
                                            & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                               << 0xaU)) 
                                           & ((~ ((IData)(this->__PVT__nC1) 
                                                  >> 0xcU)) 
                                              << 0xcU))));
    this->out__out__out27 = ((0xdfffU & (IData)(this->out__out__out27)) 
                             | (0x2000U & ((((IData)(0x7fffU) 
                                             ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__2__KET____DOT__add_mod____pinNumber1)) 
                                            & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                               << 0xbU)) 
                                           & ((~ ((IData)(this->__PVT__nC1) 
                                                  >> 0xdU)) 
                                              << 0xdU))));
    this->out__out__out29 = ((0xbfffU & (IData)(this->out__out__out29)) 
                             | (0x4000U & ((((IData)(0x7fffU) 
                                             ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__2__KET____DOT__add_mod____pinNumber1)) 
                                            & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                               << 0xcU)) 
                                           & ((~ ((IData)(this->__PVT__nC1) 
                                                  >> 0xeU)) 
                                              << 0xeU))));
    this->out__out__out31 = ((0x7fffU & (IData)(this->out__out__out31)) 
                             | (0x8000U & ((((IData)(0x7fffU) 
                                             ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__2__KET____DOT__add_mod____pinNumber1)) 
                                            & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                               << 0xdU)) 
                                           & ((~ ((IData)(this->__PVT__nC1) 
                                                  >> 0xfU)) 
                                              << 0xfU))));
    this->out__out = ((((((((((((((((((((((((((((((
                                                   (((IData)(this->out__out__out0) 
                                                     & (IData)(this->out__out__en0)) 
                                                    | ((IData)(this->out__out__out1) 
                                                       & (IData)(this->out__out__en1))) 
                                                   | ((IData)(this->out__out__out2) 
                                                      & (IData)(this->out__out__en2))) 
                                                  | ((IData)(this->out__out__out3) 
                                                     & (IData)(this->out__out__en3))) 
                                                 | ((IData)(this->out__out__out4) 
                                                    & (IData)(this->out__out__en4))) 
                                                | ((IData)(this->out__out__out5) 
                                                   & (IData)(this->out__out__en5))) 
                                               | ((IData)(this->out__out__out6) 
                                                  & (IData)(this->out__out__en6))) 
                                              | ((IData)(this->out__out__out7) 
                                                 & (IData)(this->out__out__en7))) 
                                             | ((IData)(this->out__out__out8) 
                                                & (IData)(this->out__out__en8))) 
                                            | ((IData)(this->out__out__out9) 
                                               & (IData)(this->out__out__en9))) 
                                           | ((IData)(this->out__out__out10) 
                                              & (IData)(this->out__out__en10))) 
                                          | ((IData)(this->out__out__out11) 
                                             & (IData)(this->out__out__en11))) 
                                         | ((IData)(this->out__out__out12) 
                                            & (IData)(this->out__out__en12))) 
                                        | ((IData)(this->out__out__out13) 
                                           & (IData)(this->out__out__en13))) 
                                       | ((IData)(this->out__out__out14) 
                                          & (IData)(this->out__out__en14))) 
                                      | ((IData)(this->out__out__out15) 
                                         & (IData)(this->out__out__en15))) 
                                     | ((IData)(this->out__out__out16) 
                                        & (IData)(this->out__out__en16))) 
                                    | ((IData)(this->out__out__out17) 
                                       & (IData)(this->out__out__en17))) 
                                   | ((IData)(this->out__out__out18) 
                                      & (IData)(this->out__out__en18))) 
                                  | ((IData)(this->out__out__out19) 
                                     & (IData)(this->out__out__en19))) 
                                 | ((IData)(this->out__out__out20) 
                                    & (IData)(this->out__out__en20))) 
                                | ((IData)(this->out__out__out21) 
                                   & (IData)(this->out__out__en21))) 
                               | ((IData)(this->out__out__out22) 
                                  & (IData)(this->out__out__en22))) 
                              | ((IData)(this->out__out__out23) 
                                 & (IData)(this->out__out__en23))) 
                             | ((IData)(this->out__out__out24) 
                                & (IData)(this->out__out__en24))) 
                            | ((IData)(this->out__out__out25) 
                               & (IData)(this->out__out__en25))) 
                           | ((IData)(this->out__out__out26) 
                              & (IData)(this->out__out__en26))) 
                          | ((IData)(this->out__out__out27) 
                             & (IData)(this->out__out__en27))) 
                         | ((IData)(this->out__out__out28) 
                            & (IData)(this->out__out__en28))) 
                        | ((IData)(this->out__out__out29) 
                           & (IData)(this->out__out__en29))) 
                       | ((IData)(this->out__out__out30) 
                          & (IData)(this->out__out__en30))) 
                      | ((IData)(this->out__out__out31) 
                         & (IData)(this->out__out__en31)));
}

VL_INLINE_OPT void Vfu_alu_adder__W10::_settle__TOP__fu_alu__DOT__g2fp_mod__DOT__genblk1__BRA__3__KET____DOT__add_mod__4(Vfu_alu__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+          Vfu_alu_adder__W10::_settle__TOP__fu_alu__DOT__g2fp_mod__DOT__genblk1__BRA__3__KET____DOT__add_mod__4\n"); );
    Vfu_alu* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->out__out__out0 = ((0xfffeU & (IData)(this->out__out__out0)) 
                            | (1U & ((~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__3__KET____DOT__add_mod____pinNumber1)) 
                                     & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                        >> 3U))));
    this->out__out__en0 = (1U & ((~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__3__KET____DOT__add_mod____pinNumber1)) 
                                 & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                    >> 3U)));
    this->out__out__en1 = (1U & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__3__KET____DOT__add_mod____pinNumber1) 
                                 & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                    >> 3U)));
    this->out__out__en2 = (2U & ((0x7ffeU ^ (0xfffffffeU 
                                             & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__3__KET____DOT__add_mod____pinNumber1))) 
                                 & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                    >> 2U)));
    this->out__out__en3 = (2U & (((IData)(0x7fffU) 
                                  ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__3__KET____DOT__add_mod____pinNumber1)) 
                                 & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                    >> 2U)));
    this->out__out__en4 = (4U & ((0x7ffcU ^ (0xfffffffcU 
                                             & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__3__KET____DOT__add_mod____pinNumber1))) 
                                 & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                    >> 1U)));
    this->out__out__en5 = (4U & (((IData)(0x7fffU) 
                                  ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__3__KET____DOT__add_mod____pinNumber1)) 
                                 & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                    >> 1U)));
    this->out__out__en6 = (8U & ((0x7ff8U ^ (0xfffffff8U 
                                             & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__3__KET____DOT__add_mod____pinNumber1))) 
                                 & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg)));
    this->out__out__en7 = (8U & (((IData)(0x7fffU) 
                                  ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__3__KET____DOT__add_mod____pinNumber1)) 
                                 & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg)));
    this->out__out__en8 = (0x10U & ((0x7ff0U ^ (0xfffffff0U 
                                                & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__3__KET____DOT__add_mod____pinNumber1))) 
                                    & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                       << 1U)));
    this->out__out__en9 = (0x10U & (((IData)(0x7fffU) 
                                     ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__3__KET____DOT__add_mod____pinNumber1)) 
                                    & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                       << 1U)));
    this->out__out__en10 = (0x20U & ((0x7fe0U ^ (0xffffffe0U 
                                                 & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__3__KET____DOT__add_mod____pinNumber1))) 
                                     & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                        << 2U)));
    this->out__out__en11 = (0x20U & (((IData)(0x7fffU) 
                                      ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__3__KET____DOT__add_mod____pinNumber1)) 
                                     & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                        << 2U)));
    this->out__out__en12 = (0x40U & ((0x7fc0U ^ (0xffffffc0U 
                                                 & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__3__KET____DOT__add_mod____pinNumber1))) 
                                     & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                        << 3U)));
    this->out__out__en13 = (0x40U & (((IData)(0x7fffU) 
                                      ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__3__KET____DOT__add_mod____pinNumber1)) 
                                     & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                        << 3U)));
    this->out__out__en14 = (0x80U & ((0x7f80U ^ (0xffffff80U 
                                                 & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__3__KET____DOT__add_mod____pinNumber1))) 
                                     & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                        << 4U)));
    this->out__out__en15 = (0x80U & (((IData)(0x7fffU) 
                                      ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__3__KET____DOT__add_mod____pinNumber1)) 
                                     & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                        << 4U)));
    this->out__out__en16 = (0x100U & ((0x7f00U ^ (0xffffff00U 
                                                  & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__3__KET____DOT__add_mod____pinNumber1))) 
                                      & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                         << 5U)));
    this->out__out__en17 = (0x100U & (((IData)(0x7fffU) 
                                       ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__3__KET____DOT__add_mod____pinNumber1)) 
                                      & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                         << 5U)));
    this->out__out__en18 = (0x200U & ((0x7e00U ^ (0xfffffe00U 
                                                  & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__3__KET____DOT__add_mod____pinNumber1))) 
                                      & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                         << 6U)));
    this->out__out__en19 = (0x200U & (((IData)(0x7fffU) 
                                       ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__3__KET____DOT__add_mod____pinNumber1)) 
                                      & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                         << 6U)));
    this->out__out__en20 = (0x400U & ((0x7c00U ^ (0xfffffc00U 
                                                  & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__3__KET____DOT__add_mod____pinNumber1))) 
                                      & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                         << 7U)));
    this->out__out__en21 = (0x400U & (((IData)(0x7fffU) 
                                       ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__3__KET____DOT__add_mod____pinNumber1)) 
                                      & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                         << 7U)));
    this->out__out__en22 = (0x800U & ((0x7800U ^ (0xfffff800U 
                                                  & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__3__KET____DOT__add_mod____pinNumber1))) 
                                      & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                         << 8U)));
    this->out__out__en23 = (0x800U & (((IData)(0x7fffU) 
                                       ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__3__KET____DOT__add_mod____pinNumber1)) 
                                      & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                         << 8U)));
    this->out__out__en24 = (0x1000U & ((0x7000U ^ (0xfffff000U 
                                                   & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__3__KET____DOT__add_mod____pinNumber1))) 
                                       & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                          << 9U)));
    this->out__out__en25 = (0x1000U & (((IData)(0x7fffU) 
                                        ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__3__KET____DOT__add_mod____pinNumber1)) 
                                       & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                          << 9U)));
    this->out__out__en26 = (0x2000U & ((0x6000U ^ (0xffffe000U 
                                                   & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__3__KET____DOT__add_mod____pinNumber1))) 
                                       & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                          << 0xaU)));
    this->out__out__en27 = (0x2000U & (((IData)(0x7fffU) 
                                        ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__3__KET____DOT__add_mod____pinNumber1)) 
                                       & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                          << 0xaU)));
    this->out__out__en28 = (0x4000U & ((0x4000U ^ (0xffffc000U 
                                                   & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__3__KET____DOT__add_mod____pinNumber1))) 
                                       & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                          << 0xbU)));
    this->out__out__en29 = (0x4000U & (((IData)(0x7fffU) 
                                        ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__3__KET____DOT__add_mod____pinNumber1)) 
                                       & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                          << 0xbU)));
    this->out__out__en30 = (0x8000U & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__3__KET____DOT__add_mod____pinNumber1) 
                                       & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                          << 0xcU)));
    this->out__out__en31 = (0x8000U & (((IData)(0x7fffU) 
                                        ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__3__KET____DOT__add_mod____pinNumber1)) 
                                       & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                          << 0xcU)));
    this->__PVT__G1 = ((0xfffeU & ((~ (((~ (0x3fffU 
                                            | ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__3__KET____DOT__add_mod____pinNumber1) 
                                               >> 1U))) 
                                        | (~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__3__KET____DOT__add_mod____pinNumber1))) 
                                       & (~ (0x3fffU 
                                             & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__3__KET____DOT__add_mod____pinNumber1) 
                                                >> 1U))))) 
                                   << 1U)) | (1U & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__3__KET____DOT__add_mod____pinNumber1)));
    this->__PVT__P1 = (1U | (0xfffeU & (0x7ffeU | (0xfffffffeU 
                                                   & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__3__KET____DOT__add_mod____pinNumber1)))));
    this->out__en = ((((((((((((((((((((((((((((((((IData)(this->out__out__en0) 
                                                   | (IData)(this->out__out__en1)) 
                                                  | (IData)(this->out__out__en2)) 
                                                 | (IData)(this->out__out__en3)) 
                                                | (IData)(this->out__out__en4)) 
                                               | (IData)(this->out__out__en5)) 
                                              | (IData)(this->out__out__en6)) 
                                             | (IData)(this->out__out__en7)) 
                                            | (IData)(this->out__out__en8)) 
                                           | (IData)(this->out__out__en9)) 
                                          | (IData)(this->out__out__en10)) 
                                         | (IData)(this->out__out__en11)) 
                                        | (IData)(this->out__out__en12)) 
                                       | (IData)(this->out__out__en13)) 
                                      | (IData)(this->out__out__en14)) 
                                     | (IData)(this->out__out__en15)) 
                                    | (IData)(this->out__out__en16)) 
                                   | (IData)(this->out__out__en17)) 
                                  | (IData)(this->out__out__en18)) 
                                 | (IData)(this->out__out__en19)) 
                                | (IData)(this->out__out__en20)) 
                               | (IData)(this->out__out__en21)) 
                              | (IData)(this->out__out__en22)) 
                             | (IData)(this->out__out__en23)) 
                            | (IData)(this->out__out__en24)) 
                           | (IData)(this->out__out__en25)) 
                          | (IData)(this->out__out__en26)) 
                         | (IData)(this->out__out__en27)) 
                        | (IData)(this->out__out__en28)) 
                       | (IData)(this->out__out__en29)) 
                      | (IData)(this->out__out__en30)) 
                     | (IData)(this->out__out__en31));
    this->__PVT__nG2 = ((0xfffcU & ((~ ((((IData)(this->__PVT__P1) 
                                          >> 2U) & (IData)(this->__PVT__G1)) 
                                        | ((IData)(this->__PVT__G1) 
                                           >> 2U))) 
                                    << 2U)) | (3U & 
                                               (~ (IData)(this->__PVT__G1))));
    this->__PVT__nP2 = ((0xfffcU & ((~ (((IData)(this->__PVT__P1) 
                                         >> 2U) & (IData)(this->__PVT__P1))) 
                                    << 2U)) | (3U & 
                                               (~ (IData)(this->__PVT__P1))));
    this->__PVT__P3 = ((0xfff0U & ((~ (((IData)(this->__PVT__nP2) 
                                        >> 4U) | (IData)(this->__PVT__nP2))) 
                                   << 4U)) | (0xfU 
                                              & (~ (IData)(this->__PVT__nP2))));
    this->__PVT__G3 = ((0xfff0U & ((~ ((((IData)(this->__PVT__nP2) 
                                         >> 4U) | (IData)(this->__PVT__nG2)) 
                                       & ((IData)(this->__PVT__nG2) 
                                          >> 4U))) 
                                   << 4U)) | (0xfU 
                                              & (~ (IData)(this->__PVT__nG2))));
    this->__PVT__nG4 = ((0xff00U & ((~ ((((IData)(this->__PVT__P3) 
                                          >> 8U) & (IData)(this->__PVT__G3)) 
                                        | ((IData)(this->__PVT__G3) 
                                           >> 8U))) 
                                    << 8U)) | (0xffU 
                                               & (~ (IData)(this->__PVT__G3))));
    this->out__out__out2 = ((0xfffdU & (IData)(this->out__out__out2)) 
                            | (2U & (((0x7ffeU ^ (0xfffffffeU 
                                                  & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__3__KET____DOT__add_mod____pinNumber1))) 
                                      & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                         >> 2U)) & 
                                     ((IData)(this->__PVT__nG4) 
                                      << 1U))));
    this->out__out__out4 = ((0xfffbU & (IData)(this->out__out__out4)) 
                            | (4U & (((0x7ffcU ^ (0xfffffffcU 
                                                  & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__3__KET____DOT__add_mod____pinNumber1))) 
                                      & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                         >> 1U)) & 
                                     ((IData)(this->__PVT__nG4) 
                                      << 1U))));
    this->out__out__out6 = ((0xfff7U & (IData)(this->out__out__out6)) 
                            | (8U & (((0x7ff8U ^ (0xfffffff8U 
                                                  & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__3__KET____DOT__add_mod____pinNumber1))) 
                                      & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg)) 
                                     & ((IData)(this->__PVT__nG4) 
                                        << 1U))));
    this->out__out__out8 = ((0xffefU & (IData)(this->out__out__out8)) 
                            | (0x10U & (((0x7ff0U ^ 
                                          (0xfffffff0U 
                                           & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__3__KET____DOT__add_mod____pinNumber1))) 
                                         & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                            << 1U)) 
                                        & ((IData)(this->__PVT__nG4) 
                                           << 1U))));
    this->out__out__out10 = ((0xffdfU & (IData)(this->out__out__out10)) 
                             | (0x20U & (((0x7fe0U 
                                           ^ (0xffffffe0U 
                                              & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__3__KET____DOT__add_mod____pinNumber1))) 
                                          & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                             << 2U)) 
                                         & ((IData)(this->__PVT__nG4) 
                                            << 1U))));
    this->out__out__out12 = ((0xffbfU & (IData)(this->out__out__out12)) 
                             | (0x40U & (((0x7fc0U 
                                           ^ (0xffffffc0U 
                                              & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__3__KET____DOT__add_mod____pinNumber1))) 
                                          & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                             << 3U)) 
                                         & ((IData)(this->__PVT__nG4) 
                                            << 1U))));
    this->out__out__out14 = ((0xff7fU & (IData)(this->out__out__out14)) 
                             | (0x80U & (((0x7f80U 
                                           ^ (0xffffff80U 
                                              & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__3__KET____DOT__add_mod____pinNumber1))) 
                                          & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                             << 4U)) 
                                         & ((IData)(this->__PVT__nG4) 
                                            << 1U))));
    this->out__out__out16 = ((0xfeffU & (IData)(this->out__out__out16)) 
                             | (0x100U & (((0x7f00U 
                                            ^ (0xffffff00U 
                                               & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__3__KET____DOT__add_mod____pinNumber1))) 
                                           & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                              << 5U)) 
                                          & ((IData)(this->__PVT__nG4) 
                                             << 1U))));
    this->out__out__out18 = ((0xfdffU & (IData)(this->out__out__out18)) 
                             | (0x200U & (((0x7e00U 
                                            ^ (0xfffffe00U 
                                               & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__3__KET____DOT__add_mod____pinNumber1))) 
                                           & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                              << 6U)) 
                                          & ((IData)(this->__PVT__nG4) 
                                             << 1U))));
    this->out__out__out20 = ((0xfbffU & (IData)(this->out__out__out20)) 
                             | (0x400U & (((0x7c00U 
                                            ^ (0xfffffc00U 
                                               & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__3__KET____DOT__add_mod____pinNumber1))) 
                                           & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                              << 7U)) 
                                          & ((IData)(this->__PVT__nG4) 
                                             << 1U))));
    this->out__out__out22 = ((0xf7ffU & (IData)(this->out__out__out22)) 
                             | (0x800U & (((0x7800U 
                                            ^ (0xfffff800U 
                                               & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__3__KET____DOT__add_mod____pinNumber1))) 
                                           & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                              << 8U)) 
                                          & ((IData)(this->__PVT__nG4) 
                                             << 1U))));
    this->out__out__out24 = ((0xefffU & (IData)(this->out__out__out24)) 
                             | (0x1000U & (((0x7000U 
                                             ^ (0xfffff000U 
                                                & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__3__KET____DOT__add_mod____pinNumber1))) 
                                            & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                               << 9U)) 
                                           & ((IData)(this->__PVT__nG4) 
                                              << 1U))));
    this->out__out__out26 = ((0xdfffU & (IData)(this->out__out__out26)) 
                             | (0x2000U & (((0x6000U 
                                             ^ (0xffffe000U 
                                                & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__3__KET____DOT__add_mod____pinNumber1))) 
                                            & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                               << 0xaU)) 
                                           & ((IData)(this->__PVT__nG4) 
                                              << 1U))));
    this->out__out__out28 = ((0xbfffU & (IData)(this->out__out__out28)) 
                             | (0x4000U & (((0x4000U 
                                             ^ (0xffffc000U 
                                                & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__3__KET____DOT__add_mod____pinNumber1))) 
                                            & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                               << 0xbU)) 
                                           & ((IData)(this->__PVT__nG4) 
                                              << 1U))));
    this->out__out__out30 = ((0x7fffU & (IData)(this->out__out__out30)) 
                             | (0x8000U & (((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__3__KET____DOT__add_mod____pinNumber1) 
                                            & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                               << 0xcU)) 
                                           & ((IData)(this->__PVT__nG4) 
                                              << 1U))));
    this->__PVT__nC1 = (1U | (0xfffeU & ((IData)(this->__PVT__nG4) 
                                         << 1U)));
    this->out__out__out1 = ((0xfffeU & (IData)(this->out__out__out1)) 
                            | (1U & (((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__3__KET____DOT__add_mod____pinNumber1) 
                                      & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                         >> 3U)) & 
                                     (~ (IData)(this->__PVT__nC1)))));
    this->out__out__out3 = ((0xfffdU & (IData)(this->out__out__out3)) 
                            | (2U & ((((IData)(0x7fffU) 
                                       ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__3__KET____DOT__add_mod____pinNumber1)) 
                                      & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                         >> 2U)) & 
                                     ((~ ((IData)(this->__PVT__nC1) 
                                          >> 1U)) << 1U))));
    this->out__out__out5 = ((0xfffbU & (IData)(this->out__out__out5)) 
                            | (4U & ((((IData)(0x7fffU) 
                                       ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__3__KET____DOT__add_mod____pinNumber1)) 
                                      & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                         >> 1U)) & 
                                     ((~ ((IData)(this->__PVT__nC1) 
                                          >> 2U)) << 2U))));
    this->out__out__out7 = ((0xfff7U & (IData)(this->out__out__out7)) 
                            | (8U & ((((IData)(0x7fffU) 
                                       ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__3__KET____DOT__add_mod____pinNumber1)) 
                                      & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg)) 
                                     & ((~ ((IData)(this->__PVT__nC1) 
                                            >> 3U)) 
                                        << 3U))));
    this->out__out__out9 = ((0xffefU & (IData)(this->out__out__out9)) 
                            | (0x10U & ((((IData)(0x7fffU) 
                                          ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__3__KET____DOT__add_mod____pinNumber1)) 
                                         & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                            << 1U)) 
                                        & ((~ ((IData)(this->__PVT__nC1) 
                                               >> 4U)) 
                                           << 4U))));
    this->out__out__out11 = ((0xffdfU & (IData)(this->out__out__out11)) 
                             | (0x20U & ((((IData)(0x7fffU) 
                                           ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__3__KET____DOT__add_mod____pinNumber1)) 
                                          & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                             << 2U)) 
                                         & ((~ ((IData)(this->__PVT__nC1) 
                                                >> 5U)) 
                                            << 5U))));
    this->out__out__out13 = ((0xffbfU & (IData)(this->out__out__out13)) 
                             | (0x40U & ((((IData)(0x7fffU) 
                                           ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__3__KET____DOT__add_mod____pinNumber1)) 
                                          & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                             << 3U)) 
                                         & ((~ ((IData)(this->__PVT__nC1) 
                                                >> 6U)) 
                                            << 6U))));
    this->out__out__out15 = ((0xff7fU & (IData)(this->out__out__out15)) 
                             | (0x80U & ((((IData)(0x7fffU) 
                                           ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__3__KET____DOT__add_mod____pinNumber1)) 
                                          & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                             << 4U)) 
                                         & ((~ ((IData)(this->__PVT__nC1) 
                                                >> 7U)) 
                                            << 7U))));
    this->out__out__out17 = ((0xfeffU & (IData)(this->out__out__out17)) 
                             | (0x100U & ((((IData)(0x7fffU) 
                                            ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__3__KET____DOT__add_mod____pinNumber1)) 
                                           & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                              << 5U)) 
                                          & ((~ ((IData)(this->__PVT__nC1) 
                                                 >> 8U)) 
                                             << 8U))));
    this->out__out__out19 = ((0xfdffU & (IData)(this->out__out__out19)) 
                             | (0x200U & ((((IData)(0x7fffU) 
                                            ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__3__KET____DOT__add_mod____pinNumber1)) 
                                           & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                              << 6U)) 
                                          & ((~ ((IData)(this->__PVT__nC1) 
                                                 >> 9U)) 
                                             << 9U))));
    this->out__out__out21 = ((0xfbffU & (IData)(this->out__out__out21)) 
                             | (0x400U & ((((IData)(0x7fffU) 
                                            ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__3__KET____DOT__add_mod____pinNumber1)) 
                                           & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                              << 7U)) 
                                          & ((~ ((IData)(this->__PVT__nC1) 
                                                 >> 0xaU)) 
                                             << 0xaU))));
    this->out__out__out23 = ((0xf7ffU & (IData)(this->out__out__out23)) 
                             | (0x800U & ((((IData)(0x7fffU) 
                                            ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__3__KET____DOT__add_mod____pinNumber1)) 
                                           & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                              << 8U)) 
                                          & ((~ ((IData)(this->__PVT__nC1) 
                                                 >> 0xbU)) 
                                             << 0xbU))));
    this->out__out__out25 = ((0xefffU & (IData)(this->out__out__out25)) 
                             | (0x1000U & ((((IData)(0x7fffU) 
                                             ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__3__KET____DOT__add_mod____pinNumber1)) 
                                            & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                               << 9U)) 
                                           & ((~ ((IData)(this->__PVT__nC1) 
                                                  >> 0xcU)) 
                                              << 0xcU))));
    this->out__out__out27 = ((0xdfffU & (IData)(this->out__out__out27)) 
                             | (0x2000U & ((((IData)(0x7fffU) 
                                             ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__3__KET____DOT__add_mod____pinNumber1)) 
                                            & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                               << 0xaU)) 
                                           & ((~ ((IData)(this->__PVT__nC1) 
                                                  >> 0xdU)) 
                                              << 0xdU))));
    this->out__out__out29 = ((0xbfffU & (IData)(this->out__out__out29)) 
                             | (0x4000U & ((((IData)(0x7fffU) 
                                             ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__3__KET____DOT__add_mod____pinNumber1)) 
                                            & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                               << 0xbU)) 
                                           & ((~ ((IData)(this->__PVT__nC1) 
                                                  >> 0xeU)) 
                                              << 0xeU))));
    this->out__out__out31 = ((0x7fffU & (IData)(this->out__out__out31)) 
                             | (0x8000U & ((((IData)(0x7fffU) 
                                             ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__3__KET____DOT__add_mod____pinNumber1)) 
                                            & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                               << 0xcU)) 
                                           & ((~ ((IData)(this->__PVT__nC1) 
                                                  >> 0xfU)) 
                                              << 0xfU))));
    this->out__out = ((((((((((((((((((((((((((((((
                                                   (((IData)(this->out__out__out0) 
                                                     & (IData)(this->out__out__en0)) 
                                                    | ((IData)(this->out__out__out1) 
                                                       & (IData)(this->out__out__en1))) 
                                                   | ((IData)(this->out__out__out2) 
                                                      & (IData)(this->out__out__en2))) 
                                                  | ((IData)(this->out__out__out3) 
                                                     & (IData)(this->out__out__en3))) 
                                                 | ((IData)(this->out__out__out4) 
                                                    & (IData)(this->out__out__en4))) 
                                                | ((IData)(this->out__out__out5) 
                                                   & (IData)(this->out__out__en5))) 
                                               | ((IData)(this->out__out__out6) 
                                                  & (IData)(this->out__out__en6))) 
                                              | ((IData)(this->out__out__out7) 
                                                 & (IData)(this->out__out__en7))) 
                                             | ((IData)(this->out__out__out8) 
                                                & (IData)(this->out__out__en8))) 
                                            | ((IData)(this->out__out__out9) 
                                               & (IData)(this->out__out__en9))) 
                                           | ((IData)(this->out__out__out10) 
                                              & (IData)(this->out__out__en10))) 
                                          | ((IData)(this->out__out__out11) 
                                             & (IData)(this->out__out__en11))) 
                                         | ((IData)(this->out__out__out12) 
                                            & (IData)(this->out__out__en12))) 
                                        | ((IData)(this->out__out__out13) 
                                           & (IData)(this->out__out__en13))) 
                                       | ((IData)(this->out__out__out14) 
                                          & (IData)(this->out__out__en14))) 
                                      | ((IData)(this->out__out__out15) 
                                         & (IData)(this->out__out__en15))) 
                                     | ((IData)(this->out__out__out16) 
                                        & (IData)(this->out__out__en16))) 
                                    | ((IData)(this->out__out__out17) 
                                       & (IData)(this->out__out__en17))) 
                                   | ((IData)(this->out__out__out18) 
                                      & (IData)(this->out__out__en18))) 
                                  | ((IData)(this->out__out__out19) 
                                     & (IData)(this->out__out__en19))) 
                                 | ((IData)(this->out__out__out20) 
                                    & (IData)(this->out__out__en20))) 
                                | ((IData)(this->out__out__out21) 
                                   & (IData)(this->out__out__en21))) 
                               | ((IData)(this->out__out__out22) 
                                  & (IData)(this->out__out__en22))) 
                              | ((IData)(this->out__out__out23) 
                                 & (IData)(this->out__out__en23))) 
                             | ((IData)(this->out__out__out24) 
                                & (IData)(this->out__out__en24))) 
                            | ((IData)(this->out__out__out25) 
                               & (IData)(this->out__out__en25))) 
                           | ((IData)(this->out__out__out26) 
                              & (IData)(this->out__out__en26))) 
                          | ((IData)(this->out__out__out27) 
                             & (IData)(this->out__out__en27))) 
                         | ((IData)(this->out__out__out28) 
                            & (IData)(this->out__out__en28))) 
                        | ((IData)(this->out__out__out29) 
                           & (IData)(this->out__out__en29))) 
                       | ((IData)(this->out__out__out30) 
                          & (IData)(this->out__out__en30))) 
                      | ((IData)(this->out__out__out31) 
                         & (IData)(this->out__out__en31)));
}

VL_INLINE_OPT void Vfu_alu_adder__W10::_settle__TOP__fu_alu__DOT__g2fp_mod__DOT__genblk1__BRA__4__KET____DOT__add_mod__5(Vfu_alu__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+          Vfu_alu_adder__W10::_settle__TOP__fu_alu__DOT__g2fp_mod__DOT__genblk1__BRA__4__KET____DOT__add_mod__5\n"); );
    Vfu_alu* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->out__out__out0 = ((0xfffeU & (IData)(this->out__out__out0)) 
                            | (1U & ((~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__4__KET____DOT__add_mod____pinNumber1)) 
                                     & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                        >> 4U))));
    this->out__out__en0 = (1U & ((~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__4__KET____DOT__add_mod____pinNumber1)) 
                                 & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                    >> 4U)));
    this->out__out__en1 = (1U & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__4__KET____DOT__add_mod____pinNumber1) 
                                 & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                    >> 4U)));
    this->out__out__en2 = (2U & ((0x7ffeU ^ (0xfffffffeU 
                                             & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__4__KET____DOT__add_mod____pinNumber1))) 
                                 & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                    >> 3U)));
    this->out__out__en3 = (2U & (((IData)(0x7fffU) 
                                  ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__4__KET____DOT__add_mod____pinNumber1)) 
                                 & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                    >> 3U)));
    this->out__out__en4 = (4U & ((0x7ffcU ^ (0xfffffffcU 
                                             & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__4__KET____DOT__add_mod____pinNumber1))) 
                                 & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                    >> 2U)));
    this->out__out__en5 = (4U & (((IData)(0x7fffU) 
                                  ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__4__KET____DOT__add_mod____pinNumber1)) 
                                 & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                    >> 2U)));
    this->out__out__en6 = (8U & ((0x7ff8U ^ (0xfffffff8U 
                                             & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__4__KET____DOT__add_mod____pinNumber1))) 
                                 & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                    >> 1U)));
    this->out__out__en7 = (8U & (((IData)(0x7fffU) 
                                  ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__4__KET____DOT__add_mod____pinNumber1)) 
                                 & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                    >> 1U)));
    this->out__out__en8 = (0x10U & ((0x7ff0U ^ (0xfffffff0U 
                                                & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__4__KET____DOT__add_mod____pinNumber1))) 
                                    & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg)));
    this->out__out__en9 = (0x10U & (((IData)(0x7fffU) 
                                     ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__4__KET____DOT__add_mod____pinNumber1)) 
                                    & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg)));
    this->out__out__en10 = (0x20U & ((0x7fe0U ^ (0xffffffe0U 
                                                 & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__4__KET____DOT__add_mod____pinNumber1))) 
                                     & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                        << 1U)));
    this->out__out__en11 = (0x20U & (((IData)(0x7fffU) 
                                      ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__4__KET____DOT__add_mod____pinNumber1)) 
                                     & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                        << 1U)));
    this->out__out__en12 = (0x40U & ((0x7fc0U ^ (0xffffffc0U 
                                                 & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__4__KET____DOT__add_mod____pinNumber1))) 
                                     & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                        << 2U)));
    this->out__out__en13 = (0x40U & (((IData)(0x7fffU) 
                                      ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__4__KET____DOT__add_mod____pinNumber1)) 
                                     & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                        << 2U)));
    this->out__out__en14 = (0x80U & ((0x7f80U ^ (0xffffff80U 
                                                 & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__4__KET____DOT__add_mod____pinNumber1))) 
                                     & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                        << 3U)));
    this->out__out__en15 = (0x80U & (((IData)(0x7fffU) 
                                      ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__4__KET____DOT__add_mod____pinNumber1)) 
                                     & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                        << 3U)));
    this->out__out__en16 = (0x100U & ((0x7f00U ^ (0xffffff00U 
                                                  & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__4__KET____DOT__add_mod____pinNumber1))) 
                                      & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                         << 4U)));
    this->out__out__en17 = (0x100U & (((IData)(0x7fffU) 
                                       ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__4__KET____DOT__add_mod____pinNumber1)) 
                                      & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                         << 4U)));
    this->out__out__en18 = (0x200U & ((0x7e00U ^ (0xfffffe00U 
                                                  & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__4__KET____DOT__add_mod____pinNumber1))) 
                                      & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                         << 5U)));
    this->out__out__en19 = (0x200U & (((IData)(0x7fffU) 
                                       ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__4__KET____DOT__add_mod____pinNumber1)) 
                                      & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                         << 5U)));
    this->out__out__en20 = (0x400U & ((0x7c00U ^ (0xfffffc00U 
                                                  & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__4__KET____DOT__add_mod____pinNumber1))) 
                                      & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                         << 6U)));
    this->out__out__en21 = (0x400U & (((IData)(0x7fffU) 
                                       ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__4__KET____DOT__add_mod____pinNumber1)) 
                                      & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                         << 6U)));
    this->out__out__en22 = (0x800U & ((0x7800U ^ (0xfffff800U 
                                                  & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__4__KET____DOT__add_mod____pinNumber1))) 
                                      & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                         << 7U)));
    this->out__out__en23 = (0x800U & (((IData)(0x7fffU) 
                                       ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__4__KET____DOT__add_mod____pinNumber1)) 
                                      & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                         << 7U)));
    this->out__out__en24 = (0x1000U & ((0x7000U ^ (0xfffff000U 
                                                   & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__4__KET____DOT__add_mod____pinNumber1))) 
                                       & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                          << 8U)));
    this->out__out__en25 = (0x1000U & (((IData)(0x7fffU) 
                                        ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__4__KET____DOT__add_mod____pinNumber1)) 
                                       & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                          << 8U)));
    this->out__out__en26 = (0x2000U & ((0x6000U ^ (0xffffe000U 
                                                   & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__4__KET____DOT__add_mod____pinNumber1))) 
                                       & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                          << 9U)));
    this->out__out__en27 = (0x2000U & (((IData)(0x7fffU) 
                                        ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__4__KET____DOT__add_mod____pinNumber1)) 
                                       & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                          << 9U)));
    this->out__out__en28 = (0x4000U & ((0x4000U ^ (0xffffc000U 
                                                   & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__4__KET____DOT__add_mod____pinNumber1))) 
                                       & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                          << 0xaU)));
    this->out__out__en29 = (0x4000U & (((IData)(0x7fffU) 
                                        ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__4__KET____DOT__add_mod____pinNumber1)) 
                                       & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                          << 0xaU)));
    this->out__out__en30 = (0x8000U & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__4__KET____DOT__add_mod____pinNumber1) 
                                       & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                          << 0xbU)));
    this->out__out__en31 = (0x8000U & (((IData)(0x7fffU) 
                                        ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__4__KET____DOT__add_mod____pinNumber1)) 
                                       & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                          << 0xbU)));
    this->__PVT__G1 = ((0xfffeU & ((~ (((~ (0x3fffU 
                                            | ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__4__KET____DOT__add_mod____pinNumber1) 
                                               >> 1U))) 
                                        | (~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__4__KET____DOT__add_mod____pinNumber1))) 
                                       & (~ (0x3fffU 
                                             & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__4__KET____DOT__add_mod____pinNumber1) 
                                                >> 1U))))) 
                                   << 1U)) | (1U & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__4__KET____DOT__add_mod____pinNumber1)));
    this->__PVT__P1 = (1U | (0xfffeU & (0x7ffeU | (0xfffffffeU 
                                                   & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__4__KET____DOT__add_mod____pinNumber1)))));
    this->out__en = ((((((((((((((((((((((((((((((((IData)(this->out__out__en0) 
                                                   | (IData)(this->out__out__en1)) 
                                                  | (IData)(this->out__out__en2)) 
                                                 | (IData)(this->out__out__en3)) 
                                                | (IData)(this->out__out__en4)) 
                                               | (IData)(this->out__out__en5)) 
                                              | (IData)(this->out__out__en6)) 
                                             | (IData)(this->out__out__en7)) 
                                            | (IData)(this->out__out__en8)) 
                                           | (IData)(this->out__out__en9)) 
                                          | (IData)(this->out__out__en10)) 
                                         | (IData)(this->out__out__en11)) 
                                        | (IData)(this->out__out__en12)) 
                                       | (IData)(this->out__out__en13)) 
                                      | (IData)(this->out__out__en14)) 
                                     | (IData)(this->out__out__en15)) 
                                    | (IData)(this->out__out__en16)) 
                                   | (IData)(this->out__out__en17)) 
                                  | (IData)(this->out__out__en18)) 
                                 | (IData)(this->out__out__en19)) 
                                | (IData)(this->out__out__en20)) 
                               | (IData)(this->out__out__en21)) 
                              | (IData)(this->out__out__en22)) 
                             | (IData)(this->out__out__en23)) 
                            | (IData)(this->out__out__en24)) 
                           | (IData)(this->out__out__en25)) 
                          | (IData)(this->out__out__en26)) 
                         | (IData)(this->out__out__en27)) 
                        | (IData)(this->out__out__en28)) 
                       | (IData)(this->out__out__en29)) 
                      | (IData)(this->out__out__en30)) 
                     | (IData)(this->out__out__en31));
    this->__PVT__nG2 = ((0xfffcU & ((~ ((((IData)(this->__PVT__P1) 
                                          >> 2U) & (IData)(this->__PVT__G1)) 
                                        | ((IData)(this->__PVT__G1) 
                                           >> 2U))) 
                                    << 2U)) | (3U & 
                                               (~ (IData)(this->__PVT__G1))));
    this->__PVT__nP2 = ((0xfffcU & ((~ (((IData)(this->__PVT__P1) 
                                         >> 2U) & (IData)(this->__PVT__P1))) 
                                    << 2U)) | (3U & 
                                               (~ (IData)(this->__PVT__P1))));
    this->__PVT__P3 = ((0xfff0U & ((~ (((IData)(this->__PVT__nP2) 
                                        >> 4U) | (IData)(this->__PVT__nP2))) 
                                   << 4U)) | (0xfU 
                                              & (~ (IData)(this->__PVT__nP2))));
    this->__PVT__G3 = ((0xfff0U & ((~ ((((IData)(this->__PVT__nP2) 
                                         >> 4U) | (IData)(this->__PVT__nG2)) 
                                       & ((IData)(this->__PVT__nG2) 
                                          >> 4U))) 
                                   << 4U)) | (0xfU 
                                              & (~ (IData)(this->__PVT__nG2))));
    this->__PVT__nG4 = ((0xff00U & ((~ ((((IData)(this->__PVT__P3) 
                                          >> 8U) & (IData)(this->__PVT__G3)) 
                                        | ((IData)(this->__PVT__G3) 
                                           >> 8U))) 
                                    << 8U)) | (0xffU 
                                               & (~ (IData)(this->__PVT__G3))));
    this->out__out__out2 = ((0xfffdU & (IData)(this->out__out__out2)) 
                            | (2U & (((0x7ffeU ^ (0xfffffffeU 
                                                  & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__4__KET____DOT__add_mod____pinNumber1))) 
                                      & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                         >> 3U)) & 
                                     ((IData)(this->__PVT__nG4) 
                                      << 1U))));
    this->out__out__out4 = ((0xfffbU & (IData)(this->out__out__out4)) 
                            | (4U & (((0x7ffcU ^ (0xfffffffcU 
                                                  & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__4__KET____DOT__add_mod____pinNumber1))) 
                                      & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                         >> 2U)) & 
                                     ((IData)(this->__PVT__nG4) 
                                      << 1U))));
    this->out__out__out6 = ((0xfff7U & (IData)(this->out__out__out6)) 
                            | (8U & (((0x7ff8U ^ (0xfffffff8U 
                                                  & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__4__KET____DOT__add_mod____pinNumber1))) 
                                      & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                         >> 1U)) & 
                                     ((IData)(this->__PVT__nG4) 
                                      << 1U))));
    this->out__out__out8 = ((0xffefU & (IData)(this->out__out__out8)) 
                            | (0x10U & (((0x7ff0U ^ 
                                          (0xfffffff0U 
                                           & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__4__KET____DOT__add_mod____pinNumber1))) 
                                         & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg)) 
                                        & ((IData)(this->__PVT__nG4) 
                                           << 1U))));
    this->out__out__out10 = ((0xffdfU & (IData)(this->out__out__out10)) 
                             | (0x20U & (((0x7fe0U 
                                           ^ (0xffffffe0U 
                                              & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__4__KET____DOT__add_mod____pinNumber1))) 
                                          & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                             << 1U)) 
                                         & ((IData)(this->__PVT__nG4) 
                                            << 1U))));
    this->out__out__out12 = ((0xffbfU & (IData)(this->out__out__out12)) 
                             | (0x40U & (((0x7fc0U 
                                           ^ (0xffffffc0U 
                                              & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__4__KET____DOT__add_mod____pinNumber1))) 
                                          & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                             << 2U)) 
                                         & ((IData)(this->__PVT__nG4) 
                                            << 1U))));
    this->out__out__out14 = ((0xff7fU & (IData)(this->out__out__out14)) 
                             | (0x80U & (((0x7f80U 
                                           ^ (0xffffff80U 
                                              & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__4__KET____DOT__add_mod____pinNumber1))) 
                                          & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                             << 3U)) 
                                         & ((IData)(this->__PVT__nG4) 
                                            << 1U))));
    this->out__out__out16 = ((0xfeffU & (IData)(this->out__out__out16)) 
                             | (0x100U & (((0x7f00U 
                                            ^ (0xffffff00U 
                                               & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__4__KET____DOT__add_mod____pinNumber1))) 
                                           & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                              << 4U)) 
                                          & ((IData)(this->__PVT__nG4) 
                                             << 1U))));
    this->out__out__out18 = ((0xfdffU & (IData)(this->out__out__out18)) 
                             | (0x200U & (((0x7e00U 
                                            ^ (0xfffffe00U 
                                               & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__4__KET____DOT__add_mod____pinNumber1))) 
                                           & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                              << 5U)) 
                                          & ((IData)(this->__PVT__nG4) 
                                             << 1U))));
    this->out__out__out20 = ((0xfbffU & (IData)(this->out__out__out20)) 
                             | (0x400U & (((0x7c00U 
                                            ^ (0xfffffc00U 
                                               & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__4__KET____DOT__add_mod____pinNumber1))) 
                                           & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                              << 6U)) 
                                          & ((IData)(this->__PVT__nG4) 
                                             << 1U))));
    this->out__out__out22 = ((0xf7ffU & (IData)(this->out__out__out22)) 
                             | (0x800U & (((0x7800U 
                                            ^ (0xfffff800U 
                                               & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__4__KET____DOT__add_mod____pinNumber1))) 
                                           & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                              << 7U)) 
                                          & ((IData)(this->__PVT__nG4) 
                                             << 1U))));
    this->out__out__out24 = ((0xefffU & (IData)(this->out__out__out24)) 
                             | (0x1000U & (((0x7000U 
                                             ^ (0xfffff000U 
                                                & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__4__KET____DOT__add_mod____pinNumber1))) 
                                            & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                               << 8U)) 
                                           & ((IData)(this->__PVT__nG4) 
                                              << 1U))));
    this->out__out__out26 = ((0xdfffU & (IData)(this->out__out__out26)) 
                             | (0x2000U & (((0x6000U 
                                             ^ (0xffffe000U 
                                                & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__4__KET____DOT__add_mod____pinNumber1))) 
                                            & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                               << 9U)) 
                                           & ((IData)(this->__PVT__nG4) 
                                              << 1U))));
    this->out__out__out28 = ((0xbfffU & (IData)(this->out__out__out28)) 
                             | (0x4000U & (((0x4000U 
                                             ^ (0xffffc000U 
                                                & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__4__KET____DOT__add_mod____pinNumber1))) 
                                            & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                               << 0xaU)) 
                                           & ((IData)(this->__PVT__nG4) 
                                              << 1U))));
    this->out__out__out30 = ((0x7fffU & (IData)(this->out__out__out30)) 
                             | (0x8000U & (((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__4__KET____DOT__add_mod____pinNumber1) 
                                            & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                               << 0xbU)) 
                                           & ((IData)(this->__PVT__nG4) 
                                              << 1U))));
    this->__PVT__nC1 = (1U | (0xfffeU & ((IData)(this->__PVT__nG4) 
                                         << 1U)));
    this->out__out__out1 = ((0xfffeU & (IData)(this->out__out__out1)) 
                            | (1U & (((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__4__KET____DOT__add_mod____pinNumber1) 
                                      & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                         >> 4U)) & 
                                     (~ (IData)(this->__PVT__nC1)))));
    this->out__out__out3 = ((0xfffdU & (IData)(this->out__out__out3)) 
                            | (2U & ((((IData)(0x7fffU) 
                                       ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__4__KET____DOT__add_mod____pinNumber1)) 
                                      & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                         >> 3U)) & 
                                     ((~ ((IData)(this->__PVT__nC1) 
                                          >> 1U)) << 1U))));
    this->out__out__out5 = ((0xfffbU & (IData)(this->out__out__out5)) 
                            | (4U & ((((IData)(0x7fffU) 
                                       ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__4__KET____DOT__add_mod____pinNumber1)) 
                                      & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                         >> 2U)) & 
                                     ((~ ((IData)(this->__PVT__nC1) 
                                          >> 2U)) << 2U))));
    this->out__out__out7 = ((0xfff7U & (IData)(this->out__out__out7)) 
                            | (8U & ((((IData)(0x7fffU) 
                                       ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__4__KET____DOT__add_mod____pinNumber1)) 
                                      & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                         >> 1U)) & 
                                     ((~ ((IData)(this->__PVT__nC1) 
                                          >> 3U)) << 3U))));
    this->out__out__out9 = ((0xffefU & (IData)(this->out__out__out9)) 
                            | (0x10U & ((((IData)(0x7fffU) 
                                          ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__4__KET____DOT__add_mod____pinNumber1)) 
                                         & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg)) 
                                        & ((~ ((IData)(this->__PVT__nC1) 
                                               >> 4U)) 
                                           << 4U))));
    this->out__out__out11 = ((0xffdfU & (IData)(this->out__out__out11)) 
                             | (0x20U & ((((IData)(0x7fffU) 
                                           ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__4__KET____DOT__add_mod____pinNumber1)) 
                                          & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                             << 1U)) 
                                         & ((~ ((IData)(this->__PVT__nC1) 
                                                >> 5U)) 
                                            << 5U))));
    this->out__out__out13 = ((0xffbfU & (IData)(this->out__out__out13)) 
                             | (0x40U & ((((IData)(0x7fffU) 
                                           ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__4__KET____DOT__add_mod____pinNumber1)) 
                                          & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                             << 2U)) 
                                         & ((~ ((IData)(this->__PVT__nC1) 
                                                >> 6U)) 
                                            << 6U))));
    this->out__out__out15 = ((0xff7fU & (IData)(this->out__out__out15)) 
                             | (0x80U & ((((IData)(0x7fffU) 
                                           ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__4__KET____DOT__add_mod____pinNumber1)) 
                                          & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                             << 3U)) 
                                         & ((~ ((IData)(this->__PVT__nC1) 
                                                >> 7U)) 
                                            << 7U))));
    this->out__out__out17 = ((0xfeffU & (IData)(this->out__out__out17)) 
                             | (0x100U & ((((IData)(0x7fffU) 
                                            ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__4__KET____DOT__add_mod____pinNumber1)) 
                                           & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                              << 4U)) 
                                          & ((~ ((IData)(this->__PVT__nC1) 
                                                 >> 8U)) 
                                             << 8U))));
    this->out__out__out19 = ((0xfdffU & (IData)(this->out__out__out19)) 
                             | (0x200U & ((((IData)(0x7fffU) 
                                            ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__4__KET____DOT__add_mod____pinNumber1)) 
                                           & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                              << 5U)) 
                                          & ((~ ((IData)(this->__PVT__nC1) 
                                                 >> 9U)) 
                                             << 9U))));
    this->out__out__out21 = ((0xfbffU & (IData)(this->out__out__out21)) 
                             | (0x400U & ((((IData)(0x7fffU) 
                                            ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__4__KET____DOT__add_mod____pinNumber1)) 
                                           & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                              << 6U)) 
                                          & ((~ ((IData)(this->__PVT__nC1) 
                                                 >> 0xaU)) 
                                             << 0xaU))));
    this->out__out__out23 = ((0xf7ffU & (IData)(this->out__out__out23)) 
                             | (0x800U & ((((IData)(0x7fffU) 
                                            ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__4__KET____DOT__add_mod____pinNumber1)) 
                                           & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                              << 7U)) 
                                          & ((~ ((IData)(this->__PVT__nC1) 
                                                 >> 0xbU)) 
                                             << 0xbU))));
    this->out__out__out25 = ((0xefffU & (IData)(this->out__out__out25)) 
                             | (0x1000U & ((((IData)(0x7fffU) 
                                             ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__4__KET____DOT__add_mod____pinNumber1)) 
                                            & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                               << 8U)) 
                                           & ((~ ((IData)(this->__PVT__nC1) 
                                                  >> 0xcU)) 
                                              << 0xcU))));
    this->out__out__out27 = ((0xdfffU & (IData)(this->out__out__out27)) 
                             | (0x2000U & ((((IData)(0x7fffU) 
                                             ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__4__KET____DOT__add_mod____pinNumber1)) 
                                            & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                               << 9U)) 
                                           & ((~ ((IData)(this->__PVT__nC1) 
                                                  >> 0xdU)) 
                                              << 0xdU))));
    this->out__out__out29 = ((0xbfffU & (IData)(this->out__out__out29)) 
                             | (0x4000U & ((((IData)(0x7fffU) 
                                             ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__4__KET____DOT__add_mod____pinNumber1)) 
                                            & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                               << 0xaU)) 
                                           & ((~ ((IData)(this->__PVT__nC1) 
                                                  >> 0xeU)) 
                                              << 0xeU))));
    this->out__out__out31 = ((0x7fffU & (IData)(this->out__out__out31)) 
                             | (0x8000U & ((((IData)(0x7fffU) 
                                             ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__4__KET____DOT__add_mod____pinNumber1)) 
                                            & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                               << 0xbU)) 
                                           & ((~ ((IData)(this->__PVT__nC1) 
                                                  >> 0xfU)) 
                                              << 0xfU))));
    this->out__out = ((((((((((((((((((((((((((((((
                                                   (((IData)(this->out__out__out0) 
                                                     & (IData)(this->out__out__en0)) 
                                                    | ((IData)(this->out__out__out1) 
                                                       & (IData)(this->out__out__en1))) 
                                                   | ((IData)(this->out__out__out2) 
                                                      & (IData)(this->out__out__en2))) 
                                                  | ((IData)(this->out__out__out3) 
                                                     & (IData)(this->out__out__en3))) 
                                                 | ((IData)(this->out__out__out4) 
                                                    & (IData)(this->out__out__en4))) 
                                                | ((IData)(this->out__out__out5) 
                                                   & (IData)(this->out__out__en5))) 
                                               | ((IData)(this->out__out__out6) 
                                                  & (IData)(this->out__out__en6))) 
                                              | ((IData)(this->out__out__out7) 
                                                 & (IData)(this->out__out__en7))) 
                                             | ((IData)(this->out__out__out8) 
                                                & (IData)(this->out__out__en8))) 
                                            | ((IData)(this->out__out__out9) 
                                               & (IData)(this->out__out__en9))) 
                                           | ((IData)(this->out__out__out10) 
                                              & (IData)(this->out__out__en10))) 
                                          | ((IData)(this->out__out__out11) 
                                             & (IData)(this->out__out__en11))) 
                                         | ((IData)(this->out__out__out12) 
                                            & (IData)(this->out__out__en12))) 
                                        | ((IData)(this->out__out__out13) 
                                           & (IData)(this->out__out__en13))) 
                                       | ((IData)(this->out__out__out14) 
                                          & (IData)(this->out__out__en14))) 
                                      | ((IData)(this->out__out__out15) 
                                         & (IData)(this->out__out__en15))) 
                                     | ((IData)(this->out__out__out16) 
                                        & (IData)(this->out__out__en16))) 
                                    | ((IData)(this->out__out__out17) 
                                       & (IData)(this->out__out__en17))) 
                                   | ((IData)(this->out__out__out18) 
                                      & (IData)(this->out__out__en18))) 
                                  | ((IData)(this->out__out__out19) 
                                     & (IData)(this->out__out__en19))) 
                                 | ((IData)(this->out__out__out20) 
                                    & (IData)(this->out__out__en20))) 
                                | ((IData)(this->out__out__out21) 
                                   & (IData)(this->out__out__en21))) 
                               | ((IData)(this->out__out__out22) 
                                  & (IData)(this->out__out__en22))) 
                              | ((IData)(this->out__out__out23) 
                                 & (IData)(this->out__out__en23))) 
                             | ((IData)(this->out__out__out24) 
                                & (IData)(this->out__out__en24))) 
                            | ((IData)(this->out__out__out25) 
                               & (IData)(this->out__out__en25))) 
                           | ((IData)(this->out__out__out26) 
                              & (IData)(this->out__out__en26))) 
                          | ((IData)(this->out__out__out27) 
                             & (IData)(this->out__out__en27))) 
                         | ((IData)(this->out__out__out28) 
                            & (IData)(this->out__out__en28))) 
                        | ((IData)(this->out__out__out29) 
                           & (IData)(this->out__out__en29))) 
                       | ((IData)(this->out__out__out30) 
                          & (IData)(this->out__out__en30))) 
                      | ((IData)(this->out__out__out31) 
                         & (IData)(this->out__out__en31)));
}

VL_INLINE_OPT void Vfu_alu_adder__W10::_settle__TOP__fu_alu__DOT__g2fp_mod__DOT__genblk1__BRA__5__KET____DOT__add_mod__6(Vfu_alu__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+          Vfu_alu_adder__W10::_settle__TOP__fu_alu__DOT__g2fp_mod__DOT__genblk1__BRA__5__KET____DOT__add_mod__6\n"); );
    Vfu_alu* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->out__out__out0 = ((0xfffeU & (IData)(this->out__out__out0)) 
                            | (1U & ((~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__5__KET____DOT__add_mod____pinNumber1)) 
                                     & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                        >> 5U))));
    this->out__out__en0 = (1U & ((~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__5__KET____DOT__add_mod____pinNumber1)) 
                                 & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                    >> 5U)));
    this->out__out__en1 = (1U & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__5__KET____DOT__add_mod____pinNumber1) 
                                 & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                    >> 5U)));
    this->out__out__en2 = (2U & ((0x7ffeU ^ (0xfffffffeU 
                                             & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__5__KET____DOT__add_mod____pinNumber1))) 
                                 & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                    >> 4U)));
    this->out__out__en3 = (2U & (((IData)(0x7fffU) 
                                  ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__5__KET____DOT__add_mod____pinNumber1)) 
                                 & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                    >> 4U)));
    this->out__out__en4 = (4U & ((0x7ffcU ^ (0xfffffffcU 
                                             & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__5__KET____DOT__add_mod____pinNumber1))) 
                                 & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                    >> 3U)));
    this->out__out__en5 = (4U & (((IData)(0x7fffU) 
                                  ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__5__KET____DOT__add_mod____pinNumber1)) 
                                 & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                    >> 3U)));
    this->out__out__en6 = (8U & ((0x7ff8U ^ (0xfffffff8U 
                                             & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__5__KET____DOT__add_mod____pinNumber1))) 
                                 & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                    >> 2U)));
    this->out__out__en7 = (8U & (((IData)(0x7fffU) 
                                  ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__5__KET____DOT__add_mod____pinNumber1)) 
                                 & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                    >> 2U)));
    this->out__out__en8 = (0x10U & ((0x7ff0U ^ (0xfffffff0U 
                                                & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__5__KET____DOT__add_mod____pinNumber1))) 
                                    & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                       >> 1U)));
    this->out__out__en9 = (0x10U & (((IData)(0x7fffU) 
                                     ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__5__KET____DOT__add_mod____pinNumber1)) 
                                    & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                       >> 1U)));
    this->out__out__en10 = (0x20U & ((0x7fe0U ^ (0xffffffe0U 
                                                 & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__5__KET____DOT__add_mod____pinNumber1))) 
                                     & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg)));
    this->out__out__en11 = (0x20U & (((IData)(0x7fffU) 
                                      ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__5__KET____DOT__add_mod____pinNumber1)) 
                                     & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg)));
    this->out__out__en12 = (0x40U & ((0x7fc0U ^ (0xffffffc0U 
                                                 & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__5__KET____DOT__add_mod____pinNumber1))) 
                                     & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                        << 1U)));
    this->out__out__en13 = (0x40U & (((IData)(0x7fffU) 
                                      ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__5__KET____DOT__add_mod____pinNumber1)) 
                                     & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                        << 1U)));
    this->out__out__en14 = (0x80U & ((0x7f80U ^ (0xffffff80U 
                                                 & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__5__KET____DOT__add_mod____pinNumber1))) 
                                     & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                        << 2U)));
    this->out__out__en15 = (0x80U & (((IData)(0x7fffU) 
                                      ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__5__KET____DOT__add_mod____pinNumber1)) 
                                     & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                        << 2U)));
    this->out__out__en16 = (0x100U & ((0x7f00U ^ (0xffffff00U 
                                                  & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__5__KET____DOT__add_mod____pinNumber1))) 
                                      & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                         << 3U)));
    this->out__out__en17 = (0x100U & (((IData)(0x7fffU) 
                                       ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__5__KET____DOT__add_mod____pinNumber1)) 
                                      & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                         << 3U)));
    this->out__out__en18 = (0x200U & ((0x7e00U ^ (0xfffffe00U 
                                                  & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__5__KET____DOT__add_mod____pinNumber1))) 
                                      & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                         << 4U)));
    this->out__out__en19 = (0x200U & (((IData)(0x7fffU) 
                                       ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__5__KET____DOT__add_mod____pinNumber1)) 
                                      & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                         << 4U)));
    this->out__out__en20 = (0x400U & ((0x7c00U ^ (0xfffffc00U 
                                                  & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__5__KET____DOT__add_mod____pinNumber1))) 
                                      & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                         << 5U)));
    this->out__out__en21 = (0x400U & (((IData)(0x7fffU) 
                                       ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__5__KET____DOT__add_mod____pinNumber1)) 
                                      & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                         << 5U)));
    this->out__out__en22 = (0x800U & ((0x7800U ^ (0xfffff800U 
                                                  & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__5__KET____DOT__add_mod____pinNumber1))) 
                                      & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                         << 6U)));
    this->out__out__en23 = (0x800U & (((IData)(0x7fffU) 
                                       ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__5__KET____DOT__add_mod____pinNumber1)) 
                                      & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                         << 6U)));
    this->out__out__en24 = (0x1000U & ((0x7000U ^ (0xfffff000U 
                                                   & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__5__KET____DOT__add_mod____pinNumber1))) 
                                       & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                          << 7U)));
    this->out__out__en25 = (0x1000U & (((IData)(0x7fffU) 
                                        ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__5__KET____DOT__add_mod____pinNumber1)) 
                                       & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                          << 7U)));
    this->out__out__en26 = (0x2000U & ((0x6000U ^ (0xffffe000U 
                                                   & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__5__KET____DOT__add_mod____pinNumber1))) 
                                       & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                          << 8U)));
    this->out__out__en27 = (0x2000U & (((IData)(0x7fffU) 
                                        ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__5__KET____DOT__add_mod____pinNumber1)) 
                                       & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                          << 8U)));
    this->out__out__en28 = (0x4000U & ((0x4000U ^ (0xffffc000U 
                                                   & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__5__KET____DOT__add_mod____pinNumber1))) 
                                       & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                          << 9U)));
    this->out__out__en29 = (0x4000U & (((IData)(0x7fffU) 
                                        ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__5__KET____DOT__add_mod____pinNumber1)) 
                                       & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                          << 9U)));
    this->out__out__en30 = (0x8000U & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__5__KET____DOT__add_mod____pinNumber1) 
                                       & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                          << 0xaU)));
    this->out__out__en31 = (0x8000U & (((IData)(0x7fffU) 
                                        ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__5__KET____DOT__add_mod____pinNumber1)) 
                                       & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                          << 0xaU)));
    this->__PVT__G1 = ((0xfffeU & ((~ (((~ (0x3fffU 
                                            | ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__5__KET____DOT__add_mod____pinNumber1) 
                                               >> 1U))) 
                                        | (~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__5__KET____DOT__add_mod____pinNumber1))) 
                                       & (~ (0x3fffU 
                                             & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__5__KET____DOT__add_mod____pinNumber1) 
                                                >> 1U))))) 
                                   << 1U)) | (1U & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__5__KET____DOT__add_mod____pinNumber1)));
    this->__PVT__P1 = (1U | (0xfffeU & (0x7ffeU | (0xfffffffeU 
                                                   & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__5__KET____DOT__add_mod____pinNumber1)))));
    this->out__en = ((((((((((((((((((((((((((((((((IData)(this->out__out__en0) 
                                                   | (IData)(this->out__out__en1)) 
                                                  | (IData)(this->out__out__en2)) 
                                                 | (IData)(this->out__out__en3)) 
                                                | (IData)(this->out__out__en4)) 
                                               | (IData)(this->out__out__en5)) 
                                              | (IData)(this->out__out__en6)) 
                                             | (IData)(this->out__out__en7)) 
                                            | (IData)(this->out__out__en8)) 
                                           | (IData)(this->out__out__en9)) 
                                          | (IData)(this->out__out__en10)) 
                                         | (IData)(this->out__out__en11)) 
                                        | (IData)(this->out__out__en12)) 
                                       | (IData)(this->out__out__en13)) 
                                      | (IData)(this->out__out__en14)) 
                                     | (IData)(this->out__out__en15)) 
                                    | (IData)(this->out__out__en16)) 
                                   | (IData)(this->out__out__en17)) 
                                  | (IData)(this->out__out__en18)) 
                                 | (IData)(this->out__out__en19)) 
                                | (IData)(this->out__out__en20)) 
                               | (IData)(this->out__out__en21)) 
                              | (IData)(this->out__out__en22)) 
                             | (IData)(this->out__out__en23)) 
                            | (IData)(this->out__out__en24)) 
                           | (IData)(this->out__out__en25)) 
                          | (IData)(this->out__out__en26)) 
                         | (IData)(this->out__out__en27)) 
                        | (IData)(this->out__out__en28)) 
                       | (IData)(this->out__out__en29)) 
                      | (IData)(this->out__out__en30)) 
                     | (IData)(this->out__out__en31));
    this->__PVT__nG2 = ((0xfffcU & ((~ ((((IData)(this->__PVT__P1) 
                                          >> 2U) & (IData)(this->__PVT__G1)) 
                                        | ((IData)(this->__PVT__G1) 
                                           >> 2U))) 
                                    << 2U)) | (3U & 
                                               (~ (IData)(this->__PVT__G1))));
    this->__PVT__nP2 = ((0xfffcU & ((~ (((IData)(this->__PVT__P1) 
                                         >> 2U) & (IData)(this->__PVT__P1))) 
                                    << 2U)) | (3U & 
                                               (~ (IData)(this->__PVT__P1))));
    this->__PVT__P3 = ((0xfff0U & ((~ (((IData)(this->__PVT__nP2) 
                                        >> 4U) | (IData)(this->__PVT__nP2))) 
                                   << 4U)) | (0xfU 
                                              & (~ (IData)(this->__PVT__nP2))));
    this->__PVT__G3 = ((0xfff0U & ((~ ((((IData)(this->__PVT__nP2) 
                                         >> 4U) | (IData)(this->__PVT__nG2)) 
                                       & ((IData)(this->__PVT__nG2) 
                                          >> 4U))) 
                                   << 4U)) | (0xfU 
                                              & (~ (IData)(this->__PVT__nG2))));
    this->__PVT__nG4 = ((0xff00U & ((~ ((((IData)(this->__PVT__P3) 
                                          >> 8U) & (IData)(this->__PVT__G3)) 
                                        | ((IData)(this->__PVT__G3) 
                                           >> 8U))) 
                                    << 8U)) | (0xffU 
                                               & (~ (IData)(this->__PVT__G3))));
    this->out__out__out2 = ((0xfffdU & (IData)(this->out__out__out2)) 
                            | (2U & (((0x7ffeU ^ (0xfffffffeU 
                                                  & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__5__KET____DOT__add_mod____pinNumber1))) 
                                      & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                         >> 4U)) & 
                                     ((IData)(this->__PVT__nG4) 
                                      << 1U))));
    this->out__out__out4 = ((0xfffbU & (IData)(this->out__out__out4)) 
                            | (4U & (((0x7ffcU ^ (0xfffffffcU 
                                                  & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__5__KET____DOT__add_mod____pinNumber1))) 
                                      & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                         >> 3U)) & 
                                     ((IData)(this->__PVT__nG4) 
                                      << 1U))));
    this->out__out__out6 = ((0xfff7U & (IData)(this->out__out__out6)) 
                            | (8U & (((0x7ff8U ^ (0xfffffff8U 
                                                  & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__5__KET____DOT__add_mod____pinNumber1))) 
                                      & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                         >> 2U)) & 
                                     ((IData)(this->__PVT__nG4) 
                                      << 1U))));
    this->out__out__out8 = ((0xffefU & (IData)(this->out__out__out8)) 
                            | (0x10U & (((0x7ff0U ^ 
                                          (0xfffffff0U 
                                           & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__5__KET____DOT__add_mod____pinNumber1))) 
                                         & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                            >> 1U)) 
                                        & ((IData)(this->__PVT__nG4) 
                                           << 1U))));
    this->out__out__out10 = ((0xffdfU & (IData)(this->out__out__out10)) 
                             | (0x20U & (((0x7fe0U 
                                           ^ (0xffffffe0U 
                                              & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__5__KET____DOT__add_mod____pinNumber1))) 
                                          & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg)) 
                                         & ((IData)(this->__PVT__nG4) 
                                            << 1U))));
    this->out__out__out12 = ((0xffbfU & (IData)(this->out__out__out12)) 
                             | (0x40U & (((0x7fc0U 
                                           ^ (0xffffffc0U 
                                              & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__5__KET____DOT__add_mod____pinNumber1))) 
                                          & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                             << 1U)) 
                                         & ((IData)(this->__PVT__nG4) 
                                            << 1U))));
    this->out__out__out14 = ((0xff7fU & (IData)(this->out__out__out14)) 
                             | (0x80U & (((0x7f80U 
                                           ^ (0xffffff80U 
                                              & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__5__KET____DOT__add_mod____pinNumber1))) 
                                          & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                             << 2U)) 
                                         & ((IData)(this->__PVT__nG4) 
                                            << 1U))));
    this->out__out__out16 = ((0xfeffU & (IData)(this->out__out__out16)) 
                             | (0x100U & (((0x7f00U 
                                            ^ (0xffffff00U 
                                               & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__5__KET____DOT__add_mod____pinNumber1))) 
                                           & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                              << 3U)) 
                                          & ((IData)(this->__PVT__nG4) 
                                             << 1U))));
    this->out__out__out18 = ((0xfdffU & (IData)(this->out__out__out18)) 
                             | (0x200U & (((0x7e00U 
                                            ^ (0xfffffe00U 
                                               & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__5__KET____DOT__add_mod____pinNumber1))) 
                                           & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                              << 4U)) 
                                          & ((IData)(this->__PVT__nG4) 
                                             << 1U))));
    this->out__out__out20 = ((0xfbffU & (IData)(this->out__out__out20)) 
                             | (0x400U & (((0x7c00U 
                                            ^ (0xfffffc00U 
                                               & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__5__KET____DOT__add_mod____pinNumber1))) 
                                           & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                              << 5U)) 
                                          & ((IData)(this->__PVT__nG4) 
                                             << 1U))));
    this->out__out__out22 = ((0xf7ffU & (IData)(this->out__out__out22)) 
                             | (0x800U & (((0x7800U 
                                            ^ (0xfffff800U 
                                               & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__5__KET____DOT__add_mod____pinNumber1))) 
                                           & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                              << 6U)) 
                                          & ((IData)(this->__PVT__nG4) 
                                             << 1U))));
    this->out__out__out24 = ((0xefffU & (IData)(this->out__out__out24)) 
                             | (0x1000U & (((0x7000U 
                                             ^ (0xfffff000U 
                                                & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__5__KET____DOT__add_mod____pinNumber1))) 
                                            & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                               << 7U)) 
                                           & ((IData)(this->__PVT__nG4) 
                                              << 1U))));
    this->out__out__out26 = ((0xdfffU & (IData)(this->out__out__out26)) 
                             | (0x2000U & (((0x6000U 
                                             ^ (0xffffe000U 
                                                & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__5__KET____DOT__add_mod____pinNumber1))) 
                                            & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                               << 8U)) 
                                           & ((IData)(this->__PVT__nG4) 
                                              << 1U))));
    this->out__out__out28 = ((0xbfffU & (IData)(this->out__out__out28)) 
                             | (0x4000U & (((0x4000U 
                                             ^ (0xffffc000U 
                                                & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__5__KET____DOT__add_mod____pinNumber1))) 
                                            & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                               << 9U)) 
                                           & ((IData)(this->__PVT__nG4) 
                                              << 1U))));
    this->out__out__out30 = ((0x7fffU & (IData)(this->out__out__out30)) 
                             | (0x8000U & (((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__5__KET____DOT__add_mod____pinNumber1) 
                                            & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                               << 0xaU)) 
                                           & ((IData)(this->__PVT__nG4) 
                                              << 1U))));
    this->__PVT__nC1 = (1U | (0xfffeU & ((IData)(this->__PVT__nG4) 
                                         << 1U)));
    this->out__out__out1 = ((0xfffeU & (IData)(this->out__out__out1)) 
                            | (1U & (((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__5__KET____DOT__add_mod____pinNumber1) 
                                      & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                         >> 5U)) & 
                                     (~ (IData)(this->__PVT__nC1)))));
    this->out__out__out3 = ((0xfffdU & (IData)(this->out__out__out3)) 
                            | (2U & ((((IData)(0x7fffU) 
                                       ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__5__KET____DOT__add_mod____pinNumber1)) 
                                      & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                         >> 4U)) & 
                                     ((~ ((IData)(this->__PVT__nC1) 
                                          >> 1U)) << 1U))));
    this->out__out__out5 = ((0xfffbU & (IData)(this->out__out__out5)) 
                            | (4U & ((((IData)(0x7fffU) 
                                       ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__5__KET____DOT__add_mod____pinNumber1)) 
                                      & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                         >> 3U)) & 
                                     ((~ ((IData)(this->__PVT__nC1) 
                                          >> 2U)) << 2U))));
    this->out__out__out7 = ((0xfff7U & (IData)(this->out__out__out7)) 
                            | (8U & ((((IData)(0x7fffU) 
                                       ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__5__KET____DOT__add_mod____pinNumber1)) 
                                      & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                         >> 2U)) & 
                                     ((~ ((IData)(this->__PVT__nC1) 
                                          >> 3U)) << 3U))));
    this->out__out__out9 = ((0xffefU & (IData)(this->out__out__out9)) 
                            | (0x10U & ((((IData)(0x7fffU) 
                                          ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__5__KET____DOT__add_mod____pinNumber1)) 
                                         & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                            >> 1U)) 
                                        & ((~ ((IData)(this->__PVT__nC1) 
                                               >> 4U)) 
                                           << 4U))));
    this->out__out__out11 = ((0xffdfU & (IData)(this->out__out__out11)) 
                             | (0x20U & ((((IData)(0x7fffU) 
                                           ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__5__KET____DOT__add_mod____pinNumber1)) 
                                          & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg)) 
                                         & ((~ ((IData)(this->__PVT__nC1) 
                                                >> 5U)) 
                                            << 5U))));
    this->out__out__out13 = ((0xffbfU & (IData)(this->out__out__out13)) 
                             | (0x40U & ((((IData)(0x7fffU) 
                                           ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__5__KET____DOT__add_mod____pinNumber1)) 
                                          & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                             << 1U)) 
                                         & ((~ ((IData)(this->__PVT__nC1) 
                                                >> 6U)) 
                                            << 6U))));
    this->out__out__out15 = ((0xff7fU & (IData)(this->out__out__out15)) 
                             | (0x80U & ((((IData)(0x7fffU) 
                                           ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__5__KET____DOT__add_mod____pinNumber1)) 
                                          & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                             << 2U)) 
                                         & ((~ ((IData)(this->__PVT__nC1) 
                                                >> 7U)) 
                                            << 7U))));
    this->out__out__out17 = ((0xfeffU & (IData)(this->out__out__out17)) 
                             | (0x100U & ((((IData)(0x7fffU) 
                                            ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__5__KET____DOT__add_mod____pinNumber1)) 
                                           & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                              << 3U)) 
                                          & ((~ ((IData)(this->__PVT__nC1) 
                                                 >> 8U)) 
                                             << 8U))));
    this->out__out__out19 = ((0xfdffU & (IData)(this->out__out__out19)) 
                             | (0x200U & ((((IData)(0x7fffU) 
                                            ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__5__KET____DOT__add_mod____pinNumber1)) 
                                           & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                              << 4U)) 
                                          & ((~ ((IData)(this->__PVT__nC1) 
                                                 >> 9U)) 
                                             << 9U))));
    this->out__out__out21 = ((0xfbffU & (IData)(this->out__out__out21)) 
                             | (0x400U & ((((IData)(0x7fffU) 
                                            ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__5__KET____DOT__add_mod____pinNumber1)) 
                                           & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                              << 5U)) 
                                          & ((~ ((IData)(this->__PVT__nC1) 
                                                 >> 0xaU)) 
                                             << 0xaU))));
    this->out__out__out23 = ((0xf7ffU & (IData)(this->out__out__out23)) 
                             | (0x800U & ((((IData)(0x7fffU) 
                                            ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__5__KET____DOT__add_mod____pinNumber1)) 
                                           & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                              << 6U)) 
                                          & ((~ ((IData)(this->__PVT__nC1) 
                                                 >> 0xbU)) 
                                             << 0xbU))));
    this->out__out__out25 = ((0xefffU & (IData)(this->out__out__out25)) 
                             | (0x1000U & ((((IData)(0x7fffU) 
                                             ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__5__KET____DOT__add_mod____pinNumber1)) 
                                            & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                               << 7U)) 
                                           & ((~ ((IData)(this->__PVT__nC1) 
                                                  >> 0xcU)) 
                                              << 0xcU))));
    this->out__out__out27 = ((0xdfffU & (IData)(this->out__out__out27)) 
                             | (0x2000U & ((((IData)(0x7fffU) 
                                             ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__5__KET____DOT__add_mod____pinNumber1)) 
                                            & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                               << 8U)) 
                                           & ((~ ((IData)(this->__PVT__nC1) 
                                                  >> 0xdU)) 
                                              << 0xdU))));
    this->out__out__out29 = ((0xbfffU & (IData)(this->out__out__out29)) 
                             | (0x4000U & ((((IData)(0x7fffU) 
                                             ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__5__KET____DOT__add_mod____pinNumber1)) 
                                            & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                               << 9U)) 
                                           & ((~ ((IData)(this->__PVT__nC1) 
                                                  >> 0xeU)) 
                                              << 0xeU))));
    this->out__out__out31 = ((0x7fffU & (IData)(this->out__out__out31)) 
                             | (0x8000U & ((((IData)(0x7fffU) 
                                             ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__5__KET____DOT__add_mod____pinNumber1)) 
                                            & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                               << 0xaU)) 
                                           & ((~ ((IData)(this->__PVT__nC1) 
                                                  >> 0xfU)) 
                                              << 0xfU))));
    this->out__out = ((((((((((((((((((((((((((((((
                                                   (((IData)(this->out__out__out0) 
                                                     & (IData)(this->out__out__en0)) 
                                                    | ((IData)(this->out__out__out1) 
                                                       & (IData)(this->out__out__en1))) 
                                                   | ((IData)(this->out__out__out2) 
                                                      & (IData)(this->out__out__en2))) 
                                                  | ((IData)(this->out__out__out3) 
                                                     & (IData)(this->out__out__en3))) 
                                                 | ((IData)(this->out__out__out4) 
                                                    & (IData)(this->out__out__en4))) 
                                                | ((IData)(this->out__out__out5) 
                                                   & (IData)(this->out__out__en5))) 
                                               | ((IData)(this->out__out__out6) 
                                                  & (IData)(this->out__out__en6))) 
                                              | ((IData)(this->out__out__out7) 
                                                 & (IData)(this->out__out__en7))) 
                                             | ((IData)(this->out__out__out8) 
                                                & (IData)(this->out__out__en8))) 
                                            | ((IData)(this->out__out__out9) 
                                               & (IData)(this->out__out__en9))) 
                                           | ((IData)(this->out__out__out10) 
                                              & (IData)(this->out__out__en10))) 
                                          | ((IData)(this->out__out__out11) 
                                             & (IData)(this->out__out__en11))) 
                                         | ((IData)(this->out__out__out12) 
                                            & (IData)(this->out__out__en12))) 
                                        | ((IData)(this->out__out__out13) 
                                           & (IData)(this->out__out__en13))) 
                                       | ((IData)(this->out__out__out14) 
                                          & (IData)(this->out__out__en14))) 
                                      | ((IData)(this->out__out__out15) 
                                         & (IData)(this->out__out__en15))) 
                                     | ((IData)(this->out__out__out16) 
                                        & (IData)(this->out__out__en16))) 
                                    | ((IData)(this->out__out__out17) 
                                       & (IData)(this->out__out__en17))) 
                                   | ((IData)(this->out__out__out18) 
                                      & (IData)(this->out__out__en18))) 
                                  | ((IData)(this->out__out__out19) 
                                     & (IData)(this->out__out__en19))) 
                                 | ((IData)(this->out__out__out20) 
                                    & (IData)(this->out__out__en20))) 
                                | ((IData)(this->out__out__out21) 
                                   & (IData)(this->out__out__en21))) 
                               | ((IData)(this->out__out__out22) 
                                  & (IData)(this->out__out__en22))) 
                              | ((IData)(this->out__out__out23) 
                                 & (IData)(this->out__out__en23))) 
                             | ((IData)(this->out__out__out24) 
                                & (IData)(this->out__out__en24))) 
                            | ((IData)(this->out__out__out25) 
                               & (IData)(this->out__out__en25))) 
                           | ((IData)(this->out__out__out26) 
                              & (IData)(this->out__out__en26))) 
                          | ((IData)(this->out__out__out27) 
                             & (IData)(this->out__out__en27))) 
                         | ((IData)(this->out__out__out28) 
                            & (IData)(this->out__out__en28))) 
                        | ((IData)(this->out__out__out29) 
                           & (IData)(this->out__out__en29))) 
                       | ((IData)(this->out__out__out30) 
                          & (IData)(this->out__out__en30))) 
                      | ((IData)(this->out__out__out31) 
                         & (IData)(this->out__out__en31)));
}

VL_INLINE_OPT void Vfu_alu_adder__W10::_settle__TOP__fu_alu__DOT__g2fp_mod__DOT__genblk1__BRA__6__KET____DOT__add_mod__7(Vfu_alu__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+          Vfu_alu_adder__W10::_settle__TOP__fu_alu__DOT__g2fp_mod__DOT__genblk1__BRA__6__KET____DOT__add_mod__7\n"); );
    Vfu_alu* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->out__out__out0 = ((0xfffeU & (IData)(this->out__out__out0)) 
                            | (1U & ((~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__6__KET____DOT__add_mod____pinNumber1)) 
                                     & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                        >> 6U))));
    this->out__out__en0 = (1U & ((~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__6__KET____DOT__add_mod____pinNumber1)) 
                                 & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                    >> 6U)));
    this->out__out__en1 = (1U & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__6__KET____DOT__add_mod____pinNumber1) 
                                 & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                    >> 6U)));
    this->out__out__en2 = (2U & ((0x7ffeU ^ (0xfffffffeU 
                                             & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__6__KET____DOT__add_mod____pinNumber1))) 
                                 & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                    >> 5U)));
    this->out__out__en3 = (2U & (((IData)(0x7fffU) 
                                  ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__6__KET____DOT__add_mod____pinNumber1)) 
                                 & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                    >> 5U)));
    this->out__out__en4 = (4U & ((0x7ffcU ^ (0xfffffffcU 
                                             & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__6__KET____DOT__add_mod____pinNumber1))) 
                                 & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                    >> 4U)));
    this->out__out__en5 = (4U & (((IData)(0x7fffU) 
                                  ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__6__KET____DOT__add_mod____pinNumber1)) 
                                 & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                    >> 4U)));
    this->out__out__en6 = (8U & ((0x7ff8U ^ (0xfffffff8U 
                                             & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__6__KET____DOT__add_mod____pinNumber1))) 
                                 & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                    >> 3U)));
    this->out__out__en7 = (8U & (((IData)(0x7fffU) 
                                  ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__6__KET____DOT__add_mod____pinNumber1)) 
                                 & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                    >> 3U)));
    this->out__out__en8 = (0x10U & ((0x7ff0U ^ (0xfffffff0U 
                                                & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__6__KET____DOT__add_mod____pinNumber1))) 
                                    & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                       >> 2U)));
    this->out__out__en9 = (0x10U & (((IData)(0x7fffU) 
                                     ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__6__KET____DOT__add_mod____pinNumber1)) 
                                    & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                       >> 2U)));
    this->out__out__en10 = (0x20U & ((0x7fe0U ^ (0xffffffe0U 
                                                 & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__6__KET____DOT__add_mod____pinNumber1))) 
                                     & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                        >> 1U)));
    this->out__out__en11 = (0x20U & (((IData)(0x7fffU) 
                                      ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__6__KET____DOT__add_mod____pinNumber1)) 
                                     & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                        >> 1U)));
    this->out__out__en12 = (0x40U & ((0x7fc0U ^ (0xffffffc0U 
                                                 & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__6__KET____DOT__add_mod____pinNumber1))) 
                                     & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg)));
    this->out__out__en13 = (0x40U & (((IData)(0x7fffU) 
                                      ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__6__KET____DOT__add_mod____pinNumber1)) 
                                     & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg)));
    this->out__out__en14 = (0x80U & ((0x7f80U ^ (0xffffff80U 
                                                 & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__6__KET____DOT__add_mod____pinNumber1))) 
                                     & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                        << 1U)));
    this->out__out__en15 = (0x80U & (((IData)(0x7fffU) 
                                      ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__6__KET____DOT__add_mod____pinNumber1)) 
                                     & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                        << 1U)));
    this->out__out__en16 = (0x100U & ((0x7f00U ^ (0xffffff00U 
                                                  & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__6__KET____DOT__add_mod____pinNumber1))) 
                                      & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                         << 2U)));
    this->out__out__en17 = (0x100U & (((IData)(0x7fffU) 
                                       ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__6__KET____DOT__add_mod____pinNumber1)) 
                                      & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                         << 2U)));
    this->out__out__en18 = (0x200U & ((0x7e00U ^ (0xfffffe00U 
                                                  & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__6__KET____DOT__add_mod____pinNumber1))) 
                                      & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                         << 3U)));
    this->out__out__en19 = (0x200U & (((IData)(0x7fffU) 
                                       ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__6__KET____DOT__add_mod____pinNumber1)) 
                                      & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                         << 3U)));
    this->out__out__en20 = (0x400U & ((0x7c00U ^ (0xfffffc00U 
                                                  & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__6__KET____DOT__add_mod____pinNumber1))) 
                                      & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                         << 4U)));
    this->out__out__en21 = (0x400U & (((IData)(0x7fffU) 
                                       ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__6__KET____DOT__add_mod____pinNumber1)) 
                                      & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                         << 4U)));
    this->out__out__en22 = (0x800U & ((0x7800U ^ (0xfffff800U 
                                                  & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__6__KET____DOT__add_mod____pinNumber1))) 
                                      & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                         << 5U)));
    this->out__out__en23 = (0x800U & (((IData)(0x7fffU) 
                                       ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__6__KET____DOT__add_mod____pinNumber1)) 
                                      & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                         << 5U)));
    this->out__out__en24 = (0x1000U & ((0x7000U ^ (0xfffff000U 
                                                   & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__6__KET____DOT__add_mod____pinNumber1))) 
                                       & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                          << 6U)));
    this->out__out__en25 = (0x1000U & (((IData)(0x7fffU) 
                                        ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__6__KET____DOT__add_mod____pinNumber1)) 
                                       & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                          << 6U)));
    this->out__out__en26 = (0x2000U & ((0x6000U ^ (0xffffe000U 
                                                   & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__6__KET____DOT__add_mod____pinNumber1))) 
                                       & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                          << 7U)));
    this->out__out__en27 = (0x2000U & (((IData)(0x7fffU) 
                                        ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__6__KET____DOT__add_mod____pinNumber1)) 
                                       & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                          << 7U)));
    this->out__out__en28 = (0x4000U & ((0x4000U ^ (0xffffc000U 
                                                   & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__6__KET____DOT__add_mod____pinNumber1))) 
                                       & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                          << 8U)));
    this->out__out__en29 = (0x4000U & (((IData)(0x7fffU) 
                                        ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__6__KET____DOT__add_mod____pinNumber1)) 
                                       & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                          << 8U)));
    this->out__out__en30 = (0x8000U & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__6__KET____DOT__add_mod____pinNumber1) 
                                       & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                          << 9U)));
    this->out__out__en31 = (0x8000U & (((IData)(0x7fffU) 
                                        ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__6__KET____DOT__add_mod____pinNumber1)) 
                                       & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                          << 9U)));
    this->__PVT__G1 = ((0xfffeU & ((~ (((~ (0x3fffU 
                                            | ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__6__KET____DOT__add_mod____pinNumber1) 
                                               >> 1U))) 
                                        | (~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__6__KET____DOT__add_mod____pinNumber1))) 
                                       & (~ (0x3fffU 
                                             & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__6__KET____DOT__add_mod____pinNumber1) 
                                                >> 1U))))) 
                                   << 1U)) | (1U & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__6__KET____DOT__add_mod____pinNumber1)));
    this->__PVT__P1 = (1U | (0xfffeU & (0x7ffeU | (0xfffffffeU 
                                                   & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__6__KET____DOT__add_mod____pinNumber1)))));
    this->out__en = ((((((((((((((((((((((((((((((((IData)(this->out__out__en0) 
                                                   | (IData)(this->out__out__en1)) 
                                                  | (IData)(this->out__out__en2)) 
                                                 | (IData)(this->out__out__en3)) 
                                                | (IData)(this->out__out__en4)) 
                                               | (IData)(this->out__out__en5)) 
                                              | (IData)(this->out__out__en6)) 
                                             | (IData)(this->out__out__en7)) 
                                            | (IData)(this->out__out__en8)) 
                                           | (IData)(this->out__out__en9)) 
                                          | (IData)(this->out__out__en10)) 
                                         | (IData)(this->out__out__en11)) 
                                        | (IData)(this->out__out__en12)) 
                                       | (IData)(this->out__out__en13)) 
                                      | (IData)(this->out__out__en14)) 
                                     | (IData)(this->out__out__en15)) 
                                    | (IData)(this->out__out__en16)) 
                                   | (IData)(this->out__out__en17)) 
                                  | (IData)(this->out__out__en18)) 
                                 | (IData)(this->out__out__en19)) 
                                | (IData)(this->out__out__en20)) 
                               | (IData)(this->out__out__en21)) 
                              | (IData)(this->out__out__en22)) 
                             | (IData)(this->out__out__en23)) 
                            | (IData)(this->out__out__en24)) 
                           | (IData)(this->out__out__en25)) 
                          | (IData)(this->out__out__en26)) 
                         | (IData)(this->out__out__en27)) 
                        | (IData)(this->out__out__en28)) 
                       | (IData)(this->out__out__en29)) 
                      | (IData)(this->out__out__en30)) 
                     | (IData)(this->out__out__en31));
    this->__PVT__nG2 = ((0xfffcU & ((~ ((((IData)(this->__PVT__P1) 
                                          >> 2U) & (IData)(this->__PVT__G1)) 
                                        | ((IData)(this->__PVT__G1) 
                                           >> 2U))) 
                                    << 2U)) | (3U & 
                                               (~ (IData)(this->__PVT__G1))));
    this->__PVT__nP2 = ((0xfffcU & ((~ (((IData)(this->__PVT__P1) 
                                         >> 2U) & (IData)(this->__PVT__P1))) 
                                    << 2U)) | (3U & 
                                               (~ (IData)(this->__PVT__P1))));
    this->__PVT__P3 = ((0xfff0U & ((~ (((IData)(this->__PVT__nP2) 
                                        >> 4U) | (IData)(this->__PVT__nP2))) 
                                   << 4U)) | (0xfU 
                                              & (~ (IData)(this->__PVT__nP2))));
    this->__PVT__G3 = ((0xfff0U & ((~ ((((IData)(this->__PVT__nP2) 
                                         >> 4U) | (IData)(this->__PVT__nG2)) 
                                       & ((IData)(this->__PVT__nG2) 
                                          >> 4U))) 
                                   << 4U)) | (0xfU 
                                              & (~ (IData)(this->__PVT__nG2))));
    this->__PVT__nG4 = ((0xff00U & ((~ ((((IData)(this->__PVT__P3) 
                                          >> 8U) & (IData)(this->__PVT__G3)) 
                                        | ((IData)(this->__PVT__G3) 
                                           >> 8U))) 
                                    << 8U)) | (0xffU 
                                               & (~ (IData)(this->__PVT__G3))));
    this->out__out__out2 = ((0xfffdU & (IData)(this->out__out__out2)) 
                            | (2U & (((0x7ffeU ^ (0xfffffffeU 
                                                  & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__6__KET____DOT__add_mod____pinNumber1))) 
                                      & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                         >> 5U)) & 
                                     ((IData)(this->__PVT__nG4) 
                                      << 1U))));
    this->out__out__out4 = ((0xfffbU & (IData)(this->out__out__out4)) 
                            | (4U & (((0x7ffcU ^ (0xfffffffcU 
                                                  & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__6__KET____DOT__add_mod____pinNumber1))) 
                                      & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                         >> 4U)) & 
                                     ((IData)(this->__PVT__nG4) 
                                      << 1U))));
    this->out__out__out6 = ((0xfff7U & (IData)(this->out__out__out6)) 
                            | (8U & (((0x7ff8U ^ (0xfffffff8U 
                                                  & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__6__KET____DOT__add_mod____pinNumber1))) 
                                      & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                         >> 3U)) & 
                                     ((IData)(this->__PVT__nG4) 
                                      << 1U))));
    this->out__out__out8 = ((0xffefU & (IData)(this->out__out__out8)) 
                            | (0x10U & (((0x7ff0U ^ 
                                          (0xfffffff0U 
                                           & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__6__KET____DOT__add_mod____pinNumber1))) 
                                         & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                            >> 2U)) 
                                        & ((IData)(this->__PVT__nG4) 
                                           << 1U))));
    this->out__out__out10 = ((0xffdfU & (IData)(this->out__out__out10)) 
                             | (0x20U & (((0x7fe0U 
                                           ^ (0xffffffe0U 
                                              & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__6__KET____DOT__add_mod____pinNumber1))) 
                                          & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                             >> 1U)) 
                                         & ((IData)(this->__PVT__nG4) 
                                            << 1U))));
    this->out__out__out12 = ((0xffbfU & (IData)(this->out__out__out12)) 
                             | (0x40U & (((0x7fc0U 
                                           ^ (0xffffffc0U 
                                              & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__6__KET____DOT__add_mod____pinNumber1))) 
                                          & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg)) 
                                         & ((IData)(this->__PVT__nG4) 
                                            << 1U))));
    this->out__out__out14 = ((0xff7fU & (IData)(this->out__out__out14)) 
                             | (0x80U & (((0x7f80U 
                                           ^ (0xffffff80U 
                                              & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__6__KET____DOT__add_mod____pinNumber1))) 
                                          & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                             << 1U)) 
                                         & ((IData)(this->__PVT__nG4) 
                                            << 1U))));
    this->out__out__out16 = ((0xfeffU & (IData)(this->out__out__out16)) 
                             | (0x100U & (((0x7f00U 
                                            ^ (0xffffff00U 
                                               & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__6__KET____DOT__add_mod____pinNumber1))) 
                                           & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                              << 2U)) 
                                          & ((IData)(this->__PVT__nG4) 
                                             << 1U))));
    this->out__out__out18 = ((0xfdffU & (IData)(this->out__out__out18)) 
                             | (0x200U & (((0x7e00U 
                                            ^ (0xfffffe00U 
                                               & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__6__KET____DOT__add_mod____pinNumber1))) 
                                           & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                              << 3U)) 
                                          & ((IData)(this->__PVT__nG4) 
                                             << 1U))));
    this->out__out__out20 = ((0xfbffU & (IData)(this->out__out__out20)) 
                             | (0x400U & (((0x7c00U 
                                            ^ (0xfffffc00U 
                                               & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__6__KET____DOT__add_mod____pinNumber1))) 
                                           & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                              << 4U)) 
                                          & ((IData)(this->__PVT__nG4) 
                                             << 1U))));
    this->out__out__out22 = ((0xf7ffU & (IData)(this->out__out__out22)) 
                             | (0x800U & (((0x7800U 
                                            ^ (0xfffff800U 
                                               & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__6__KET____DOT__add_mod____pinNumber1))) 
                                           & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                              << 5U)) 
                                          & ((IData)(this->__PVT__nG4) 
                                             << 1U))));
    this->out__out__out24 = ((0xefffU & (IData)(this->out__out__out24)) 
                             | (0x1000U & (((0x7000U 
                                             ^ (0xfffff000U 
                                                & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__6__KET____DOT__add_mod____pinNumber1))) 
                                            & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                               << 6U)) 
                                           & ((IData)(this->__PVT__nG4) 
                                              << 1U))));
    this->out__out__out26 = ((0xdfffU & (IData)(this->out__out__out26)) 
                             | (0x2000U & (((0x6000U 
                                             ^ (0xffffe000U 
                                                & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__6__KET____DOT__add_mod____pinNumber1))) 
                                            & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                               << 7U)) 
                                           & ((IData)(this->__PVT__nG4) 
                                              << 1U))));
    this->out__out__out28 = ((0xbfffU & (IData)(this->out__out__out28)) 
                             | (0x4000U & (((0x4000U 
                                             ^ (0xffffc000U 
                                                & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__6__KET____DOT__add_mod____pinNumber1))) 
                                            & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                               << 8U)) 
                                           & ((IData)(this->__PVT__nG4) 
                                              << 1U))));
    this->out__out__out30 = ((0x7fffU & (IData)(this->out__out__out30)) 
                             | (0x8000U & (((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__6__KET____DOT__add_mod____pinNumber1) 
                                            & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                               << 9U)) 
                                           & ((IData)(this->__PVT__nG4) 
                                              << 1U))));
    this->__PVT__nC1 = (1U | (0xfffeU & ((IData)(this->__PVT__nG4) 
                                         << 1U)));
    this->out__out__out1 = ((0xfffeU & (IData)(this->out__out__out1)) 
                            | (1U & (((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__6__KET____DOT__add_mod____pinNumber1) 
                                      & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                         >> 6U)) & 
                                     (~ (IData)(this->__PVT__nC1)))));
    this->out__out__out3 = ((0xfffdU & (IData)(this->out__out__out3)) 
                            | (2U & ((((IData)(0x7fffU) 
                                       ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__6__KET____DOT__add_mod____pinNumber1)) 
                                      & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                         >> 5U)) & 
                                     ((~ ((IData)(this->__PVT__nC1) 
                                          >> 1U)) << 1U))));
    this->out__out__out5 = ((0xfffbU & (IData)(this->out__out__out5)) 
                            | (4U & ((((IData)(0x7fffU) 
                                       ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__6__KET____DOT__add_mod____pinNumber1)) 
                                      & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                         >> 4U)) & 
                                     ((~ ((IData)(this->__PVT__nC1) 
                                          >> 2U)) << 2U))));
    this->out__out__out7 = ((0xfff7U & (IData)(this->out__out__out7)) 
                            | (8U & ((((IData)(0x7fffU) 
                                       ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__6__KET____DOT__add_mod____pinNumber1)) 
                                      & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                         >> 3U)) & 
                                     ((~ ((IData)(this->__PVT__nC1) 
                                          >> 3U)) << 3U))));
    this->out__out__out9 = ((0xffefU & (IData)(this->out__out__out9)) 
                            | (0x10U & ((((IData)(0x7fffU) 
                                          ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__6__KET____DOT__add_mod____pinNumber1)) 
                                         & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                            >> 2U)) 
                                        & ((~ ((IData)(this->__PVT__nC1) 
                                               >> 4U)) 
                                           << 4U))));
    this->out__out__out11 = ((0xffdfU & (IData)(this->out__out__out11)) 
                             | (0x20U & ((((IData)(0x7fffU) 
                                           ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__6__KET____DOT__add_mod____pinNumber1)) 
                                          & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                             >> 1U)) 
                                         & ((~ ((IData)(this->__PVT__nC1) 
                                                >> 5U)) 
                                            << 5U))));
    this->out__out__out13 = ((0xffbfU & (IData)(this->out__out__out13)) 
                             | (0x40U & ((((IData)(0x7fffU) 
                                           ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__6__KET____DOT__add_mod____pinNumber1)) 
                                          & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg)) 
                                         & ((~ ((IData)(this->__PVT__nC1) 
                                                >> 6U)) 
                                            << 6U))));
    this->out__out__out15 = ((0xff7fU & (IData)(this->out__out__out15)) 
                             | (0x80U & ((((IData)(0x7fffU) 
                                           ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__6__KET____DOT__add_mod____pinNumber1)) 
                                          & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                             << 1U)) 
                                         & ((~ ((IData)(this->__PVT__nC1) 
                                                >> 7U)) 
                                            << 7U))));
    this->out__out__out17 = ((0xfeffU & (IData)(this->out__out__out17)) 
                             | (0x100U & ((((IData)(0x7fffU) 
                                            ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__6__KET____DOT__add_mod____pinNumber1)) 
                                           & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                              << 2U)) 
                                          & ((~ ((IData)(this->__PVT__nC1) 
                                                 >> 8U)) 
                                             << 8U))));
    this->out__out__out19 = ((0xfdffU & (IData)(this->out__out__out19)) 
                             | (0x200U & ((((IData)(0x7fffU) 
                                            ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__6__KET____DOT__add_mod____pinNumber1)) 
                                           & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                              << 3U)) 
                                          & ((~ ((IData)(this->__PVT__nC1) 
                                                 >> 9U)) 
                                             << 9U))));
    this->out__out__out21 = ((0xfbffU & (IData)(this->out__out__out21)) 
                             | (0x400U & ((((IData)(0x7fffU) 
                                            ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__6__KET____DOT__add_mod____pinNumber1)) 
                                           & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                              << 4U)) 
                                          & ((~ ((IData)(this->__PVT__nC1) 
                                                 >> 0xaU)) 
                                             << 0xaU))));
    this->out__out__out23 = ((0xf7ffU & (IData)(this->out__out__out23)) 
                             | (0x800U & ((((IData)(0x7fffU) 
                                            ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__6__KET____DOT__add_mod____pinNumber1)) 
                                           & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                              << 5U)) 
                                          & ((~ ((IData)(this->__PVT__nC1) 
                                                 >> 0xbU)) 
                                             << 0xbU))));
    this->out__out__out25 = ((0xefffU & (IData)(this->out__out__out25)) 
                             | (0x1000U & ((((IData)(0x7fffU) 
                                             ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__6__KET____DOT__add_mod____pinNumber1)) 
                                            & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                               << 6U)) 
                                           & ((~ ((IData)(this->__PVT__nC1) 
                                                  >> 0xcU)) 
                                              << 0xcU))));
    this->out__out__out27 = ((0xdfffU & (IData)(this->out__out__out27)) 
                             | (0x2000U & ((((IData)(0x7fffU) 
                                             ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__6__KET____DOT__add_mod____pinNumber1)) 
                                            & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                               << 7U)) 
                                           & ((~ ((IData)(this->__PVT__nC1) 
                                                  >> 0xdU)) 
                                              << 0xdU))));
    this->out__out__out29 = ((0xbfffU & (IData)(this->out__out__out29)) 
                             | (0x4000U & ((((IData)(0x7fffU) 
                                             ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__6__KET____DOT__add_mod____pinNumber1)) 
                                            & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                               << 8U)) 
                                           & ((~ ((IData)(this->__PVT__nC1) 
                                                  >> 0xeU)) 
                                              << 0xeU))));
    this->out__out__out31 = ((0x7fffU & (IData)(this->out__out__out31)) 
                             | (0x8000U & ((((IData)(0x7fffU) 
                                             ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__6__KET____DOT__add_mod____pinNumber1)) 
                                            & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                               << 9U)) 
                                           & ((~ ((IData)(this->__PVT__nC1) 
                                                  >> 0xfU)) 
                                              << 0xfU))));
    this->out__out = ((((((((((((((((((((((((((((((
                                                   (((IData)(this->out__out__out0) 
                                                     & (IData)(this->out__out__en0)) 
                                                    | ((IData)(this->out__out__out1) 
                                                       & (IData)(this->out__out__en1))) 
                                                   | ((IData)(this->out__out__out2) 
                                                      & (IData)(this->out__out__en2))) 
                                                  | ((IData)(this->out__out__out3) 
                                                     & (IData)(this->out__out__en3))) 
                                                 | ((IData)(this->out__out__out4) 
                                                    & (IData)(this->out__out__en4))) 
                                                | ((IData)(this->out__out__out5) 
                                                   & (IData)(this->out__out__en5))) 
                                               | ((IData)(this->out__out__out6) 
                                                  & (IData)(this->out__out__en6))) 
                                              | ((IData)(this->out__out__out7) 
                                                 & (IData)(this->out__out__en7))) 
                                             | ((IData)(this->out__out__out8) 
                                                & (IData)(this->out__out__en8))) 
                                            | ((IData)(this->out__out__out9) 
                                               & (IData)(this->out__out__en9))) 
                                           | ((IData)(this->out__out__out10) 
                                              & (IData)(this->out__out__en10))) 
                                          | ((IData)(this->out__out__out11) 
                                             & (IData)(this->out__out__en11))) 
                                         | ((IData)(this->out__out__out12) 
                                            & (IData)(this->out__out__en12))) 
                                        | ((IData)(this->out__out__out13) 
                                           & (IData)(this->out__out__en13))) 
                                       | ((IData)(this->out__out__out14) 
                                          & (IData)(this->out__out__en14))) 
                                      | ((IData)(this->out__out__out15) 
                                         & (IData)(this->out__out__en15))) 
                                     | ((IData)(this->out__out__out16) 
                                        & (IData)(this->out__out__en16))) 
                                    | ((IData)(this->out__out__out17) 
                                       & (IData)(this->out__out__en17))) 
                                   | ((IData)(this->out__out__out18) 
                                      & (IData)(this->out__out__en18))) 
                                  | ((IData)(this->out__out__out19) 
                                     & (IData)(this->out__out__en19))) 
                                 | ((IData)(this->out__out__out20) 
                                    & (IData)(this->out__out__en20))) 
                                | ((IData)(this->out__out__out21) 
                                   & (IData)(this->out__out__en21))) 
                               | ((IData)(this->out__out__out22) 
                                  & (IData)(this->out__out__en22))) 
                              | ((IData)(this->out__out__out23) 
                                 & (IData)(this->out__out__en23))) 
                             | ((IData)(this->out__out__out24) 
                                & (IData)(this->out__out__en24))) 
                            | ((IData)(this->out__out__out25) 
                               & (IData)(this->out__out__en25))) 
                           | ((IData)(this->out__out__out26) 
                              & (IData)(this->out__out__en26))) 
                          | ((IData)(this->out__out__out27) 
                             & (IData)(this->out__out__en27))) 
                         | ((IData)(this->out__out__out28) 
                            & (IData)(this->out__out__en28))) 
                        | ((IData)(this->out__out__out29) 
                           & (IData)(this->out__out__en29))) 
                       | ((IData)(this->out__out__out30) 
                          & (IData)(this->out__out__en30))) 
                      | ((IData)(this->out__out__out31) 
                         & (IData)(this->out__out__en31)));
}

VL_INLINE_OPT void Vfu_alu_adder__W10::_settle__TOP__fu_alu__DOT__g2fp_mod__DOT__genblk1__BRA__7__KET____DOT__add_mod__8(Vfu_alu__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+          Vfu_alu_adder__W10::_settle__TOP__fu_alu__DOT__g2fp_mod__DOT__genblk1__BRA__7__KET____DOT__add_mod__8\n"); );
    Vfu_alu* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->out__out__out0 = ((0xfffeU & (IData)(this->out__out__out0)) 
                            | (1U & ((~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__7__KET____DOT__add_mod____pinNumber1)) 
                                     & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                        >> 7U))));
    this->out__out__en0 = (1U & ((~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__7__KET____DOT__add_mod____pinNumber1)) 
                                 & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                    >> 7U)));
    this->out__out__en1 = (1U & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__7__KET____DOT__add_mod____pinNumber1) 
                                 & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                    >> 7U)));
    this->out__out__en2 = (2U & ((0x7ffeU ^ (0xfffffffeU 
                                             & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__7__KET____DOT__add_mod____pinNumber1))) 
                                 & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                    >> 6U)));
    this->out__out__en3 = (2U & (((IData)(0x7fffU) 
                                  ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__7__KET____DOT__add_mod____pinNumber1)) 
                                 & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                    >> 6U)));
    this->out__out__en4 = (4U & ((0x7ffcU ^ (0xfffffffcU 
                                             & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__7__KET____DOT__add_mod____pinNumber1))) 
                                 & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                    >> 5U)));
    this->out__out__en5 = (4U & (((IData)(0x7fffU) 
                                  ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__7__KET____DOT__add_mod____pinNumber1)) 
                                 & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                    >> 5U)));
    this->out__out__en6 = (8U & ((0x7ff8U ^ (0xfffffff8U 
                                             & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__7__KET____DOT__add_mod____pinNumber1))) 
                                 & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                    >> 4U)));
    this->out__out__en7 = (8U & (((IData)(0x7fffU) 
                                  ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__7__KET____DOT__add_mod____pinNumber1)) 
                                 & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                    >> 4U)));
    this->out__out__en8 = (0x10U & ((0x7ff0U ^ (0xfffffff0U 
                                                & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__7__KET____DOT__add_mod____pinNumber1))) 
                                    & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                       >> 3U)));
    this->out__out__en9 = (0x10U & (((IData)(0x7fffU) 
                                     ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__7__KET____DOT__add_mod____pinNumber1)) 
                                    & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                       >> 3U)));
    this->out__out__en10 = (0x20U & ((0x7fe0U ^ (0xffffffe0U 
                                                 & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__7__KET____DOT__add_mod____pinNumber1))) 
                                     & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                        >> 2U)));
    this->out__out__en11 = (0x20U & (((IData)(0x7fffU) 
                                      ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__7__KET____DOT__add_mod____pinNumber1)) 
                                     & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                        >> 2U)));
    this->out__out__en12 = (0x40U & ((0x7fc0U ^ (0xffffffc0U 
                                                 & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__7__KET____DOT__add_mod____pinNumber1))) 
                                     & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                        >> 1U)));
    this->out__out__en13 = (0x40U & (((IData)(0x7fffU) 
                                      ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__7__KET____DOT__add_mod____pinNumber1)) 
                                     & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                        >> 1U)));
    this->out__out__en14 = (0x80U & ((0x7f80U ^ (0xffffff80U 
                                                 & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__7__KET____DOT__add_mod____pinNumber1))) 
                                     & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg)));
    this->out__out__en15 = (0x80U & (((IData)(0x7fffU) 
                                      ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__7__KET____DOT__add_mod____pinNumber1)) 
                                     & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg)));
    this->out__out__en16 = (0x100U & ((0x7f00U ^ (0xffffff00U 
                                                  & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__7__KET____DOT__add_mod____pinNumber1))) 
                                      & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                         << 1U)));
    this->out__out__en17 = (0x100U & (((IData)(0x7fffU) 
                                       ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__7__KET____DOT__add_mod____pinNumber1)) 
                                      & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                         << 1U)));
    this->out__out__en18 = (0x200U & ((0x7e00U ^ (0xfffffe00U 
                                                  & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__7__KET____DOT__add_mod____pinNumber1))) 
                                      & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                         << 2U)));
    this->out__out__en19 = (0x200U & (((IData)(0x7fffU) 
                                       ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__7__KET____DOT__add_mod____pinNumber1)) 
                                      & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                         << 2U)));
    this->out__out__en20 = (0x400U & ((0x7c00U ^ (0xfffffc00U 
                                                  & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__7__KET____DOT__add_mod____pinNumber1))) 
                                      & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                         << 3U)));
    this->out__out__en21 = (0x400U & (((IData)(0x7fffU) 
                                       ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__7__KET____DOT__add_mod____pinNumber1)) 
                                      & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                         << 3U)));
    this->out__out__en22 = (0x800U & ((0x7800U ^ (0xfffff800U 
                                                  & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__7__KET____DOT__add_mod____pinNumber1))) 
                                      & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                         << 4U)));
    this->out__out__en23 = (0x800U & (((IData)(0x7fffU) 
                                       ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__7__KET____DOT__add_mod____pinNumber1)) 
                                      & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                         << 4U)));
    this->out__out__en24 = (0x1000U & ((0x7000U ^ (0xfffff000U 
                                                   & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__7__KET____DOT__add_mod____pinNumber1))) 
                                       & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                          << 5U)));
    this->out__out__en25 = (0x1000U & (((IData)(0x7fffU) 
                                        ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__7__KET____DOT__add_mod____pinNumber1)) 
                                       & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                          << 5U)));
    this->out__out__en26 = (0x2000U & ((0x6000U ^ (0xffffe000U 
                                                   & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__7__KET____DOT__add_mod____pinNumber1))) 
                                       & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                          << 6U)));
    this->out__out__en27 = (0x2000U & (((IData)(0x7fffU) 
                                        ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__7__KET____DOT__add_mod____pinNumber1)) 
                                       & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                          << 6U)));
    this->out__out__en28 = (0x4000U & ((0x4000U ^ (0xffffc000U 
                                                   & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__7__KET____DOT__add_mod____pinNumber1))) 
                                       & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                          << 7U)));
    this->out__out__en29 = (0x4000U & (((IData)(0x7fffU) 
                                        ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__7__KET____DOT__add_mod____pinNumber1)) 
                                       & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                          << 7U)));
    this->out__out__en30 = (0x8000U & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__7__KET____DOT__add_mod____pinNumber1) 
                                       & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                          << 8U)));
    this->out__out__en31 = (0x8000U & (((IData)(0x7fffU) 
                                        ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__7__KET____DOT__add_mod____pinNumber1)) 
                                       & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                          << 8U)));
    this->__PVT__G1 = ((0xfffeU & ((~ (((~ (0x3fffU 
                                            | ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__7__KET____DOT__add_mod____pinNumber1) 
                                               >> 1U))) 
                                        | (~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__7__KET____DOT__add_mod____pinNumber1))) 
                                       & (~ (0x3fffU 
                                             & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__7__KET____DOT__add_mod____pinNumber1) 
                                                >> 1U))))) 
                                   << 1U)) | (1U & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__7__KET____DOT__add_mod____pinNumber1)));
    this->__PVT__P1 = (1U | (0xfffeU & (0x7ffeU | (0xfffffffeU 
                                                   & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__7__KET____DOT__add_mod____pinNumber1)))));
    this->out__en = ((((((((((((((((((((((((((((((((IData)(this->out__out__en0) 
                                                   | (IData)(this->out__out__en1)) 
                                                  | (IData)(this->out__out__en2)) 
                                                 | (IData)(this->out__out__en3)) 
                                                | (IData)(this->out__out__en4)) 
                                               | (IData)(this->out__out__en5)) 
                                              | (IData)(this->out__out__en6)) 
                                             | (IData)(this->out__out__en7)) 
                                            | (IData)(this->out__out__en8)) 
                                           | (IData)(this->out__out__en9)) 
                                          | (IData)(this->out__out__en10)) 
                                         | (IData)(this->out__out__en11)) 
                                        | (IData)(this->out__out__en12)) 
                                       | (IData)(this->out__out__en13)) 
                                      | (IData)(this->out__out__en14)) 
                                     | (IData)(this->out__out__en15)) 
                                    | (IData)(this->out__out__en16)) 
                                   | (IData)(this->out__out__en17)) 
                                  | (IData)(this->out__out__en18)) 
                                 | (IData)(this->out__out__en19)) 
                                | (IData)(this->out__out__en20)) 
                               | (IData)(this->out__out__en21)) 
                              | (IData)(this->out__out__en22)) 
                             | (IData)(this->out__out__en23)) 
                            | (IData)(this->out__out__en24)) 
                           | (IData)(this->out__out__en25)) 
                          | (IData)(this->out__out__en26)) 
                         | (IData)(this->out__out__en27)) 
                        | (IData)(this->out__out__en28)) 
                       | (IData)(this->out__out__en29)) 
                      | (IData)(this->out__out__en30)) 
                     | (IData)(this->out__out__en31));
    this->__PVT__nG2 = ((0xfffcU & ((~ ((((IData)(this->__PVT__P1) 
                                          >> 2U) & (IData)(this->__PVT__G1)) 
                                        | ((IData)(this->__PVT__G1) 
                                           >> 2U))) 
                                    << 2U)) | (3U & 
                                               (~ (IData)(this->__PVT__G1))));
    this->__PVT__nP2 = ((0xfffcU & ((~ (((IData)(this->__PVT__P1) 
                                         >> 2U) & (IData)(this->__PVT__P1))) 
                                    << 2U)) | (3U & 
                                               (~ (IData)(this->__PVT__P1))));
    this->__PVT__P3 = ((0xfff0U & ((~ (((IData)(this->__PVT__nP2) 
                                        >> 4U) | (IData)(this->__PVT__nP2))) 
                                   << 4U)) | (0xfU 
                                              & (~ (IData)(this->__PVT__nP2))));
    this->__PVT__G3 = ((0xfff0U & ((~ ((((IData)(this->__PVT__nP2) 
                                         >> 4U) | (IData)(this->__PVT__nG2)) 
                                       & ((IData)(this->__PVT__nG2) 
                                          >> 4U))) 
                                   << 4U)) | (0xfU 
                                              & (~ (IData)(this->__PVT__nG2))));
    this->__PVT__nG4 = ((0xff00U & ((~ ((((IData)(this->__PVT__P3) 
                                          >> 8U) & (IData)(this->__PVT__G3)) 
                                        | ((IData)(this->__PVT__G3) 
                                           >> 8U))) 
                                    << 8U)) | (0xffU 
                                               & (~ (IData)(this->__PVT__G3))));
    this->out__out__out2 = ((0xfffdU & (IData)(this->out__out__out2)) 
                            | (2U & (((0x7ffeU ^ (0xfffffffeU 
                                                  & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__7__KET____DOT__add_mod____pinNumber1))) 
                                      & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                         >> 6U)) & 
                                     ((IData)(this->__PVT__nG4) 
                                      << 1U))));
    this->out__out__out4 = ((0xfffbU & (IData)(this->out__out__out4)) 
                            | (4U & (((0x7ffcU ^ (0xfffffffcU 
                                                  & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__7__KET____DOT__add_mod____pinNumber1))) 
                                      & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                         >> 5U)) & 
                                     ((IData)(this->__PVT__nG4) 
                                      << 1U))));
    this->out__out__out6 = ((0xfff7U & (IData)(this->out__out__out6)) 
                            | (8U & (((0x7ff8U ^ (0xfffffff8U 
                                                  & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__7__KET____DOT__add_mod____pinNumber1))) 
                                      & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                         >> 4U)) & 
                                     ((IData)(this->__PVT__nG4) 
                                      << 1U))));
    this->out__out__out8 = ((0xffefU & (IData)(this->out__out__out8)) 
                            | (0x10U & (((0x7ff0U ^ 
                                          (0xfffffff0U 
                                           & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__7__KET____DOT__add_mod____pinNumber1))) 
                                         & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                            >> 3U)) 
                                        & ((IData)(this->__PVT__nG4) 
                                           << 1U))));
    this->out__out__out10 = ((0xffdfU & (IData)(this->out__out__out10)) 
                             | (0x20U & (((0x7fe0U 
                                           ^ (0xffffffe0U 
                                              & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__7__KET____DOT__add_mod____pinNumber1))) 
                                          & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                             >> 2U)) 
                                         & ((IData)(this->__PVT__nG4) 
                                            << 1U))));
    this->out__out__out12 = ((0xffbfU & (IData)(this->out__out__out12)) 
                             | (0x40U & (((0x7fc0U 
                                           ^ (0xffffffc0U 
                                              & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__7__KET____DOT__add_mod____pinNumber1))) 
                                          & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                             >> 1U)) 
                                         & ((IData)(this->__PVT__nG4) 
                                            << 1U))));
    this->out__out__out14 = ((0xff7fU & (IData)(this->out__out__out14)) 
                             | (0x80U & (((0x7f80U 
                                           ^ (0xffffff80U 
                                              & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__7__KET____DOT__add_mod____pinNumber1))) 
                                          & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg)) 
                                         & ((IData)(this->__PVT__nG4) 
                                            << 1U))));
    this->out__out__out16 = ((0xfeffU & (IData)(this->out__out__out16)) 
                             | (0x100U & (((0x7f00U 
                                            ^ (0xffffff00U 
                                               & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__7__KET____DOT__add_mod____pinNumber1))) 
                                           & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                              << 1U)) 
                                          & ((IData)(this->__PVT__nG4) 
                                             << 1U))));
    this->out__out__out18 = ((0xfdffU & (IData)(this->out__out__out18)) 
                             | (0x200U & (((0x7e00U 
                                            ^ (0xfffffe00U 
                                               & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__7__KET____DOT__add_mod____pinNumber1))) 
                                           & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                              << 2U)) 
                                          & ((IData)(this->__PVT__nG4) 
                                             << 1U))));
    this->out__out__out20 = ((0xfbffU & (IData)(this->out__out__out20)) 
                             | (0x400U & (((0x7c00U 
                                            ^ (0xfffffc00U 
                                               & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__7__KET____DOT__add_mod____pinNumber1))) 
                                           & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                              << 3U)) 
                                          & ((IData)(this->__PVT__nG4) 
                                             << 1U))));
    this->out__out__out22 = ((0xf7ffU & (IData)(this->out__out__out22)) 
                             | (0x800U & (((0x7800U 
                                            ^ (0xfffff800U 
                                               & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__7__KET____DOT__add_mod____pinNumber1))) 
                                           & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                              << 4U)) 
                                          & ((IData)(this->__PVT__nG4) 
                                             << 1U))));
    this->out__out__out24 = ((0xefffU & (IData)(this->out__out__out24)) 
                             | (0x1000U & (((0x7000U 
                                             ^ (0xfffff000U 
                                                & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__7__KET____DOT__add_mod____pinNumber1))) 
                                            & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                               << 5U)) 
                                           & ((IData)(this->__PVT__nG4) 
                                              << 1U))));
    this->out__out__out26 = ((0xdfffU & (IData)(this->out__out__out26)) 
                             | (0x2000U & (((0x6000U 
                                             ^ (0xffffe000U 
                                                & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__7__KET____DOT__add_mod____pinNumber1))) 
                                            & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                               << 6U)) 
                                           & ((IData)(this->__PVT__nG4) 
                                              << 1U))));
    this->out__out__out28 = ((0xbfffU & (IData)(this->out__out__out28)) 
                             | (0x4000U & (((0x4000U 
                                             ^ (0xffffc000U 
                                                & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__7__KET____DOT__add_mod____pinNumber1))) 
                                            & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                               << 7U)) 
                                           & ((IData)(this->__PVT__nG4) 
                                              << 1U))));
    this->out__out__out30 = ((0x7fffU & (IData)(this->out__out__out30)) 
                             | (0x8000U & (((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__7__KET____DOT__add_mod____pinNumber1) 
                                            & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                               << 8U)) 
                                           & ((IData)(this->__PVT__nG4) 
                                              << 1U))));
    this->__PVT__nC1 = (1U | (0xfffeU & ((IData)(this->__PVT__nG4) 
                                         << 1U)));
    this->out__out__out1 = ((0xfffeU & (IData)(this->out__out__out1)) 
                            | (1U & (((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__7__KET____DOT__add_mod____pinNumber1) 
                                      & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                         >> 7U)) & 
                                     (~ (IData)(this->__PVT__nC1)))));
    this->out__out__out3 = ((0xfffdU & (IData)(this->out__out__out3)) 
                            | (2U & ((((IData)(0x7fffU) 
                                       ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__7__KET____DOT__add_mod____pinNumber1)) 
                                      & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                         >> 6U)) & 
                                     ((~ ((IData)(this->__PVT__nC1) 
                                          >> 1U)) << 1U))));
    this->out__out__out5 = ((0xfffbU & (IData)(this->out__out__out5)) 
                            | (4U & ((((IData)(0x7fffU) 
                                       ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__7__KET____DOT__add_mod____pinNumber1)) 
                                      & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                         >> 5U)) & 
                                     ((~ ((IData)(this->__PVT__nC1) 
                                          >> 2U)) << 2U))));
    this->out__out__out7 = ((0xfff7U & (IData)(this->out__out__out7)) 
                            | (8U & ((((IData)(0x7fffU) 
                                       ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__7__KET____DOT__add_mod____pinNumber1)) 
                                      & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                         >> 4U)) & 
                                     ((~ ((IData)(this->__PVT__nC1) 
                                          >> 3U)) << 3U))));
    this->out__out__out9 = ((0xffefU & (IData)(this->out__out__out9)) 
                            | (0x10U & ((((IData)(0x7fffU) 
                                          ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__7__KET____DOT__add_mod____pinNumber1)) 
                                         & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                            >> 3U)) 
                                        & ((~ ((IData)(this->__PVT__nC1) 
                                               >> 4U)) 
                                           << 4U))));
    this->out__out__out11 = ((0xffdfU & (IData)(this->out__out__out11)) 
                             | (0x20U & ((((IData)(0x7fffU) 
                                           ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__7__KET____DOT__add_mod____pinNumber1)) 
                                          & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                             >> 2U)) 
                                         & ((~ ((IData)(this->__PVT__nC1) 
                                                >> 5U)) 
                                            << 5U))));
    this->out__out__out13 = ((0xffbfU & (IData)(this->out__out__out13)) 
                             | (0x40U & ((((IData)(0x7fffU) 
                                           ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__7__KET____DOT__add_mod____pinNumber1)) 
                                          & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                             >> 1U)) 
                                         & ((~ ((IData)(this->__PVT__nC1) 
                                                >> 6U)) 
                                            << 6U))));
    this->out__out__out15 = ((0xff7fU & (IData)(this->out__out__out15)) 
                             | (0x80U & ((((IData)(0x7fffU) 
                                           ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__7__KET____DOT__add_mod____pinNumber1)) 
                                          & (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg)) 
                                         & ((~ ((IData)(this->__PVT__nC1) 
                                                >> 7U)) 
                                            << 7U))));
    this->out__out__out17 = ((0xfeffU & (IData)(this->out__out__out17)) 
                             | (0x100U & ((((IData)(0x7fffU) 
                                            ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__7__KET____DOT__add_mod____pinNumber1)) 
                                           & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                              << 1U)) 
                                          & ((~ ((IData)(this->__PVT__nC1) 
                                                 >> 8U)) 
                                             << 8U))));
    this->out__out__out19 = ((0xfdffU & (IData)(this->out__out__out19)) 
                             | (0x200U & ((((IData)(0x7fffU) 
                                            ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__7__KET____DOT__add_mod____pinNumber1)) 
                                           & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                              << 2U)) 
                                          & ((~ ((IData)(this->__PVT__nC1) 
                                                 >> 9U)) 
                                             << 9U))));
    this->out__out__out21 = ((0xfbffU & (IData)(this->out__out__out21)) 
                             | (0x400U & ((((IData)(0x7fffU) 
                                            ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__7__KET____DOT__add_mod____pinNumber1)) 
                                           & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                              << 3U)) 
                                          & ((~ ((IData)(this->__PVT__nC1) 
                                                 >> 0xaU)) 
                                             << 0xaU))));
    this->out__out__out23 = ((0xf7ffU & (IData)(this->out__out__out23)) 
                             | (0x800U & ((((IData)(0x7fffU) 
                                            ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__7__KET____DOT__add_mod____pinNumber1)) 
                                           & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                              << 4U)) 
                                          & ((~ ((IData)(this->__PVT__nC1) 
                                                 >> 0xbU)) 
                                             << 0xbU))));
    this->out__out__out25 = ((0xefffU & (IData)(this->out__out__out25)) 
                             | (0x1000U & ((((IData)(0x7fffU) 
                                             ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__7__KET____DOT__add_mod____pinNumber1)) 
                                            & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                               << 5U)) 
                                           & ((~ ((IData)(this->__PVT__nC1) 
                                                  >> 0xcU)) 
                                              << 0xcU))));
    this->out__out__out27 = ((0xdfffU & (IData)(this->out__out__out27)) 
                             | (0x2000U & ((((IData)(0x7fffU) 
                                             ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__7__KET____DOT__add_mod____pinNumber1)) 
                                            & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                               << 6U)) 
                                           & ((~ ((IData)(this->__PVT__nC1) 
                                                  >> 0xdU)) 
                                              << 0xdU))));
    this->out__out__out29 = ((0xbfffU & (IData)(this->out__out__out29)) 
                             | (0x4000U & ((((IData)(0x7fffU) 
                                             ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__7__KET____DOT__add_mod____pinNumber1)) 
                                            & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                               << 7U)) 
                                           & ((~ ((IData)(this->__PVT__nC1) 
                                                  >> 0xeU)) 
                                              << 0xeU))));
    this->out__out__out31 = ((0x7fffU & (IData)(this->out__out__out31)) 
                             | (0x8000U & ((((IData)(0x7fffU) 
                                             ^ ~ (IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT____Vcellinp__genblk1__BRA__7__KET____DOT__add_mod____pinNumber1)) 
                                            & ((IData)(vlTOPp->fu_alu__DOT__g2fp_mod__DOT__medb_reg) 
                                               << 8U)) 
                                           & ((~ ((IData)(this->__PVT__nC1) 
                                                  >> 0xfU)) 
                                              << 0xfU))));
    this->out__out = ((((((((((((((((((((((((((((((
                                                   (((IData)(this->out__out__out0) 
                                                     & (IData)(this->out__out__en0)) 
                                                    | ((IData)(this->out__out__out1) 
                                                       & (IData)(this->out__out__en1))) 
                                                   | ((IData)(this->out__out__out2) 
                                                      & (IData)(this->out__out__en2))) 
                                                  | ((IData)(this->out__out__out3) 
                                                     & (IData)(this->out__out__en3))) 
                                                 | ((IData)(this->out__out__out4) 
                                                    & (IData)(this->out__out__en4))) 
                                                | ((IData)(this->out__out__out5) 
                                                   & (IData)(this->out__out__en5))) 
                                               | ((IData)(this->out__out__out6) 
                                                  & (IData)(this->out__out__en6))) 
                                              | ((IData)(this->out__out__out7) 
                                                 & (IData)(this->out__out__en7))) 
                                             | ((IData)(this->out__out__out8) 
                                                & (IData)(this->out__out__en8))) 
                                            | ((IData)(this->out__out__out9) 
                                               & (IData)(this->out__out__en9))) 
                                           | ((IData)(this->out__out__out10) 
                                              & (IData)(this->out__out__en10))) 
                                          | ((IData)(this->out__out__out11) 
                                             & (IData)(this->out__out__en11))) 
                                         | ((IData)(this->out__out__out12) 
                                            & (IData)(this->out__out__en12))) 
                                        | ((IData)(this->out__out__out13) 
                                           & (IData)(this->out__out__en13))) 
                                       | ((IData)(this->out__out__out14) 
                                          & (IData)(this->out__out__en14))) 
                                      | ((IData)(this->out__out__out15) 
                                         & (IData)(this->out__out__en15))) 
                                     | ((IData)(this->out__out__out16) 
                                        & (IData)(this->out__out__en16))) 
                                    | ((IData)(this->out__out__out17) 
                                       & (IData)(this->out__out__en17))) 
                                   | ((IData)(this->out__out__out18) 
                                      & (IData)(this->out__out__en18))) 
                                  | ((IData)(this->out__out__out19) 
                                     & (IData)(this->out__out__en19))) 
                                 | ((IData)(this->out__out__out20) 
                                    & (IData)(this->out__out__en20))) 
                                | ((IData)(this->out__out__out21) 
                                   & (IData)(this->out__out__en21))) 
                               | ((IData)(this->out__out__out22) 
                                  & (IData)(this->out__out__en22))) 
                              | ((IData)(this->out__out__out23) 
                                 & (IData)(this->out__out__en23))) 
                             | ((IData)(this->out__out__out24) 
                                & (IData)(this->out__out__en24))) 
                            | ((IData)(this->out__out__out25) 
                               & (IData)(this->out__out__en25))) 
                           | ((IData)(this->out__out__out26) 
                              & (IData)(this->out__out__en26))) 
                          | ((IData)(this->out__out__out27) 
                             & (IData)(this->out__out__en27))) 
                         | ((IData)(this->out__out__out28) 
                            & (IData)(this->out__out__en28))) 
                        | ((IData)(this->out__out__out29) 
                           & (IData)(this->out__out__en29))) 
                       | ((IData)(this->out__out__out30) 
                          & (IData)(this->out__out__en30))) 
                      | ((IData)(this->out__out__out31) 
                         & (IData)(this->out__out__en31)));
}

void Vfu_alu_adder__W10::_ctor_var_reset() {
    VL_DEBUG_IF(VL_DBG_MSGF("+          Vfu_alu_adder__W10::_ctor_var_reset\n"); );
    // Body
    a = VL_RAND_RESET_I(16);
    b = VL_RAND_RESET_I(16);
    out = VL_RAND_RESET_I(16);
    cin = VL_RAND_RESET_I(1);
    en = VL_RAND_RESET_I(1);
    __PVT__cout = VL_RAND_RESET_I(1);
    __PVT__cout8 = VL_RAND_RESET_I(1);
    __PVT__cout16 = VL_RAND_RESET_I(1);
    __PVT__cout32 = VL_RAND_RESET_I(1);
    __PVT__P1 = VL_RAND_RESET_I(16);
    __PVT__G1 = VL_RAND_RESET_I(16);
    __PVT__nP2 = VL_RAND_RESET_I(16);
    __PVT__nG2 = VL_RAND_RESET_I(16);
    __PVT__P3 = VL_RAND_RESET_I(16);
    __PVT__G3 = VL_RAND_RESET_I(16);
    __PVT__nG4 = VL_RAND_RESET_I(16);
    __PVT__nC1 = VL_RAND_RESET_I(16);
    out__out = VL_RAND_RESET_I(16);
    out__en = VL_RAND_RESET_I(16);
    out__out__out0 = 0;
    out__out__en0 = 0;
    out__out__out1 = 0;
    out__out__en1 = 0;
    out__out__out2 = 0;
    out__out__en2 = 0;
    out__out__out3 = 0;
    out__out__en3 = 0;
    out__out__out4 = 0;
    out__out__en4 = 0;
    out__out__out5 = 0;
    out__out__en5 = 0;
    out__out__out6 = 0;
    out__out__en6 = 0;
    out__out__out7 = 0;
    out__out__en7 = 0;
    out__out__out8 = 0;
    out__out__en8 = 0;
    out__out__out9 = 0;
    out__out__en9 = 0;
    out__out__out10 = 0;
    out__out__en10 = 0;
    out__out__out11 = 0;
    out__out__en11 = 0;
    out__out__out12 = 0;
    out__out__en12 = 0;
    out__out__out13 = 0;
    out__out__en13 = 0;
    out__out__out14 = 0;
    out__out__en14 = 0;
    out__out__out15 = 0;
    out__out__en15 = 0;
    out__out__out16 = 0;
    out__out__en16 = 0;
    out__out__out17 = 0;
    out__out__en17 = 0;
    out__out__out18 = 0;
    out__out__en18 = 0;
    out__out__out19 = 0;
    out__out__en19 = 0;
    out__out__out20 = 0;
    out__out__en20 = 0;
    out__out__out21 = 0;
    out__out__en21 = 0;
    out__out__out22 = 0;
    out__out__en22 = 0;
    out__out__out23 = 0;
    out__out__en23 = 0;
    out__out__out24 = 0;
    out__out__en24 = 0;
    out__out__out25 = 0;
    out__out__en25 = 0;
    out__out__out26 = 0;
    out__out__en26 = 0;
    out__out__out27 = 0;
    out__out__en27 = 0;
    out__out__out28 = 0;
    out__out__en28 = 0;
    out__out__out29 = 0;
    out__out__en29 = 0;
    out__out__out30 = 0;
    out__out__en30 = 0;
    out__out__out31 = 0;
    out__out__en31 = 0;
}
