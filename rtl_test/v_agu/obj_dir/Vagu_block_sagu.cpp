// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Vagu_block.h for the primary calling header

#include "Vagu_block_sagu.h"
#include "Vagu_block__Syms.h"

//==========

VL_CTOR_IMP(Vagu_block_sagu) {
    VL_CELL(__PVT__tlb_mod, Vagu_block_dtlb);
    // Reset internal values
    // Reset structure values
    _ctor_var_reset();
}

void Vagu_block_sagu::__Vconfigure(Vagu_block__Syms* vlSymsp, bool first) {
    if (0 && first) {}  // Prevent unused
    this->__VlSymsp = vlSymsp;
}

Vagu_block_sagu::~Vagu_block_sagu() {
}

void Vagu_block_sagu::_settle__TOP__agu_block__DOT__Wagu_mod__1(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+        Vagu_block_sagu::_settle__TOP__agu_block__DOT__Wagu_mod__1\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->faultCode = (((IData)(this->__PVT__fault_cann_reg) 
                        << 4U) | ((8U & ((IData)(this->__PVT__pageFault_t_reg) 
                                         << 2U)) | 
                                  (2U & ((IData)(this->__PVT__pageFault_t_reg) 
                                         << 1U))));
}

void Vagu_block_sagu::_settle__TOP__agu_block__DOT__Wagu_mod__3(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+        Vagu_block_sagu::_settle__TOP__agu_block__DOT__Wagu_mod__3\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->__pinNumber3__en0 = (0x3fffU & ((((((((((
                                                   (((((((((((((((((1U 
                                                                    & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr)) 
                                                                   | (1U 
                                                                      & (~ 
                                                                         (0x1fffU 
                                                                          & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr))))) 
                                                                  | (2U 
                                                                     & (0x80U 
                                                                        ^ 
                                                                        (0x1ffeU 
                                                                         & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr))))) 
                                                                 | (2U 
                                                                    & ((IData)(0x80U) 
                                                                       ^ ~ 
                                                                       (0x1fffU 
                                                                        & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr))))) 
                                                                | (4U 
                                                                   & (0x80U 
                                                                      ^ 
                                                                      (0x1ffcU 
                                                                       & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr))))) 
                                                               | (4U 
                                                                  & ((IData)(0x80U) 
                                                                     ^ ~ 
                                                                     (0x1fffU 
                                                                      & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr))))) 
                                                              | (8U 
                                                                 & (0x80U 
                                                                    ^ 
                                                                    (0x1ff8U 
                                                                     & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr))))) 
                                                             | (8U 
                                                                & ((IData)(0x80U) 
                                                                   ^ ~ 
                                                                   (0x1fffU 
                                                                    & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr))))) 
                                                            | (0x10U 
                                                               & (0x80U 
                                                                  ^ 
                                                                  (0x1ff0U 
                                                                   & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr))))) 
                                                           | (0x10U 
                                                              & ((IData)(0x80U) 
                                                                 ^ ~ 
                                                                 (0x1fffU 
                                                                  & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr))))) 
                                                          | (0x20U 
                                                             & (0x80U 
                                                                ^ 
                                                                (0x1fe0U 
                                                                 & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr))))) 
                                                         | (0x20U 
                                                            & ((IData)(0x80U) 
                                                               ^ ~ 
                                                               (0x1fffU 
                                                                & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr))))) 
                                                        | (0x40U 
                                                           & (0x80U 
                                                              ^ 
                                                              (0x1fc0U 
                                                               & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr))))) 
                                                       | (0x40U 
                                                          & ((IData)(0x80U) 
                                                             ^ ~ 
                                                             (0x1fffU 
                                                              & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr))))) 
                                                      | (0x80U 
                                                         & (0x80U 
                                                            ^ 
                                                            (0x1f80U 
                                                             & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr))))) 
                                                     | (0x80U 
                                                        & ((IData)(0x80U) 
                                                           ^ ~ 
                                                           (0x1fffU 
                                                            & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr))))) 
                                                    | (0x100U 
                                                       & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr))) 
                                                   | (0x100U 
                                                      & ((IData)(0x80U) 
                                                         ^ ~ 
                                                         (0x1fffU 
                                                          & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr))))) 
                                                  | (0x200U 
                                                     & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr))) 
                                                 | (0x200U 
                                                    & ((IData)(0x80U) 
                                                       ^ ~ 
                                                       (0x1fffU 
                                                        & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr))))) 
                                                | (0x400U 
                                                   & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr))) 
                                               | (0x400U 
                                                  & ((IData)(0x80U) 
                                                     ^ ~ 
                                                     (0x1fffU 
                                                      & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr))))) 
                                              | (0x800U 
                                                 & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr))) 
                                             | (0x800U 
                                                & ((IData)(0x80U) 
                                                   ^ ~ 
                                                   (0x1fffU 
                                                    & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr))))) 
                                            | (0x1000U 
                                               & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr))) 
                                           | (0x1000U 
                                              & ((IData)(0x80U) 
                                                 ^ ~ 
                                                 (0x1fffU 
                                                  & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr))))) 
                                          | (0x2000U 
                                             & ((IData)(0x80U) 
                                                ^ ~ 
                                                (0x1fffU 
                                                 & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr))))));
}

void Vagu_block_sagu::_settle__TOP__agu_block__DOT__Wagu_mod__5(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+        Vagu_block_sagu::_settle__TOP__agu_block__DOT__Wagu_mod__5\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->nextCAddr_mod__DOT__out__out__out0 = ((0x3ffeU 
                                                 & (IData)(this->nextCAddr_mod__DOT__out__out__out0)) 
                                                | (1U 
                                                   & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr)));
}

void Vagu_block_sagu::_settle__TOP__agu_block__DOT__Wagu_mod__7(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+        Vagu_block_sagu::_settle__TOP__agu_block__DOT__Wagu_mod__7\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->__PVT__rng_mod__DOT__sh_mod__DOT__bits_med 
        = ((((((0U == (3U & (IData)((vlTOPp->agu_block__DOT__p4_cmplxAddr 
                                     >> 0x3eU)))) ? (IData)(
                                                            (vlTOPp->agu_block__DOT__p4_cmplxAddr 
                                                             >> 4U))
                : 0U) & ((0U == (3U & (IData)((vlTOPp->agu_block__DOT__p4_cmplxAddr 
                                               >> 0x3eU))))
                          ? 0xffffU : 0U)) | (((1U 
                                                == 
                                                (3U 
                                                 & (IData)(
                                                           (vlTOPp->agu_block__DOT__p4_cmplxAddr 
                                                            >> 0x3eU))))
                                                ? (IData)(
                                                          (vlTOPp->agu_block__DOT__p4_cmplxAddr 
                                                           >> 0xcU))
                                                : 0U) 
                                              & ((1U 
                                                  == 
                                                  (3U 
                                                   & (IData)(
                                                             (vlTOPp->agu_block__DOT__p4_cmplxAddr 
                                                              >> 0x3eU))))
                                                  ? 0xffffU
                                                  : 0U))) 
            | (((2U == (3U & (IData)((vlTOPp->agu_block__DOT__p4_cmplxAddr 
                                      >> 0x3eU)))) ? (IData)(
                                                             (vlTOPp->agu_block__DOT__p4_cmplxAddr 
                                                              >> 0x14U))
                 : 0U) & ((2U == (3U & (IData)((vlTOPp->agu_block__DOT__p4_cmplxAddr 
                                                >> 0x3eU))))
                           ? 0xffffU : 0U))) | (((3U 
                                                  == 
                                                  (3U 
                                                   & (IData)(
                                                             (vlTOPp->agu_block__DOT__p4_cmplxAddr 
                                                              >> 0x3eU))))
                                                  ? (IData)(
                                                            (vlTOPp->agu_block__DOT__p4_cmplxAddr 
                                                             >> 0x1cU))
                                                  : 0U) 
                                                & ((3U 
                                                    == 
                                                    (3U 
                                                     & (IData)(
                                                               (vlTOPp->agu_block__DOT__p4_cmplxAddr 
                                                                >> 0x3eU))))
                                                    ? 0xffffU
                                                    : 0U)));
}

void Vagu_block_sagu::_settle__TOP__agu_block__DOT__Wagu_mod__9(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+        Vagu_block_sagu::_settle__TOP__agu_block__DOT__Wagu_mod__9\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->__PVT__opsize = ((0x20U & (IData)(this->__PVT__op_reg))
                            ? ((0x10U & (IData)(this->__PVT__op_reg))
                                ? 5U : ((8U & (IData)(this->__PVT__op_reg))
                                         ? 5U : ((4U 
                                                  & (IData)(this->__PVT__op_reg))
                                                  ? 
                                                 ((2U 
                                                   & (IData)(this->__PVT__op_reg))
                                                   ? 3U
                                                   : 2U)
                                                  : 
                                                 ((2U 
                                                   & (IData)(this->__PVT__op_reg))
                                                   ? 1U
                                                   : 0U))))
                            : ((0x10U & (IData)(this->__PVT__op_reg))
                                ? ((8U & (IData)(this->__PVT__op_reg))
                                    ? ((4U & (IData)(this->__PVT__op_reg))
                                        ? ((2U & (IData)(this->__PVT__op_reg))
                                            ? 6U : 2U)
                                        : ((2U & (IData)(this->__PVT__op_reg))
                                            ? 3U : 5U))
                                    : ((4U & (IData)(this->__PVT__op_reg))
                                        ? 5U : ((2U 
                                                 & (IData)(this->__PVT__op_reg))
                                                 ? 3U
                                                 : 2U)))
                                : ((8U & (IData)(this->__PVT__op_reg))
                                    ? ((4U & (IData)(this->__PVT__op_reg))
                                        ? 2U : 3U) : 
                                   ((4U & (IData)(this->__PVT__op_reg))
                                     ? ((2U & (IData)(this->__PVT__op_reg))
                                         ? 4U : 5U)
                                     : 5U))));
}

void Vagu_block_sagu::_settle__TOP__agu_block__DOT__Wagu_mod__11(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+        Vagu_block_sagu::_settle__TOP__agu_block__DOT__Wagu_mod__11\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->__PVT__nextCAddr_mod__DOT__G1 = (0x3ffeU 
                                           & ((~ ((
                                                   (~ 
                                                    (0x40U 
                                                     | (0xfffU 
                                                        & ((IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr) 
                                                           >> 1U)))) 
                                                   | (~ 
                                                      (0x80U 
                                                       & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr)))) 
                                                  & (~ 
                                                     (0x40U 
                                                      & ((IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr) 
                                                         >> 1U))))) 
                                              << 1U));
}

void Vagu_block_sagu::_settle__TOP__agu_block__DOT__Wagu_mod__13(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+        Vagu_block_sagu::_settle__TOP__agu_block__DOT__Wagu_mod__13\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->rng_mod__DOT__sh_mod__DOT__bits_med__en = 
        (((((0U == (3U & (IData)((vlTOPp->agu_block__DOT__p4_cmplxAddr 
                                  >> 0x3eU)))) ? 0xffffU
             : 0U) | ((1U == (3U & (IData)((vlTOPp->agu_block__DOT__p4_cmplxAddr 
                                            >> 0x3eU))))
                       ? 0xffffU : 0U)) | ((2U == (3U 
                                                   & (IData)(
                                                             (vlTOPp->agu_block__DOT__p4_cmplxAddr 
                                                              >> 0x3eU))))
                                            ? 0xffffU
                                            : 0U)) 
         | ((3U == (3U & (IData)((vlTOPp->agu_block__DOT__p4_cmplxAddr 
                                  >> 0x3eU)))) ? 0xffffU
             : 0U));
}

void Vagu_block_sagu::_settle__TOP__agu_block__DOT__Wagu_mod__15(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+        Vagu_block_sagu::_settle__TOP__agu_block__DOT__Wagu_mod__15\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->__PVT__nextCAddr_mod__DOT__P1 = ((0x3ffeU 
                                            & ((~ (
                                                   (~ 
                                                    (0x40U 
                                                     | (0xfffU 
                                                        & ((IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr) 
                                                           >> 1U)))) 
                                                   | (~ 
                                                      (0x80U 
                                                       | (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr))))) 
                                               << 1U)) 
                                           | (1U & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr)));
}

void Vagu_block_sagu::_settle__TOP__agu_block__DOT__Wagu_mod__17(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+        Vagu_block_sagu::_settle__TOP__agu_block__DOT__Wagu_mod__17\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->__PVT__addrTlb = (((QData)((IData)((0x1fffffU 
                                              & this->__PVT__proc))) 
                             << 0x1fU) | (QData)((IData)(
                                                         (0x7fffffffU 
                                                          & (IData)(
                                                                    (vlTOPp->agu_block__DOT__p4_cmplxAddr 
                                                                     >> 0xdU))))));
}

void Vagu_block_sagu::_settle__TOP__agu_block__DOT__Wagu_mod__19(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+        Vagu_block_sagu::_settle__TOP__agu_block__DOT__Wagu_mod__19\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->__PVT__rcn_mask = ((2U & ((~ (IData)(vlTOPp->except)) 
                                    << 1U)) | (1U & 
                                               (~ (IData)(vlTOPp->except))));
}

void Vagu_block_sagu::_settle__TOP__agu_block__DOT__Wagu_mod__21(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+        Vagu_block_sagu::_settle__TOP__agu_block__DOT__Wagu_mod__21\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->mOp_split__out__en7 = ((5U == (IData)(this->__PVT__opsize)) 
                                 | (6U == (IData)(this->__PVT__opsize)));
}

void Vagu_block_sagu::_settle__TOP__agu_block__DOT__Wagu_mod__23(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+        Vagu_block_sagu::_settle__TOP__agu_block__DOT__Wagu_mod__23\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->__PVT__banks0 = ((0xfffffffeU & this->__PVT__banks0) 
                           | (((((0U == (0x1fU & (IData)(
                                                         (vlTOPp->agu_block__DOT__p4_cmplxAddr 
                                                          >> 2U)))) 
                                 | (((((3U == (IData)(this->__PVT__opsize)) 
                                       | ((IData)(this->__PVT__opsize) 
                                          >> 2U)) | 
                                      ((0U != (3U & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr))) 
                                       & (2U == (IData)(this->__PVT__opsize)))) 
                                     | ((3U == (3U 
                                                & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr))) 
                                        & (1U == (IData)(this->__PVT__opsize)))) 
                                    & (0x1fU == (0x1fU 
                                                 & (IData)(
                                                           (vlTOPp->agu_block__DOT__p4_cmplxAddr 
                                                            >> 2U)))))) 
                                | ((((3U == (IData)(this->__PVT__opsize)) 
                                     & (0U != (3U & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr)))) 
                                    | ((IData)(this->__PVT__opsize) 
                                       >> 2U)) & (0x1eU 
                                                  == 
                                                  (0x1fU 
                                                   & (IData)(
                                                             (vlTOPp->agu_block__DOT__p4_cmplxAddr 
                                                              >> 2U)))))) 
                               | (((((4U == (IData)(this->__PVT__opsize)) 
                                     & (3U == (3U & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr)))) 
                                    | (5U == (IData)(this->__PVT__opsize))) 
                                   | (6U == (IData)(this->__PVT__opsize))) 
                                  & (0x1dU == (0x1fU 
                                               & (IData)(
                                                         (vlTOPp->agu_block__DOT__p4_cmplxAddr 
                                                          >> 2U)))))) 
                              | ((((5U == (IData)(this->__PVT__opsize)) 
                                   & (0U != (3U & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr)))) 
                                  | (6U == (IData)(this->__PVT__opsize))) 
                                 & (0x1cU == (0x1fU 
                                              & (IData)(
                                                        (vlTOPp->agu_block__DOT__p4_cmplxAddr 
                                                         >> 2U)))))));
    this->__PVT__banks0 = ((0xfffffffdU & this->__PVT__banks0) 
                           | ((((((1U == (0x1fU & (IData)(
                                                          (vlTOPp->agu_block__DOT__p4_cmplxAddr 
                                                           >> 2U)))) 
                                  << 1U) | ((((((3U 
                                                 == (IData)(this->__PVT__opsize)) 
                                                << 1U) 
                                               | (0x7ffffffeU 
                                                  & ((IData)(this->__PVT__opsize) 
                                                     >> 1U))) 
                                              | (((0U 
                                                   != 
                                                   (3U 
                                                    & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr))) 
                                                  & (2U 
                                                     == (IData)(this->__PVT__opsize))) 
                                                 << 1U)) 
                                             | (((3U 
                                                  == 
                                                  (3U 
                                                   & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr))) 
                                                 & (1U 
                                                    == (IData)(this->__PVT__opsize))) 
                                                << 1U)) 
                                            & ((0U 
                                                == 
                                                (0x1fU 
                                                 & (IData)(
                                                           (vlTOPp->agu_block__DOT__p4_cmplxAddr 
                                                            >> 2U)))) 
                                               << 1U))) 
                                | (((((3U == (IData)(this->__PVT__opsize)) 
                                      & (0U != (3U 
                                                & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr)))) 
                                     << 1U) | (0x7ffffffeU 
                                               & ((IData)(this->__PVT__opsize) 
                                                  >> 1U))) 
                                   & ((0x1fU == (0x1fU 
                                                 & (IData)(
                                                           (vlTOPp->agu_block__DOT__p4_cmplxAddr 
                                                            >> 2U)))) 
                                      << 1U))) | ((
                                                   ((((4U 
                                                       == (IData)(this->__PVT__opsize)) 
                                                      & (3U 
                                                         == 
                                                         (3U 
                                                          & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr)))) 
                                                     | (5U 
                                                        == (IData)(this->__PVT__opsize))) 
                                                    | (6U 
                                                       == (IData)(this->__PVT__opsize))) 
                                                   & (0x1eU 
                                                      == 
                                                      (0x1fU 
                                                       & (IData)(
                                                                 (vlTOPp->agu_block__DOT__p4_cmplxAddr 
                                                                  >> 2U))))) 
                                                  << 1U)) 
                              | (((((5U == (IData)(this->__PVT__opsize)) 
                                    & (0U != (3U & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr)))) 
                                   | (6U == (IData)(this->__PVT__opsize))) 
                                  & (0x1dU == (0x1fU 
                                               & (IData)(
                                                         (vlTOPp->agu_block__DOT__p4_cmplxAddr 
                                                          >> 2U))))) 
                                 << 1U)));
    this->__PVT__banks0 = ((0xfffffffbU & this->__PVT__banks0) 
                           | ((((((2U == (0x1fU & (IData)(
                                                          (vlTOPp->agu_block__DOT__p4_cmplxAddr 
                                                           >> 2U)))) 
                                  << 2U) | ((((((3U 
                                                 == (IData)(this->__PVT__opsize)) 
                                                << 2U) 
                                               | (0xfffffffcU 
                                                  & (IData)(this->__PVT__opsize))) 
                                              | (((0U 
                                                   != 
                                                   (3U 
                                                    & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr))) 
                                                  & (2U 
                                                     == (IData)(this->__PVT__opsize))) 
                                                 << 2U)) 
                                             | (((3U 
                                                  == 
                                                  (3U 
                                                   & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr))) 
                                                 & (1U 
                                                    == (IData)(this->__PVT__opsize))) 
                                                << 2U)) 
                                            & ((1U 
                                                == 
                                                (0x1fU 
                                                 & (IData)(
                                                           (vlTOPp->agu_block__DOT__p4_cmplxAddr 
                                                            >> 2U)))) 
                                               << 2U))) 
                                | (((((3U == (IData)(this->__PVT__opsize)) 
                                      & (0U != (3U 
                                                & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr)))) 
                                     << 2U) | (0xfffffffcU 
                                               & (IData)(this->__PVT__opsize))) 
                                   & ((0U == (0x1fU 
                                              & (IData)(
                                                        (vlTOPp->agu_block__DOT__p4_cmplxAddr 
                                                         >> 2U)))) 
                                      << 2U))) | ((
                                                   ((((4U 
                                                       == (IData)(this->__PVT__opsize)) 
                                                      & (3U 
                                                         == 
                                                         (3U 
                                                          & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr)))) 
                                                     | (5U 
                                                        == (IData)(this->__PVT__opsize))) 
                                                    | (6U 
                                                       == (IData)(this->__PVT__opsize))) 
                                                   & (0x1fU 
                                                      == 
                                                      (0x1fU 
                                                       & (IData)(
                                                                 (vlTOPp->agu_block__DOT__p4_cmplxAddr 
                                                                  >> 2U))))) 
                                                  << 2U)) 
                              | (((((5U == (IData)(this->__PVT__opsize)) 
                                    & (0U != (3U & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr)))) 
                                   | (6U == (IData)(this->__PVT__opsize))) 
                                  & (0x1eU == (0x1fU 
                                               & (IData)(
                                                         (vlTOPp->agu_block__DOT__p4_cmplxAddr 
                                                          >> 2U))))) 
                                 << 2U)));
    this->__PVT__banks0 = ((0xfffffff7U & this->__PVT__banks0) 
                           | ((((((3U == (0x1fU & (IData)(
                                                          (vlTOPp->agu_block__DOT__p4_cmplxAddr 
                                                           >> 2U)))) 
                                  << 3U) | ((((((3U 
                                                 == (IData)(this->__PVT__opsize)) 
                                                << 3U) 
                                               | (0xfffffff8U 
                                                  & ((IData)(this->__PVT__opsize) 
                                                     << 1U))) 
                                              | (((0U 
                                                   != 
                                                   (3U 
                                                    & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr))) 
                                                  & (2U 
                                                     == (IData)(this->__PVT__opsize))) 
                                                 << 3U)) 
                                             | (((3U 
                                                  == 
                                                  (3U 
                                                   & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr))) 
                                                 & (1U 
                                                    == (IData)(this->__PVT__opsize))) 
                                                << 3U)) 
                                            & ((2U 
                                                == 
                                                (0x1fU 
                                                 & (IData)(
                                                           (vlTOPp->agu_block__DOT__p4_cmplxAddr 
                                                            >> 2U)))) 
                                               << 3U))) 
                                | (((((3U == (IData)(this->__PVT__opsize)) 
                                      & (0U != (3U 
                                                & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr)))) 
                                     << 3U) | (0xfffffff8U 
                                               & ((IData)(this->__PVT__opsize) 
                                                  << 1U))) 
                                   & ((1U == (0x1fU 
                                              & (IData)(
                                                        (vlTOPp->agu_block__DOT__p4_cmplxAddr 
                                                         >> 2U)))) 
                                      << 3U))) | ((
                                                   ((((4U 
                                                       == (IData)(this->__PVT__opsize)) 
                                                      & (3U 
                                                         == 
                                                         (3U 
                                                          & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr)))) 
                                                     | (5U 
                                                        == (IData)(this->__PVT__opsize))) 
                                                    | (6U 
                                                       == (IData)(this->__PVT__opsize))) 
                                                   & (0U 
                                                      == 
                                                      (0x1fU 
                                                       & (IData)(
                                                                 (vlTOPp->agu_block__DOT__p4_cmplxAddr 
                                                                  >> 2U))))) 
                                                  << 3U)) 
                              | (((((5U == (IData)(this->__PVT__opsize)) 
                                    & (0U != (3U & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr)))) 
                                   | (6U == (IData)(this->__PVT__opsize))) 
                                  & (0x1fU == (0x1fU 
                                               & (IData)(
                                                         (vlTOPp->agu_block__DOT__p4_cmplxAddr 
                                                          >> 2U))))) 
                                 << 3U)));
    this->__PVT__banks0 = ((0xffffffefU & this->__PVT__banks0) 
                           | ((((((4U == (0x1fU & (IData)(
                                                          (vlTOPp->agu_block__DOT__p4_cmplxAddr 
                                                           >> 2U)))) 
                                  << 4U) | ((((((3U 
                                                 == (IData)(this->__PVT__opsize)) 
                                                << 4U) 
                                               | (0xfffffff0U 
                                                  & ((IData)(this->__PVT__opsize) 
                                                     << 2U))) 
                                              | (((0U 
                                                   != 
                                                   (3U 
                                                    & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr))) 
                                                  & (2U 
                                                     == (IData)(this->__PVT__opsize))) 
                                                 << 4U)) 
                                             | (((3U 
                                                  == 
                                                  (3U 
                                                   & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr))) 
                                                 & (1U 
                                                    == (IData)(this->__PVT__opsize))) 
                                                << 4U)) 
                                            & ((3U 
                                                == 
                                                (0x1fU 
                                                 & (IData)(
                                                           (vlTOPp->agu_block__DOT__p4_cmplxAddr 
                                                            >> 2U)))) 
                                               << 4U))) 
                                | (((((3U == (IData)(this->__PVT__opsize)) 
                                      & (0U != (3U 
                                                & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr)))) 
                                     << 4U) | (0xfffffff0U 
                                               & ((IData)(this->__PVT__opsize) 
                                                  << 2U))) 
                                   & ((2U == (0x1fU 
                                              & (IData)(
                                                        (vlTOPp->agu_block__DOT__p4_cmplxAddr 
                                                         >> 2U)))) 
                                      << 4U))) | ((
                                                   ((((4U 
                                                       == (IData)(this->__PVT__opsize)) 
                                                      & (3U 
                                                         == 
                                                         (3U 
                                                          & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr)))) 
                                                     | (5U 
                                                        == (IData)(this->__PVT__opsize))) 
                                                    | (6U 
                                                       == (IData)(this->__PVT__opsize))) 
                                                   & (1U 
                                                      == 
                                                      (0x1fU 
                                                       & (IData)(
                                                                 (vlTOPp->agu_block__DOT__p4_cmplxAddr 
                                                                  >> 2U))))) 
                                                  << 4U)) 
                              | (((((5U == (IData)(this->__PVT__opsize)) 
                                    & (0U != (3U & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr)))) 
                                   | (6U == (IData)(this->__PVT__opsize))) 
                                  & (0U == (0x1fU & (IData)(
                                                            (vlTOPp->agu_block__DOT__p4_cmplxAddr 
                                                             >> 2U))))) 
                                 << 4U)));
    this->__PVT__banks0 = ((0xffffffdfU & this->__PVT__banks0) 
                           | ((((((5U == (0x1fU & (IData)(
                                                          (vlTOPp->agu_block__DOT__p4_cmplxAddr 
                                                           >> 2U)))) 
                                  << 5U) | ((((((3U 
                                                 == (IData)(this->__PVT__opsize)) 
                                                << 5U) 
                                               | (0xffffffe0U 
                                                  & ((IData)(this->__PVT__opsize) 
                                                     << 3U))) 
                                              | (((0U 
                                                   != 
                                                   (3U 
                                                    & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr))) 
                                                  & (2U 
                                                     == (IData)(this->__PVT__opsize))) 
                                                 << 5U)) 
                                             | (((3U 
                                                  == 
                                                  (3U 
                                                   & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr))) 
                                                 & (1U 
                                                    == (IData)(this->__PVT__opsize))) 
                                                << 5U)) 
                                            & ((4U 
                                                == 
                                                (0x1fU 
                                                 & (IData)(
                                                           (vlTOPp->agu_block__DOT__p4_cmplxAddr 
                                                            >> 2U)))) 
                                               << 5U))) 
                                | (((((3U == (IData)(this->__PVT__opsize)) 
                                      & (0U != (3U 
                                                & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr)))) 
                                     << 5U) | (0xffffffe0U 
                                               & ((IData)(this->__PVT__opsize) 
                                                  << 3U))) 
                                   & ((3U == (0x1fU 
                                              & (IData)(
                                                        (vlTOPp->agu_block__DOT__p4_cmplxAddr 
                                                         >> 2U)))) 
                                      << 5U))) | ((
                                                   ((((4U 
                                                       == (IData)(this->__PVT__opsize)) 
                                                      & (3U 
                                                         == 
                                                         (3U 
                                                          & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr)))) 
                                                     | (5U 
                                                        == (IData)(this->__PVT__opsize))) 
                                                    | (6U 
                                                       == (IData)(this->__PVT__opsize))) 
                                                   & (2U 
                                                      == 
                                                      (0x1fU 
                                                       & (IData)(
                                                                 (vlTOPp->agu_block__DOT__p4_cmplxAddr 
                                                                  >> 2U))))) 
                                                  << 5U)) 
                              | (((((5U == (IData)(this->__PVT__opsize)) 
                                    & (0U != (3U & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr)))) 
                                   | (6U == (IData)(this->__PVT__opsize))) 
                                  & (1U == (0x1fU & (IData)(
                                                            (vlTOPp->agu_block__DOT__p4_cmplxAddr 
                                                             >> 2U))))) 
                                 << 5U)));
    this->__PVT__banks0 = ((0xffffffbfU & this->__PVT__banks0) 
                           | ((((((6U == (0x1fU & (IData)(
                                                          (vlTOPp->agu_block__DOT__p4_cmplxAddr 
                                                           >> 2U)))) 
                                  << 6U) | ((((((3U 
                                                 == (IData)(this->__PVT__opsize)) 
                                                << 6U) 
                                               | (0xffffffc0U 
                                                  & ((IData)(this->__PVT__opsize) 
                                                     << 4U))) 
                                              | (((0U 
                                                   != 
                                                   (3U 
                                                    & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr))) 
                                                  & (2U 
                                                     == (IData)(this->__PVT__opsize))) 
                                                 << 6U)) 
                                             | (((3U 
                                                  == 
                                                  (3U 
                                                   & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr))) 
                                                 & (1U 
                                                    == (IData)(this->__PVT__opsize))) 
                                                << 6U)) 
                                            & ((5U 
                                                == 
                                                (0x1fU 
                                                 & (IData)(
                                                           (vlTOPp->agu_block__DOT__p4_cmplxAddr 
                                                            >> 2U)))) 
                                               << 6U))) 
                                | (((((3U == (IData)(this->__PVT__opsize)) 
                                      & (0U != (3U 
                                                & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr)))) 
                                     << 6U) | (0xffffffc0U 
                                               & ((IData)(this->__PVT__opsize) 
                                                  << 4U))) 
                                   & ((4U == (0x1fU 
                                              & (IData)(
                                                        (vlTOPp->agu_block__DOT__p4_cmplxAddr 
                                                         >> 2U)))) 
                                      << 6U))) | ((
                                                   ((((4U 
                                                       == (IData)(this->__PVT__opsize)) 
                                                      & (3U 
                                                         == 
                                                         (3U 
                                                          & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr)))) 
                                                     | (5U 
                                                        == (IData)(this->__PVT__opsize))) 
                                                    | (6U 
                                                       == (IData)(this->__PVT__opsize))) 
                                                   & (3U 
                                                      == 
                                                      (0x1fU 
                                                       & (IData)(
                                                                 (vlTOPp->agu_block__DOT__p4_cmplxAddr 
                                                                  >> 2U))))) 
                                                  << 6U)) 
                              | (((((5U == (IData)(this->__PVT__opsize)) 
                                    & (0U != (3U & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr)))) 
                                   | (6U == (IData)(this->__PVT__opsize))) 
                                  & (2U == (0x1fU & (IData)(
                                                            (vlTOPp->agu_block__DOT__p4_cmplxAddr 
                                                             >> 2U))))) 
                                 << 6U)));
    this->__PVT__banks0 = ((0xffffff7fU & this->__PVT__banks0) 
                           | ((((((7U == (0x1fU & (IData)(
                                                          (vlTOPp->agu_block__DOT__p4_cmplxAddr 
                                                           >> 2U)))) 
                                  << 7U) | ((((((3U 
                                                 == (IData)(this->__PVT__opsize)) 
                                                << 7U) 
                                               | (0xffffff80U 
                                                  & ((IData)(this->__PVT__opsize) 
                                                     << 5U))) 
                                              | (((0U 
                                                   != 
                                                   (3U 
                                                    & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr))) 
                                                  & (2U 
                                                     == (IData)(this->__PVT__opsize))) 
                                                 << 7U)) 
                                             | (((3U 
                                                  == 
                                                  (3U 
                                                   & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr))) 
                                                 & (1U 
                                                    == (IData)(this->__PVT__opsize))) 
                                                << 7U)) 
                                            & ((6U 
                                                == 
                                                (0x1fU 
                                                 & (IData)(
                                                           (vlTOPp->agu_block__DOT__p4_cmplxAddr 
                                                            >> 2U)))) 
                                               << 7U))) 
                                | (((((3U == (IData)(this->__PVT__opsize)) 
                                      & (0U != (3U 
                                                & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr)))) 
                                     << 7U) | (0xffffff80U 
                                               & ((IData)(this->__PVT__opsize) 
                                                  << 5U))) 
                                   & ((5U == (0x1fU 
                                              & (IData)(
                                                        (vlTOPp->agu_block__DOT__p4_cmplxAddr 
                                                         >> 2U)))) 
                                      << 7U))) | ((
                                                   ((((4U 
                                                       == (IData)(this->__PVT__opsize)) 
                                                      & (3U 
                                                         == 
                                                         (3U 
                                                          & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr)))) 
                                                     | (5U 
                                                        == (IData)(this->__PVT__opsize))) 
                                                    | (6U 
                                                       == (IData)(this->__PVT__opsize))) 
                                                   & (4U 
                                                      == 
                                                      (0x1fU 
                                                       & (IData)(
                                                                 (vlTOPp->agu_block__DOT__p4_cmplxAddr 
                                                                  >> 2U))))) 
                                                  << 7U)) 
                              | (((((5U == (IData)(this->__PVT__opsize)) 
                                    & (0U != (3U & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr)))) 
                                   | (6U == (IData)(this->__PVT__opsize))) 
                                  & (3U == (0x1fU & (IData)(
                                                            (vlTOPp->agu_block__DOT__p4_cmplxAddr 
                                                             >> 2U))))) 
                                 << 7U)));
    this->__PVT__banks0 = ((0xfffffeffU & this->__PVT__banks0) 
                           | ((((((8U == (0x1fU & (IData)(
                                                          (vlTOPp->agu_block__DOT__p4_cmplxAddr 
                                                           >> 2U)))) 
                                  << 8U) | ((((((3U 
                                                 == (IData)(this->__PVT__opsize)) 
                                                << 8U) 
                                               | (0xffffff00U 
                                                  & ((IData)(this->__PVT__opsize) 
                                                     << 6U))) 
                                              | (((0U 
                                                   != 
                                                   (3U 
                                                    & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr))) 
                                                  & (2U 
                                                     == (IData)(this->__PVT__opsize))) 
                                                 << 8U)) 
                                             | (((3U 
                                                  == 
                                                  (3U 
                                                   & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr))) 
                                                 & (1U 
                                                    == (IData)(this->__PVT__opsize))) 
                                                << 8U)) 
                                            & ((7U 
                                                == 
                                                (0x1fU 
                                                 & (IData)(
                                                           (vlTOPp->agu_block__DOT__p4_cmplxAddr 
                                                            >> 2U)))) 
                                               << 8U))) 
                                | (((((3U == (IData)(this->__PVT__opsize)) 
                                      & (0U != (3U 
                                                & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr)))) 
                                     << 8U) | (0xffffff00U 
                                               & ((IData)(this->__PVT__opsize) 
                                                  << 6U))) 
                                   & ((6U == (0x1fU 
                                              & (IData)(
                                                        (vlTOPp->agu_block__DOT__p4_cmplxAddr 
                                                         >> 2U)))) 
                                      << 8U))) | ((
                                                   ((((4U 
                                                       == (IData)(this->__PVT__opsize)) 
                                                      & (3U 
                                                         == 
                                                         (3U 
                                                          & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr)))) 
                                                     | (5U 
                                                        == (IData)(this->__PVT__opsize))) 
                                                    | (6U 
                                                       == (IData)(this->__PVT__opsize))) 
                                                   & (5U 
                                                      == 
                                                      (0x1fU 
                                                       & (IData)(
                                                                 (vlTOPp->agu_block__DOT__p4_cmplxAddr 
                                                                  >> 2U))))) 
                                                  << 8U)) 
                              | (((((5U == (IData)(this->__PVT__opsize)) 
                                    & (0U != (3U & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr)))) 
                                   | (6U == (IData)(this->__PVT__opsize))) 
                                  & (4U == (0x1fU & (IData)(
                                                            (vlTOPp->agu_block__DOT__p4_cmplxAddr 
                                                             >> 2U))))) 
                                 << 8U)));
    this->__PVT__banks0 = ((0xfffffdffU & this->__PVT__banks0) 
                           | ((((((9U == (0x1fU & (IData)(
                                                          (vlTOPp->agu_block__DOT__p4_cmplxAddr 
                                                           >> 2U)))) 
                                  << 9U) | ((((((3U 
                                                 == (IData)(this->__PVT__opsize)) 
                                                << 9U) 
                                               | (0xfffffe00U 
                                                  & ((IData)(this->__PVT__opsize) 
                                                     << 7U))) 
                                              | (((0U 
                                                   != 
                                                   (3U 
                                                    & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr))) 
                                                  & (2U 
                                                     == (IData)(this->__PVT__opsize))) 
                                                 << 9U)) 
                                             | (((3U 
                                                  == 
                                                  (3U 
                                                   & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr))) 
                                                 & (1U 
                                                    == (IData)(this->__PVT__opsize))) 
                                                << 9U)) 
                                            & ((8U 
                                                == 
                                                (0x1fU 
                                                 & (IData)(
                                                           (vlTOPp->agu_block__DOT__p4_cmplxAddr 
                                                            >> 2U)))) 
                                               << 9U))) 
                                | (((((3U == (IData)(this->__PVT__opsize)) 
                                      & (0U != (3U 
                                                & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr)))) 
                                     << 9U) | (0xfffffe00U 
                                               & ((IData)(this->__PVT__opsize) 
                                                  << 7U))) 
                                   & ((7U == (0x1fU 
                                              & (IData)(
                                                        (vlTOPp->agu_block__DOT__p4_cmplxAddr 
                                                         >> 2U)))) 
                                      << 9U))) | ((
                                                   ((((4U 
                                                       == (IData)(this->__PVT__opsize)) 
                                                      & (3U 
                                                         == 
                                                         (3U 
                                                          & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr)))) 
                                                     | (5U 
                                                        == (IData)(this->__PVT__opsize))) 
                                                    | (6U 
                                                       == (IData)(this->__PVT__opsize))) 
                                                   & (6U 
                                                      == 
                                                      (0x1fU 
                                                       & (IData)(
                                                                 (vlTOPp->agu_block__DOT__p4_cmplxAddr 
                                                                  >> 2U))))) 
                                                  << 9U)) 
                              | (((((5U == (IData)(this->__PVT__opsize)) 
                                    & (0U != (3U & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr)))) 
                                   | (6U == (IData)(this->__PVT__opsize))) 
                                  & (5U == (0x1fU & (IData)(
                                                            (vlTOPp->agu_block__DOT__p4_cmplxAddr 
                                                             >> 2U))))) 
                                 << 9U)));
    this->__PVT__banks0 = ((0xfffffbffU & this->__PVT__banks0) 
                           | ((((((0xaU == (0x1fU & (IData)(
                                                            (vlTOPp->agu_block__DOT__p4_cmplxAddr 
                                                             >> 2U)))) 
                                  << 0xaU) | ((((((3U 
                                                   == (IData)(this->__PVT__opsize)) 
                                                  << 0xaU) 
                                                 | (0xfffffc00U 
                                                    & ((IData)(this->__PVT__opsize) 
                                                       << 8U))) 
                                                | (((0U 
                                                     != 
                                                     (3U 
                                                      & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr))) 
                                                    & (2U 
                                                       == (IData)(this->__PVT__opsize))) 
                                                   << 0xaU)) 
                                               | (((3U 
                                                    == 
                                                    (3U 
                                                     & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr))) 
                                                   & (1U 
                                                      == (IData)(this->__PVT__opsize))) 
                                                  << 0xaU)) 
                                              & ((9U 
                                                  == 
                                                  (0x1fU 
                                                   & (IData)(
                                                             (vlTOPp->agu_block__DOT__p4_cmplxAddr 
                                                              >> 2U)))) 
                                                 << 0xaU))) 
                                | (((((3U == (IData)(this->__PVT__opsize)) 
                                      & (0U != (3U 
                                                & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr)))) 
                                     << 0xaU) | (0xfffffc00U 
                                                 & ((IData)(this->__PVT__opsize) 
                                                    << 8U))) 
                                   & ((8U == (0x1fU 
                                              & (IData)(
                                                        (vlTOPp->agu_block__DOT__p4_cmplxAddr 
                                                         >> 2U)))) 
                                      << 0xaU))) | 
                               ((((((4U == (IData)(this->__PVT__opsize)) 
                                    & (3U == (3U & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr)))) 
                                   | (5U == (IData)(this->__PVT__opsize))) 
                                  | (6U == (IData)(this->__PVT__opsize))) 
                                 & (7U == (0x1fU & (IData)(
                                                           (vlTOPp->agu_block__DOT__p4_cmplxAddr 
                                                            >> 2U))))) 
                                << 0xaU)) | (((((5U 
                                                 == (IData)(this->__PVT__opsize)) 
                                                & (0U 
                                                   != 
                                                   (3U 
                                                    & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr)))) 
                                               | (6U 
                                                  == (IData)(this->__PVT__opsize))) 
                                              & (6U 
                                                 == 
                                                 (0x1fU 
                                                  & (IData)(
                                                            (vlTOPp->agu_block__DOT__p4_cmplxAddr 
                                                             >> 2U))))) 
                                             << 0xaU)));
    this->__PVT__banks0 = ((0xfffff7ffU & this->__PVT__banks0) 
                           | ((((((0xbU == (0x1fU & (IData)(
                                                            (vlTOPp->agu_block__DOT__p4_cmplxAddr 
                                                             >> 2U)))) 
                                  << 0xbU) | ((((((3U 
                                                   == (IData)(this->__PVT__opsize)) 
                                                  << 0xbU) 
                                                 | (0xfffff800U 
                                                    & ((IData)(this->__PVT__opsize) 
                                                       << 9U))) 
                                                | (((0U 
                                                     != 
                                                     (3U 
                                                      & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr))) 
                                                    & (2U 
                                                       == (IData)(this->__PVT__opsize))) 
                                                   << 0xbU)) 
                                               | (((3U 
                                                    == 
                                                    (3U 
                                                     & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr))) 
                                                   & (1U 
                                                      == (IData)(this->__PVT__opsize))) 
                                                  << 0xbU)) 
                                              & ((0xaU 
                                                  == 
                                                  (0x1fU 
                                                   & (IData)(
                                                             (vlTOPp->agu_block__DOT__p4_cmplxAddr 
                                                              >> 2U)))) 
                                                 << 0xbU))) 
                                | (((((3U == (IData)(this->__PVT__opsize)) 
                                      & (0U != (3U 
                                                & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr)))) 
                                     << 0xbU) | (0xfffff800U 
                                                 & ((IData)(this->__PVT__opsize) 
                                                    << 9U))) 
                                   & ((9U == (0x1fU 
                                              & (IData)(
                                                        (vlTOPp->agu_block__DOT__p4_cmplxAddr 
                                                         >> 2U)))) 
                                      << 0xbU))) | 
                               ((((((4U == (IData)(this->__PVT__opsize)) 
                                    & (3U == (3U & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr)))) 
                                   | (5U == (IData)(this->__PVT__opsize))) 
                                  | (6U == (IData)(this->__PVT__opsize))) 
                                 & (8U == (0x1fU & (IData)(
                                                           (vlTOPp->agu_block__DOT__p4_cmplxAddr 
                                                            >> 2U))))) 
                                << 0xbU)) | (((((5U 
                                                 == (IData)(this->__PVT__opsize)) 
                                                & (0U 
                                                   != 
                                                   (3U 
                                                    & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr)))) 
                                               | (6U 
                                                  == (IData)(this->__PVT__opsize))) 
                                              & (7U 
                                                 == 
                                                 (0x1fU 
                                                  & (IData)(
                                                            (vlTOPp->agu_block__DOT__p4_cmplxAddr 
                                                             >> 2U))))) 
                                             << 0xbU)));
    this->__PVT__banks0 = ((0xffffefffU & this->__PVT__banks0) 
                           | ((((((0xcU == (0x1fU & (IData)(
                                                            (vlTOPp->agu_block__DOT__p4_cmplxAddr 
                                                             >> 2U)))) 
                                  << 0xcU) | ((((((3U 
                                                   == (IData)(this->__PVT__opsize)) 
                                                  << 0xcU) 
                                                 | (0xfffff000U 
                                                    & ((IData)(this->__PVT__opsize) 
                                                       << 0xaU))) 
                                                | (((0U 
                                                     != 
                                                     (3U 
                                                      & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr))) 
                                                    & (2U 
                                                       == (IData)(this->__PVT__opsize))) 
                                                   << 0xcU)) 
                                               | (((3U 
                                                    == 
                                                    (3U 
                                                     & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr))) 
                                                   & (1U 
                                                      == (IData)(this->__PVT__opsize))) 
                                                  << 0xcU)) 
                                              & ((0xbU 
                                                  == 
                                                  (0x1fU 
                                                   & (IData)(
                                                             (vlTOPp->agu_block__DOT__p4_cmplxAddr 
                                                              >> 2U)))) 
                                                 << 0xcU))) 
                                | (((((3U == (IData)(this->__PVT__opsize)) 
                                      & (0U != (3U 
                                                & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr)))) 
                                     << 0xcU) | (0xfffff000U 
                                                 & ((IData)(this->__PVT__opsize) 
                                                    << 0xaU))) 
                                   & ((0xaU == (0x1fU 
                                                & (IData)(
                                                          (vlTOPp->agu_block__DOT__p4_cmplxAddr 
                                                           >> 2U)))) 
                                      << 0xcU))) | 
                               ((((((4U == (IData)(this->__PVT__opsize)) 
                                    & (3U == (3U & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr)))) 
                                   | (5U == (IData)(this->__PVT__opsize))) 
                                  | (6U == (IData)(this->__PVT__opsize))) 
                                 & (9U == (0x1fU & (IData)(
                                                           (vlTOPp->agu_block__DOT__p4_cmplxAddr 
                                                            >> 2U))))) 
                                << 0xcU)) | (((((5U 
                                                 == (IData)(this->__PVT__opsize)) 
                                                & (0U 
                                                   != 
                                                   (3U 
                                                    & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr)))) 
                                               | (6U 
                                                  == (IData)(this->__PVT__opsize))) 
                                              & (8U 
                                                 == 
                                                 (0x1fU 
                                                  & (IData)(
                                                            (vlTOPp->agu_block__DOT__p4_cmplxAddr 
                                                             >> 2U))))) 
                                             << 0xcU)));
    this->__PVT__banks0 = ((0xffffdfffU & this->__PVT__banks0) 
                           | ((((((0xdU == (0x1fU & (IData)(
                                                            (vlTOPp->agu_block__DOT__p4_cmplxAddr 
                                                             >> 2U)))) 
                                  << 0xdU) | ((((((3U 
                                                   == (IData)(this->__PVT__opsize)) 
                                                  << 0xdU) 
                                                 | (0xffffe000U 
                                                    & ((IData)(this->__PVT__opsize) 
                                                       << 0xbU))) 
                                                | (((0U 
                                                     != 
                                                     (3U 
                                                      & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr))) 
                                                    & (2U 
                                                       == (IData)(this->__PVT__opsize))) 
                                                   << 0xdU)) 
                                               | (((3U 
                                                    == 
                                                    (3U 
                                                     & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr))) 
                                                   & (1U 
                                                      == (IData)(this->__PVT__opsize))) 
                                                  << 0xdU)) 
                                              & ((0xcU 
                                                  == 
                                                  (0x1fU 
                                                   & (IData)(
                                                             (vlTOPp->agu_block__DOT__p4_cmplxAddr 
                                                              >> 2U)))) 
                                                 << 0xdU))) 
                                | (((((3U == (IData)(this->__PVT__opsize)) 
                                      & (0U != (3U 
                                                & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr)))) 
                                     << 0xdU) | (0xffffe000U 
                                                 & ((IData)(this->__PVT__opsize) 
                                                    << 0xbU))) 
                                   & ((0xbU == (0x1fU 
                                                & (IData)(
                                                          (vlTOPp->agu_block__DOT__p4_cmplxAddr 
                                                           >> 2U)))) 
                                      << 0xdU))) | 
                               ((((((4U == (IData)(this->__PVT__opsize)) 
                                    & (3U == (3U & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr)))) 
                                   | (5U == (IData)(this->__PVT__opsize))) 
                                  | (6U == (IData)(this->__PVT__opsize))) 
                                 & (0xaU == (0x1fU 
                                             & (IData)(
                                                       (vlTOPp->agu_block__DOT__p4_cmplxAddr 
                                                        >> 2U))))) 
                                << 0xdU)) | (((((5U 
                                                 == (IData)(this->__PVT__opsize)) 
                                                & (0U 
                                                   != 
                                                   (3U 
                                                    & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr)))) 
                                               | (6U 
                                                  == (IData)(this->__PVT__opsize))) 
                                              & (9U 
                                                 == 
                                                 (0x1fU 
                                                  & (IData)(
                                                            (vlTOPp->agu_block__DOT__p4_cmplxAddr 
                                                             >> 2U))))) 
                                             << 0xdU)));
    this->__PVT__banks0 = ((0xffffbfffU & this->__PVT__banks0) 
                           | ((((((0xeU == (0x1fU & (IData)(
                                                            (vlTOPp->agu_block__DOT__p4_cmplxAddr 
                                                             >> 2U)))) 
                                  << 0xeU) | ((((((3U 
                                                   == (IData)(this->__PVT__opsize)) 
                                                  << 0xeU) 
                                                 | (0xffffc000U 
                                                    & ((IData)(this->__PVT__opsize) 
                                                       << 0xcU))) 
                                                | (((0U 
                                                     != 
                                                     (3U 
                                                      & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr))) 
                                                    & (2U 
                                                       == (IData)(this->__PVT__opsize))) 
                                                   << 0xeU)) 
                                               | (((3U 
                                                    == 
                                                    (3U 
                                                     & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr))) 
                                                   & (1U 
                                                      == (IData)(this->__PVT__opsize))) 
                                                  << 0xeU)) 
                                              & ((0xdU 
                                                  == 
                                                  (0x1fU 
                                                   & (IData)(
                                                             (vlTOPp->agu_block__DOT__p4_cmplxAddr 
                                                              >> 2U)))) 
                                                 << 0xeU))) 
                                | (((((3U == (IData)(this->__PVT__opsize)) 
                                      & (0U != (3U 
                                                & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr)))) 
                                     << 0xeU) | (0xffffc000U 
                                                 & ((IData)(this->__PVT__opsize) 
                                                    << 0xcU))) 
                                   & ((0xcU == (0x1fU 
                                                & (IData)(
                                                          (vlTOPp->agu_block__DOT__p4_cmplxAddr 
                                                           >> 2U)))) 
                                      << 0xeU))) | 
                               ((((((4U == (IData)(this->__PVT__opsize)) 
                                    & (3U == (3U & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr)))) 
                                   | (5U == (IData)(this->__PVT__opsize))) 
                                  | (6U == (IData)(this->__PVT__opsize))) 
                                 & (0xbU == (0x1fU 
                                             & (IData)(
                                                       (vlTOPp->agu_block__DOT__p4_cmplxAddr 
                                                        >> 2U))))) 
                                << 0xeU)) | (((((5U 
                                                 == (IData)(this->__PVT__opsize)) 
                                                & (0U 
                                                   != 
                                                   (3U 
                                                    & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr)))) 
                                               | (6U 
                                                  == (IData)(this->__PVT__opsize))) 
                                              & (0xaU 
                                                 == 
                                                 (0x1fU 
                                                  & (IData)(
                                                            (vlTOPp->agu_block__DOT__p4_cmplxAddr 
                                                             >> 2U))))) 
                                             << 0xeU)));
    this->__PVT__banks0 = ((0xffff7fffU & this->__PVT__banks0) 
                           | ((((((0xfU == (0x1fU & (IData)(
                                                            (vlTOPp->agu_block__DOT__p4_cmplxAddr 
                                                             >> 2U)))) 
                                  << 0xfU) | ((((((3U 
                                                   == (IData)(this->__PVT__opsize)) 
                                                  << 0xfU) 
                                                 | (0xffff8000U 
                                                    & ((IData)(this->__PVT__opsize) 
                                                       << 0xdU))) 
                                                | (((0U 
                                                     != 
                                                     (3U 
                                                      & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr))) 
                                                    & (2U 
                                                       == (IData)(this->__PVT__opsize))) 
                                                   << 0xfU)) 
                                               | (((3U 
                                                    == 
                                                    (3U 
                                                     & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr))) 
                                                   & (1U 
                                                      == (IData)(this->__PVT__opsize))) 
                                                  << 0xfU)) 
                                              & ((0xeU 
                                                  == 
                                                  (0x1fU 
                                                   & (IData)(
                                                             (vlTOPp->agu_block__DOT__p4_cmplxAddr 
                                                              >> 2U)))) 
                                                 << 0xfU))) 
                                | (((((3U == (IData)(this->__PVT__opsize)) 
                                      & (0U != (3U 
                                                & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr)))) 
                                     << 0xfU) | (0xffff8000U 
                                                 & ((IData)(this->__PVT__opsize) 
                                                    << 0xdU))) 
                                   & ((0xdU == (0x1fU 
                                                & (IData)(
                                                          (vlTOPp->agu_block__DOT__p4_cmplxAddr 
                                                           >> 2U)))) 
                                      << 0xfU))) | 
                               ((((((4U == (IData)(this->__PVT__opsize)) 
                                    & (3U == (3U & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr)))) 
                                   | (5U == (IData)(this->__PVT__opsize))) 
                                  | (6U == (IData)(this->__PVT__opsize))) 
                                 & (0xcU == (0x1fU 
                                             & (IData)(
                                                       (vlTOPp->agu_block__DOT__p4_cmplxAddr 
                                                        >> 2U))))) 
                                << 0xfU)) | (((((5U 
                                                 == (IData)(this->__PVT__opsize)) 
                                                & (0U 
                                                   != 
                                                   (3U 
                                                    & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr)))) 
                                               | (6U 
                                                  == (IData)(this->__PVT__opsize))) 
                                              & (0xbU 
                                                 == 
                                                 (0x1fU 
                                                  & (IData)(
                                                            (vlTOPp->agu_block__DOT__p4_cmplxAddr 
                                                             >> 2U))))) 
                                             << 0xfU)));
    this->__PVT__banks0 = ((0xfffeffffU & this->__PVT__banks0) 
                           | ((((((0x10U == (0x1fU 
                                             & (IData)(
                                                       (vlTOPp->agu_block__DOT__p4_cmplxAddr 
                                                        >> 2U)))) 
                                  << 0x10U) | (((((
                                                   (3U 
                                                    == (IData)(this->__PVT__opsize)) 
                                                   << 0x10U) 
                                                  | (0xffff0000U 
                                                     & ((IData)(this->__PVT__opsize) 
                                                        << 0xeU))) 
                                                 | (((0U 
                                                      != 
                                                      (3U 
                                                       & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr))) 
                                                     & (2U 
                                                        == (IData)(this->__PVT__opsize))) 
                                                    << 0x10U)) 
                                                | (((3U 
                                                     == 
                                                     (3U 
                                                      & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr))) 
                                                    & (1U 
                                                       == (IData)(this->__PVT__opsize))) 
                                                   << 0x10U)) 
                                               & ((0xfU 
                                                   == 
                                                   (0x1fU 
                                                    & (IData)(
                                                              (vlTOPp->agu_block__DOT__p4_cmplxAddr 
                                                               >> 2U)))) 
                                                  << 0x10U))) 
                                | (((((3U == (IData)(this->__PVT__opsize)) 
                                      & (0U != (3U 
                                                & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr)))) 
                                     << 0x10U) | (0xffff0000U 
                                                  & ((IData)(this->__PVT__opsize) 
                                                     << 0xeU))) 
                                   & ((0xeU == (0x1fU 
                                                & (IData)(
                                                          (vlTOPp->agu_block__DOT__p4_cmplxAddr 
                                                           >> 2U)))) 
                                      << 0x10U))) | 
                               ((((((4U == (IData)(this->__PVT__opsize)) 
                                    & (3U == (3U & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr)))) 
                                   | (5U == (IData)(this->__PVT__opsize))) 
                                  | (6U == (IData)(this->__PVT__opsize))) 
                                 & (0xdU == (0x1fU 
                                             & (IData)(
                                                       (vlTOPp->agu_block__DOT__p4_cmplxAddr 
                                                        >> 2U))))) 
                                << 0x10U)) | (((((5U 
                                                  == (IData)(this->__PVT__opsize)) 
                                                 & (0U 
                                                    != 
                                                    (3U 
                                                     & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr)))) 
                                                | (6U 
                                                   == (IData)(this->__PVT__opsize))) 
                                               & (0xcU 
                                                  == 
                                                  (0x1fU 
                                                   & (IData)(
                                                             (vlTOPp->agu_block__DOT__p4_cmplxAddr 
                                                              >> 2U))))) 
                                              << 0x10U)));
    this->__PVT__banks0 = ((0xfffdffffU & this->__PVT__banks0) 
                           | ((((((0x11U == (0x1fU 
                                             & (IData)(
                                                       (vlTOPp->agu_block__DOT__p4_cmplxAddr 
                                                        >> 2U)))) 
                                  << 0x11U) | (((((
                                                   (3U 
                                                    == (IData)(this->__PVT__opsize)) 
                                                   << 0x11U) 
                                                  | (0xfffe0000U 
                                                     & ((IData)(this->__PVT__opsize) 
                                                        << 0xfU))) 
                                                 | (((0U 
                                                      != 
                                                      (3U 
                                                       & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr))) 
                                                     & (2U 
                                                        == (IData)(this->__PVT__opsize))) 
                                                    << 0x11U)) 
                                                | (((3U 
                                                     == 
                                                     (3U 
                                                      & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr))) 
                                                    & (1U 
                                                       == (IData)(this->__PVT__opsize))) 
                                                   << 0x11U)) 
                                               & ((0x10U 
                                                   == 
                                                   (0x1fU 
                                                    & (IData)(
                                                              (vlTOPp->agu_block__DOT__p4_cmplxAddr 
                                                               >> 2U)))) 
                                                  << 0x11U))) 
                                | (((((3U == (IData)(this->__PVT__opsize)) 
                                      & (0U != (3U 
                                                & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr)))) 
                                     << 0x11U) | (0xfffe0000U 
                                                  & ((IData)(this->__PVT__opsize) 
                                                     << 0xfU))) 
                                   & ((0xfU == (0x1fU 
                                                & (IData)(
                                                          (vlTOPp->agu_block__DOT__p4_cmplxAddr 
                                                           >> 2U)))) 
                                      << 0x11U))) | 
                               ((((((4U == (IData)(this->__PVT__opsize)) 
                                    & (3U == (3U & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr)))) 
                                   | (5U == (IData)(this->__PVT__opsize))) 
                                  | (6U == (IData)(this->__PVT__opsize))) 
                                 & (0xeU == (0x1fU 
                                             & (IData)(
                                                       (vlTOPp->agu_block__DOT__p4_cmplxAddr 
                                                        >> 2U))))) 
                                << 0x11U)) | (((((5U 
                                                  == (IData)(this->__PVT__opsize)) 
                                                 & (0U 
                                                    != 
                                                    (3U 
                                                     & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr)))) 
                                                | (6U 
                                                   == (IData)(this->__PVT__opsize))) 
                                               & (0xdU 
                                                  == 
                                                  (0x1fU 
                                                   & (IData)(
                                                             (vlTOPp->agu_block__DOT__p4_cmplxAddr 
                                                              >> 2U))))) 
                                              << 0x11U)));
    this->__PVT__banks0 = ((0xfffbffffU & this->__PVT__banks0) 
                           | ((((((0x12U == (0x1fU 
                                             & (IData)(
                                                       (vlTOPp->agu_block__DOT__p4_cmplxAddr 
                                                        >> 2U)))) 
                                  << 0x12U) | (((((
                                                   (3U 
                                                    == (IData)(this->__PVT__opsize)) 
                                                   << 0x12U) 
                                                  | (0xfffc0000U 
                                                     & ((IData)(this->__PVT__opsize) 
                                                        << 0x10U))) 
                                                 | (((0U 
                                                      != 
                                                      (3U 
                                                       & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr))) 
                                                     & (2U 
                                                        == (IData)(this->__PVT__opsize))) 
                                                    << 0x12U)) 
                                                | (((3U 
                                                     == 
                                                     (3U 
                                                      & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr))) 
                                                    & (1U 
                                                       == (IData)(this->__PVT__opsize))) 
                                                   << 0x12U)) 
                                               & ((0x11U 
                                                   == 
                                                   (0x1fU 
                                                    & (IData)(
                                                              (vlTOPp->agu_block__DOT__p4_cmplxAddr 
                                                               >> 2U)))) 
                                                  << 0x12U))) 
                                | (((((3U == (IData)(this->__PVT__opsize)) 
                                      & (0U != (3U 
                                                & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr)))) 
                                     << 0x12U) | (0xfffc0000U 
                                                  & ((IData)(this->__PVT__opsize) 
                                                     << 0x10U))) 
                                   & ((0x10U == (0x1fU 
                                                 & (IData)(
                                                           (vlTOPp->agu_block__DOT__p4_cmplxAddr 
                                                            >> 2U)))) 
                                      << 0x12U))) | 
                               ((((((4U == (IData)(this->__PVT__opsize)) 
                                    & (3U == (3U & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr)))) 
                                   | (5U == (IData)(this->__PVT__opsize))) 
                                  | (6U == (IData)(this->__PVT__opsize))) 
                                 & (0xfU == (0x1fU 
                                             & (IData)(
                                                       (vlTOPp->agu_block__DOT__p4_cmplxAddr 
                                                        >> 2U))))) 
                                << 0x12U)) | (((((5U 
                                                  == (IData)(this->__PVT__opsize)) 
                                                 & (0U 
                                                    != 
                                                    (3U 
                                                     & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr)))) 
                                                | (6U 
                                                   == (IData)(this->__PVT__opsize))) 
                                               & (0xeU 
                                                  == 
                                                  (0x1fU 
                                                   & (IData)(
                                                             (vlTOPp->agu_block__DOT__p4_cmplxAddr 
                                                              >> 2U))))) 
                                              << 0x12U)));
    this->__PVT__banks0 = ((0xfff7ffffU & this->__PVT__banks0) 
                           | ((((((0x13U == (0x1fU 
                                             & (IData)(
                                                       (vlTOPp->agu_block__DOT__p4_cmplxAddr 
                                                        >> 2U)))) 
                                  << 0x13U) | (((((
                                                   (3U 
                                                    == (IData)(this->__PVT__opsize)) 
                                                   << 0x13U) 
                                                  | (0xfff80000U 
                                                     & ((IData)(this->__PVT__opsize) 
                                                        << 0x11U))) 
                                                 | (((0U 
                                                      != 
                                                      (3U 
                                                       & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr))) 
                                                     & (2U 
                                                        == (IData)(this->__PVT__opsize))) 
                                                    << 0x13U)) 
                                                | (((3U 
                                                     == 
                                                     (3U 
                                                      & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr))) 
                                                    & (1U 
                                                       == (IData)(this->__PVT__opsize))) 
                                                   << 0x13U)) 
                                               & ((0x12U 
                                                   == 
                                                   (0x1fU 
                                                    & (IData)(
                                                              (vlTOPp->agu_block__DOT__p4_cmplxAddr 
                                                               >> 2U)))) 
                                                  << 0x13U))) 
                                | (((((3U == (IData)(this->__PVT__opsize)) 
                                      & (0U != (3U 
                                                & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr)))) 
                                     << 0x13U) | (0xfff80000U 
                                                  & ((IData)(this->__PVT__opsize) 
                                                     << 0x11U))) 
                                   & ((0x11U == (0x1fU 
                                                 & (IData)(
                                                           (vlTOPp->agu_block__DOT__p4_cmplxAddr 
                                                            >> 2U)))) 
                                      << 0x13U))) | 
                               ((((((4U == (IData)(this->__PVT__opsize)) 
                                    & (3U == (3U & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr)))) 
                                   | (5U == (IData)(this->__PVT__opsize))) 
                                  | (6U == (IData)(this->__PVT__opsize))) 
                                 & (0x10U == (0x1fU 
                                              & (IData)(
                                                        (vlTOPp->agu_block__DOT__p4_cmplxAddr 
                                                         >> 2U))))) 
                                << 0x13U)) | (((((5U 
                                                  == (IData)(this->__PVT__opsize)) 
                                                 & (0U 
                                                    != 
                                                    (3U 
                                                     & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr)))) 
                                                | (6U 
                                                   == (IData)(this->__PVT__opsize))) 
                                               & (0xfU 
                                                  == 
                                                  (0x1fU 
                                                   & (IData)(
                                                             (vlTOPp->agu_block__DOT__p4_cmplxAddr 
                                                              >> 2U))))) 
                                              << 0x13U)));
    this->__PVT__banks0 = ((0xffefffffU & this->__PVT__banks0) 
                           | ((((((0x14U == (0x1fU 
                                             & (IData)(
                                                       (vlTOPp->agu_block__DOT__p4_cmplxAddr 
                                                        >> 2U)))) 
                                  << 0x14U) | (((((
                                                   (3U 
                                                    == (IData)(this->__PVT__opsize)) 
                                                   << 0x14U) 
                                                  | (0xfff00000U 
                                                     & ((IData)(this->__PVT__opsize) 
                                                        << 0x12U))) 
                                                 | (((0U 
                                                      != 
                                                      (3U 
                                                       & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr))) 
                                                     & (2U 
                                                        == (IData)(this->__PVT__opsize))) 
                                                    << 0x14U)) 
                                                | (((3U 
                                                     == 
                                                     (3U 
                                                      & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr))) 
                                                    & (1U 
                                                       == (IData)(this->__PVT__opsize))) 
                                                   << 0x14U)) 
                                               & ((0x13U 
                                                   == 
                                                   (0x1fU 
                                                    & (IData)(
                                                              (vlTOPp->agu_block__DOT__p4_cmplxAddr 
                                                               >> 2U)))) 
                                                  << 0x14U))) 
                                | (((((3U == (IData)(this->__PVT__opsize)) 
                                      & (0U != (3U 
                                                & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr)))) 
                                     << 0x14U) | (0xfff00000U 
                                                  & ((IData)(this->__PVT__opsize) 
                                                     << 0x12U))) 
                                   & ((0x12U == (0x1fU 
                                                 & (IData)(
                                                           (vlTOPp->agu_block__DOT__p4_cmplxAddr 
                                                            >> 2U)))) 
                                      << 0x14U))) | 
                               ((((((4U == (IData)(this->__PVT__opsize)) 
                                    & (3U == (3U & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr)))) 
                                   | (5U == (IData)(this->__PVT__opsize))) 
                                  | (6U == (IData)(this->__PVT__opsize))) 
                                 & (0x11U == (0x1fU 
                                              & (IData)(
                                                        (vlTOPp->agu_block__DOT__p4_cmplxAddr 
                                                         >> 2U))))) 
                                << 0x14U)) | (((((5U 
                                                  == (IData)(this->__PVT__opsize)) 
                                                 & (0U 
                                                    != 
                                                    (3U 
                                                     & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr)))) 
                                                | (6U 
                                                   == (IData)(this->__PVT__opsize))) 
                                               & (0x10U 
                                                  == 
                                                  (0x1fU 
                                                   & (IData)(
                                                             (vlTOPp->agu_block__DOT__p4_cmplxAddr 
                                                              >> 2U))))) 
                                              << 0x14U)));
    this->__PVT__banks0 = ((0xffdfffffU & this->__PVT__banks0) 
                           | ((((((0x15U == (0x1fU 
                                             & (IData)(
                                                       (vlTOPp->agu_block__DOT__p4_cmplxAddr 
                                                        >> 2U)))) 
                                  << 0x15U) | (((((
                                                   (3U 
                                                    == (IData)(this->__PVT__opsize)) 
                                                   << 0x15U) 
                                                  | (0xffe00000U 
                                                     & ((IData)(this->__PVT__opsize) 
                                                        << 0x13U))) 
                                                 | (((0U 
                                                      != 
                                                      (3U 
                                                       & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr))) 
                                                     & (2U 
                                                        == (IData)(this->__PVT__opsize))) 
                                                    << 0x15U)) 
                                                | (((3U 
                                                     == 
                                                     (3U 
                                                      & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr))) 
                                                    & (1U 
                                                       == (IData)(this->__PVT__opsize))) 
                                                   << 0x15U)) 
                                               & ((0x14U 
                                                   == 
                                                   (0x1fU 
                                                    & (IData)(
                                                              (vlTOPp->agu_block__DOT__p4_cmplxAddr 
                                                               >> 2U)))) 
                                                  << 0x15U))) 
                                | (((((3U == (IData)(this->__PVT__opsize)) 
                                      & (0U != (3U 
                                                & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr)))) 
                                     << 0x15U) | (0xffe00000U 
                                                  & ((IData)(this->__PVT__opsize) 
                                                     << 0x13U))) 
                                   & ((0x13U == (0x1fU 
                                                 & (IData)(
                                                           (vlTOPp->agu_block__DOT__p4_cmplxAddr 
                                                            >> 2U)))) 
                                      << 0x15U))) | 
                               ((((((4U == (IData)(this->__PVT__opsize)) 
                                    & (3U == (3U & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr)))) 
                                   | (5U == (IData)(this->__PVT__opsize))) 
                                  | (6U == (IData)(this->__PVT__opsize))) 
                                 & (0x12U == (0x1fU 
                                              & (IData)(
                                                        (vlTOPp->agu_block__DOT__p4_cmplxAddr 
                                                         >> 2U))))) 
                                << 0x15U)) | (((((5U 
                                                  == (IData)(this->__PVT__opsize)) 
                                                 & (0U 
                                                    != 
                                                    (3U 
                                                     & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr)))) 
                                                | (6U 
                                                   == (IData)(this->__PVT__opsize))) 
                                               & (0x11U 
                                                  == 
                                                  (0x1fU 
                                                   & (IData)(
                                                             (vlTOPp->agu_block__DOT__p4_cmplxAddr 
                                                              >> 2U))))) 
                                              << 0x15U)));
    this->__PVT__banks0 = ((0xffbfffffU & this->__PVT__banks0) 
                           | ((((((0x16U == (0x1fU 
                                             & (IData)(
                                                       (vlTOPp->agu_block__DOT__p4_cmplxAddr 
                                                        >> 2U)))) 
                                  << 0x16U) | (((((
                                                   (3U 
                                                    == (IData)(this->__PVT__opsize)) 
                                                   << 0x16U) 
                                                  | (0xffc00000U 
                                                     & ((IData)(this->__PVT__opsize) 
                                                        << 0x14U))) 
                                                 | (((0U 
                                                      != 
                                                      (3U 
                                                       & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr))) 
                                                     & (2U 
                                                        == (IData)(this->__PVT__opsize))) 
                                                    << 0x16U)) 
                                                | (((3U 
                                                     == 
                                                     (3U 
                                                      & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr))) 
                                                    & (1U 
                                                       == (IData)(this->__PVT__opsize))) 
                                                   << 0x16U)) 
                                               & ((0x15U 
                                                   == 
                                                   (0x1fU 
                                                    & (IData)(
                                                              (vlTOPp->agu_block__DOT__p4_cmplxAddr 
                                                               >> 2U)))) 
                                                  << 0x16U))) 
                                | (((((3U == (IData)(this->__PVT__opsize)) 
                                      & (0U != (3U 
                                                & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr)))) 
                                     << 0x16U) | (0xffc00000U 
                                                  & ((IData)(this->__PVT__opsize) 
                                                     << 0x14U))) 
                                   & ((0x14U == (0x1fU 
                                                 & (IData)(
                                                           (vlTOPp->agu_block__DOT__p4_cmplxAddr 
                                                            >> 2U)))) 
                                      << 0x16U))) | 
                               ((((((4U == (IData)(this->__PVT__opsize)) 
                                    & (3U == (3U & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr)))) 
                                   | (5U == (IData)(this->__PVT__opsize))) 
                                  | (6U == (IData)(this->__PVT__opsize))) 
                                 & (0x13U == (0x1fU 
                                              & (IData)(
                                                        (vlTOPp->agu_block__DOT__p4_cmplxAddr 
                                                         >> 2U))))) 
                                << 0x16U)) | (((((5U 
                                                  == (IData)(this->__PVT__opsize)) 
                                                 & (0U 
                                                    != 
                                                    (3U 
                                                     & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr)))) 
                                                | (6U 
                                                   == (IData)(this->__PVT__opsize))) 
                                               & (0x12U 
                                                  == 
                                                  (0x1fU 
                                                   & (IData)(
                                                             (vlTOPp->agu_block__DOT__p4_cmplxAddr 
                                                              >> 2U))))) 
                                              << 0x16U)));
    this->__PVT__banks0 = ((0xff7fffffU & this->__PVT__banks0) 
                           | ((((((0x17U == (0x1fU 
                                             & (IData)(
                                                       (vlTOPp->agu_block__DOT__p4_cmplxAddr 
                                                        >> 2U)))) 
                                  << 0x17U) | (((((
                                                   (3U 
                                                    == (IData)(this->__PVT__opsize)) 
                                                   << 0x17U) 
                                                  | (0xff800000U 
                                                     & ((IData)(this->__PVT__opsize) 
                                                        << 0x15U))) 
                                                 | (((0U 
                                                      != 
                                                      (3U 
                                                       & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr))) 
                                                     & (2U 
                                                        == (IData)(this->__PVT__opsize))) 
                                                    << 0x17U)) 
                                                | (((3U 
                                                     == 
                                                     (3U 
                                                      & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr))) 
                                                    & (1U 
                                                       == (IData)(this->__PVT__opsize))) 
                                                   << 0x17U)) 
                                               & ((0x16U 
                                                   == 
                                                   (0x1fU 
                                                    & (IData)(
                                                              (vlTOPp->agu_block__DOT__p4_cmplxAddr 
                                                               >> 2U)))) 
                                                  << 0x17U))) 
                                | (((((3U == (IData)(this->__PVT__opsize)) 
                                      & (0U != (3U 
                                                & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr)))) 
                                     << 0x17U) | (0xff800000U 
                                                  & ((IData)(this->__PVT__opsize) 
                                                     << 0x15U))) 
                                   & ((0x15U == (0x1fU 
                                                 & (IData)(
                                                           (vlTOPp->agu_block__DOT__p4_cmplxAddr 
                                                            >> 2U)))) 
                                      << 0x17U))) | 
                               ((((((4U == (IData)(this->__PVT__opsize)) 
                                    & (3U == (3U & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr)))) 
                                   | (5U == (IData)(this->__PVT__opsize))) 
                                  | (6U == (IData)(this->__PVT__opsize))) 
                                 & (0x14U == (0x1fU 
                                              & (IData)(
                                                        (vlTOPp->agu_block__DOT__p4_cmplxAddr 
                                                         >> 2U))))) 
                                << 0x17U)) | (((((5U 
                                                  == (IData)(this->__PVT__opsize)) 
                                                 & (0U 
                                                    != 
                                                    (3U 
                                                     & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr)))) 
                                                | (6U 
                                                   == (IData)(this->__PVT__opsize))) 
                                               & (0x13U 
                                                  == 
                                                  (0x1fU 
                                                   & (IData)(
                                                             (vlTOPp->agu_block__DOT__p4_cmplxAddr 
                                                              >> 2U))))) 
                                              << 0x17U)));
    this->__PVT__banks0 = ((0xfeffffffU & this->__PVT__banks0) 
                           | ((((((0x18U == (0x1fU 
                                             & (IData)(
                                                       (vlTOPp->agu_block__DOT__p4_cmplxAddr 
                                                        >> 2U)))) 
                                  << 0x18U) | (((((
                                                   (3U 
                                                    == (IData)(this->__PVT__opsize)) 
                                                   << 0x18U) 
                                                  | (0xff000000U 
                                                     & ((IData)(this->__PVT__opsize) 
                                                        << 0x16U))) 
                                                 | (((0U 
                                                      != 
                                                      (3U 
                                                       & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr))) 
                                                     & (2U 
                                                        == (IData)(this->__PVT__opsize))) 
                                                    << 0x18U)) 
                                                | (((3U 
                                                     == 
                                                     (3U 
                                                      & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr))) 
                                                    & (1U 
                                                       == (IData)(this->__PVT__opsize))) 
                                                   << 0x18U)) 
                                               & ((0x17U 
                                                   == 
                                                   (0x1fU 
                                                    & (IData)(
                                                              (vlTOPp->agu_block__DOT__p4_cmplxAddr 
                                                               >> 2U)))) 
                                                  << 0x18U))) 
                                | (((((3U == (IData)(this->__PVT__opsize)) 
                                      & (0U != (3U 
                                                & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr)))) 
                                     << 0x18U) | (0xff000000U 
                                                  & ((IData)(this->__PVT__opsize) 
                                                     << 0x16U))) 
                                   & ((0x16U == (0x1fU 
                                                 & (IData)(
                                                           (vlTOPp->agu_block__DOT__p4_cmplxAddr 
                                                            >> 2U)))) 
                                      << 0x18U))) | 
                               ((((((4U == (IData)(this->__PVT__opsize)) 
                                    & (3U == (3U & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr)))) 
                                   | (5U == (IData)(this->__PVT__opsize))) 
                                  | (6U == (IData)(this->__PVT__opsize))) 
                                 & (0x15U == (0x1fU 
                                              & (IData)(
                                                        (vlTOPp->agu_block__DOT__p4_cmplxAddr 
                                                         >> 2U))))) 
                                << 0x18U)) | (((((5U 
                                                  == (IData)(this->__PVT__opsize)) 
                                                 & (0U 
                                                    != 
                                                    (3U 
                                                     & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr)))) 
                                                | (6U 
                                                   == (IData)(this->__PVT__opsize))) 
                                               & (0x14U 
                                                  == 
                                                  (0x1fU 
                                                   & (IData)(
                                                             (vlTOPp->agu_block__DOT__p4_cmplxAddr 
                                                              >> 2U))))) 
                                              << 0x18U)));
    this->__PVT__banks0 = ((0xfdffffffU & this->__PVT__banks0) 
                           | ((((((0x19U == (0x1fU 
                                             & (IData)(
                                                       (vlTOPp->agu_block__DOT__p4_cmplxAddr 
                                                        >> 2U)))) 
                                  << 0x19U) | (((((
                                                   (3U 
                                                    == (IData)(this->__PVT__opsize)) 
                                                   << 0x19U) 
                                                  | (0xfe000000U 
                                                     & ((IData)(this->__PVT__opsize) 
                                                        << 0x17U))) 
                                                 | (((0U 
                                                      != 
                                                      (3U 
                                                       & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr))) 
                                                     & (2U 
                                                        == (IData)(this->__PVT__opsize))) 
                                                    << 0x19U)) 
                                                | (((3U 
                                                     == 
                                                     (3U 
                                                      & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr))) 
                                                    & (1U 
                                                       == (IData)(this->__PVT__opsize))) 
                                                   << 0x19U)) 
                                               & ((0x18U 
                                                   == 
                                                   (0x1fU 
                                                    & (IData)(
                                                              (vlTOPp->agu_block__DOT__p4_cmplxAddr 
                                                               >> 2U)))) 
                                                  << 0x19U))) 
                                | (((((3U == (IData)(this->__PVT__opsize)) 
                                      & (0U != (3U 
                                                & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr)))) 
                                     << 0x19U) | (0xfe000000U 
                                                  & ((IData)(this->__PVT__opsize) 
                                                     << 0x17U))) 
                                   & ((0x17U == (0x1fU 
                                                 & (IData)(
                                                           (vlTOPp->agu_block__DOT__p4_cmplxAddr 
                                                            >> 2U)))) 
                                      << 0x19U))) | 
                               ((((((4U == (IData)(this->__PVT__opsize)) 
                                    & (3U == (3U & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr)))) 
                                   | (5U == (IData)(this->__PVT__opsize))) 
                                  | (6U == (IData)(this->__PVT__opsize))) 
                                 & (0x16U == (0x1fU 
                                              & (IData)(
                                                        (vlTOPp->agu_block__DOT__p4_cmplxAddr 
                                                         >> 2U))))) 
                                << 0x19U)) | (((((5U 
                                                  == (IData)(this->__PVT__opsize)) 
                                                 & (0U 
                                                    != 
                                                    (3U 
                                                     & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr)))) 
                                                | (6U 
                                                   == (IData)(this->__PVT__opsize))) 
                                               & (0x15U 
                                                  == 
                                                  (0x1fU 
                                                   & (IData)(
                                                             (vlTOPp->agu_block__DOT__p4_cmplxAddr 
                                                              >> 2U))))) 
                                              << 0x19U)));
    this->__PVT__banks0 = ((0xfbffffffU & this->__PVT__banks0) 
                           | ((((((0x1aU == (0x1fU 
                                             & (IData)(
                                                       (vlTOPp->agu_block__DOT__p4_cmplxAddr 
                                                        >> 2U)))) 
                                  << 0x1aU) | (((((
                                                   (3U 
                                                    == (IData)(this->__PVT__opsize)) 
                                                   << 0x1aU) 
                                                  | (0xfc000000U 
                                                     & ((IData)(this->__PVT__opsize) 
                                                        << 0x18U))) 
                                                 | (((0U 
                                                      != 
                                                      (3U 
                                                       & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr))) 
                                                     & (2U 
                                                        == (IData)(this->__PVT__opsize))) 
                                                    << 0x1aU)) 
                                                | (((3U 
                                                     == 
                                                     (3U 
                                                      & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr))) 
                                                    & (1U 
                                                       == (IData)(this->__PVT__opsize))) 
                                                   << 0x1aU)) 
                                               & ((0x19U 
                                                   == 
                                                   (0x1fU 
                                                    & (IData)(
                                                              (vlTOPp->agu_block__DOT__p4_cmplxAddr 
                                                               >> 2U)))) 
                                                  << 0x1aU))) 
                                | (((((3U == (IData)(this->__PVT__opsize)) 
                                      & (0U != (3U 
                                                & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr)))) 
                                     << 0x1aU) | (0xfc000000U 
                                                  & ((IData)(this->__PVT__opsize) 
                                                     << 0x18U))) 
                                   & ((0x18U == (0x1fU 
                                                 & (IData)(
                                                           (vlTOPp->agu_block__DOT__p4_cmplxAddr 
                                                            >> 2U)))) 
                                      << 0x1aU))) | 
                               ((((((4U == (IData)(this->__PVT__opsize)) 
                                    & (3U == (3U & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr)))) 
                                   | (5U == (IData)(this->__PVT__opsize))) 
                                  | (6U == (IData)(this->__PVT__opsize))) 
                                 & (0x17U == (0x1fU 
                                              & (IData)(
                                                        (vlTOPp->agu_block__DOT__p4_cmplxAddr 
                                                         >> 2U))))) 
                                << 0x1aU)) | (((((5U 
                                                  == (IData)(this->__PVT__opsize)) 
                                                 & (0U 
                                                    != 
                                                    (3U 
                                                     & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr)))) 
                                                | (6U 
                                                   == (IData)(this->__PVT__opsize))) 
                                               & (0x16U 
                                                  == 
                                                  (0x1fU 
                                                   & (IData)(
                                                             (vlTOPp->agu_block__DOT__p4_cmplxAddr 
                                                              >> 2U))))) 
                                              << 0x1aU)));
    this->__PVT__banks0 = ((0xf7ffffffU & this->__PVT__banks0) 
                           | ((((((0x1bU == (0x1fU 
                                             & (IData)(
                                                       (vlTOPp->agu_block__DOT__p4_cmplxAddr 
                                                        >> 2U)))) 
                                  << 0x1bU) | (((((
                                                   (3U 
                                                    == (IData)(this->__PVT__opsize)) 
                                                   << 0x1bU) 
                                                  | (0xf8000000U 
                                                     & ((IData)(this->__PVT__opsize) 
                                                        << 0x19U))) 
                                                 | (((0U 
                                                      != 
                                                      (3U 
                                                       & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr))) 
                                                     & (2U 
                                                        == (IData)(this->__PVT__opsize))) 
                                                    << 0x1bU)) 
                                                | (((3U 
                                                     == 
                                                     (3U 
                                                      & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr))) 
                                                    & (1U 
                                                       == (IData)(this->__PVT__opsize))) 
                                                   << 0x1bU)) 
                                               & ((0x1aU 
                                                   == 
                                                   (0x1fU 
                                                    & (IData)(
                                                              (vlTOPp->agu_block__DOT__p4_cmplxAddr 
                                                               >> 2U)))) 
                                                  << 0x1bU))) 
                                | (((((3U == (IData)(this->__PVT__opsize)) 
                                      & (0U != (3U 
                                                & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr)))) 
                                     << 0x1bU) | (0xf8000000U 
                                                  & ((IData)(this->__PVT__opsize) 
                                                     << 0x19U))) 
                                   & ((0x19U == (0x1fU 
                                                 & (IData)(
                                                           (vlTOPp->agu_block__DOT__p4_cmplxAddr 
                                                            >> 2U)))) 
                                      << 0x1bU))) | 
                               ((((((4U == (IData)(this->__PVT__opsize)) 
                                    & (3U == (3U & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr)))) 
                                   | (5U == (IData)(this->__PVT__opsize))) 
                                  | (6U == (IData)(this->__PVT__opsize))) 
                                 & (0x18U == (0x1fU 
                                              & (IData)(
                                                        (vlTOPp->agu_block__DOT__p4_cmplxAddr 
                                                         >> 2U))))) 
                                << 0x1bU)) | (((((5U 
                                                  == (IData)(this->__PVT__opsize)) 
                                                 & (0U 
                                                    != 
                                                    (3U 
                                                     & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr)))) 
                                                | (6U 
                                                   == (IData)(this->__PVT__opsize))) 
                                               & (0x17U 
                                                  == 
                                                  (0x1fU 
                                                   & (IData)(
                                                             (vlTOPp->agu_block__DOT__p4_cmplxAddr 
                                                              >> 2U))))) 
                                              << 0x1bU)));
    this->__PVT__banks0 = ((0xefffffffU & this->__PVT__banks0) 
                           | ((((((0x1cU == (0x1fU 
                                             & (IData)(
                                                       (vlTOPp->agu_block__DOT__p4_cmplxAddr 
                                                        >> 2U)))) 
                                  << 0x1cU) | (((((
                                                   (3U 
                                                    == (IData)(this->__PVT__opsize)) 
                                                   << 0x1cU) 
                                                  | (0xf0000000U 
                                                     & ((IData)(this->__PVT__opsize) 
                                                        << 0x1aU))) 
                                                 | (((0U 
                                                      != 
                                                      (3U 
                                                       & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr))) 
                                                     & (2U 
                                                        == (IData)(this->__PVT__opsize))) 
                                                    << 0x1cU)) 
                                                | (((3U 
                                                     == 
                                                     (3U 
                                                      & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr))) 
                                                    & (1U 
                                                       == (IData)(this->__PVT__opsize))) 
                                                   << 0x1cU)) 
                                               & ((0x1bU 
                                                   == 
                                                   (0x1fU 
                                                    & (IData)(
                                                              (vlTOPp->agu_block__DOT__p4_cmplxAddr 
                                                               >> 2U)))) 
                                                  << 0x1cU))) 
                                | (((((3U == (IData)(this->__PVT__opsize)) 
                                      & (0U != (3U 
                                                & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr)))) 
                                     << 0x1cU) | (0xf0000000U 
                                                  & ((IData)(this->__PVT__opsize) 
                                                     << 0x1aU))) 
                                   & ((0x1aU == (0x1fU 
                                                 & (IData)(
                                                           (vlTOPp->agu_block__DOT__p4_cmplxAddr 
                                                            >> 2U)))) 
                                      << 0x1cU))) | 
                               ((((((4U == (IData)(this->__PVT__opsize)) 
                                    & (3U == (3U & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr)))) 
                                   | (5U == (IData)(this->__PVT__opsize))) 
                                  | (6U == (IData)(this->__PVT__opsize))) 
                                 & (0x19U == (0x1fU 
                                              & (IData)(
                                                        (vlTOPp->agu_block__DOT__p4_cmplxAddr 
                                                         >> 2U))))) 
                                << 0x1cU)) | (((((5U 
                                                  == (IData)(this->__PVT__opsize)) 
                                                 & (0U 
                                                    != 
                                                    (3U 
                                                     & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr)))) 
                                                | (6U 
                                                   == (IData)(this->__PVT__opsize))) 
                                               & (0x18U 
                                                  == 
                                                  (0x1fU 
                                                   & (IData)(
                                                             (vlTOPp->agu_block__DOT__p4_cmplxAddr 
                                                              >> 2U))))) 
                                              << 0x1cU)));
    this->__PVT__banks0 = ((0xdfffffffU & this->__PVT__banks0) 
                           | ((((((0x1dU == (0x1fU 
                                             & (IData)(
                                                       (vlTOPp->agu_block__DOT__p4_cmplxAddr 
                                                        >> 2U)))) 
                                  << 0x1dU) | (((((
                                                   (3U 
                                                    == (IData)(this->__PVT__opsize)) 
                                                   << 0x1dU) 
                                                  | (0xe0000000U 
                                                     & ((IData)(this->__PVT__opsize) 
                                                        << 0x1bU))) 
                                                 | (((0U 
                                                      != 
                                                      (3U 
                                                       & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr))) 
                                                     & (2U 
                                                        == (IData)(this->__PVT__opsize))) 
                                                    << 0x1dU)) 
                                                | (((3U 
                                                     == 
                                                     (3U 
                                                      & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr))) 
                                                    & (1U 
                                                       == (IData)(this->__PVT__opsize))) 
                                                   << 0x1dU)) 
                                               & ((0x1cU 
                                                   == 
                                                   (0x1fU 
                                                    & (IData)(
                                                              (vlTOPp->agu_block__DOT__p4_cmplxAddr 
                                                               >> 2U)))) 
                                                  << 0x1dU))) 
                                | (((((3U == (IData)(this->__PVT__opsize)) 
                                      & (0U != (3U 
                                                & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr)))) 
                                     << 0x1dU) | (0xe0000000U 
                                                  & ((IData)(this->__PVT__opsize) 
                                                     << 0x1bU))) 
                                   & ((0x1bU == (0x1fU 
                                                 & (IData)(
                                                           (vlTOPp->agu_block__DOT__p4_cmplxAddr 
                                                            >> 2U)))) 
                                      << 0x1dU))) | 
                               ((((((4U == (IData)(this->__PVT__opsize)) 
                                    & (3U == (3U & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr)))) 
                                   | (5U == (IData)(this->__PVT__opsize))) 
                                  | (6U == (IData)(this->__PVT__opsize))) 
                                 & (0x1aU == (0x1fU 
                                              & (IData)(
                                                        (vlTOPp->agu_block__DOT__p4_cmplxAddr 
                                                         >> 2U))))) 
                                << 0x1dU)) | (((((5U 
                                                  == (IData)(this->__PVT__opsize)) 
                                                 & (0U 
                                                    != 
                                                    (3U 
                                                     & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr)))) 
                                                | (6U 
                                                   == (IData)(this->__PVT__opsize))) 
                                               & (0x19U 
                                                  == 
                                                  (0x1fU 
                                                   & (IData)(
                                                             (vlTOPp->agu_block__DOT__p4_cmplxAddr 
                                                              >> 2U))))) 
                                              << 0x1dU)));
    this->__PVT__banks0 = ((0xbfffffffU & this->__PVT__banks0) 
                           | ((((((0x1eU == (0x1fU 
                                             & (IData)(
                                                       (vlTOPp->agu_block__DOT__p4_cmplxAddr 
                                                        >> 2U)))) 
                                  << 0x1eU) | (((((
                                                   (3U 
                                                    == (IData)(this->__PVT__opsize)) 
                                                   << 0x1eU) 
                                                  | (0xc0000000U 
                                                     & ((IData)(this->__PVT__opsize) 
                                                        << 0x1cU))) 
                                                 | (((0U 
                                                      != 
                                                      (3U 
                                                       & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr))) 
                                                     & (2U 
                                                        == (IData)(this->__PVT__opsize))) 
                                                    << 0x1eU)) 
                                                | (((3U 
                                                     == 
                                                     (3U 
                                                      & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr))) 
                                                    & (1U 
                                                       == (IData)(this->__PVT__opsize))) 
                                                   << 0x1eU)) 
                                               & ((0x1dU 
                                                   == 
                                                   (0x1fU 
                                                    & (IData)(
                                                              (vlTOPp->agu_block__DOT__p4_cmplxAddr 
                                                               >> 2U)))) 
                                                  << 0x1eU))) 
                                | (((((3U == (IData)(this->__PVT__opsize)) 
                                      & (0U != (3U 
                                                & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr)))) 
                                     << 0x1eU) | (0xc0000000U 
                                                  & ((IData)(this->__PVT__opsize) 
                                                     << 0x1cU))) 
                                   & ((0x1cU == (0x1fU 
                                                 & (IData)(
                                                           (vlTOPp->agu_block__DOT__p4_cmplxAddr 
                                                            >> 2U)))) 
                                      << 0x1eU))) | 
                               ((((((4U == (IData)(this->__PVT__opsize)) 
                                    & (3U == (3U & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr)))) 
                                   | (5U == (IData)(this->__PVT__opsize))) 
                                  | (6U == (IData)(this->__PVT__opsize))) 
                                 & (0x1bU == (0x1fU 
                                              & (IData)(
                                                        (vlTOPp->agu_block__DOT__p4_cmplxAddr 
                                                         >> 2U))))) 
                                << 0x1eU)) | (((((5U 
                                                  == (IData)(this->__PVT__opsize)) 
                                                 & (0U 
                                                    != 
                                                    (3U 
                                                     & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr)))) 
                                                | (6U 
                                                   == (IData)(this->__PVT__opsize))) 
                                               & (0x1aU 
                                                  == 
                                                  (0x1fU 
                                                   & (IData)(
                                                             (vlTOPp->agu_block__DOT__p4_cmplxAddr 
                                                              >> 2U))))) 
                                              << 0x1eU)));
    this->__PVT__banks0 = ((0x7fffffffU & this->__PVT__banks0) 
                           | ((((((0x1fU == (0x1fU 
                                             & (IData)(
                                                       (vlTOPp->agu_block__DOT__p4_cmplxAddr 
                                                        >> 2U)))) 
                                  << 0x1fU) | (((((
                                                   (3U 
                                                    == (IData)(this->__PVT__opsize)) 
                                                   << 0x1fU) 
                                                  | (0x80000000U 
                                                     & ((IData)(this->__PVT__opsize) 
                                                        << 0x1dU))) 
                                                 | (((0U 
                                                      != 
                                                      (3U 
                                                       & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr))) 
                                                     & (2U 
                                                        == (IData)(this->__PVT__opsize))) 
                                                    << 0x1fU)) 
                                                | (((3U 
                                                     == 
                                                     (3U 
                                                      & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr))) 
                                                    & (1U 
                                                       == (IData)(this->__PVT__opsize))) 
                                                   << 0x1fU)) 
                                               & ((0x1eU 
                                                   == 
                                                   (0x1fU 
                                                    & (IData)(
                                                              (vlTOPp->agu_block__DOT__p4_cmplxAddr 
                                                               >> 2U)))) 
                                                  << 0x1fU))) 
                                | (((((3U == (IData)(this->__PVT__opsize)) 
                                      & (0U != (3U 
                                                & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr)))) 
                                     << 0x1fU) | (0x80000000U 
                                                  & ((IData)(this->__PVT__opsize) 
                                                     << 0x1dU))) 
                                   & ((0x1dU == (0x1fU 
                                                 & (IData)(
                                                           (vlTOPp->agu_block__DOT__p4_cmplxAddr 
                                                            >> 2U)))) 
                                      << 0x1fU))) | 
                               ((((((4U == (IData)(this->__PVT__opsize)) 
                                    & (3U == (3U & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr)))) 
                                   | (5U == (IData)(this->__PVT__opsize))) 
                                  | (6U == (IData)(this->__PVT__opsize))) 
                                 & (0x1cU == (0x1fU 
                                              & (IData)(
                                                        (vlTOPp->agu_block__DOT__p4_cmplxAddr 
                                                         >> 2U))))) 
                                << 0x1fU)) | (((((5U 
                                                  == (IData)(this->__PVT__opsize)) 
                                                 & (0U 
                                                    != 
                                                    (3U 
                                                     & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr)))) 
                                                | (6U 
                                                   == (IData)(this->__PVT__opsize))) 
                                               & (0x1bU 
                                                  == 
                                                  (0x1fU 
                                                   & (IData)(
                                                             (vlTOPp->agu_block__DOT__p4_cmplxAddr 
                                                              >> 2U))))) 
                                              << 0x1fU)));
}

void Vagu_block_sagu::_settle__TOP__agu_block__DOT__Wagu_mod__25(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+        Vagu_block_sagu::_settle__TOP__agu_block__DOT__Wagu_mod__25\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->rng_mod__DOT__sh_mod__DOT__bits_out__out__en0 
        = ((0U == (7U & (IData)((vlTOPp->agu_block__DOT__p4_cmplxAddr 
                                 >> 0x3bU)))) ? (0xffU 
                                                 & (IData)(this->rng_mod__DOT__sh_mod__DOT__bits_med__en))
            : 0U);
    this->rng_mod__DOT__sh_mod__DOT__bits_out__out__en1 
        = ((1U == (7U & (IData)((vlTOPp->agu_block__DOT__p4_cmplxAddr 
                                 >> 0x3bU)))) ? (0xffU 
                                                 & ((IData)(this->rng_mod__DOT__sh_mod__DOT__bits_med__en) 
                                                    >> 1U))
            : 0U);
    this->rng_mod__DOT__sh_mod__DOT__bits_out__out__en2 
        = ((2U == (7U & (IData)((vlTOPp->agu_block__DOT__p4_cmplxAddr 
                                 >> 0x3bU)))) ? (0xffU 
                                                 & ((IData)(this->rng_mod__DOT__sh_mod__DOT__bits_med__en) 
                                                    >> 2U))
            : 0U);
    this->rng_mod__DOT__sh_mod__DOT__bits_out__out__en3 
        = ((3U == (7U & (IData)((vlTOPp->agu_block__DOT__p4_cmplxAddr 
                                 >> 0x3bU)))) ? (0xffU 
                                                 & ((IData)(this->rng_mod__DOT__sh_mod__DOT__bits_med__en) 
                                                    >> 3U))
            : 0U);
    this->rng_mod__DOT__sh_mod__DOT__bits_out__out__en4 
        = ((4U == (7U & (IData)((vlTOPp->agu_block__DOT__p4_cmplxAddr 
                                 >> 0x3bU)))) ? (0xffU 
                                                 & ((IData)(this->rng_mod__DOT__sh_mod__DOT__bits_med__en) 
                                                    >> 4U))
            : 0U);
    this->rng_mod__DOT__sh_mod__DOT__bits_out__out__en5 
        = ((5U == (7U & (IData)((vlTOPp->agu_block__DOT__p4_cmplxAddr 
                                 >> 0x3bU)))) ? (0xffU 
                                                 & ((IData)(this->rng_mod__DOT__sh_mod__DOT__bits_med__en) 
                                                    >> 5U))
            : 0U);
    this->rng_mod__DOT__sh_mod__DOT__bits_out__out__en6 
        = ((6U == (7U & (IData)((vlTOPp->agu_block__DOT__p4_cmplxAddr 
                                 >> 0x3bU)))) ? (0xffU 
                                                 & ((IData)(this->rng_mod__DOT__sh_mod__DOT__bits_med__en) 
                                                    >> 6U))
            : 0U);
    this->rng_mod__DOT__sh_mod__DOT__bits_out__out__en7 
        = ((7U == (7U & (IData)((vlTOPp->agu_block__DOT__p4_cmplxAddr 
                                 >> 0x3bU)))) ? (0xffU 
                                                 & ((IData)(this->rng_mod__DOT__sh_mod__DOT__bits_med__en) 
                                                    >> 7U))
            : 0U);
}

void Vagu_block_sagu::_settle__TOP__agu_block__DOT__Wagu_mod__27(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+        Vagu_block_sagu::_settle__TOP__agu_block__DOT__Wagu_mod__27\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->__PVT__nextCAddr_mod__DOT__nG2 = ((0x3ffcU 
                                             & ((~ 
                                                 ((((IData)(this->__PVT__nextCAddr_mod__DOT__P1) 
                                                    >> 2U) 
                                                   & (IData)(this->__PVT__nextCAddr_mod__DOT__G1)) 
                                                  | ((IData)(this->__PVT__nextCAddr_mod__DOT__G1) 
                                                     >> 2U))) 
                                                << 2U)) 
                                            | (3U & 
                                               (~ (IData)(this->__PVT__nextCAddr_mod__DOT__G1))));
}

void Vagu_block_sagu::_settle__TOP__agu_block__DOT__Wagu_mod__29(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+        Vagu_block_sagu::_settle__TOP__agu_block__DOT__Wagu_mod__29\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->__PVT__nextCAddr_mod__DOT__nP2 = ((0x3ffcU 
                                             & ((~ 
                                                 (((IData)(this->__PVT__nextCAddr_mod__DOT__P1) 
                                                   >> 2U) 
                                                  & (IData)(this->__PVT__nextCAddr_mod__DOT__P1))) 
                                                << 2U)) 
                                            | (3U & 
                                               (~ (IData)(this->__PVT__nextCAddr_mod__DOT__P1))));
}

void Vagu_block_sagu::_settle__TOP__agu_block__DOT__Wagu_mod__31(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+        Vagu_block_sagu::_settle__TOP__agu_block__DOT__Wagu_mod__31\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->mOp_banks = ((0xfffffffeU & this->mOp_banks) 
                       | ((~ (IData)(this->__PVT__bus_hold_reg)) 
                          & (this->__PVT__banks0 & (IData)(this->__PVT__read_clkEn_reg))));
    this->mOp_banks = ((0xfffffffdU & this->mOp_banks) 
                       | (0xfffffffeU & (((~ (IData)(this->__PVT__bus_hold_reg)) 
                                          << 1U) & 
                                         (this->__PVT__banks0 
                                          & ((IData)(this->__PVT__read_clkEn_reg) 
                                             << 1U)))));
    this->mOp_banks = ((0xfffffffbU & this->mOp_banks) 
                       | (0xfffffffcU & (((~ (IData)(this->__PVT__bus_hold_reg)) 
                                          << 2U) & 
                                         (this->__PVT__banks0 
                                          & ((IData)(this->__PVT__read_clkEn_reg) 
                                             << 2U)))));
    this->mOp_banks = ((0xfffffff7U & this->mOp_banks) 
                       | (0xfffffff8U & (((~ (IData)(this->__PVT__bus_hold_reg)) 
                                          << 3U) & 
                                         (this->__PVT__banks0 
                                          & ((IData)(this->__PVT__read_clkEn_reg) 
                                             << 3U)))));
    this->mOp_banks = ((0xffffffefU & this->mOp_banks) 
                       | (0xfffffff0U & (((~ (IData)(this->__PVT__bus_hold_reg)) 
                                          << 4U) & 
                                         (this->__PVT__banks0 
                                          & ((IData)(this->__PVT__read_clkEn_reg) 
                                             << 4U)))));
    this->mOp_banks = ((0xffffffdfU & this->mOp_banks) 
                       | (0xffffffe0U & (((~ (IData)(this->__PVT__bus_hold_reg)) 
                                          << 5U) & 
                                         (this->__PVT__banks0 
                                          & ((IData)(this->__PVT__read_clkEn_reg) 
                                             << 5U)))));
    this->mOp_banks = ((0xffffffbfU & this->mOp_banks) 
                       | (0xffffffc0U & (((~ (IData)(this->__PVT__bus_hold_reg)) 
                                          << 6U) & 
                                         (this->__PVT__banks0 
                                          & ((IData)(this->__PVT__read_clkEn_reg) 
                                             << 6U)))));
    this->mOp_banks = ((0xffffff7fU & this->mOp_banks) 
                       | (0xffffff80U & (((~ (IData)(this->__PVT__bus_hold_reg)) 
                                          << 7U) & 
                                         (this->__PVT__banks0 
                                          & ((IData)(this->__PVT__read_clkEn_reg) 
                                             << 7U)))));
    this->mOp_banks = ((0xfffffeffU & this->mOp_banks) 
                       | (0xffffff00U & (((~ (IData)(this->__PVT__bus_hold_reg)) 
                                          << 8U) & 
                                         (this->__PVT__banks0 
                                          & ((IData)(this->__PVT__read_clkEn_reg) 
                                             << 8U)))));
    this->mOp_banks = ((0xfffffdffU & this->mOp_banks) 
                       | (0xfffffe00U & (((~ (IData)(this->__PVT__bus_hold_reg)) 
                                          << 9U) & 
                                         (this->__PVT__banks0 
                                          & ((IData)(this->__PVT__read_clkEn_reg) 
                                             << 9U)))));
    this->mOp_banks = ((0xfffffbffU & this->mOp_banks) 
                       | (0xfffffc00U & (((~ (IData)(this->__PVT__bus_hold_reg)) 
                                          << 0xaU) 
                                         & (this->__PVT__banks0 
                                            & ((IData)(this->__PVT__read_clkEn_reg) 
                                               << 0xaU)))));
    this->mOp_banks = ((0xfffff7ffU & this->mOp_banks) 
                       | (0xfffff800U & (((~ (IData)(this->__PVT__bus_hold_reg)) 
                                          << 0xbU) 
                                         & (this->__PVT__banks0 
                                            & ((IData)(this->__PVT__read_clkEn_reg) 
                                               << 0xbU)))));
    this->mOp_banks = ((0xffffefffU & this->mOp_banks) 
                       | (0xfffff000U & (((~ (IData)(this->__PVT__bus_hold_reg)) 
                                          << 0xcU) 
                                         & (this->__PVT__banks0 
                                            & ((IData)(this->__PVT__read_clkEn_reg) 
                                               << 0xcU)))));
    this->mOp_banks = ((0xffffdfffU & this->mOp_banks) 
                       | (0xffffe000U & (((~ (IData)(this->__PVT__bus_hold_reg)) 
                                          << 0xdU) 
                                         & (this->__PVT__banks0 
                                            & ((IData)(this->__PVT__read_clkEn_reg) 
                                               << 0xdU)))));
    this->mOp_banks = ((0xffffbfffU & this->mOp_banks) 
                       | (0xffffc000U & (((~ (IData)(this->__PVT__bus_hold_reg)) 
                                          << 0xeU) 
                                         & (this->__PVT__banks0 
                                            & ((IData)(this->__PVT__read_clkEn_reg) 
                                               << 0xeU)))));
    this->mOp_banks = ((0xffff7fffU & this->mOp_banks) 
                       | (0xffff8000U & (((~ (IData)(this->__PVT__bus_hold_reg)) 
                                          << 0xfU) 
                                         & (this->__PVT__banks0 
                                            & ((IData)(this->__PVT__read_clkEn_reg) 
                                               << 0xfU)))));
    this->mOp_banks = ((0xfffeffffU & this->mOp_banks) 
                       | (0xffff0000U & (((~ (IData)(this->__PVT__bus_hold_reg)) 
                                          << 0x10U) 
                                         & (this->__PVT__banks0 
                                            & ((IData)(this->__PVT__read_clkEn_reg) 
                                               << 0x10U)))));
    this->mOp_banks = ((0xfffdffffU & this->mOp_banks) 
                       | (0xfffe0000U & (((~ (IData)(this->__PVT__bus_hold_reg)) 
                                          << 0x11U) 
                                         & (this->__PVT__banks0 
                                            & ((IData)(this->__PVT__read_clkEn_reg) 
                                               << 0x11U)))));
    this->mOp_banks = ((0xfffbffffU & this->mOp_banks) 
                       | (0xfffc0000U & (((~ (IData)(this->__PVT__bus_hold_reg)) 
                                          << 0x12U) 
                                         & (this->__PVT__banks0 
                                            & ((IData)(this->__PVT__read_clkEn_reg) 
                                               << 0x12U)))));
    this->mOp_banks = ((0xfff7ffffU & this->mOp_banks) 
                       | (0xfff80000U & (((~ (IData)(this->__PVT__bus_hold_reg)) 
                                          << 0x13U) 
                                         & (this->__PVT__banks0 
                                            & ((IData)(this->__PVT__read_clkEn_reg) 
                                               << 0x13U)))));
    this->mOp_banks = ((0xffefffffU & this->mOp_banks) 
                       | (0xfff00000U & (((~ (IData)(this->__PVT__bus_hold_reg)) 
                                          << 0x14U) 
                                         & (this->__PVT__banks0 
                                            & ((IData)(this->__PVT__read_clkEn_reg) 
                                               << 0x14U)))));
    this->mOp_banks = ((0xffdfffffU & this->mOp_banks) 
                       | (0xffe00000U & (((~ (IData)(this->__PVT__bus_hold_reg)) 
                                          << 0x15U) 
                                         & (this->__PVT__banks0 
                                            & ((IData)(this->__PVT__read_clkEn_reg) 
                                               << 0x15U)))));
    this->mOp_banks = ((0xffbfffffU & this->mOp_banks) 
                       | (0xffc00000U & (((~ (IData)(this->__PVT__bus_hold_reg)) 
                                          << 0x16U) 
                                         & (this->__PVT__banks0 
                                            & ((IData)(this->__PVT__read_clkEn_reg) 
                                               << 0x16U)))));
    this->mOp_banks = ((0xff7fffffU & this->mOp_banks) 
                       | (0xff800000U & (((~ (IData)(this->__PVT__bus_hold_reg)) 
                                          << 0x17U) 
                                         & (this->__PVT__banks0 
                                            & ((IData)(this->__PVT__read_clkEn_reg) 
                                               << 0x17U)))));
    this->mOp_banks = ((0xfeffffffU & this->mOp_banks) 
                       | (0xff000000U & (((~ (IData)(this->__PVT__bus_hold_reg)) 
                                          << 0x18U) 
                                         & (this->__PVT__banks0 
                                            & ((IData)(this->__PVT__read_clkEn_reg) 
                                               << 0x18U)))));
    this->mOp_banks = ((0xfdffffffU & this->mOp_banks) 
                       | (0xfe000000U & (((~ (IData)(this->__PVT__bus_hold_reg)) 
                                          << 0x19U) 
                                         & (this->__PVT__banks0 
                                            & ((IData)(this->__PVT__read_clkEn_reg) 
                                               << 0x19U)))));
    this->mOp_banks = ((0xfbffffffU & this->mOp_banks) 
                       | (0xfc000000U & (((~ (IData)(this->__PVT__bus_hold_reg)) 
                                          << 0x1aU) 
                                         & (this->__PVT__banks0 
                                            & ((IData)(this->__PVT__read_clkEn_reg) 
                                               << 0x1aU)))));
    this->mOp_banks = ((0xf7ffffffU & this->mOp_banks) 
                       | (0xf8000000U & (((~ (IData)(this->__PVT__bus_hold_reg)) 
                                          << 0x1bU) 
                                         & (this->__PVT__banks0 
                                            & ((IData)(this->__PVT__read_clkEn_reg) 
                                               << 0x1bU)))));
    this->mOp_banks = ((0xefffffffU & this->mOp_banks) 
                       | (0xf0000000U & (((~ (IData)(this->__PVT__bus_hold_reg)) 
                                          << 0x1cU) 
                                         & (this->__PVT__banks0 
                                            & ((IData)(this->__PVT__read_clkEn_reg) 
                                               << 0x1cU)))));
    this->mOp_banks = ((0xdfffffffU & this->mOp_banks) 
                       | (0xe0000000U & (((~ (IData)(this->__PVT__bus_hold_reg)) 
                                          << 0x1dU) 
                                         & (this->__PVT__banks0 
                                            & ((IData)(this->__PVT__read_clkEn_reg) 
                                               << 0x1dU)))));
    this->mOp_banks = ((0xbfffffffU & this->mOp_banks) 
                       | (0xc0000000U & (((~ (IData)(this->__PVT__bus_hold_reg)) 
                                          << 0x1eU) 
                                         & (this->__PVT__banks0 
                                            & ((IData)(this->__PVT__read_clkEn_reg) 
                                               << 0x1eU)))));
    this->mOp_banks = ((0x7fffffffU & this->mOp_banks) 
                       | (0x80000000U & (((~ (IData)(this->__PVT__bus_hold_reg)) 
                                          << 0x1fU) 
                                         & (this->__PVT__banks0 
                                            & ((IData)(this->__PVT__read_clkEn_reg) 
                                               << 0x1fU)))));
}

void Vagu_block_sagu::_settle__TOP__agu_block__DOT__Wagu_mod__33(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+        Vagu_block_sagu::_settle__TOP__agu_block__DOT__Wagu_mod__33\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->__PVT__rng_mod__DOT__bits = (((((((((((0U 
                                                 == 
                                                 (7U 
                                                  & (IData)(
                                                            (vlTOPp->agu_block__DOT__p4_cmplxAddr 
                                                             >> 0x3bU))))
                                                 ? (IData)(this->__PVT__rng_mod__DOT__sh_mod__DOT__bits_med)
                                                 : 0U) 
                                               & (IData)(this->rng_mod__DOT__sh_mod__DOT__bits_out__out__en0)) 
                                              | (((1U 
                                                   == 
                                                   (7U 
                                                    & (IData)(
                                                              (vlTOPp->agu_block__DOT__p4_cmplxAddr 
                                                               >> 0x3bU))))
                                                   ? 
                                                  ((IData)(this->__PVT__rng_mod__DOT__sh_mod__DOT__bits_med) 
                                                   >> 1U)
                                                   : 0U) 
                                                 & (IData)(this->rng_mod__DOT__sh_mod__DOT__bits_out__out__en1))) 
                                             | (((2U 
                                                  == 
                                                  (7U 
                                                   & (IData)(
                                                             (vlTOPp->agu_block__DOT__p4_cmplxAddr 
                                                              >> 0x3bU))))
                                                  ? 
                                                 ((IData)(this->__PVT__rng_mod__DOT__sh_mod__DOT__bits_med) 
                                                  >> 2U)
                                                  : 0U) 
                                                & (IData)(this->rng_mod__DOT__sh_mod__DOT__bits_out__out__en2))) 
                                            | (((3U 
                                                 == 
                                                 (7U 
                                                  & (IData)(
                                                            (vlTOPp->agu_block__DOT__p4_cmplxAddr 
                                                             >> 0x3bU))))
                                                 ? 
                                                ((IData)(this->__PVT__rng_mod__DOT__sh_mod__DOT__bits_med) 
                                                 >> 3U)
                                                 : 0U) 
                                               & (IData)(this->rng_mod__DOT__sh_mod__DOT__bits_out__out__en3))) 
                                           | (((4U 
                                                == 
                                                (7U 
                                                 & (IData)(
                                                           (vlTOPp->agu_block__DOT__p4_cmplxAddr 
                                                            >> 0x3bU))))
                                                ? ((IData)(this->__PVT__rng_mod__DOT__sh_mod__DOT__bits_med) 
                                                   >> 4U)
                                                : 0U) 
                                              & (IData)(this->rng_mod__DOT__sh_mod__DOT__bits_out__out__en4))) 
                                          | (((5U == 
                                               (7U 
                                                & (IData)(
                                                          (vlTOPp->agu_block__DOT__p4_cmplxAddr 
                                                           >> 0x3bU))))
                                               ? ((IData)(this->__PVT__rng_mod__DOT__sh_mod__DOT__bits_med) 
                                                  >> 5U)
                                               : 0U) 
                                             & (IData)(this->rng_mod__DOT__sh_mod__DOT__bits_out__out__en5))) 
                                         | (((6U == 
                                              (7U & (IData)(
                                                            (vlTOPp->agu_block__DOT__p4_cmplxAddr 
                                                             >> 0x3bU))))
                                              ? ((IData)(this->__PVT__rng_mod__DOT__sh_mod__DOT__bits_med) 
                                                 >> 6U)
                                              : 0U) 
                                            & (IData)(this->rng_mod__DOT__sh_mod__DOT__bits_out__out__en6))) 
                                        | (((7U == 
                                             (7U & (IData)(
                                                           (vlTOPp->agu_block__DOT__p4_cmplxAddr 
                                                            >> 0x3bU))))
                                             ? ((IData)(this->__PVT__rng_mod__DOT__sh_mod__DOT__bits_med) 
                                                >> 7U)
                                             : 0U) 
                                           & (IData)(this->rng_mod__DOT__sh_mod__DOT__bits_out__out__en7))) 
                                       & ((((((((IData)(this->rng_mod__DOT__sh_mod__DOT__bits_out__out__en0) 
                                                | (IData)(this->rng_mod__DOT__sh_mod__DOT__bits_out__out__en1)) 
                                               | (IData)(this->rng_mod__DOT__sh_mod__DOT__bits_out__out__en2)) 
                                              | (IData)(this->rng_mod__DOT__sh_mod__DOT__bits_out__out__en3)) 
                                             | (IData)(this->rng_mod__DOT__sh_mod__DOT__bits_out__out__en4)) 
                                            | (IData)(this->rng_mod__DOT__sh_mod__DOT__bits_out__out__en5)) 
                                           | (IData)(this->rng_mod__DOT__sh_mod__DOT__bits_out__out__en6)) 
                                          | (IData)(this->rng_mod__DOT__sh_mod__DOT__bits_out__out__en7)));
}

void Vagu_block_sagu::_settle__TOP__agu_block__DOT__Wagu_mod__35(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+        Vagu_block_sagu::_settle__TOP__agu_block__DOT__Wagu_mod__35\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->__PVT__nextCAddr_mod__DOT__P3 = ((0x3ff0U 
                                            & ((~ (
                                                   ((IData)(this->__PVT__nextCAddr_mod__DOT__nP2) 
                                                    >> 4U) 
                                                   | (IData)(this->__PVT__nextCAddr_mod__DOT__nP2))) 
                                               << 4U)) 
                                           | (0xfU 
                                              & (~ (IData)(this->__PVT__nextCAddr_mod__DOT__nP2))));
}

void Vagu_block_sagu::_settle__TOP__agu_block__DOT__Wagu_mod__37(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+        Vagu_block_sagu::_settle__TOP__agu_block__DOT__Wagu_mod__37\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->__PVT__nextCAddr_mod__DOT__G3 = ((0x3ff0U 
                                            & ((~ (
                                                   (((IData)(this->__PVT__nextCAddr_mod__DOT__nP2) 
                                                     >> 4U) 
                                                    | (IData)(this->__PVT__nextCAddr_mod__DOT__nG2)) 
                                                   & ((IData)(this->__PVT__nextCAddr_mod__DOT__nG2) 
                                                      >> 4U))) 
                                               << 4U)) 
                                           | (0xfU 
                                              & (~ (IData)(this->__PVT__nextCAddr_mod__DOT__nG2))));
}

void Vagu_block_sagu::_settle__TOP__agu_block__DOT__Wagu_mod__39(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+        Vagu_block_sagu::_settle__TOP__agu_block__DOT__Wagu_mod__39\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->__PVT__tlb_clkEn = ((IData)(this->__PVT__read_clkEn_reg) 
                              | (IData)(this->__PVT__mex_en_reg));
}

void Vagu_block_sagu::_settle__TOP__agu_block__DOT__Wagu_mod__41(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+        Vagu_block_sagu::_settle__TOP__agu_block__DOT__Wagu_mod__41\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->__PVT__rng_mod__DOT__cmpLow_mod__DOT__nG0 
        = (0xffU & (~ ((~ (0xfeU & ((IData)((vlTOPp->agu_block__DOT__p4_cmplxAddr 
                                             >> 0x34U)) 
                                    << 1U))) & (IData)(this->__PVT__rng_mod__DOT__bits))));
    this->__PVT__rng_mod__DOT__cmpHio_mod__DOT__nG0 
        = (0xffU & (~ ((1U | (0xfeU & ((IData)((vlTOPp->agu_block__DOT__p4_cmplxAddr 
                                                >> 0x2dU)) 
                                       << 1U))) & (~ (IData)(this->__PVT__rng_mod__DOT__bits)))));
}

void Vagu_block_sagu::_settle__TOP__agu_block__DOT__Wagu_mod__43(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+        Vagu_block_sagu::_settle__TOP__agu_block__DOT__Wagu_mod__43\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->__PVT__rng_mod__DOT__cmpLow_mod__DOT__nP0 
        = (0xffU & (~ ((~ (0xfeU & ((IData)((vlTOPp->agu_block__DOT__p4_cmplxAddr 
                                             >> 0x34U)) 
                                    << 1U))) | (IData)(this->__PVT__rng_mod__DOT__bits))));
    this->__PVT__rng_mod__DOT__cmpHio_mod__DOT__nP0 
        = (0xffU & (~ (1U | ((0xfeU & ((IData)((vlTOPp->agu_block__DOT__p4_cmplxAddr 
                                                >> 0x2dU)) 
                                       << 1U)) | (~ (IData)(this->__PVT__rng_mod__DOT__bits))))));
}

void Vagu_block_sagu::_settle__TOP__agu_block__DOT__Wagu_mod__45(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+        Vagu_block_sagu::_settle__TOP__agu_block__DOT__Wagu_mod__45\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->__PVT__nextCAddr_mod__DOT__nG4 = ((0x3f00U 
                                             & ((~ 
                                                 ((((IData)(this->__PVT__nextCAddr_mod__DOT__P3) 
                                                    >> 8U) 
                                                   & (IData)(this->__PVT__nextCAddr_mod__DOT__G3)) 
                                                  | ((IData)(this->__PVT__nextCAddr_mod__DOT__G3) 
                                                     >> 8U))) 
                                                << 8U)) 
                                            | (0xffU 
                                               & (~ (IData)(this->__PVT__nextCAddr_mod__DOT__G3))));
}

void Vagu_block_sagu::_settle__TOP__agu_block__DOT__Wagu_mod__47(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+        Vagu_block_sagu::_settle__TOP__agu_block__DOT__Wagu_mod__47\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->nextCAddr_mod__DOT__out__out__out2 = ((0x3ffdU 
                                                 & (IData)(this->nextCAddr_mod__DOT__out__out__out2)) 
                                                | (2U 
                                                   & ((0x80U 
                                                       ^ 
                                                       (0x1ffeU 
                                                        & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr))) 
                                                      & ((IData)(this->__PVT__nextCAddr_mod__DOT__nG4) 
                                                         << 1U))));
    this->nextCAddr_mod__DOT__out__out__out4 = ((0x3ffbU 
                                                 & (IData)(this->nextCAddr_mod__DOT__out__out__out4)) 
                                                | (4U 
                                                   & ((0x80U 
                                                       ^ 
                                                       (0x1ffcU 
                                                        & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr))) 
                                                      & ((IData)(this->__PVT__nextCAddr_mod__DOT__nG4) 
                                                         << 1U))));
    this->nextCAddr_mod__DOT__out__out__out6 = ((0x3ff7U 
                                                 & (IData)(this->nextCAddr_mod__DOT__out__out__out6)) 
                                                | (8U 
                                                   & ((0x80U 
                                                       ^ 
                                                       (0x1ff8U 
                                                        & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr))) 
                                                      & ((IData)(this->__PVT__nextCAddr_mod__DOT__nG4) 
                                                         << 1U))));
    this->nextCAddr_mod__DOT__out__out__out8 = ((0x3fefU 
                                                 & (IData)(this->nextCAddr_mod__DOT__out__out__out8)) 
                                                | (0x10U 
                                                   & ((0x80U 
                                                       ^ 
                                                       (0x1ff0U 
                                                        & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr))) 
                                                      & ((IData)(this->__PVT__nextCAddr_mod__DOT__nG4) 
                                                         << 1U))));
    this->nextCAddr_mod__DOT__out__out__out10 = ((0x3fdfU 
                                                  & (IData)(this->nextCAddr_mod__DOT__out__out__out10)) 
                                                 | (0x20U 
                                                    & ((0x80U 
                                                        ^ 
                                                        (0x1fe0U 
                                                         & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr))) 
                                                       & ((IData)(this->__PVT__nextCAddr_mod__DOT__nG4) 
                                                          << 1U))));
    this->nextCAddr_mod__DOT__out__out__out12 = ((0x3fbfU 
                                                  & (IData)(this->nextCAddr_mod__DOT__out__out__out12)) 
                                                 | (0x40U 
                                                    & ((0x80U 
                                                        ^ 
                                                        (0x1fc0U 
                                                         & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr))) 
                                                       & ((IData)(this->__PVT__nextCAddr_mod__DOT__nG4) 
                                                          << 1U))));
    this->nextCAddr_mod__DOT__out__out__out14 = ((0x3f7fU 
                                                  & (IData)(this->nextCAddr_mod__DOT__out__out__out14)) 
                                                 | (0x80U 
                                                    & ((0x80U 
                                                        ^ 
                                                        (0x1f80U 
                                                         & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr))) 
                                                       & ((IData)(this->__PVT__nextCAddr_mod__DOT__nG4) 
                                                          << 1U))));
    this->nextCAddr_mod__DOT__out__out__out16 = ((0x3effU 
                                                  & (IData)(this->nextCAddr_mod__DOT__out__out__out16)) 
                                                 | (0x100U 
                                                    & ((IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr) 
                                                       & ((IData)(this->__PVT__nextCAddr_mod__DOT__nG4) 
                                                          << 1U))));
    this->nextCAddr_mod__DOT__out__out__out18 = ((0x3dffU 
                                                  & (IData)(this->nextCAddr_mod__DOT__out__out__out18)) 
                                                 | (0x200U 
                                                    & ((IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr) 
                                                       & ((IData)(this->__PVT__nextCAddr_mod__DOT__nG4) 
                                                          << 1U))));
    this->nextCAddr_mod__DOT__out__out__out20 = ((0x3bffU 
                                                  & (IData)(this->nextCAddr_mod__DOT__out__out__out20)) 
                                                 | (0x400U 
                                                    & ((IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr) 
                                                       & ((IData)(this->__PVT__nextCAddr_mod__DOT__nG4) 
                                                          << 1U))));
    this->nextCAddr_mod__DOT__out__out__out22 = ((0x37ffU 
                                                  & (IData)(this->nextCAddr_mod__DOT__out__out__out22)) 
                                                 | (0x800U 
                                                    & ((IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr) 
                                                       & ((IData)(this->__PVT__nextCAddr_mod__DOT__nG4) 
                                                          << 1U))));
    this->nextCAddr_mod__DOT__out__out__out24 = ((0x2fffU 
                                                  & (IData)(this->nextCAddr_mod__DOT__out__out__out24)) 
                                                 | (0x1000U 
                                                    & ((IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr) 
                                                       & ((IData)(this->__PVT__nextCAddr_mod__DOT__nG4) 
                                                          << 1U))));
    this->nextCAddr_mod__DOT__out__out__out26 = (0x1fffU 
                                                 & (IData)(this->nextCAddr_mod__DOT__out__out__out26));
}

void Vagu_block_sagu::_settle__TOP__agu_block__DOT__Wagu_mod__49(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+        Vagu_block_sagu::_settle__TOP__agu_block__DOT__Wagu_mod__49\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->__PVT__rng_mod__DOT__cmpLow_mod__DOT__G1 
        = ((0xfeU & ((~ ((((IData)(this->__PVT__rng_mod__DOT__cmpLow_mod__DOT__nP0) 
                           >> 1U) | (IData)(this->__PVT__rng_mod__DOT__cmpLow_mod__DOT__nG0)) 
                         & ((IData)(this->__PVT__rng_mod__DOT__cmpLow_mod__DOT__nG0) 
                            >> 1U))) << 1U)) | (1U 
                                                & (~ (IData)(this->__PVT__rng_mod__DOT__cmpLow_mod__DOT__nG0))));
    this->__PVT__rng_mod__DOT__cmpHio_mod__DOT__G1 
        = ((0xfeU & ((~ ((((IData)(this->__PVT__rng_mod__DOT__cmpHio_mod__DOT__nP0) 
                           >> 1U) | (IData)(this->__PVT__rng_mod__DOT__cmpHio_mod__DOT__nG0)) 
                         & ((IData)(this->__PVT__rng_mod__DOT__cmpHio_mod__DOT__nG0) 
                            >> 1U))) << 1U)) | (1U 
                                                & (~ (IData)(this->__PVT__rng_mod__DOT__cmpHio_mod__DOT__nG0))));
}

void Vagu_block_sagu::_settle__TOP__agu_block__DOT__Wagu_mod__51(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+        Vagu_block_sagu::_settle__TOP__agu_block__DOT__Wagu_mod__51\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->__PVT__rng_mod__DOT__cmpLow_mod__DOT__P1 
        = ((0xfeU & ((~ (((IData)(this->__PVT__rng_mod__DOT__cmpLow_mod__DOT__nP0) 
                          >> 1U) | (IData)(this->__PVT__rng_mod__DOT__cmpLow_mod__DOT__nP0))) 
                     << 1U)) | (1U & (~ (IData)(this->__PVT__rng_mod__DOT__cmpLow_mod__DOT__nP0))));
    this->__PVT__rng_mod__DOT__cmpHio_mod__DOT__P1 
        = ((0xfeU & ((~ (((IData)(this->__PVT__rng_mod__DOT__cmpHio_mod__DOT__nP0) 
                          >> 1U) | (IData)(this->__PVT__rng_mod__DOT__cmpHio_mod__DOT__nP0))) 
                     << 1U)) | (1U & (~ (IData)(this->__PVT__rng_mod__DOT__cmpHio_mod__DOT__nP0))));
}

void Vagu_block_sagu::_settle__TOP__agu_block__DOT__Wagu_mod__53(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+        Vagu_block_sagu::_settle__TOP__agu_block__DOT__Wagu_mod__53\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->__PVT__nextCAddr_mod__DOT__nC1 = (1U | (0x3ffeU 
                                                  & ((IData)(this->__PVT__nextCAddr_mod__DOT__nG4) 
                                                     << 1U)));
}

void Vagu_block_sagu::_settle__TOP__agu_block__DOT__Wagu_mod__55(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+        Vagu_block_sagu::_settle__TOP__agu_block__DOT__Wagu_mod__55\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->__PVT__fault_tlb = ((((3U == (3U & (IData)(this->__PVT__mflags))) 
                                & (IData)((__PVT__tlb_mod->read_data 
                                           >> 0x1fU))) 
                               << 1U) | (1U & ((~ (IData)(
                                                          (__PVT__tlb_mod->read_data 
                                                           >> 0x21U))) 
                                               | (IData)(
                                                         (__PVT__tlb_mod->read_data 
                                                          >> 0x20U)))));
}

void Vagu_block_sagu::_settle__TOP__agu_block__DOT__Wagu_mod__57(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+        Vagu_block_sagu::_settle__TOP__agu_block__DOT__Wagu_mod__57\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->__PVT__rng_mod__DOT__cmpLow_mod__DOT__nG2 
        = ((0xfcU & ((~ ((((IData)(this->__PVT__rng_mod__DOT__cmpLow_mod__DOT__P1) 
                           >> 2U) & (IData)(this->__PVT__rng_mod__DOT__cmpLow_mod__DOT__G1)) 
                         | ((IData)(this->__PVT__rng_mod__DOT__cmpLow_mod__DOT__G1) 
                            >> 2U))) << 2U)) | (3U 
                                                & (~ (IData)(this->__PVT__rng_mod__DOT__cmpLow_mod__DOT__G1))));
    this->__PVT__rng_mod__DOT__cmpHio_mod__DOT__nG2 
        = ((0xfcU & ((~ ((((IData)(this->__PVT__rng_mod__DOT__cmpHio_mod__DOT__P1) 
                           >> 2U) & (IData)(this->__PVT__rng_mod__DOT__cmpHio_mod__DOT__G1)) 
                         | ((IData)(this->__PVT__rng_mod__DOT__cmpHio_mod__DOT__G1) 
                            >> 2U))) << 2U)) | (3U 
                                                & (~ (IData)(this->__PVT__rng_mod__DOT__cmpHio_mod__DOT__G1))));
}

void Vagu_block_sagu::_settle__TOP__agu_block__DOT__Wagu_mod__59(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+        Vagu_block_sagu::_settle__TOP__agu_block__DOT__Wagu_mod__59\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->nextCAddr_mod__DOT__out__out__out1 = ((0x3ffeU 
                                                 & (IData)(this->nextCAddr_mod__DOT__out__out__out1)) 
                                                | (1U 
                                                   & ((~ 
                                                       (0x1fffU 
                                                        & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr))) 
                                                      & (~ (IData)(this->__PVT__nextCAddr_mod__DOT__nC1)))));
    this->nextCAddr_mod__DOT__out__out__out3 = ((0x3ffdU 
                                                 & (IData)(this->nextCAddr_mod__DOT__out__out__out3)) 
                                                | (2U 
                                                   & (((IData)(0x80U) 
                                                       ^ ~ 
                                                       (0x1fffU 
                                                        & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr))) 
                                                      & ((~ 
                                                          ((IData)(this->__PVT__nextCAddr_mod__DOT__nC1) 
                                                           >> 1U)) 
                                                         << 1U))));
    this->nextCAddr_mod__DOT__out__out__out5 = ((0x3ffbU 
                                                 & (IData)(this->nextCAddr_mod__DOT__out__out__out5)) 
                                                | (4U 
                                                   & (((IData)(0x80U) 
                                                       ^ ~ 
                                                       (0x1fffU 
                                                        & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr))) 
                                                      & ((~ 
                                                          ((IData)(this->__PVT__nextCAddr_mod__DOT__nC1) 
                                                           >> 2U)) 
                                                         << 2U))));
    this->nextCAddr_mod__DOT__out__out__out7 = ((0x3ff7U 
                                                 & (IData)(this->nextCAddr_mod__DOT__out__out__out7)) 
                                                | (8U 
                                                   & (((IData)(0x80U) 
                                                       ^ ~ 
                                                       (0x1fffU 
                                                        & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr))) 
                                                      & ((~ 
                                                          ((IData)(this->__PVT__nextCAddr_mod__DOT__nC1) 
                                                           >> 3U)) 
                                                         << 3U))));
    this->nextCAddr_mod__DOT__out__out__out9 = ((0x3fefU 
                                                 & (IData)(this->nextCAddr_mod__DOT__out__out__out9)) 
                                                | (0x10U 
                                                   & (((IData)(0x80U) 
                                                       ^ ~ 
                                                       (0x1fffU 
                                                        & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr))) 
                                                      & ((~ 
                                                          ((IData)(this->__PVT__nextCAddr_mod__DOT__nC1) 
                                                           >> 4U)) 
                                                         << 4U))));
    this->nextCAddr_mod__DOT__out__out__out11 = ((0x3fdfU 
                                                  & (IData)(this->nextCAddr_mod__DOT__out__out__out11)) 
                                                 | (0x20U 
                                                    & (((IData)(0x80U) 
                                                        ^ ~ 
                                                        (0x1fffU 
                                                         & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr))) 
                                                       & ((~ 
                                                           ((IData)(this->__PVT__nextCAddr_mod__DOT__nC1) 
                                                            >> 5U)) 
                                                          << 5U))));
    this->nextCAddr_mod__DOT__out__out__out13 = ((0x3fbfU 
                                                  & (IData)(this->nextCAddr_mod__DOT__out__out__out13)) 
                                                 | (0x40U 
                                                    & (((IData)(0x80U) 
                                                        ^ ~ 
                                                        (0x1fffU 
                                                         & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr))) 
                                                       & ((~ 
                                                           ((IData)(this->__PVT__nextCAddr_mod__DOT__nC1) 
                                                            >> 6U)) 
                                                          << 6U))));
    this->nextCAddr_mod__DOT__out__out__out15 = ((0x3f7fU 
                                                  & (IData)(this->nextCAddr_mod__DOT__out__out__out15)) 
                                                 | (0x80U 
                                                    & (((IData)(0x80U) 
                                                        ^ ~ 
                                                        (0x1fffU 
                                                         & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr))) 
                                                       & ((~ 
                                                           ((IData)(this->__PVT__nextCAddr_mod__DOT__nC1) 
                                                            >> 7U)) 
                                                          << 7U))));
    this->nextCAddr_mod__DOT__out__out__out17 = ((0x3effU 
                                                  & (IData)(this->nextCAddr_mod__DOT__out__out__out17)) 
                                                 | (0x100U 
                                                    & (((IData)(0x80U) 
                                                        ^ ~ 
                                                        (0x1fffU 
                                                         & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr))) 
                                                       & ((~ 
                                                           ((IData)(this->__PVT__nextCAddr_mod__DOT__nC1) 
                                                            >> 8U)) 
                                                          << 8U))));
    this->nextCAddr_mod__DOT__out__out__out19 = ((0x3dffU 
                                                  & (IData)(this->nextCAddr_mod__DOT__out__out__out19)) 
                                                 | (0x200U 
                                                    & (((IData)(0x80U) 
                                                        ^ ~ 
                                                        (0x1fffU 
                                                         & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr))) 
                                                       & ((~ 
                                                           ((IData)(this->__PVT__nextCAddr_mod__DOT__nC1) 
                                                            >> 9U)) 
                                                          << 9U))));
    this->nextCAddr_mod__DOT__out__out__out21 = ((0x3bffU 
                                                  & (IData)(this->nextCAddr_mod__DOT__out__out__out21)) 
                                                 | (0x400U 
                                                    & (((IData)(0x80U) 
                                                        ^ ~ 
                                                        (0x1fffU 
                                                         & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr))) 
                                                       & ((~ 
                                                           ((IData)(this->__PVT__nextCAddr_mod__DOT__nC1) 
                                                            >> 0xaU)) 
                                                          << 0xaU))));
    this->nextCAddr_mod__DOT__out__out__out23 = ((0x37ffU 
                                                  & (IData)(this->nextCAddr_mod__DOT__out__out__out23)) 
                                                 | (0x800U 
                                                    & (((IData)(0x80U) 
                                                        ^ ~ 
                                                        (0x1fffU 
                                                         & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr))) 
                                                       & ((~ 
                                                           ((IData)(this->__PVT__nextCAddr_mod__DOT__nC1) 
                                                            >> 0xbU)) 
                                                          << 0xbU))));
    this->nextCAddr_mod__DOT__out__out__out25 = ((0x2fffU 
                                                  & (IData)(this->nextCAddr_mod__DOT__out__out__out25)) 
                                                 | (0x1000U 
                                                    & (((IData)(0x80U) 
                                                        ^ ~ 
                                                        (0x1fffU 
                                                         & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr))) 
                                                       & ((~ 
                                                           ((IData)(this->__PVT__nextCAddr_mod__DOT__nC1) 
                                                            >> 0xcU)) 
                                                          << 0xcU))));
    this->nextCAddr_mod__DOT__out__out__out27 = ((0x1fffU 
                                                  & (IData)(this->nextCAddr_mod__DOT__out__out__out27)) 
                                                 | (0x2000U 
                                                    & (((IData)(0x80U) 
                                                        ^ ~ 
                                                        (0x1fffU 
                                                         & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr))) 
                                                       & ((~ 
                                                           ((IData)(this->__PVT__nextCAddr_mod__DOT__nC1) 
                                                            >> 0xdU)) 
                                                          << 0xdU))));
}

void Vagu_block_sagu::_settle__TOP__agu_block__DOT__Wagu_mod__61(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+        Vagu_block_sagu::_settle__TOP__agu_block__DOT__Wagu_mod__61\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->__PVT__rng_mod__DOT__cmpLow_mod__DOT__nP2 
        = ((0xfcU & ((~ (((IData)(this->__PVT__rng_mod__DOT__cmpLow_mod__DOT__P1) 
                          >> 2U) & (IData)(this->__PVT__rng_mod__DOT__cmpLow_mod__DOT__P1))) 
                     << 2U)) | (3U & (~ (IData)(this->__PVT__rng_mod__DOT__cmpLow_mod__DOT__P1))));
    this->__PVT__rng_mod__DOT__cmpHio_mod__DOT__nP2 
        = ((0xfcU & ((~ (((IData)(this->__PVT__rng_mod__DOT__cmpHio_mod__DOT__P1) 
                          >> 2U) & (IData)(this->__PVT__rng_mod__DOT__cmpHio_mod__DOT__P1))) 
                     << 2U)) | (3U & (~ (IData)(this->__PVT__rng_mod__DOT__cmpHio_mod__DOT__P1))));
}

void Vagu_block_sagu::_settle__TOP__agu_block__DOT__Wagu_mod__63(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+        Vagu_block_sagu::_settle__TOP__agu_block__DOT__Wagu_mod__63\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->__PVT__rng_mod__DOT__cmpLow_mod__DOT__P3 
        = ((0xf0U & ((~ (((IData)(this->__PVT__rng_mod__DOT__cmpLow_mod__DOT__nP2) 
                          >> 4U) | (IData)(this->__PVT__rng_mod__DOT__cmpLow_mod__DOT__nP2))) 
                     << 4U)) | (0xfU & (~ (IData)(this->__PVT__rng_mod__DOT__cmpLow_mod__DOT__nP2))));
    this->__PVT__rng_mod__DOT__cmpHio_mod__DOT__P3 
        = ((0xf0U & ((~ (((IData)(this->__PVT__rng_mod__DOT__cmpHio_mod__DOT__nP2) 
                          >> 4U) | (IData)(this->__PVT__rng_mod__DOT__cmpHio_mod__DOT__nP2))) 
                     << 4U)) | (0xfU & (~ (IData)(this->__PVT__rng_mod__DOT__cmpHio_mod__DOT__nP2))));
}

void Vagu_block_sagu::_settle__TOP__agu_block__DOT__Wagu_mod__65(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+        Vagu_block_sagu::_settle__TOP__agu_block__DOT__Wagu_mod__65\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->__PVT__rng_mod__DOT__cmpLow_mod__DOT__G3 
        = ((0xf0U & ((~ ((((IData)(this->__PVT__rng_mod__DOT__cmpLow_mod__DOT__nP2) 
                           >> 4U) | (IData)(this->__PVT__rng_mod__DOT__cmpLow_mod__DOT__nG2)) 
                         & ((IData)(this->__PVT__rng_mod__DOT__cmpLow_mod__DOT__nG2) 
                            >> 4U))) << 4U)) | (0xfU 
                                                & (~ (IData)(this->__PVT__rng_mod__DOT__cmpLow_mod__DOT__nG2))));
    this->__PVT__rng_mod__DOT__cmpHio_mod__DOT__G3 
        = ((0xf0U & ((~ ((((IData)(this->__PVT__rng_mod__DOT__cmpHio_mod__DOT__nP2) 
                           >> 4U) | (IData)(this->__PVT__rng_mod__DOT__cmpHio_mod__DOT__nG2)) 
                         & ((IData)(this->__PVT__rng_mod__DOT__cmpHio_mod__DOT__nG2) 
                            >> 4U))) << 4U)) | (0xfU 
                                                & (~ (IData)(this->__PVT__rng_mod__DOT__cmpHio_mod__DOT__nG2))));
}

void Vagu_block_sagu::_settle__TOP__agu_block__DOT__Wagu_mod__67(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+        Vagu_block_sagu::_settle__TOP__agu_block__DOT__Wagu_mod__67\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->addrNext__out9 = ((((((((((((((((((((((((
                                                   (((1U 
                                                      & ((IData)(this->nextCAddr_mod__DOT__out__out__out0) 
                                                         & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr))) 
                                                     | (1U 
                                                        & ((IData)(this->nextCAddr_mod__DOT__out__out__out1) 
                                                           & (~ 
                                                              (0x1fffU 
                                                               & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr)))))) 
                                                    | (2U 
                                                       & ((IData)(this->nextCAddr_mod__DOT__out__out__out2) 
                                                          & (0x80U 
                                                             ^ 
                                                             (0x1ffeU 
                                                              & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr)))))) 
                                                   | (2U 
                                                      & ((IData)(this->nextCAddr_mod__DOT__out__out__out3) 
                                                         & ((IData)(0x80U) 
                                                            ^ ~ 
                                                            (0x1fffU 
                                                             & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr)))))) 
                                                  | (4U 
                                                     & ((IData)(this->nextCAddr_mod__DOT__out__out__out4) 
                                                        & (0x80U 
                                                           ^ 
                                                           (0x1ffcU 
                                                            & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr)))))) 
                                                 | (4U 
                                                    & ((IData)(this->nextCAddr_mod__DOT__out__out__out5) 
                                                       & ((IData)(0x80U) 
                                                          ^ ~ 
                                                          (0x1fffU 
                                                           & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr)))))) 
                                                | (8U 
                                                   & ((IData)(this->nextCAddr_mod__DOT__out__out__out6) 
                                                      & (0x80U 
                                                         ^ 
                                                         (0x1ff8U 
                                                          & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr)))))) 
                                               | (8U 
                                                  & ((IData)(this->nextCAddr_mod__DOT__out__out__out7) 
                                                     & ((IData)(0x80U) 
                                                        ^ ~ 
                                                        (0x1fffU 
                                                         & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr)))))) 
                                              | (0x10U 
                                                 & ((IData)(this->nextCAddr_mod__DOT__out__out__out8) 
                                                    & (0x80U 
                                                       ^ 
                                                       (0x1ff0U 
                                                        & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr)))))) 
                                             | (0x10U 
                                                & ((IData)(this->nextCAddr_mod__DOT__out__out__out9) 
                                                   & ((IData)(0x80U) 
                                                      ^ ~ 
                                                      (0x1fffU 
                                                       & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr)))))) 
                                            | (0x20U 
                                               & ((IData)(this->nextCAddr_mod__DOT__out__out__out10) 
                                                  & (0x80U 
                                                     ^ 
                                                     (0x1fe0U 
                                                      & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr)))))) 
                                           | (0x20U 
                                              & ((IData)(this->nextCAddr_mod__DOT__out__out__out11) 
                                                 & ((IData)(0x80U) 
                                                    ^ ~ 
                                                    (0x1fffU 
                                                     & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr)))))) 
                                          | (0x40U 
                                             & ((IData)(this->nextCAddr_mod__DOT__out__out__out12) 
                                                & (0x80U 
                                                   ^ 
                                                   (0x1fc0U 
                                                    & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr)))))) 
                                         | (0x40U & 
                                            ((IData)(this->nextCAddr_mod__DOT__out__out__out13) 
                                             & ((IData)(0x80U) 
                                                ^ ~ 
                                                (0x1fffU 
                                                 & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr)))))) 
                                        | (0x80U & 
                                           ((IData)(this->nextCAddr_mod__DOT__out__out__out14) 
                                            & (0x80U 
                                               ^ (0x1f80U 
                                                  & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr)))))) 
                                       | (0x80U & ((IData)(this->nextCAddr_mod__DOT__out__out__out15) 
                                                   & ((IData)(0x80U) 
                                                      ^ ~ 
                                                      (0x1fffU 
                                                       & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr)))))) 
                                      | (0x100U & ((IData)(this->nextCAddr_mod__DOT__out__out__out16) 
                                                   & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr)))) 
                                     | (0x100U & ((IData)(this->nextCAddr_mod__DOT__out__out__out17) 
                                                  & ((IData)(0x80U) 
                                                     ^ ~ 
                                                     (0x1fffU 
                                                      & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr)))))) 
                                    | (0x200U & ((IData)(this->nextCAddr_mod__DOT__out__out__out18) 
                                                 & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr)))) 
                                   | (0x200U & ((IData)(this->nextCAddr_mod__DOT__out__out__out19) 
                                                & ((IData)(0x80U) 
                                                   ^ ~ 
                                                   (0x1fffU 
                                                    & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr)))))) 
                                  | (0x400U & ((IData)(this->nextCAddr_mod__DOT__out__out__out20) 
                                               & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr)))) 
                                 | (0x400U & ((IData)(this->nextCAddr_mod__DOT__out__out__out21) 
                                              & ((IData)(0x80U) 
                                                 ^ ~ 
                                                 (0x1fffU 
                                                  & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr)))))) 
                                | (0x800U & ((IData)(this->nextCAddr_mod__DOT__out__out__out22) 
                                             & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr)))) 
                               | (0x800U & ((IData)(this->nextCAddr_mod__DOT__out__out__out23) 
                                            & ((IData)(0x80U) 
                                               ^ ~ 
                                               (0x1fffU 
                                                & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr)))))) 
                              | (0x1000U & ((IData)(this->nextCAddr_mod__DOT__out__out__out24) 
                                            & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr)))) 
                             | (0x1000U & ((IData)(this->nextCAddr_mod__DOT__out__out__out25) 
                                           & ((IData)(0x80U) 
                                              ^ ~ (0x1fffU 
                                                   & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr)))))) 
                            | (0x2000U & ((IData)(this->nextCAddr_mod__DOT__out__out__out27) 
                                          & ((IData)(0x80U) 
                                             ^ ~ (0x1fffU 
                                                  & (IData)(vlTOPp->agu_block__DOT__p4_cmplxAddr))))));
}

void Vagu_block_sagu::_settle__TOP__agu_block__DOT__Wagu_mod__69(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+        Vagu_block_sagu::_settle__TOP__agu_block__DOT__Wagu_mod__69\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->__PVT__rng_mod__DOT__cmpLow_mod__DOT__nC 
        = (0xffU & (~ ((IData)(this->__PVT__rng_mod__DOT__cmpLow_mod__DOT__P3) 
                       | (IData)(this->__PVT__rng_mod__DOT__cmpLow_mod__DOT__G3))));
    this->__PVT__rng_mod__DOT__cmpHio_mod__DOT__nC 
        = (0xffU & (~ ((IData)(this->__PVT__rng_mod__DOT__cmpHio_mod__DOT__P3) 
                       | (IData)(this->__PVT__rng_mod__DOT__cmpHio_mod__DOT__G3))));
}

void Vagu_block_sagu::_settle__TOP__agu_block__DOT__Wagu_mod__71(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+        Vagu_block_sagu::_settle__TOP__agu_block__DOT__Wagu_mod__71\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->__PVT__addrNext = ((IData)(this->addrNext__out9) 
                             & (IData)(this->__pinNumber3__en0));
}

void Vagu_block_sagu::_settle__TOP__agu_block__DOT__Wagu_mod__73(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+        Vagu_block_sagu::_settle__TOP__agu_block__DOT__Wagu_mod__73\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->mOp_addrEven = ((VL_ULL(0xfffffffe0) & this->mOp_addrEven) 
                          | (IData)((IData)((0x1fU 
                                             & ((1U 
                                                 & (IData)(
                                                           (vlTOPp->agu_block__DOT__p4_cmplxAddr 
                                                            >> 7U)))
                                                 ? 
                                                ((IData)(this->__PVT__addrNext) 
                                                 >> 8U)
                                                 : (IData)(
                                                           (vlTOPp->agu_block__DOT__p4_cmplxAddr 
                                                            >> 8U)))))));
    this->mOp_addrOdd = ((VL_ULL(0xfffffffe0) & this->mOp_addrOdd) 
                         | (IData)((IData)((0x1fU & 
                                            ((1U & (IData)(
                                                           (vlTOPp->agu_block__DOT__p4_cmplxAddr 
                                                            >> 7U)))
                                              ? (IData)(
                                                        (vlTOPp->agu_block__DOT__p4_cmplxAddr 
                                                         >> 8U))
                                              : ((IData)(this->__PVT__addrNext) 
                                                 >> 8U))))));
}

void Vagu_block_sagu::_settle__TOP__agu_block__DOT__Wagu_mod__75(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+        Vagu_block_sagu::_settle__TOP__agu_block__DOT__Wagu_mod__75\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->mOp_addrEven = ((VL_ULL(0x1f) & this->mOp_addrEven) 
                          | ((QData)((IData)((0x7fffffffU 
                                              & ((1U 
                                                  & ((IData)(
                                                             (vlTOPp->agu_block__DOT__p4_cmplxAddr 
                                                              >> 7U)) 
                                                     & ((IData)(this->__PVT__addrNext) 
                                                        >> 0xdU)))
                                                  ? (IData)(__PVT__tlb_mod->read_data_next)
                                                  : (IData)(__PVT__tlb_mod->read_data))))) 
                             << 5U));
    this->mOp_addrOdd = ((VL_ULL(0x1f) & this->mOp_addrOdd) 
                         | ((QData)((IData)((0x7fffffffU 
                                             & ((1U 
                                                 & ((~ (IData)(
                                                               (vlTOPp->agu_block__DOT__p4_cmplxAddr 
                                                                >> 7U))) 
                                                    & ((IData)(this->__PVT__addrNext) 
                                                       >> 0xdU)))
                                                 ? (IData)(__PVT__tlb_mod->read_data_next)
                                                 : (IData)(__PVT__tlb_mod->read_data))))) 
                            << 5U));
}

void Vagu_block_sagu::_settle__TOP__agu_block__DOT__Wagu_mod__77(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+        Vagu_block_sagu::_settle__TOP__agu_block__DOT__Wagu_mod__77\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->__PVT__cout_secq = ((((IData)(vlTOPp->agu_block__DOT__p4_mex_en_reg) 
                                | (IData)(vlTOPp->agu_block__DOT__p4_sec_in_reg)) 
                               & ((~ ((IData)(this->__PVT__rng_mod__DOT__cmpLow_mod__DOT__nC) 
                                      >> 7U)) | ((IData)(vlTOPp->agu_block__DOT____Vcellinp__Wagu_mod__ptrdiff) 
                                                 & (~ (IData)(
                                                              (vlTOPp->agu_block__DOT__p4_cmplxAddr 
                                                               >> 0x2cU)))))) 
                              & ((~ ((IData)(this->__PVT__rng_mod__DOT__cmpHio_mod__DOT__nC) 
                                     >> 7U)) | ((IData)(vlTOPp->agu_block__DOT____Vcellinp__Wagu_mod__ptrdiff) 
                                                & (IData)(
                                                          (vlTOPp->agu_block__DOT__p4_cmplxAddr 
                                                           >> 0x2cU)))));
}

void Vagu_block_sagu::_settle__TOP__agu_block__DOT__Wagu_mod__79(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+        Vagu_block_sagu::_settle__TOP__agu_block__DOT__Wagu_mod__79\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->tlbMiss = ((((IData)(this->__PVT__read_clkEn_reg) 
                       & (~ (IData)(__PVT__tlb_mod->read_hit))) 
                      & (IData)(this->__PVT__cout_secq)) 
                     & (~ (IData)(vlTOPp->except)));
}

VL_INLINE_OPT void Vagu_block_sagu::_combo__TOP__agu_block__DOT__Wagu_mod__81(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+        Vagu_block_sagu::_combo__TOP__agu_block__DOT__Wagu_mod__81\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->__PVT__rcn_mask = ((2U & ((~ (IData)(vlTOPp->except)) 
                                    << 1U)) | (1U & 
                                               (~ (IData)(vlTOPp->except))));
    vlSymsp->TOP__agu_block__DOT__Wagu2_mod.__PVT__rcn_mask 
        = ((2U & ((~ (IData)(vlTOPp->except)) << 1U)) 
           | (1U & (~ (IData)(vlTOPp->except))));
}

void Vagu_block_sagu::_settle__TOP__agu_block__DOT__Wagu2_mod__4(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+        Vagu_block_sagu::_settle__TOP__agu_block__DOT__Wagu2_mod__4\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->__pinNumber3__en0 = (0x3fffU & ((((((((((
                                                   (((((((((((((((((1U 
                                                                    & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr)) 
                                                                   | (1U 
                                                                      & (~ 
                                                                         (0x1fffU 
                                                                          & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr))))) 
                                                                  | (2U 
                                                                     & (0x80U 
                                                                        ^ 
                                                                        (0x1ffeU 
                                                                         & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr))))) 
                                                                 | (2U 
                                                                    & ((IData)(0x80U) 
                                                                       ^ ~ 
                                                                       (0x1fffU 
                                                                        & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr))))) 
                                                                | (4U 
                                                                   & (0x80U 
                                                                      ^ 
                                                                      (0x1ffcU 
                                                                       & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr))))) 
                                                               | (4U 
                                                                  & ((IData)(0x80U) 
                                                                     ^ ~ 
                                                                     (0x1fffU 
                                                                      & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr))))) 
                                                              | (8U 
                                                                 & (0x80U 
                                                                    ^ 
                                                                    (0x1ff8U 
                                                                     & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr))))) 
                                                             | (8U 
                                                                & ((IData)(0x80U) 
                                                                   ^ ~ 
                                                                   (0x1fffU 
                                                                    & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr))))) 
                                                            | (0x10U 
                                                               & (0x80U 
                                                                  ^ 
                                                                  (0x1ff0U 
                                                                   & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr))))) 
                                                           | (0x10U 
                                                              & ((IData)(0x80U) 
                                                                 ^ ~ 
                                                                 (0x1fffU 
                                                                  & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr))))) 
                                                          | (0x20U 
                                                             & (0x80U 
                                                                ^ 
                                                                (0x1fe0U 
                                                                 & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr))))) 
                                                         | (0x20U 
                                                            & ((IData)(0x80U) 
                                                               ^ ~ 
                                                               (0x1fffU 
                                                                & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr))))) 
                                                        | (0x40U 
                                                           & (0x80U 
                                                              ^ 
                                                              (0x1fc0U 
                                                               & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr))))) 
                                                       | (0x40U 
                                                          & ((IData)(0x80U) 
                                                             ^ ~ 
                                                             (0x1fffU 
                                                              & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr))))) 
                                                      | (0x80U 
                                                         & (0x80U 
                                                            ^ 
                                                            (0x1f80U 
                                                             & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr))))) 
                                                     | (0x80U 
                                                        & ((IData)(0x80U) 
                                                           ^ ~ 
                                                           (0x1fffU 
                                                            & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr))))) 
                                                    | (0x100U 
                                                       & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr))) 
                                                   | (0x100U 
                                                      & ((IData)(0x80U) 
                                                         ^ ~ 
                                                         (0x1fffU 
                                                          & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr))))) 
                                                  | (0x200U 
                                                     & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr))) 
                                                 | (0x200U 
                                                    & ((IData)(0x80U) 
                                                       ^ ~ 
                                                       (0x1fffU 
                                                        & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr))))) 
                                                | (0x400U 
                                                   & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr))) 
                                               | (0x400U 
                                                  & ((IData)(0x80U) 
                                                     ^ ~ 
                                                     (0x1fffU 
                                                      & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr))))) 
                                              | (0x800U 
                                                 & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr))) 
                                             | (0x800U 
                                                & ((IData)(0x80U) 
                                                   ^ ~ 
                                                   (0x1fffU 
                                                    & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr))))) 
                                            | (0x1000U 
                                               & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr))) 
                                           | (0x1000U 
                                              & ((IData)(0x80U) 
                                                 ^ ~ 
                                                 (0x1fffU 
                                                  & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr))))) 
                                          | (0x2000U 
                                             & ((IData)(0x80U) 
                                                ^ ~ 
                                                (0x1fffU 
                                                 & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr))))));
}

void Vagu_block_sagu::_settle__TOP__agu_block__DOT__Wagu2_mod__6(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+        Vagu_block_sagu::_settle__TOP__agu_block__DOT__Wagu2_mod__6\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->nextCAddr_mod__DOT__out__out__out0 = ((0x3ffeU 
                                                 & (IData)(this->nextCAddr_mod__DOT__out__out__out0)) 
                                                | (1U 
                                                   & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr)));
}

void Vagu_block_sagu::_settle__TOP__agu_block__DOT__Wagu2_mod__8(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+        Vagu_block_sagu::_settle__TOP__agu_block__DOT__Wagu2_mod__8\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->__PVT__rng_mod__DOT__sh_mod__DOT__bits_med 
        = ((((((0U == (3U & (IData)((vlTOPp->agu_block__DOT__p5_cmplxAddr 
                                     >> 0x3eU)))) ? (IData)(
                                                            (vlTOPp->agu_block__DOT__p5_cmplxAddr 
                                                             >> 4U))
                : 0U) & ((0U == (3U & (IData)((vlTOPp->agu_block__DOT__p5_cmplxAddr 
                                               >> 0x3eU))))
                          ? 0xffffU : 0U)) | (((1U 
                                                == 
                                                (3U 
                                                 & (IData)(
                                                           (vlTOPp->agu_block__DOT__p5_cmplxAddr 
                                                            >> 0x3eU))))
                                                ? (IData)(
                                                          (vlTOPp->agu_block__DOT__p5_cmplxAddr 
                                                           >> 0xcU))
                                                : 0U) 
                                              & ((1U 
                                                  == 
                                                  (3U 
                                                   & (IData)(
                                                             (vlTOPp->agu_block__DOT__p5_cmplxAddr 
                                                              >> 0x3eU))))
                                                  ? 0xffffU
                                                  : 0U))) 
            | (((2U == (3U & (IData)((vlTOPp->agu_block__DOT__p5_cmplxAddr 
                                      >> 0x3eU)))) ? (IData)(
                                                             (vlTOPp->agu_block__DOT__p5_cmplxAddr 
                                                              >> 0x14U))
                 : 0U) & ((2U == (3U & (IData)((vlTOPp->agu_block__DOT__p5_cmplxAddr 
                                                >> 0x3eU))))
                           ? 0xffffU : 0U))) | (((3U 
                                                  == 
                                                  (3U 
                                                   & (IData)(
                                                             (vlTOPp->agu_block__DOT__p5_cmplxAddr 
                                                              >> 0x3eU))))
                                                  ? (IData)(
                                                            (vlTOPp->agu_block__DOT__p5_cmplxAddr 
                                                             >> 0x1cU))
                                                  : 0U) 
                                                & ((3U 
                                                    == 
                                                    (3U 
                                                     & (IData)(
                                                               (vlTOPp->agu_block__DOT__p5_cmplxAddr 
                                                                >> 0x3eU))))
                                                    ? 0xffffU
                                                    : 0U)));
}

void Vagu_block_sagu::_settle__TOP__agu_block__DOT__Wagu2_mod__12(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+        Vagu_block_sagu::_settle__TOP__agu_block__DOT__Wagu2_mod__12\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->__PVT__nextCAddr_mod__DOT__G1 = (0x3ffeU 
                                           & ((~ ((
                                                   (~ 
                                                    (0x40U 
                                                     | (0xfffU 
                                                        & ((IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr) 
                                                           >> 1U)))) 
                                                   | (~ 
                                                      (0x80U 
                                                       & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr)))) 
                                                  & (~ 
                                                     (0x40U 
                                                      & ((IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr) 
                                                         >> 1U))))) 
                                              << 1U));
}

void Vagu_block_sagu::_settle__TOP__agu_block__DOT__Wagu2_mod__14(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+        Vagu_block_sagu::_settle__TOP__agu_block__DOT__Wagu2_mod__14\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->rng_mod__DOT__sh_mod__DOT__bits_med__en = 
        (((((0U == (3U & (IData)((vlTOPp->agu_block__DOT__p5_cmplxAddr 
                                  >> 0x3eU)))) ? 0xffffU
             : 0U) | ((1U == (3U & (IData)((vlTOPp->agu_block__DOT__p5_cmplxAddr 
                                            >> 0x3eU))))
                       ? 0xffffU : 0U)) | ((2U == (3U 
                                                   & (IData)(
                                                             (vlTOPp->agu_block__DOT__p5_cmplxAddr 
                                                              >> 0x3eU))))
                                            ? 0xffffU
                                            : 0U)) 
         | ((3U == (3U & (IData)((vlTOPp->agu_block__DOT__p5_cmplxAddr 
                                  >> 0x3eU)))) ? 0xffffU
             : 0U));
}

void Vagu_block_sagu::_settle__TOP__agu_block__DOT__Wagu2_mod__16(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+        Vagu_block_sagu::_settle__TOP__agu_block__DOT__Wagu2_mod__16\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->__PVT__nextCAddr_mod__DOT__P1 = ((0x3ffeU 
                                            & ((~ (
                                                   (~ 
                                                    (0x40U 
                                                     | (0xfffU 
                                                        & ((IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr) 
                                                           >> 1U)))) 
                                                   | (~ 
                                                      (0x80U 
                                                       | (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr))))) 
                                               << 1U)) 
                                           | (1U & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr)));
}

void Vagu_block_sagu::_settle__TOP__agu_block__DOT__Wagu2_mod__18(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+        Vagu_block_sagu::_settle__TOP__agu_block__DOT__Wagu2_mod__18\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->__PVT__addrTlb = (((QData)((IData)((0x1fffffU 
                                              & this->__PVT__proc))) 
                             << 0x1fU) | (QData)((IData)(
                                                         (0x7fffffffU 
                                                          & (IData)(
                                                                    (vlTOPp->agu_block__DOT__p5_cmplxAddr 
                                                                     >> 0xdU))))));
}

void Vagu_block_sagu::_settle__TOP__agu_block__DOT__Wagu2_mod__24(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+        Vagu_block_sagu::_settle__TOP__agu_block__DOT__Wagu2_mod__24\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->__PVT__banks0 = ((0xfffffffeU & this->__PVT__banks0) 
                           | (((((0U == (0x1fU & (IData)(
                                                         (vlTOPp->agu_block__DOT__p5_cmplxAddr 
                                                          >> 2U)))) 
                                 | (((((3U == (IData)(this->__PVT__opsize)) 
                                       | ((IData)(this->__PVT__opsize) 
                                          >> 2U)) | 
                                      ((0U != (3U & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr))) 
                                       & (2U == (IData)(this->__PVT__opsize)))) 
                                     | ((3U == (3U 
                                                & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr))) 
                                        & (1U == (IData)(this->__PVT__opsize)))) 
                                    & (0x1fU == (0x1fU 
                                                 & (IData)(
                                                           (vlTOPp->agu_block__DOT__p5_cmplxAddr 
                                                            >> 2U)))))) 
                                | ((((3U == (IData)(this->__PVT__opsize)) 
                                     & (0U != (3U & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr)))) 
                                    | ((IData)(this->__PVT__opsize) 
                                       >> 2U)) & (0x1eU 
                                                  == 
                                                  (0x1fU 
                                                   & (IData)(
                                                             (vlTOPp->agu_block__DOT__p5_cmplxAddr 
                                                              >> 2U)))))) 
                               | (((((4U == (IData)(this->__PVT__opsize)) 
                                     & (3U == (3U & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr)))) 
                                    | (5U == (IData)(this->__PVT__opsize))) 
                                   | (6U == (IData)(this->__PVT__opsize))) 
                                  & (0x1dU == (0x1fU 
                                               & (IData)(
                                                         (vlTOPp->agu_block__DOT__p5_cmplxAddr 
                                                          >> 2U)))))) 
                              | ((((5U == (IData)(this->__PVT__opsize)) 
                                   & (0U != (3U & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr)))) 
                                  | (6U == (IData)(this->__PVT__opsize))) 
                                 & (0x1cU == (0x1fU 
                                              & (IData)(
                                                        (vlTOPp->agu_block__DOT__p5_cmplxAddr 
                                                         >> 2U)))))));
    this->__PVT__banks0 = ((0xfffffffdU & this->__PVT__banks0) 
                           | ((((((1U == (0x1fU & (IData)(
                                                          (vlTOPp->agu_block__DOT__p5_cmplxAddr 
                                                           >> 2U)))) 
                                  << 1U) | ((((((3U 
                                                 == (IData)(this->__PVT__opsize)) 
                                                << 1U) 
                                               | (0x7ffffffeU 
                                                  & ((IData)(this->__PVT__opsize) 
                                                     >> 1U))) 
                                              | (((0U 
                                                   != 
                                                   (3U 
                                                    & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr))) 
                                                  & (2U 
                                                     == (IData)(this->__PVT__opsize))) 
                                                 << 1U)) 
                                             | (((3U 
                                                  == 
                                                  (3U 
                                                   & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr))) 
                                                 & (1U 
                                                    == (IData)(this->__PVT__opsize))) 
                                                << 1U)) 
                                            & ((0U 
                                                == 
                                                (0x1fU 
                                                 & (IData)(
                                                           (vlTOPp->agu_block__DOT__p5_cmplxAddr 
                                                            >> 2U)))) 
                                               << 1U))) 
                                | (((((3U == (IData)(this->__PVT__opsize)) 
                                      & (0U != (3U 
                                                & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr)))) 
                                     << 1U) | (0x7ffffffeU 
                                               & ((IData)(this->__PVT__opsize) 
                                                  >> 1U))) 
                                   & ((0x1fU == (0x1fU 
                                                 & (IData)(
                                                           (vlTOPp->agu_block__DOT__p5_cmplxAddr 
                                                            >> 2U)))) 
                                      << 1U))) | ((
                                                   ((((4U 
                                                       == (IData)(this->__PVT__opsize)) 
                                                      & (3U 
                                                         == 
                                                         (3U 
                                                          & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr)))) 
                                                     | (5U 
                                                        == (IData)(this->__PVT__opsize))) 
                                                    | (6U 
                                                       == (IData)(this->__PVT__opsize))) 
                                                   & (0x1eU 
                                                      == 
                                                      (0x1fU 
                                                       & (IData)(
                                                                 (vlTOPp->agu_block__DOT__p5_cmplxAddr 
                                                                  >> 2U))))) 
                                                  << 1U)) 
                              | (((((5U == (IData)(this->__PVT__opsize)) 
                                    & (0U != (3U & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr)))) 
                                   | (6U == (IData)(this->__PVT__opsize))) 
                                  & (0x1dU == (0x1fU 
                                               & (IData)(
                                                         (vlTOPp->agu_block__DOT__p5_cmplxAddr 
                                                          >> 2U))))) 
                                 << 1U)));
    this->__PVT__banks0 = ((0xfffffffbU & this->__PVT__banks0) 
                           | ((((((2U == (0x1fU & (IData)(
                                                          (vlTOPp->agu_block__DOT__p5_cmplxAddr 
                                                           >> 2U)))) 
                                  << 2U) | ((((((3U 
                                                 == (IData)(this->__PVT__opsize)) 
                                                << 2U) 
                                               | (0xfffffffcU 
                                                  & (IData)(this->__PVT__opsize))) 
                                              | (((0U 
                                                   != 
                                                   (3U 
                                                    & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr))) 
                                                  & (2U 
                                                     == (IData)(this->__PVT__opsize))) 
                                                 << 2U)) 
                                             | (((3U 
                                                  == 
                                                  (3U 
                                                   & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr))) 
                                                 & (1U 
                                                    == (IData)(this->__PVT__opsize))) 
                                                << 2U)) 
                                            & ((1U 
                                                == 
                                                (0x1fU 
                                                 & (IData)(
                                                           (vlTOPp->agu_block__DOT__p5_cmplxAddr 
                                                            >> 2U)))) 
                                               << 2U))) 
                                | (((((3U == (IData)(this->__PVT__opsize)) 
                                      & (0U != (3U 
                                                & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr)))) 
                                     << 2U) | (0xfffffffcU 
                                               & (IData)(this->__PVT__opsize))) 
                                   & ((0U == (0x1fU 
                                              & (IData)(
                                                        (vlTOPp->agu_block__DOT__p5_cmplxAddr 
                                                         >> 2U)))) 
                                      << 2U))) | ((
                                                   ((((4U 
                                                       == (IData)(this->__PVT__opsize)) 
                                                      & (3U 
                                                         == 
                                                         (3U 
                                                          & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr)))) 
                                                     | (5U 
                                                        == (IData)(this->__PVT__opsize))) 
                                                    | (6U 
                                                       == (IData)(this->__PVT__opsize))) 
                                                   & (0x1fU 
                                                      == 
                                                      (0x1fU 
                                                       & (IData)(
                                                                 (vlTOPp->agu_block__DOT__p5_cmplxAddr 
                                                                  >> 2U))))) 
                                                  << 2U)) 
                              | (((((5U == (IData)(this->__PVT__opsize)) 
                                    & (0U != (3U & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr)))) 
                                   | (6U == (IData)(this->__PVT__opsize))) 
                                  & (0x1eU == (0x1fU 
                                               & (IData)(
                                                         (vlTOPp->agu_block__DOT__p5_cmplxAddr 
                                                          >> 2U))))) 
                                 << 2U)));
    this->__PVT__banks0 = ((0xfffffff7U & this->__PVT__banks0) 
                           | ((((((3U == (0x1fU & (IData)(
                                                          (vlTOPp->agu_block__DOT__p5_cmplxAddr 
                                                           >> 2U)))) 
                                  << 3U) | ((((((3U 
                                                 == (IData)(this->__PVT__opsize)) 
                                                << 3U) 
                                               | (0xfffffff8U 
                                                  & ((IData)(this->__PVT__opsize) 
                                                     << 1U))) 
                                              | (((0U 
                                                   != 
                                                   (3U 
                                                    & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr))) 
                                                  & (2U 
                                                     == (IData)(this->__PVT__opsize))) 
                                                 << 3U)) 
                                             | (((3U 
                                                  == 
                                                  (3U 
                                                   & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr))) 
                                                 & (1U 
                                                    == (IData)(this->__PVT__opsize))) 
                                                << 3U)) 
                                            & ((2U 
                                                == 
                                                (0x1fU 
                                                 & (IData)(
                                                           (vlTOPp->agu_block__DOT__p5_cmplxAddr 
                                                            >> 2U)))) 
                                               << 3U))) 
                                | (((((3U == (IData)(this->__PVT__opsize)) 
                                      & (0U != (3U 
                                                & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr)))) 
                                     << 3U) | (0xfffffff8U 
                                               & ((IData)(this->__PVT__opsize) 
                                                  << 1U))) 
                                   & ((1U == (0x1fU 
                                              & (IData)(
                                                        (vlTOPp->agu_block__DOT__p5_cmplxAddr 
                                                         >> 2U)))) 
                                      << 3U))) | ((
                                                   ((((4U 
                                                       == (IData)(this->__PVT__opsize)) 
                                                      & (3U 
                                                         == 
                                                         (3U 
                                                          & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr)))) 
                                                     | (5U 
                                                        == (IData)(this->__PVT__opsize))) 
                                                    | (6U 
                                                       == (IData)(this->__PVT__opsize))) 
                                                   & (0U 
                                                      == 
                                                      (0x1fU 
                                                       & (IData)(
                                                                 (vlTOPp->agu_block__DOT__p5_cmplxAddr 
                                                                  >> 2U))))) 
                                                  << 3U)) 
                              | (((((5U == (IData)(this->__PVT__opsize)) 
                                    & (0U != (3U & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr)))) 
                                   | (6U == (IData)(this->__PVT__opsize))) 
                                  & (0x1fU == (0x1fU 
                                               & (IData)(
                                                         (vlTOPp->agu_block__DOT__p5_cmplxAddr 
                                                          >> 2U))))) 
                                 << 3U)));
    this->__PVT__banks0 = ((0xffffffefU & this->__PVT__banks0) 
                           | ((((((4U == (0x1fU & (IData)(
                                                          (vlTOPp->agu_block__DOT__p5_cmplxAddr 
                                                           >> 2U)))) 
                                  << 4U) | ((((((3U 
                                                 == (IData)(this->__PVT__opsize)) 
                                                << 4U) 
                                               | (0xfffffff0U 
                                                  & ((IData)(this->__PVT__opsize) 
                                                     << 2U))) 
                                              | (((0U 
                                                   != 
                                                   (3U 
                                                    & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr))) 
                                                  & (2U 
                                                     == (IData)(this->__PVT__opsize))) 
                                                 << 4U)) 
                                             | (((3U 
                                                  == 
                                                  (3U 
                                                   & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr))) 
                                                 & (1U 
                                                    == (IData)(this->__PVT__opsize))) 
                                                << 4U)) 
                                            & ((3U 
                                                == 
                                                (0x1fU 
                                                 & (IData)(
                                                           (vlTOPp->agu_block__DOT__p5_cmplxAddr 
                                                            >> 2U)))) 
                                               << 4U))) 
                                | (((((3U == (IData)(this->__PVT__opsize)) 
                                      & (0U != (3U 
                                                & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr)))) 
                                     << 4U) | (0xfffffff0U 
                                               & ((IData)(this->__PVT__opsize) 
                                                  << 2U))) 
                                   & ((2U == (0x1fU 
                                              & (IData)(
                                                        (vlTOPp->agu_block__DOT__p5_cmplxAddr 
                                                         >> 2U)))) 
                                      << 4U))) | ((
                                                   ((((4U 
                                                       == (IData)(this->__PVT__opsize)) 
                                                      & (3U 
                                                         == 
                                                         (3U 
                                                          & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr)))) 
                                                     | (5U 
                                                        == (IData)(this->__PVT__opsize))) 
                                                    | (6U 
                                                       == (IData)(this->__PVT__opsize))) 
                                                   & (1U 
                                                      == 
                                                      (0x1fU 
                                                       & (IData)(
                                                                 (vlTOPp->agu_block__DOT__p5_cmplxAddr 
                                                                  >> 2U))))) 
                                                  << 4U)) 
                              | (((((5U == (IData)(this->__PVT__opsize)) 
                                    & (0U != (3U & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr)))) 
                                   | (6U == (IData)(this->__PVT__opsize))) 
                                  & (0U == (0x1fU & (IData)(
                                                            (vlTOPp->agu_block__DOT__p5_cmplxAddr 
                                                             >> 2U))))) 
                                 << 4U)));
    this->__PVT__banks0 = ((0xffffffdfU & this->__PVT__banks0) 
                           | ((((((5U == (0x1fU & (IData)(
                                                          (vlTOPp->agu_block__DOT__p5_cmplxAddr 
                                                           >> 2U)))) 
                                  << 5U) | ((((((3U 
                                                 == (IData)(this->__PVT__opsize)) 
                                                << 5U) 
                                               | (0xffffffe0U 
                                                  & ((IData)(this->__PVT__opsize) 
                                                     << 3U))) 
                                              | (((0U 
                                                   != 
                                                   (3U 
                                                    & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr))) 
                                                  & (2U 
                                                     == (IData)(this->__PVT__opsize))) 
                                                 << 5U)) 
                                             | (((3U 
                                                  == 
                                                  (3U 
                                                   & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr))) 
                                                 & (1U 
                                                    == (IData)(this->__PVT__opsize))) 
                                                << 5U)) 
                                            & ((4U 
                                                == 
                                                (0x1fU 
                                                 & (IData)(
                                                           (vlTOPp->agu_block__DOT__p5_cmplxAddr 
                                                            >> 2U)))) 
                                               << 5U))) 
                                | (((((3U == (IData)(this->__PVT__opsize)) 
                                      & (0U != (3U 
                                                & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr)))) 
                                     << 5U) | (0xffffffe0U 
                                               & ((IData)(this->__PVT__opsize) 
                                                  << 3U))) 
                                   & ((3U == (0x1fU 
                                              & (IData)(
                                                        (vlTOPp->agu_block__DOT__p5_cmplxAddr 
                                                         >> 2U)))) 
                                      << 5U))) | ((
                                                   ((((4U 
                                                       == (IData)(this->__PVT__opsize)) 
                                                      & (3U 
                                                         == 
                                                         (3U 
                                                          & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr)))) 
                                                     | (5U 
                                                        == (IData)(this->__PVT__opsize))) 
                                                    | (6U 
                                                       == (IData)(this->__PVT__opsize))) 
                                                   & (2U 
                                                      == 
                                                      (0x1fU 
                                                       & (IData)(
                                                                 (vlTOPp->agu_block__DOT__p5_cmplxAddr 
                                                                  >> 2U))))) 
                                                  << 5U)) 
                              | (((((5U == (IData)(this->__PVT__opsize)) 
                                    & (0U != (3U & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr)))) 
                                   | (6U == (IData)(this->__PVT__opsize))) 
                                  & (1U == (0x1fU & (IData)(
                                                            (vlTOPp->agu_block__DOT__p5_cmplxAddr 
                                                             >> 2U))))) 
                                 << 5U)));
    this->__PVT__banks0 = ((0xffffffbfU & this->__PVT__banks0) 
                           | ((((((6U == (0x1fU & (IData)(
                                                          (vlTOPp->agu_block__DOT__p5_cmplxAddr 
                                                           >> 2U)))) 
                                  << 6U) | ((((((3U 
                                                 == (IData)(this->__PVT__opsize)) 
                                                << 6U) 
                                               | (0xffffffc0U 
                                                  & ((IData)(this->__PVT__opsize) 
                                                     << 4U))) 
                                              | (((0U 
                                                   != 
                                                   (3U 
                                                    & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr))) 
                                                  & (2U 
                                                     == (IData)(this->__PVT__opsize))) 
                                                 << 6U)) 
                                             | (((3U 
                                                  == 
                                                  (3U 
                                                   & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr))) 
                                                 & (1U 
                                                    == (IData)(this->__PVT__opsize))) 
                                                << 6U)) 
                                            & ((5U 
                                                == 
                                                (0x1fU 
                                                 & (IData)(
                                                           (vlTOPp->agu_block__DOT__p5_cmplxAddr 
                                                            >> 2U)))) 
                                               << 6U))) 
                                | (((((3U == (IData)(this->__PVT__opsize)) 
                                      & (0U != (3U 
                                                & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr)))) 
                                     << 6U) | (0xffffffc0U 
                                               & ((IData)(this->__PVT__opsize) 
                                                  << 4U))) 
                                   & ((4U == (0x1fU 
                                              & (IData)(
                                                        (vlTOPp->agu_block__DOT__p5_cmplxAddr 
                                                         >> 2U)))) 
                                      << 6U))) | ((
                                                   ((((4U 
                                                       == (IData)(this->__PVT__opsize)) 
                                                      & (3U 
                                                         == 
                                                         (3U 
                                                          & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr)))) 
                                                     | (5U 
                                                        == (IData)(this->__PVT__opsize))) 
                                                    | (6U 
                                                       == (IData)(this->__PVT__opsize))) 
                                                   & (3U 
                                                      == 
                                                      (0x1fU 
                                                       & (IData)(
                                                                 (vlTOPp->agu_block__DOT__p5_cmplxAddr 
                                                                  >> 2U))))) 
                                                  << 6U)) 
                              | (((((5U == (IData)(this->__PVT__opsize)) 
                                    & (0U != (3U & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr)))) 
                                   | (6U == (IData)(this->__PVT__opsize))) 
                                  & (2U == (0x1fU & (IData)(
                                                            (vlTOPp->agu_block__DOT__p5_cmplxAddr 
                                                             >> 2U))))) 
                                 << 6U)));
    this->__PVT__banks0 = ((0xffffff7fU & this->__PVT__banks0) 
                           | ((((((7U == (0x1fU & (IData)(
                                                          (vlTOPp->agu_block__DOT__p5_cmplxAddr 
                                                           >> 2U)))) 
                                  << 7U) | ((((((3U 
                                                 == (IData)(this->__PVT__opsize)) 
                                                << 7U) 
                                               | (0xffffff80U 
                                                  & ((IData)(this->__PVT__opsize) 
                                                     << 5U))) 
                                              | (((0U 
                                                   != 
                                                   (3U 
                                                    & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr))) 
                                                  & (2U 
                                                     == (IData)(this->__PVT__opsize))) 
                                                 << 7U)) 
                                             | (((3U 
                                                  == 
                                                  (3U 
                                                   & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr))) 
                                                 & (1U 
                                                    == (IData)(this->__PVT__opsize))) 
                                                << 7U)) 
                                            & ((6U 
                                                == 
                                                (0x1fU 
                                                 & (IData)(
                                                           (vlTOPp->agu_block__DOT__p5_cmplxAddr 
                                                            >> 2U)))) 
                                               << 7U))) 
                                | (((((3U == (IData)(this->__PVT__opsize)) 
                                      & (0U != (3U 
                                                & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr)))) 
                                     << 7U) | (0xffffff80U 
                                               & ((IData)(this->__PVT__opsize) 
                                                  << 5U))) 
                                   & ((5U == (0x1fU 
                                              & (IData)(
                                                        (vlTOPp->agu_block__DOT__p5_cmplxAddr 
                                                         >> 2U)))) 
                                      << 7U))) | ((
                                                   ((((4U 
                                                       == (IData)(this->__PVT__opsize)) 
                                                      & (3U 
                                                         == 
                                                         (3U 
                                                          & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr)))) 
                                                     | (5U 
                                                        == (IData)(this->__PVT__opsize))) 
                                                    | (6U 
                                                       == (IData)(this->__PVT__opsize))) 
                                                   & (4U 
                                                      == 
                                                      (0x1fU 
                                                       & (IData)(
                                                                 (vlTOPp->agu_block__DOT__p5_cmplxAddr 
                                                                  >> 2U))))) 
                                                  << 7U)) 
                              | (((((5U == (IData)(this->__PVT__opsize)) 
                                    & (0U != (3U & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr)))) 
                                   | (6U == (IData)(this->__PVT__opsize))) 
                                  & (3U == (0x1fU & (IData)(
                                                            (vlTOPp->agu_block__DOT__p5_cmplxAddr 
                                                             >> 2U))))) 
                                 << 7U)));
    this->__PVT__banks0 = ((0xfffffeffU & this->__PVT__banks0) 
                           | ((((((8U == (0x1fU & (IData)(
                                                          (vlTOPp->agu_block__DOT__p5_cmplxAddr 
                                                           >> 2U)))) 
                                  << 8U) | ((((((3U 
                                                 == (IData)(this->__PVT__opsize)) 
                                                << 8U) 
                                               | (0xffffff00U 
                                                  & ((IData)(this->__PVT__opsize) 
                                                     << 6U))) 
                                              | (((0U 
                                                   != 
                                                   (3U 
                                                    & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr))) 
                                                  & (2U 
                                                     == (IData)(this->__PVT__opsize))) 
                                                 << 8U)) 
                                             | (((3U 
                                                  == 
                                                  (3U 
                                                   & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr))) 
                                                 & (1U 
                                                    == (IData)(this->__PVT__opsize))) 
                                                << 8U)) 
                                            & ((7U 
                                                == 
                                                (0x1fU 
                                                 & (IData)(
                                                           (vlTOPp->agu_block__DOT__p5_cmplxAddr 
                                                            >> 2U)))) 
                                               << 8U))) 
                                | (((((3U == (IData)(this->__PVT__opsize)) 
                                      & (0U != (3U 
                                                & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr)))) 
                                     << 8U) | (0xffffff00U 
                                               & ((IData)(this->__PVT__opsize) 
                                                  << 6U))) 
                                   & ((6U == (0x1fU 
                                              & (IData)(
                                                        (vlTOPp->agu_block__DOT__p5_cmplxAddr 
                                                         >> 2U)))) 
                                      << 8U))) | ((
                                                   ((((4U 
                                                       == (IData)(this->__PVT__opsize)) 
                                                      & (3U 
                                                         == 
                                                         (3U 
                                                          & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr)))) 
                                                     | (5U 
                                                        == (IData)(this->__PVT__opsize))) 
                                                    | (6U 
                                                       == (IData)(this->__PVT__opsize))) 
                                                   & (5U 
                                                      == 
                                                      (0x1fU 
                                                       & (IData)(
                                                                 (vlTOPp->agu_block__DOT__p5_cmplxAddr 
                                                                  >> 2U))))) 
                                                  << 8U)) 
                              | (((((5U == (IData)(this->__PVT__opsize)) 
                                    & (0U != (3U & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr)))) 
                                   | (6U == (IData)(this->__PVT__opsize))) 
                                  & (4U == (0x1fU & (IData)(
                                                            (vlTOPp->agu_block__DOT__p5_cmplxAddr 
                                                             >> 2U))))) 
                                 << 8U)));
    this->__PVT__banks0 = ((0xfffffdffU & this->__PVT__banks0) 
                           | ((((((9U == (0x1fU & (IData)(
                                                          (vlTOPp->agu_block__DOT__p5_cmplxAddr 
                                                           >> 2U)))) 
                                  << 9U) | ((((((3U 
                                                 == (IData)(this->__PVT__opsize)) 
                                                << 9U) 
                                               | (0xfffffe00U 
                                                  & ((IData)(this->__PVT__opsize) 
                                                     << 7U))) 
                                              | (((0U 
                                                   != 
                                                   (3U 
                                                    & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr))) 
                                                  & (2U 
                                                     == (IData)(this->__PVT__opsize))) 
                                                 << 9U)) 
                                             | (((3U 
                                                  == 
                                                  (3U 
                                                   & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr))) 
                                                 & (1U 
                                                    == (IData)(this->__PVT__opsize))) 
                                                << 9U)) 
                                            & ((8U 
                                                == 
                                                (0x1fU 
                                                 & (IData)(
                                                           (vlTOPp->agu_block__DOT__p5_cmplxAddr 
                                                            >> 2U)))) 
                                               << 9U))) 
                                | (((((3U == (IData)(this->__PVT__opsize)) 
                                      & (0U != (3U 
                                                & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr)))) 
                                     << 9U) | (0xfffffe00U 
                                               & ((IData)(this->__PVT__opsize) 
                                                  << 7U))) 
                                   & ((7U == (0x1fU 
                                              & (IData)(
                                                        (vlTOPp->agu_block__DOT__p5_cmplxAddr 
                                                         >> 2U)))) 
                                      << 9U))) | ((
                                                   ((((4U 
                                                       == (IData)(this->__PVT__opsize)) 
                                                      & (3U 
                                                         == 
                                                         (3U 
                                                          & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr)))) 
                                                     | (5U 
                                                        == (IData)(this->__PVT__opsize))) 
                                                    | (6U 
                                                       == (IData)(this->__PVT__opsize))) 
                                                   & (6U 
                                                      == 
                                                      (0x1fU 
                                                       & (IData)(
                                                                 (vlTOPp->agu_block__DOT__p5_cmplxAddr 
                                                                  >> 2U))))) 
                                                  << 9U)) 
                              | (((((5U == (IData)(this->__PVT__opsize)) 
                                    & (0U != (3U & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr)))) 
                                   | (6U == (IData)(this->__PVT__opsize))) 
                                  & (5U == (0x1fU & (IData)(
                                                            (vlTOPp->agu_block__DOT__p5_cmplxAddr 
                                                             >> 2U))))) 
                                 << 9U)));
    this->__PVT__banks0 = ((0xfffffbffU & this->__PVT__banks0) 
                           | ((((((0xaU == (0x1fU & (IData)(
                                                            (vlTOPp->agu_block__DOT__p5_cmplxAddr 
                                                             >> 2U)))) 
                                  << 0xaU) | ((((((3U 
                                                   == (IData)(this->__PVT__opsize)) 
                                                  << 0xaU) 
                                                 | (0xfffffc00U 
                                                    & ((IData)(this->__PVT__opsize) 
                                                       << 8U))) 
                                                | (((0U 
                                                     != 
                                                     (3U 
                                                      & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr))) 
                                                    & (2U 
                                                       == (IData)(this->__PVT__opsize))) 
                                                   << 0xaU)) 
                                               | (((3U 
                                                    == 
                                                    (3U 
                                                     & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr))) 
                                                   & (1U 
                                                      == (IData)(this->__PVT__opsize))) 
                                                  << 0xaU)) 
                                              & ((9U 
                                                  == 
                                                  (0x1fU 
                                                   & (IData)(
                                                             (vlTOPp->agu_block__DOT__p5_cmplxAddr 
                                                              >> 2U)))) 
                                                 << 0xaU))) 
                                | (((((3U == (IData)(this->__PVT__opsize)) 
                                      & (0U != (3U 
                                                & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr)))) 
                                     << 0xaU) | (0xfffffc00U 
                                                 & ((IData)(this->__PVT__opsize) 
                                                    << 8U))) 
                                   & ((8U == (0x1fU 
                                              & (IData)(
                                                        (vlTOPp->agu_block__DOT__p5_cmplxAddr 
                                                         >> 2U)))) 
                                      << 0xaU))) | 
                               ((((((4U == (IData)(this->__PVT__opsize)) 
                                    & (3U == (3U & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr)))) 
                                   | (5U == (IData)(this->__PVT__opsize))) 
                                  | (6U == (IData)(this->__PVT__opsize))) 
                                 & (7U == (0x1fU & (IData)(
                                                           (vlTOPp->agu_block__DOT__p5_cmplxAddr 
                                                            >> 2U))))) 
                                << 0xaU)) | (((((5U 
                                                 == (IData)(this->__PVT__opsize)) 
                                                & (0U 
                                                   != 
                                                   (3U 
                                                    & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr)))) 
                                               | (6U 
                                                  == (IData)(this->__PVT__opsize))) 
                                              & (6U 
                                                 == 
                                                 (0x1fU 
                                                  & (IData)(
                                                            (vlTOPp->agu_block__DOT__p5_cmplxAddr 
                                                             >> 2U))))) 
                                             << 0xaU)));
    this->__PVT__banks0 = ((0xfffff7ffU & this->__PVT__banks0) 
                           | ((((((0xbU == (0x1fU & (IData)(
                                                            (vlTOPp->agu_block__DOT__p5_cmplxAddr 
                                                             >> 2U)))) 
                                  << 0xbU) | ((((((3U 
                                                   == (IData)(this->__PVT__opsize)) 
                                                  << 0xbU) 
                                                 | (0xfffff800U 
                                                    & ((IData)(this->__PVT__opsize) 
                                                       << 9U))) 
                                                | (((0U 
                                                     != 
                                                     (3U 
                                                      & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr))) 
                                                    & (2U 
                                                       == (IData)(this->__PVT__opsize))) 
                                                   << 0xbU)) 
                                               | (((3U 
                                                    == 
                                                    (3U 
                                                     & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr))) 
                                                   & (1U 
                                                      == (IData)(this->__PVT__opsize))) 
                                                  << 0xbU)) 
                                              & ((0xaU 
                                                  == 
                                                  (0x1fU 
                                                   & (IData)(
                                                             (vlTOPp->agu_block__DOT__p5_cmplxAddr 
                                                              >> 2U)))) 
                                                 << 0xbU))) 
                                | (((((3U == (IData)(this->__PVT__opsize)) 
                                      & (0U != (3U 
                                                & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr)))) 
                                     << 0xbU) | (0xfffff800U 
                                                 & ((IData)(this->__PVT__opsize) 
                                                    << 9U))) 
                                   & ((9U == (0x1fU 
                                              & (IData)(
                                                        (vlTOPp->agu_block__DOT__p5_cmplxAddr 
                                                         >> 2U)))) 
                                      << 0xbU))) | 
                               ((((((4U == (IData)(this->__PVT__opsize)) 
                                    & (3U == (3U & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr)))) 
                                   | (5U == (IData)(this->__PVT__opsize))) 
                                  | (6U == (IData)(this->__PVT__opsize))) 
                                 & (8U == (0x1fU & (IData)(
                                                           (vlTOPp->agu_block__DOT__p5_cmplxAddr 
                                                            >> 2U))))) 
                                << 0xbU)) | (((((5U 
                                                 == (IData)(this->__PVT__opsize)) 
                                                & (0U 
                                                   != 
                                                   (3U 
                                                    & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr)))) 
                                               | (6U 
                                                  == (IData)(this->__PVT__opsize))) 
                                              & (7U 
                                                 == 
                                                 (0x1fU 
                                                  & (IData)(
                                                            (vlTOPp->agu_block__DOT__p5_cmplxAddr 
                                                             >> 2U))))) 
                                             << 0xbU)));
    this->__PVT__banks0 = ((0xffffefffU & this->__PVT__banks0) 
                           | ((((((0xcU == (0x1fU & (IData)(
                                                            (vlTOPp->agu_block__DOT__p5_cmplxAddr 
                                                             >> 2U)))) 
                                  << 0xcU) | ((((((3U 
                                                   == (IData)(this->__PVT__opsize)) 
                                                  << 0xcU) 
                                                 | (0xfffff000U 
                                                    & ((IData)(this->__PVT__opsize) 
                                                       << 0xaU))) 
                                                | (((0U 
                                                     != 
                                                     (3U 
                                                      & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr))) 
                                                    & (2U 
                                                       == (IData)(this->__PVT__opsize))) 
                                                   << 0xcU)) 
                                               | (((3U 
                                                    == 
                                                    (3U 
                                                     & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr))) 
                                                   & (1U 
                                                      == (IData)(this->__PVT__opsize))) 
                                                  << 0xcU)) 
                                              & ((0xbU 
                                                  == 
                                                  (0x1fU 
                                                   & (IData)(
                                                             (vlTOPp->agu_block__DOT__p5_cmplxAddr 
                                                              >> 2U)))) 
                                                 << 0xcU))) 
                                | (((((3U == (IData)(this->__PVT__opsize)) 
                                      & (0U != (3U 
                                                & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr)))) 
                                     << 0xcU) | (0xfffff000U 
                                                 & ((IData)(this->__PVT__opsize) 
                                                    << 0xaU))) 
                                   & ((0xaU == (0x1fU 
                                                & (IData)(
                                                          (vlTOPp->agu_block__DOT__p5_cmplxAddr 
                                                           >> 2U)))) 
                                      << 0xcU))) | 
                               ((((((4U == (IData)(this->__PVT__opsize)) 
                                    & (3U == (3U & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr)))) 
                                   | (5U == (IData)(this->__PVT__opsize))) 
                                  | (6U == (IData)(this->__PVT__opsize))) 
                                 & (9U == (0x1fU & (IData)(
                                                           (vlTOPp->agu_block__DOT__p5_cmplxAddr 
                                                            >> 2U))))) 
                                << 0xcU)) | (((((5U 
                                                 == (IData)(this->__PVT__opsize)) 
                                                & (0U 
                                                   != 
                                                   (3U 
                                                    & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr)))) 
                                               | (6U 
                                                  == (IData)(this->__PVT__opsize))) 
                                              & (8U 
                                                 == 
                                                 (0x1fU 
                                                  & (IData)(
                                                            (vlTOPp->agu_block__DOT__p5_cmplxAddr 
                                                             >> 2U))))) 
                                             << 0xcU)));
    this->__PVT__banks0 = ((0xffffdfffU & this->__PVT__banks0) 
                           | ((((((0xdU == (0x1fU & (IData)(
                                                            (vlTOPp->agu_block__DOT__p5_cmplxAddr 
                                                             >> 2U)))) 
                                  << 0xdU) | ((((((3U 
                                                   == (IData)(this->__PVT__opsize)) 
                                                  << 0xdU) 
                                                 | (0xffffe000U 
                                                    & ((IData)(this->__PVT__opsize) 
                                                       << 0xbU))) 
                                                | (((0U 
                                                     != 
                                                     (3U 
                                                      & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr))) 
                                                    & (2U 
                                                       == (IData)(this->__PVT__opsize))) 
                                                   << 0xdU)) 
                                               | (((3U 
                                                    == 
                                                    (3U 
                                                     & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr))) 
                                                   & (1U 
                                                      == (IData)(this->__PVT__opsize))) 
                                                  << 0xdU)) 
                                              & ((0xcU 
                                                  == 
                                                  (0x1fU 
                                                   & (IData)(
                                                             (vlTOPp->agu_block__DOT__p5_cmplxAddr 
                                                              >> 2U)))) 
                                                 << 0xdU))) 
                                | (((((3U == (IData)(this->__PVT__opsize)) 
                                      & (0U != (3U 
                                                & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr)))) 
                                     << 0xdU) | (0xffffe000U 
                                                 & ((IData)(this->__PVT__opsize) 
                                                    << 0xbU))) 
                                   & ((0xbU == (0x1fU 
                                                & (IData)(
                                                          (vlTOPp->agu_block__DOT__p5_cmplxAddr 
                                                           >> 2U)))) 
                                      << 0xdU))) | 
                               ((((((4U == (IData)(this->__PVT__opsize)) 
                                    & (3U == (3U & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr)))) 
                                   | (5U == (IData)(this->__PVT__opsize))) 
                                  | (6U == (IData)(this->__PVT__opsize))) 
                                 & (0xaU == (0x1fU 
                                             & (IData)(
                                                       (vlTOPp->agu_block__DOT__p5_cmplxAddr 
                                                        >> 2U))))) 
                                << 0xdU)) | (((((5U 
                                                 == (IData)(this->__PVT__opsize)) 
                                                & (0U 
                                                   != 
                                                   (3U 
                                                    & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr)))) 
                                               | (6U 
                                                  == (IData)(this->__PVT__opsize))) 
                                              & (9U 
                                                 == 
                                                 (0x1fU 
                                                  & (IData)(
                                                            (vlTOPp->agu_block__DOT__p5_cmplxAddr 
                                                             >> 2U))))) 
                                             << 0xdU)));
    this->__PVT__banks0 = ((0xffffbfffU & this->__PVT__banks0) 
                           | ((((((0xeU == (0x1fU & (IData)(
                                                            (vlTOPp->agu_block__DOT__p5_cmplxAddr 
                                                             >> 2U)))) 
                                  << 0xeU) | ((((((3U 
                                                   == (IData)(this->__PVT__opsize)) 
                                                  << 0xeU) 
                                                 | (0xffffc000U 
                                                    & ((IData)(this->__PVT__opsize) 
                                                       << 0xcU))) 
                                                | (((0U 
                                                     != 
                                                     (3U 
                                                      & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr))) 
                                                    & (2U 
                                                       == (IData)(this->__PVT__opsize))) 
                                                   << 0xeU)) 
                                               | (((3U 
                                                    == 
                                                    (3U 
                                                     & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr))) 
                                                   & (1U 
                                                      == (IData)(this->__PVT__opsize))) 
                                                  << 0xeU)) 
                                              & ((0xdU 
                                                  == 
                                                  (0x1fU 
                                                   & (IData)(
                                                             (vlTOPp->agu_block__DOT__p5_cmplxAddr 
                                                              >> 2U)))) 
                                                 << 0xeU))) 
                                | (((((3U == (IData)(this->__PVT__opsize)) 
                                      & (0U != (3U 
                                                & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr)))) 
                                     << 0xeU) | (0xffffc000U 
                                                 & ((IData)(this->__PVT__opsize) 
                                                    << 0xcU))) 
                                   & ((0xcU == (0x1fU 
                                                & (IData)(
                                                          (vlTOPp->agu_block__DOT__p5_cmplxAddr 
                                                           >> 2U)))) 
                                      << 0xeU))) | 
                               ((((((4U == (IData)(this->__PVT__opsize)) 
                                    & (3U == (3U & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr)))) 
                                   | (5U == (IData)(this->__PVT__opsize))) 
                                  | (6U == (IData)(this->__PVT__opsize))) 
                                 & (0xbU == (0x1fU 
                                             & (IData)(
                                                       (vlTOPp->agu_block__DOT__p5_cmplxAddr 
                                                        >> 2U))))) 
                                << 0xeU)) | (((((5U 
                                                 == (IData)(this->__PVT__opsize)) 
                                                & (0U 
                                                   != 
                                                   (3U 
                                                    & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr)))) 
                                               | (6U 
                                                  == (IData)(this->__PVT__opsize))) 
                                              & (0xaU 
                                                 == 
                                                 (0x1fU 
                                                  & (IData)(
                                                            (vlTOPp->agu_block__DOT__p5_cmplxAddr 
                                                             >> 2U))))) 
                                             << 0xeU)));
    this->__PVT__banks0 = ((0xffff7fffU & this->__PVT__banks0) 
                           | ((((((0xfU == (0x1fU & (IData)(
                                                            (vlTOPp->agu_block__DOT__p5_cmplxAddr 
                                                             >> 2U)))) 
                                  << 0xfU) | ((((((3U 
                                                   == (IData)(this->__PVT__opsize)) 
                                                  << 0xfU) 
                                                 | (0xffff8000U 
                                                    & ((IData)(this->__PVT__opsize) 
                                                       << 0xdU))) 
                                                | (((0U 
                                                     != 
                                                     (3U 
                                                      & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr))) 
                                                    & (2U 
                                                       == (IData)(this->__PVT__opsize))) 
                                                   << 0xfU)) 
                                               | (((3U 
                                                    == 
                                                    (3U 
                                                     & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr))) 
                                                   & (1U 
                                                      == (IData)(this->__PVT__opsize))) 
                                                  << 0xfU)) 
                                              & ((0xeU 
                                                  == 
                                                  (0x1fU 
                                                   & (IData)(
                                                             (vlTOPp->agu_block__DOT__p5_cmplxAddr 
                                                              >> 2U)))) 
                                                 << 0xfU))) 
                                | (((((3U == (IData)(this->__PVT__opsize)) 
                                      & (0U != (3U 
                                                & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr)))) 
                                     << 0xfU) | (0xffff8000U 
                                                 & ((IData)(this->__PVT__opsize) 
                                                    << 0xdU))) 
                                   & ((0xdU == (0x1fU 
                                                & (IData)(
                                                          (vlTOPp->agu_block__DOT__p5_cmplxAddr 
                                                           >> 2U)))) 
                                      << 0xfU))) | 
                               ((((((4U == (IData)(this->__PVT__opsize)) 
                                    & (3U == (3U & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr)))) 
                                   | (5U == (IData)(this->__PVT__opsize))) 
                                  | (6U == (IData)(this->__PVT__opsize))) 
                                 & (0xcU == (0x1fU 
                                             & (IData)(
                                                       (vlTOPp->agu_block__DOT__p5_cmplxAddr 
                                                        >> 2U))))) 
                                << 0xfU)) | (((((5U 
                                                 == (IData)(this->__PVT__opsize)) 
                                                & (0U 
                                                   != 
                                                   (3U 
                                                    & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr)))) 
                                               | (6U 
                                                  == (IData)(this->__PVT__opsize))) 
                                              & (0xbU 
                                                 == 
                                                 (0x1fU 
                                                  & (IData)(
                                                            (vlTOPp->agu_block__DOT__p5_cmplxAddr 
                                                             >> 2U))))) 
                                             << 0xfU)));
    this->__PVT__banks0 = ((0xfffeffffU & this->__PVT__banks0) 
                           | ((((((0x10U == (0x1fU 
                                             & (IData)(
                                                       (vlTOPp->agu_block__DOT__p5_cmplxAddr 
                                                        >> 2U)))) 
                                  << 0x10U) | (((((
                                                   (3U 
                                                    == (IData)(this->__PVT__opsize)) 
                                                   << 0x10U) 
                                                  | (0xffff0000U 
                                                     & ((IData)(this->__PVT__opsize) 
                                                        << 0xeU))) 
                                                 | (((0U 
                                                      != 
                                                      (3U 
                                                       & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr))) 
                                                     & (2U 
                                                        == (IData)(this->__PVT__opsize))) 
                                                    << 0x10U)) 
                                                | (((3U 
                                                     == 
                                                     (3U 
                                                      & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr))) 
                                                    & (1U 
                                                       == (IData)(this->__PVT__opsize))) 
                                                   << 0x10U)) 
                                               & ((0xfU 
                                                   == 
                                                   (0x1fU 
                                                    & (IData)(
                                                              (vlTOPp->agu_block__DOT__p5_cmplxAddr 
                                                               >> 2U)))) 
                                                  << 0x10U))) 
                                | (((((3U == (IData)(this->__PVT__opsize)) 
                                      & (0U != (3U 
                                                & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr)))) 
                                     << 0x10U) | (0xffff0000U 
                                                  & ((IData)(this->__PVT__opsize) 
                                                     << 0xeU))) 
                                   & ((0xeU == (0x1fU 
                                                & (IData)(
                                                          (vlTOPp->agu_block__DOT__p5_cmplxAddr 
                                                           >> 2U)))) 
                                      << 0x10U))) | 
                               ((((((4U == (IData)(this->__PVT__opsize)) 
                                    & (3U == (3U & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr)))) 
                                   | (5U == (IData)(this->__PVT__opsize))) 
                                  | (6U == (IData)(this->__PVT__opsize))) 
                                 & (0xdU == (0x1fU 
                                             & (IData)(
                                                       (vlTOPp->agu_block__DOT__p5_cmplxAddr 
                                                        >> 2U))))) 
                                << 0x10U)) | (((((5U 
                                                  == (IData)(this->__PVT__opsize)) 
                                                 & (0U 
                                                    != 
                                                    (3U 
                                                     & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr)))) 
                                                | (6U 
                                                   == (IData)(this->__PVT__opsize))) 
                                               & (0xcU 
                                                  == 
                                                  (0x1fU 
                                                   & (IData)(
                                                             (vlTOPp->agu_block__DOT__p5_cmplxAddr 
                                                              >> 2U))))) 
                                              << 0x10U)));
    this->__PVT__banks0 = ((0xfffdffffU & this->__PVT__banks0) 
                           | ((((((0x11U == (0x1fU 
                                             & (IData)(
                                                       (vlTOPp->agu_block__DOT__p5_cmplxAddr 
                                                        >> 2U)))) 
                                  << 0x11U) | (((((
                                                   (3U 
                                                    == (IData)(this->__PVT__opsize)) 
                                                   << 0x11U) 
                                                  | (0xfffe0000U 
                                                     & ((IData)(this->__PVT__opsize) 
                                                        << 0xfU))) 
                                                 | (((0U 
                                                      != 
                                                      (3U 
                                                       & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr))) 
                                                     & (2U 
                                                        == (IData)(this->__PVT__opsize))) 
                                                    << 0x11U)) 
                                                | (((3U 
                                                     == 
                                                     (3U 
                                                      & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr))) 
                                                    & (1U 
                                                       == (IData)(this->__PVT__opsize))) 
                                                   << 0x11U)) 
                                               & ((0x10U 
                                                   == 
                                                   (0x1fU 
                                                    & (IData)(
                                                              (vlTOPp->agu_block__DOT__p5_cmplxAddr 
                                                               >> 2U)))) 
                                                  << 0x11U))) 
                                | (((((3U == (IData)(this->__PVT__opsize)) 
                                      & (0U != (3U 
                                                & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr)))) 
                                     << 0x11U) | (0xfffe0000U 
                                                  & ((IData)(this->__PVT__opsize) 
                                                     << 0xfU))) 
                                   & ((0xfU == (0x1fU 
                                                & (IData)(
                                                          (vlTOPp->agu_block__DOT__p5_cmplxAddr 
                                                           >> 2U)))) 
                                      << 0x11U))) | 
                               ((((((4U == (IData)(this->__PVT__opsize)) 
                                    & (3U == (3U & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr)))) 
                                   | (5U == (IData)(this->__PVT__opsize))) 
                                  | (6U == (IData)(this->__PVT__opsize))) 
                                 & (0xeU == (0x1fU 
                                             & (IData)(
                                                       (vlTOPp->agu_block__DOT__p5_cmplxAddr 
                                                        >> 2U))))) 
                                << 0x11U)) | (((((5U 
                                                  == (IData)(this->__PVT__opsize)) 
                                                 & (0U 
                                                    != 
                                                    (3U 
                                                     & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr)))) 
                                                | (6U 
                                                   == (IData)(this->__PVT__opsize))) 
                                               & (0xdU 
                                                  == 
                                                  (0x1fU 
                                                   & (IData)(
                                                             (vlTOPp->agu_block__DOT__p5_cmplxAddr 
                                                              >> 2U))))) 
                                              << 0x11U)));
    this->__PVT__banks0 = ((0xfffbffffU & this->__PVT__banks0) 
                           | ((((((0x12U == (0x1fU 
                                             & (IData)(
                                                       (vlTOPp->agu_block__DOT__p5_cmplxAddr 
                                                        >> 2U)))) 
                                  << 0x12U) | (((((
                                                   (3U 
                                                    == (IData)(this->__PVT__opsize)) 
                                                   << 0x12U) 
                                                  | (0xfffc0000U 
                                                     & ((IData)(this->__PVT__opsize) 
                                                        << 0x10U))) 
                                                 | (((0U 
                                                      != 
                                                      (3U 
                                                       & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr))) 
                                                     & (2U 
                                                        == (IData)(this->__PVT__opsize))) 
                                                    << 0x12U)) 
                                                | (((3U 
                                                     == 
                                                     (3U 
                                                      & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr))) 
                                                    & (1U 
                                                       == (IData)(this->__PVT__opsize))) 
                                                   << 0x12U)) 
                                               & ((0x11U 
                                                   == 
                                                   (0x1fU 
                                                    & (IData)(
                                                              (vlTOPp->agu_block__DOT__p5_cmplxAddr 
                                                               >> 2U)))) 
                                                  << 0x12U))) 
                                | (((((3U == (IData)(this->__PVT__opsize)) 
                                      & (0U != (3U 
                                                & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr)))) 
                                     << 0x12U) | (0xfffc0000U 
                                                  & ((IData)(this->__PVT__opsize) 
                                                     << 0x10U))) 
                                   & ((0x10U == (0x1fU 
                                                 & (IData)(
                                                           (vlTOPp->agu_block__DOT__p5_cmplxAddr 
                                                            >> 2U)))) 
                                      << 0x12U))) | 
                               ((((((4U == (IData)(this->__PVT__opsize)) 
                                    & (3U == (3U & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr)))) 
                                   | (5U == (IData)(this->__PVT__opsize))) 
                                  | (6U == (IData)(this->__PVT__opsize))) 
                                 & (0xfU == (0x1fU 
                                             & (IData)(
                                                       (vlTOPp->agu_block__DOT__p5_cmplxAddr 
                                                        >> 2U))))) 
                                << 0x12U)) | (((((5U 
                                                  == (IData)(this->__PVT__opsize)) 
                                                 & (0U 
                                                    != 
                                                    (3U 
                                                     & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr)))) 
                                                | (6U 
                                                   == (IData)(this->__PVT__opsize))) 
                                               & (0xeU 
                                                  == 
                                                  (0x1fU 
                                                   & (IData)(
                                                             (vlTOPp->agu_block__DOT__p5_cmplxAddr 
                                                              >> 2U))))) 
                                              << 0x12U)));
    this->__PVT__banks0 = ((0xfff7ffffU & this->__PVT__banks0) 
                           | ((((((0x13U == (0x1fU 
                                             & (IData)(
                                                       (vlTOPp->agu_block__DOT__p5_cmplxAddr 
                                                        >> 2U)))) 
                                  << 0x13U) | (((((
                                                   (3U 
                                                    == (IData)(this->__PVT__opsize)) 
                                                   << 0x13U) 
                                                  | (0xfff80000U 
                                                     & ((IData)(this->__PVT__opsize) 
                                                        << 0x11U))) 
                                                 | (((0U 
                                                      != 
                                                      (3U 
                                                       & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr))) 
                                                     & (2U 
                                                        == (IData)(this->__PVT__opsize))) 
                                                    << 0x13U)) 
                                                | (((3U 
                                                     == 
                                                     (3U 
                                                      & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr))) 
                                                    & (1U 
                                                       == (IData)(this->__PVT__opsize))) 
                                                   << 0x13U)) 
                                               & ((0x12U 
                                                   == 
                                                   (0x1fU 
                                                    & (IData)(
                                                              (vlTOPp->agu_block__DOT__p5_cmplxAddr 
                                                               >> 2U)))) 
                                                  << 0x13U))) 
                                | (((((3U == (IData)(this->__PVT__opsize)) 
                                      & (0U != (3U 
                                                & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr)))) 
                                     << 0x13U) | (0xfff80000U 
                                                  & ((IData)(this->__PVT__opsize) 
                                                     << 0x11U))) 
                                   & ((0x11U == (0x1fU 
                                                 & (IData)(
                                                           (vlTOPp->agu_block__DOT__p5_cmplxAddr 
                                                            >> 2U)))) 
                                      << 0x13U))) | 
                               ((((((4U == (IData)(this->__PVT__opsize)) 
                                    & (3U == (3U & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr)))) 
                                   | (5U == (IData)(this->__PVT__opsize))) 
                                  | (6U == (IData)(this->__PVT__opsize))) 
                                 & (0x10U == (0x1fU 
                                              & (IData)(
                                                        (vlTOPp->agu_block__DOT__p5_cmplxAddr 
                                                         >> 2U))))) 
                                << 0x13U)) | (((((5U 
                                                  == (IData)(this->__PVT__opsize)) 
                                                 & (0U 
                                                    != 
                                                    (3U 
                                                     & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr)))) 
                                                | (6U 
                                                   == (IData)(this->__PVT__opsize))) 
                                               & (0xfU 
                                                  == 
                                                  (0x1fU 
                                                   & (IData)(
                                                             (vlTOPp->agu_block__DOT__p5_cmplxAddr 
                                                              >> 2U))))) 
                                              << 0x13U)));
    this->__PVT__banks0 = ((0xffefffffU & this->__PVT__banks0) 
                           | ((((((0x14U == (0x1fU 
                                             & (IData)(
                                                       (vlTOPp->agu_block__DOT__p5_cmplxAddr 
                                                        >> 2U)))) 
                                  << 0x14U) | (((((
                                                   (3U 
                                                    == (IData)(this->__PVT__opsize)) 
                                                   << 0x14U) 
                                                  | (0xfff00000U 
                                                     & ((IData)(this->__PVT__opsize) 
                                                        << 0x12U))) 
                                                 | (((0U 
                                                      != 
                                                      (3U 
                                                       & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr))) 
                                                     & (2U 
                                                        == (IData)(this->__PVT__opsize))) 
                                                    << 0x14U)) 
                                                | (((3U 
                                                     == 
                                                     (3U 
                                                      & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr))) 
                                                    & (1U 
                                                       == (IData)(this->__PVT__opsize))) 
                                                   << 0x14U)) 
                                               & ((0x13U 
                                                   == 
                                                   (0x1fU 
                                                    & (IData)(
                                                              (vlTOPp->agu_block__DOT__p5_cmplxAddr 
                                                               >> 2U)))) 
                                                  << 0x14U))) 
                                | (((((3U == (IData)(this->__PVT__opsize)) 
                                      & (0U != (3U 
                                                & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr)))) 
                                     << 0x14U) | (0xfff00000U 
                                                  & ((IData)(this->__PVT__opsize) 
                                                     << 0x12U))) 
                                   & ((0x12U == (0x1fU 
                                                 & (IData)(
                                                           (vlTOPp->agu_block__DOT__p5_cmplxAddr 
                                                            >> 2U)))) 
                                      << 0x14U))) | 
                               ((((((4U == (IData)(this->__PVT__opsize)) 
                                    & (3U == (3U & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr)))) 
                                   | (5U == (IData)(this->__PVT__opsize))) 
                                  | (6U == (IData)(this->__PVT__opsize))) 
                                 & (0x11U == (0x1fU 
                                              & (IData)(
                                                        (vlTOPp->agu_block__DOT__p5_cmplxAddr 
                                                         >> 2U))))) 
                                << 0x14U)) | (((((5U 
                                                  == (IData)(this->__PVT__opsize)) 
                                                 & (0U 
                                                    != 
                                                    (3U 
                                                     & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr)))) 
                                                | (6U 
                                                   == (IData)(this->__PVT__opsize))) 
                                               & (0x10U 
                                                  == 
                                                  (0x1fU 
                                                   & (IData)(
                                                             (vlTOPp->agu_block__DOT__p5_cmplxAddr 
                                                              >> 2U))))) 
                                              << 0x14U)));
    this->__PVT__banks0 = ((0xffdfffffU & this->__PVT__banks0) 
                           | ((((((0x15U == (0x1fU 
                                             & (IData)(
                                                       (vlTOPp->agu_block__DOT__p5_cmplxAddr 
                                                        >> 2U)))) 
                                  << 0x15U) | (((((
                                                   (3U 
                                                    == (IData)(this->__PVT__opsize)) 
                                                   << 0x15U) 
                                                  | (0xffe00000U 
                                                     & ((IData)(this->__PVT__opsize) 
                                                        << 0x13U))) 
                                                 | (((0U 
                                                      != 
                                                      (3U 
                                                       & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr))) 
                                                     & (2U 
                                                        == (IData)(this->__PVT__opsize))) 
                                                    << 0x15U)) 
                                                | (((3U 
                                                     == 
                                                     (3U 
                                                      & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr))) 
                                                    & (1U 
                                                       == (IData)(this->__PVT__opsize))) 
                                                   << 0x15U)) 
                                               & ((0x14U 
                                                   == 
                                                   (0x1fU 
                                                    & (IData)(
                                                              (vlTOPp->agu_block__DOT__p5_cmplxAddr 
                                                               >> 2U)))) 
                                                  << 0x15U))) 
                                | (((((3U == (IData)(this->__PVT__opsize)) 
                                      & (0U != (3U 
                                                & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr)))) 
                                     << 0x15U) | (0xffe00000U 
                                                  & ((IData)(this->__PVT__opsize) 
                                                     << 0x13U))) 
                                   & ((0x13U == (0x1fU 
                                                 & (IData)(
                                                           (vlTOPp->agu_block__DOT__p5_cmplxAddr 
                                                            >> 2U)))) 
                                      << 0x15U))) | 
                               ((((((4U == (IData)(this->__PVT__opsize)) 
                                    & (3U == (3U & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr)))) 
                                   | (5U == (IData)(this->__PVT__opsize))) 
                                  | (6U == (IData)(this->__PVT__opsize))) 
                                 & (0x12U == (0x1fU 
                                              & (IData)(
                                                        (vlTOPp->agu_block__DOT__p5_cmplxAddr 
                                                         >> 2U))))) 
                                << 0x15U)) | (((((5U 
                                                  == (IData)(this->__PVT__opsize)) 
                                                 & (0U 
                                                    != 
                                                    (3U 
                                                     & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr)))) 
                                                | (6U 
                                                   == (IData)(this->__PVT__opsize))) 
                                               & (0x11U 
                                                  == 
                                                  (0x1fU 
                                                   & (IData)(
                                                             (vlTOPp->agu_block__DOT__p5_cmplxAddr 
                                                              >> 2U))))) 
                                              << 0x15U)));
    this->__PVT__banks0 = ((0xffbfffffU & this->__PVT__banks0) 
                           | ((((((0x16U == (0x1fU 
                                             & (IData)(
                                                       (vlTOPp->agu_block__DOT__p5_cmplxAddr 
                                                        >> 2U)))) 
                                  << 0x16U) | (((((
                                                   (3U 
                                                    == (IData)(this->__PVT__opsize)) 
                                                   << 0x16U) 
                                                  | (0xffc00000U 
                                                     & ((IData)(this->__PVT__opsize) 
                                                        << 0x14U))) 
                                                 | (((0U 
                                                      != 
                                                      (3U 
                                                       & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr))) 
                                                     & (2U 
                                                        == (IData)(this->__PVT__opsize))) 
                                                    << 0x16U)) 
                                                | (((3U 
                                                     == 
                                                     (3U 
                                                      & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr))) 
                                                    & (1U 
                                                       == (IData)(this->__PVT__opsize))) 
                                                   << 0x16U)) 
                                               & ((0x15U 
                                                   == 
                                                   (0x1fU 
                                                    & (IData)(
                                                              (vlTOPp->agu_block__DOT__p5_cmplxAddr 
                                                               >> 2U)))) 
                                                  << 0x16U))) 
                                | (((((3U == (IData)(this->__PVT__opsize)) 
                                      & (0U != (3U 
                                                & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr)))) 
                                     << 0x16U) | (0xffc00000U 
                                                  & ((IData)(this->__PVT__opsize) 
                                                     << 0x14U))) 
                                   & ((0x14U == (0x1fU 
                                                 & (IData)(
                                                           (vlTOPp->agu_block__DOT__p5_cmplxAddr 
                                                            >> 2U)))) 
                                      << 0x16U))) | 
                               ((((((4U == (IData)(this->__PVT__opsize)) 
                                    & (3U == (3U & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr)))) 
                                   | (5U == (IData)(this->__PVT__opsize))) 
                                  | (6U == (IData)(this->__PVT__opsize))) 
                                 & (0x13U == (0x1fU 
                                              & (IData)(
                                                        (vlTOPp->agu_block__DOT__p5_cmplxAddr 
                                                         >> 2U))))) 
                                << 0x16U)) | (((((5U 
                                                  == (IData)(this->__PVT__opsize)) 
                                                 & (0U 
                                                    != 
                                                    (3U 
                                                     & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr)))) 
                                                | (6U 
                                                   == (IData)(this->__PVT__opsize))) 
                                               & (0x12U 
                                                  == 
                                                  (0x1fU 
                                                   & (IData)(
                                                             (vlTOPp->agu_block__DOT__p5_cmplxAddr 
                                                              >> 2U))))) 
                                              << 0x16U)));
    this->__PVT__banks0 = ((0xff7fffffU & this->__PVT__banks0) 
                           | ((((((0x17U == (0x1fU 
                                             & (IData)(
                                                       (vlTOPp->agu_block__DOT__p5_cmplxAddr 
                                                        >> 2U)))) 
                                  << 0x17U) | (((((
                                                   (3U 
                                                    == (IData)(this->__PVT__opsize)) 
                                                   << 0x17U) 
                                                  | (0xff800000U 
                                                     & ((IData)(this->__PVT__opsize) 
                                                        << 0x15U))) 
                                                 | (((0U 
                                                      != 
                                                      (3U 
                                                       & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr))) 
                                                     & (2U 
                                                        == (IData)(this->__PVT__opsize))) 
                                                    << 0x17U)) 
                                                | (((3U 
                                                     == 
                                                     (3U 
                                                      & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr))) 
                                                    & (1U 
                                                       == (IData)(this->__PVT__opsize))) 
                                                   << 0x17U)) 
                                               & ((0x16U 
                                                   == 
                                                   (0x1fU 
                                                    & (IData)(
                                                              (vlTOPp->agu_block__DOT__p5_cmplxAddr 
                                                               >> 2U)))) 
                                                  << 0x17U))) 
                                | (((((3U == (IData)(this->__PVT__opsize)) 
                                      & (0U != (3U 
                                                & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr)))) 
                                     << 0x17U) | (0xff800000U 
                                                  & ((IData)(this->__PVT__opsize) 
                                                     << 0x15U))) 
                                   & ((0x15U == (0x1fU 
                                                 & (IData)(
                                                           (vlTOPp->agu_block__DOT__p5_cmplxAddr 
                                                            >> 2U)))) 
                                      << 0x17U))) | 
                               ((((((4U == (IData)(this->__PVT__opsize)) 
                                    & (3U == (3U & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr)))) 
                                   | (5U == (IData)(this->__PVT__opsize))) 
                                  | (6U == (IData)(this->__PVT__opsize))) 
                                 & (0x14U == (0x1fU 
                                              & (IData)(
                                                        (vlTOPp->agu_block__DOT__p5_cmplxAddr 
                                                         >> 2U))))) 
                                << 0x17U)) | (((((5U 
                                                  == (IData)(this->__PVT__opsize)) 
                                                 & (0U 
                                                    != 
                                                    (3U 
                                                     & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr)))) 
                                                | (6U 
                                                   == (IData)(this->__PVT__opsize))) 
                                               & (0x13U 
                                                  == 
                                                  (0x1fU 
                                                   & (IData)(
                                                             (vlTOPp->agu_block__DOT__p5_cmplxAddr 
                                                              >> 2U))))) 
                                              << 0x17U)));
    this->__PVT__banks0 = ((0xfeffffffU & this->__PVT__banks0) 
                           | ((((((0x18U == (0x1fU 
                                             & (IData)(
                                                       (vlTOPp->agu_block__DOT__p5_cmplxAddr 
                                                        >> 2U)))) 
                                  << 0x18U) | (((((
                                                   (3U 
                                                    == (IData)(this->__PVT__opsize)) 
                                                   << 0x18U) 
                                                  | (0xff000000U 
                                                     & ((IData)(this->__PVT__opsize) 
                                                        << 0x16U))) 
                                                 | (((0U 
                                                      != 
                                                      (3U 
                                                       & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr))) 
                                                     & (2U 
                                                        == (IData)(this->__PVT__opsize))) 
                                                    << 0x18U)) 
                                                | (((3U 
                                                     == 
                                                     (3U 
                                                      & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr))) 
                                                    & (1U 
                                                       == (IData)(this->__PVT__opsize))) 
                                                   << 0x18U)) 
                                               & ((0x17U 
                                                   == 
                                                   (0x1fU 
                                                    & (IData)(
                                                              (vlTOPp->agu_block__DOT__p5_cmplxAddr 
                                                               >> 2U)))) 
                                                  << 0x18U))) 
                                | (((((3U == (IData)(this->__PVT__opsize)) 
                                      & (0U != (3U 
                                                & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr)))) 
                                     << 0x18U) | (0xff000000U 
                                                  & ((IData)(this->__PVT__opsize) 
                                                     << 0x16U))) 
                                   & ((0x16U == (0x1fU 
                                                 & (IData)(
                                                           (vlTOPp->agu_block__DOT__p5_cmplxAddr 
                                                            >> 2U)))) 
                                      << 0x18U))) | 
                               ((((((4U == (IData)(this->__PVT__opsize)) 
                                    & (3U == (3U & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr)))) 
                                   | (5U == (IData)(this->__PVT__opsize))) 
                                  | (6U == (IData)(this->__PVT__opsize))) 
                                 & (0x15U == (0x1fU 
                                              & (IData)(
                                                        (vlTOPp->agu_block__DOT__p5_cmplxAddr 
                                                         >> 2U))))) 
                                << 0x18U)) | (((((5U 
                                                  == (IData)(this->__PVT__opsize)) 
                                                 & (0U 
                                                    != 
                                                    (3U 
                                                     & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr)))) 
                                                | (6U 
                                                   == (IData)(this->__PVT__opsize))) 
                                               & (0x14U 
                                                  == 
                                                  (0x1fU 
                                                   & (IData)(
                                                             (vlTOPp->agu_block__DOT__p5_cmplxAddr 
                                                              >> 2U))))) 
                                              << 0x18U)));
    this->__PVT__banks0 = ((0xfdffffffU & this->__PVT__banks0) 
                           | ((((((0x19U == (0x1fU 
                                             & (IData)(
                                                       (vlTOPp->agu_block__DOT__p5_cmplxAddr 
                                                        >> 2U)))) 
                                  << 0x19U) | (((((
                                                   (3U 
                                                    == (IData)(this->__PVT__opsize)) 
                                                   << 0x19U) 
                                                  | (0xfe000000U 
                                                     & ((IData)(this->__PVT__opsize) 
                                                        << 0x17U))) 
                                                 | (((0U 
                                                      != 
                                                      (3U 
                                                       & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr))) 
                                                     & (2U 
                                                        == (IData)(this->__PVT__opsize))) 
                                                    << 0x19U)) 
                                                | (((3U 
                                                     == 
                                                     (3U 
                                                      & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr))) 
                                                    & (1U 
                                                       == (IData)(this->__PVT__opsize))) 
                                                   << 0x19U)) 
                                               & ((0x18U 
                                                   == 
                                                   (0x1fU 
                                                    & (IData)(
                                                              (vlTOPp->agu_block__DOT__p5_cmplxAddr 
                                                               >> 2U)))) 
                                                  << 0x19U))) 
                                | (((((3U == (IData)(this->__PVT__opsize)) 
                                      & (0U != (3U 
                                                & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr)))) 
                                     << 0x19U) | (0xfe000000U 
                                                  & ((IData)(this->__PVT__opsize) 
                                                     << 0x17U))) 
                                   & ((0x17U == (0x1fU 
                                                 & (IData)(
                                                           (vlTOPp->agu_block__DOT__p5_cmplxAddr 
                                                            >> 2U)))) 
                                      << 0x19U))) | 
                               ((((((4U == (IData)(this->__PVT__opsize)) 
                                    & (3U == (3U & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr)))) 
                                   | (5U == (IData)(this->__PVT__opsize))) 
                                  | (6U == (IData)(this->__PVT__opsize))) 
                                 & (0x16U == (0x1fU 
                                              & (IData)(
                                                        (vlTOPp->agu_block__DOT__p5_cmplxAddr 
                                                         >> 2U))))) 
                                << 0x19U)) | (((((5U 
                                                  == (IData)(this->__PVT__opsize)) 
                                                 & (0U 
                                                    != 
                                                    (3U 
                                                     & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr)))) 
                                                | (6U 
                                                   == (IData)(this->__PVT__opsize))) 
                                               & (0x15U 
                                                  == 
                                                  (0x1fU 
                                                   & (IData)(
                                                             (vlTOPp->agu_block__DOT__p5_cmplxAddr 
                                                              >> 2U))))) 
                                              << 0x19U)));
    this->__PVT__banks0 = ((0xfbffffffU & this->__PVT__banks0) 
                           | ((((((0x1aU == (0x1fU 
                                             & (IData)(
                                                       (vlTOPp->agu_block__DOT__p5_cmplxAddr 
                                                        >> 2U)))) 
                                  << 0x1aU) | (((((
                                                   (3U 
                                                    == (IData)(this->__PVT__opsize)) 
                                                   << 0x1aU) 
                                                  | (0xfc000000U 
                                                     & ((IData)(this->__PVT__opsize) 
                                                        << 0x18U))) 
                                                 | (((0U 
                                                      != 
                                                      (3U 
                                                       & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr))) 
                                                     & (2U 
                                                        == (IData)(this->__PVT__opsize))) 
                                                    << 0x1aU)) 
                                                | (((3U 
                                                     == 
                                                     (3U 
                                                      & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr))) 
                                                    & (1U 
                                                       == (IData)(this->__PVT__opsize))) 
                                                   << 0x1aU)) 
                                               & ((0x19U 
                                                   == 
                                                   (0x1fU 
                                                    & (IData)(
                                                              (vlTOPp->agu_block__DOT__p5_cmplxAddr 
                                                               >> 2U)))) 
                                                  << 0x1aU))) 
                                | (((((3U == (IData)(this->__PVT__opsize)) 
                                      & (0U != (3U 
                                                & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr)))) 
                                     << 0x1aU) | (0xfc000000U 
                                                  & ((IData)(this->__PVT__opsize) 
                                                     << 0x18U))) 
                                   & ((0x18U == (0x1fU 
                                                 & (IData)(
                                                           (vlTOPp->agu_block__DOT__p5_cmplxAddr 
                                                            >> 2U)))) 
                                      << 0x1aU))) | 
                               ((((((4U == (IData)(this->__PVT__opsize)) 
                                    & (3U == (3U & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr)))) 
                                   | (5U == (IData)(this->__PVT__opsize))) 
                                  | (6U == (IData)(this->__PVT__opsize))) 
                                 & (0x17U == (0x1fU 
                                              & (IData)(
                                                        (vlTOPp->agu_block__DOT__p5_cmplxAddr 
                                                         >> 2U))))) 
                                << 0x1aU)) | (((((5U 
                                                  == (IData)(this->__PVT__opsize)) 
                                                 & (0U 
                                                    != 
                                                    (3U 
                                                     & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr)))) 
                                                | (6U 
                                                   == (IData)(this->__PVT__opsize))) 
                                               & (0x16U 
                                                  == 
                                                  (0x1fU 
                                                   & (IData)(
                                                             (vlTOPp->agu_block__DOT__p5_cmplxAddr 
                                                              >> 2U))))) 
                                              << 0x1aU)));
    this->__PVT__banks0 = ((0xf7ffffffU & this->__PVT__banks0) 
                           | ((((((0x1bU == (0x1fU 
                                             & (IData)(
                                                       (vlTOPp->agu_block__DOT__p5_cmplxAddr 
                                                        >> 2U)))) 
                                  << 0x1bU) | (((((
                                                   (3U 
                                                    == (IData)(this->__PVT__opsize)) 
                                                   << 0x1bU) 
                                                  | (0xf8000000U 
                                                     & ((IData)(this->__PVT__opsize) 
                                                        << 0x19U))) 
                                                 | (((0U 
                                                      != 
                                                      (3U 
                                                       & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr))) 
                                                     & (2U 
                                                        == (IData)(this->__PVT__opsize))) 
                                                    << 0x1bU)) 
                                                | (((3U 
                                                     == 
                                                     (3U 
                                                      & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr))) 
                                                    & (1U 
                                                       == (IData)(this->__PVT__opsize))) 
                                                   << 0x1bU)) 
                                               & ((0x1aU 
                                                   == 
                                                   (0x1fU 
                                                    & (IData)(
                                                              (vlTOPp->agu_block__DOT__p5_cmplxAddr 
                                                               >> 2U)))) 
                                                  << 0x1bU))) 
                                | (((((3U == (IData)(this->__PVT__opsize)) 
                                      & (0U != (3U 
                                                & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr)))) 
                                     << 0x1bU) | (0xf8000000U 
                                                  & ((IData)(this->__PVT__opsize) 
                                                     << 0x19U))) 
                                   & ((0x19U == (0x1fU 
                                                 & (IData)(
                                                           (vlTOPp->agu_block__DOT__p5_cmplxAddr 
                                                            >> 2U)))) 
                                      << 0x1bU))) | 
                               ((((((4U == (IData)(this->__PVT__opsize)) 
                                    & (3U == (3U & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr)))) 
                                   | (5U == (IData)(this->__PVT__opsize))) 
                                  | (6U == (IData)(this->__PVT__opsize))) 
                                 & (0x18U == (0x1fU 
                                              & (IData)(
                                                        (vlTOPp->agu_block__DOT__p5_cmplxAddr 
                                                         >> 2U))))) 
                                << 0x1bU)) | (((((5U 
                                                  == (IData)(this->__PVT__opsize)) 
                                                 & (0U 
                                                    != 
                                                    (3U 
                                                     & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr)))) 
                                                | (6U 
                                                   == (IData)(this->__PVT__opsize))) 
                                               & (0x17U 
                                                  == 
                                                  (0x1fU 
                                                   & (IData)(
                                                             (vlTOPp->agu_block__DOT__p5_cmplxAddr 
                                                              >> 2U))))) 
                                              << 0x1bU)));
    this->__PVT__banks0 = ((0xefffffffU & this->__PVT__banks0) 
                           | ((((((0x1cU == (0x1fU 
                                             & (IData)(
                                                       (vlTOPp->agu_block__DOT__p5_cmplxAddr 
                                                        >> 2U)))) 
                                  << 0x1cU) | (((((
                                                   (3U 
                                                    == (IData)(this->__PVT__opsize)) 
                                                   << 0x1cU) 
                                                  | (0xf0000000U 
                                                     & ((IData)(this->__PVT__opsize) 
                                                        << 0x1aU))) 
                                                 | (((0U 
                                                      != 
                                                      (3U 
                                                       & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr))) 
                                                     & (2U 
                                                        == (IData)(this->__PVT__opsize))) 
                                                    << 0x1cU)) 
                                                | (((3U 
                                                     == 
                                                     (3U 
                                                      & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr))) 
                                                    & (1U 
                                                       == (IData)(this->__PVT__opsize))) 
                                                   << 0x1cU)) 
                                               & ((0x1bU 
                                                   == 
                                                   (0x1fU 
                                                    & (IData)(
                                                              (vlTOPp->agu_block__DOT__p5_cmplxAddr 
                                                               >> 2U)))) 
                                                  << 0x1cU))) 
                                | (((((3U == (IData)(this->__PVT__opsize)) 
                                      & (0U != (3U 
                                                & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr)))) 
                                     << 0x1cU) | (0xf0000000U 
                                                  & ((IData)(this->__PVT__opsize) 
                                                     << 0x1aU))) 
                                   & ((0x1aU == (0x1fU 
                                                 & (IData)(
                                                           (vlTOPp->agu_block__DOT__p5_cmplxAddr 
                                                            >> 2U)))) 
                                      << 0x1cU))) | 
                               ((((((4U == (IData)(this->__PVT__opsize)) 
                                    & (3U == (3U & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr)))) 
                                   | (5U == (IData)(this->__PVT__opsize))) 
                                  | (6U == (IData)(this->__PVT__opsize))) 
                                 & (0x19U == (0x1fU 
                                              & (IData)(
                                                        (vlTOPp->agu_block__DOT__p5_cmplxAddr 
                                                         >> 2U))))) 
                                << 0x1cU)) | (((((5U 
                                                  == (IData)(this->__PVT__opsize)) 
                                                 & (0U 
                                                    != 
                                                    (3U 
                                                     & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr)))) 
                                                | (6U 
                                                   == (IData)(this->__PVT__opsize))) 
                                               & (0x18U 
                                                  == 
                                                  (0x1fU 
                                                   & (IData)(
                                                             (vlTOPp->agu_block__DOT__p5_cmplxAddr 
                                                              >> 2U))))) 
                                              << 0x1cU)));
    this->__PVT__banks0 = ((0xdfffffffU & this->__PVT__banks0) 
                           | ((((((0x1dU == (0x1fU 
                                             & (IData)(
                                                       (vlTOPp->agu_block__DOT__p5_cmplxAddr 
                                                        >> 2U)))) 
                                  << 0x1dU) | (((((
                                                   (3U 
                                                    == (IData)(this->__PVT__opsize)) 
                                                   << 0x1dU) 
                                                  | (0xe0000000U 
                                                     & ((IData)(this->__PVT__opsize) 
                                                        << 0x1bU))) 
                                                 | (((0U 
                                                      != 
                                                      (3U 
                                                       & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr))) 
                                                     & (2U 
                                                        == (IData)(this->__PVT__opsize))) 
                                                    << 0x1dU)) 
                                                | (((3U 
                                                     == 
                                                     (3U 
                                                      & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr))) 
                                                    & (1U 
                                                       == (IData)(this->__PVT__opsize))) 
                                                   << 0x1dU)) 
                                               & ((0x1cU 
                                                   == 
                                                   (0x1fU 
                                                    & (IData)(
                                                              (vlTOPp->agu_block__DOT__p5_cmplxAddr 
                                                               >> 2U)))) 
                                                  << 0x1dU))) 
                                | (((((3U == (IData)(this->__PVT__opsize)) 
                                      & (0U != (3U 
                                                & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr)))) 
                                     << 0x1dU) | (0xe0000000U 
                                                  & ((IData)(this->__PVT__opsize) 
                                                     << 0x1bU))) 
                                   & ((0x1bU == (0x1fU 
                                                 & (IData)(
                                                           (vlTOPp->agu_block__DOT__p5_cmplxAddr 
                                                            >> 2U)))) 
                                      << 0x1dU))) | 
                               ((((((4U == (IData)(this->__PVT__opsize)) 
                                    & (3U == (3U & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr)))) 
                                   | (5U == (IData)(this->__PVT__opsize))) 
                                  | (6U == (IData)(this->__PVT__opsize))) 
                                 & (0x1aU == (0x1fU 
                                              & (IData)(
                                                        (vlTOPp->agu_block__DOT__p5_cmplxAddr 
                                                         >> 2U))))) 
                                << 0x1dU)) | (((((5U 
                                                  == (IData)(this->__PVT__opsize)) 
                                                 & (0U 
                                                    != 
                                                    (3U 
                                                     & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr)))) 
                                                | (6U 
                                                   == (IData)(this->__PVT__opsize))) 
                                               & (0x19U 
                                                  == 
                                                  (0x1fU 
                                                   & (IData)(
                                                             (vlTOPp->agu_block__DOT__p5_cmplxAddr 
                                                              >> 2U))))) 
                                              << 0x1dU)));
    this->__PVT__banks0 = ((0xbfffffffU & this->__PVT__banks0) 
                           | ((((((0x1eU == (0x1fU 
                                             & (IData)(
                                                       (vlTOPp->agu_block__DOT__p5_cmplxAddr 
                                                        >> 2U)))) 
                                  << 0x1eU) | (((((
                                                   (3U 
                                                    == (IData)(this->__PVT__opsize)) 
                                                   << 0x1eU) 
                                                  | (0xc0000000U 
                                                     & ((IData)(this->__PVT__opsize) 
                                                        << 0x1cU))) 
                                                 | (((0U 
                                                      != 
                                                      (3U 
                                                       & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr))) 
                                                     & (2U 
                                                        == (IData)(this->__PVT__opsize))) 
                                                    << 0x1eU)) 
                                                | (((3U 
                                                     == 
                                                     (3U 
                                                      & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr))) 
                                                    & (1U 
                                                       == (IData)(this->__PVT__opsize))) 
                                                   << 0x1eU)) 
                                               & ((0x1dU 
                                                   == 
                                                   (0x1fU 
                                                    & (IData)(
                                                              (vlTOPp->agu_block__DOT__p5_cmplxAddr 
                                                               >> 2U)))) 
                                                  << 0x1eU))) 
                                | (((((3U == (IData)(this->__PVT__opsize)) 
                                      & (0U != (3U 
                                                & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr)))) 
                                     << 0x1eU) | (0xc0000000U 
                                                  & ((IData)(this->__PVT__opsize) 
                                                     << 0x1cU))) 
                                   & ((0x1cU == (0x1fU 
                                                 & (IData)(
                                                           (vlTOPp->agu_block__DOT__p5_cmplxAddr 
                                                            >> 2U)))) 
                                      << 0x1eU))) | 
                               ((((((4U == (IData)(this->__PVT__opsize)) 
                                    & (3U == (3U & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr)))) 
                                   | (5U == (IData)(this->__PVT__opsize))) 
                                  | (6U == (IData)(this->__PVT__opsize))) 
                                 & (0x1bU == (0x1fU 
                                              & (IData)(
                                                        (vlTOPp->agu_block__DOT__p5_cmplxAddr 
                                                         >> 2U))))) 
                                << 0x1eU)) | (((((5U 
                                                  == (IData)(this->__PVT__opsize)) 
                                                 & (0U 
                                                    != 
                                                    (3U 
                                                     & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr)))) 
                                                | (6U 
                                                   == (IData)(this->__PVT__opsize))) 
                                               & (0x1aU 
                                                  == 
                                                  (0x1fU 
                                                   & (IData)(
                                                             (vlTOPp->agu_block__DOT__p5_cmplxAddr 
                                                              >> 2U))))) 
                                              << 0x1eU)));
    this->__PVT__banks0 = ((0x7fffffffU & this->__PVT__banks0) 
                           | ((((((0x1fU == (0x1fU 
                                             & (IData)(
                                                       (vlTOPp->agu_block__DOT__p5_cmplxAddr 
                                                        >> 2U)))) 
                                  << 0x1fU) | (((((
                                                   (3U 
                                                    == (IData)(this->__PVT__opsize)) 
                                                   << 0x1fU) 
                                                  | (0x80000000U 
                                                     & ((IData)(this->__PVT__opsize) 
                                                        << 0x1dU))) 
                                                 | (((0U 
                                                      != 
                                                      (3U 
                                                       & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr))) 
                                                     & (2U 
                                                        == (IData)(this->__PVT__opsize))) 
                                                    << 0x1fU)) 
                                                | (((3U 
                                                     == 
                                                     (3U 
                                                      & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr))) 
                                                    & (1U 
                                                       == (IData)(this->__PVT__opsize))) 
                                                   << 0x1fU)) 
                                               & ((0x1eU 
                                                   == 
                                                   (0x1fU 
                                                    & (IData)(
                                                              (vlTOPp->agu_block__DOT__p5_cmplxAddr 
                                                               >> 2U)))) 
                                                  << 0x1fU))) 
                                | (((((3U == (IData)(this->__PVT__opsize)) 
                                      & (0U != (3U 
                                                & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr)))) 
                                     << 0x1fU) | (0x80000000U 
                                                  & ((IData)(this->__PVT__opsize) 
                                                     << 0x1dU))) 
                                   & ((0x1dU == (0x1fU 
                                                 & (IData)(
                                                           (vlTOPp->agu_block__DOT__p5_cmplxAddr 
                                                            >> 2U)))) 
                                      << 0x1fU))) | 
                               ((((((4U == (IData)(this->__PVT__opsize)) 
                                    & (3U == (3U & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr)))) 
                                   | (5U == (IData)(this->__PVT__opsize))) 
                                  | (6U == (IData)(this->__PVT__opsize))) 
                                 & (0x1cU == (0x1fU 
                                              & (IData)(
                                                        (vlTOPp->agu_block__DOT__p5_cmplxAddr 
                                                         >> 2U))))) 
                                << 0x1fU)) | (((((5U 
                                                  == (IData)(this->__PVT__opsize)) 
                                                 & (0U 
                                                    != 
                                                    (3U 
                                                     & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr)))) 
                                                | (6U 
                                                   == (IData)(this->__PVT__opsize))) 
                                               & (0x1bU 
                                                  == 
                                                  (0x1fU 
                                                   & (IData)(
                                                             (vlTOPp->agu_block__DOT__p5_cmplxAddr 
                                                              >> 2U))))) 
                                              << 0x1fU)));
}

void Vagu_block_sagu::_settle__TOP__agu_block__DOT__Wagu2_mod__26(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+        Vagu_block_sagu::_settle__TOP__agu_block__DOT__Wagu2_mod__26\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->rng_mod__DOT__sh_mod__DOT__bits_out__out__en0 
        = ((0U == (7U & (IData)((vlTOPp->agu_block__DOT__p5_cmplxAddr 
                                 >> 0x3bU)))) ? (0xffU 
                                                 & (IData)(this->rng_mod__DOT__sh_mod__DOT__bits_med__en))
            : 0U);
    this->rng_mod__DOT__sh_mod__DOT__bits_out__out__en1 
        = ((1U == (7U & (IData)((vlTOPp->agu_block__DOT__p5_cmplxAddr 
                                 >> 0x3bU)))) ? (0xffU 
                                                 & ((IData)(this->rng_mod__DOT__sh_mod__DOT__bits_med__en) 
                                                    >> 1U))
            : 0U);
    this->rng_mod__DOT__sh_mod__DOT__bits_out__out__en2 
        = ((2U == (7U & (IData)((vlTOPp->agu_block__DOT__p5_cmplxAddr 
                                 >> 0x3bU)))) ? (0xffU 
                                                 & ((IData)(this->rng_mod__DOT__sh_mod__DOT__bits_med__en) 
                                                    >> 2U))
            : 0U);
    this->rng_mod__DOT__sh_mod__DOT__bits_out__out__en3 
        = ((3U == (7U & (IData)((vlTOPp->agu_block__DOT__p5_cmplxAddr 
                                 >> 0x3bU)))) ? (0xffU 
                                                 & ((IData)(this->rng_mod__DOT__sh_mod__DOT__bits_med__en) 
                                                    >> 3U))
            : 0U);
    this->rng_mod__DOT__sh_mod__DOT__bits_out__out__en4 
        = ((4U == (7U & (IData)((vlTOPp->agu_block__DOT__p5_cmplxAddr 
                                 >> 0x3bU)))) ? (0xffU 
                                                 & ((IData)(this->rng_mod__DOT__sh_mod__DOT__bits_med__en) 
                                                    >> 4U))
            : 0U);
    this->rng_mod__DOT__sh_mod__DOT__bits_out__out__en5 
        = ((5U == (7U & (IData)((vlTOPp->agu_block__DOT__p5_cmplxAddr 
                                 >> 0x3bU)))) ? (0xffU 
                                                 & ((IData)(this->rng_mod__DOT__sh_mod__DOT__bits_med__en) 
                                                    >> 5U))
            : 0U);
    this->rng_mod__DOT__sh_mod__DOT__bits_out__out__en6 
        = ((6U == (7U & (IData)((vlTOPp->agu_block__DOT__p5_cmplxAddr 
                                 >> 0x3bU)))) ? (0xffU 
                                                 & ((IData)(this->rng_mod__DOT__sh_mod__DOT__bits_med__en) 
                                                    >> 6U))
            : 0U);
    this->rng_mod__DOT__sh_mod__DOT__bits_out__out__en7 
        = ((7U == (7U & (IData)((vlTOPp->agu_block__DOT__p5_cmplxAddr 
                                 >> 0x3bU)))) ? (0xffU 
                                                 & ((IData)(this->rng_mod__DOT__sh_mod__DOT__bits_med__en) 
                                                    >> 7U))
            : 0U);
}

void Vagu_block_sagu::_settle__TOP__agu_block__DOT__Wagu2_mod__34(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+        Vagu_block_sagu::_settle__TOP__agu_block__DOT__Wagu2_mod__34\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->__PVT__rng_mod__DOT__bits = (((((((((((0U 
                                                 == 
                                                 (7U 
                                                  & (IData)(
                                                            (vlTOPp->agu_block__DOT__p5_cmplxAddr 
                                                             >> 0x3bU))))
                                                 ? (IData)(this->__PVT__rng_mod__DOT__sh_mod__DOT__bits_med)
                                                 : 0U) 
                                               & (IData)(this->rng_mod__DOT__sh_mod__DOT__bits_out__out__en0)) 
                                              | (((1U 
                                                   == 
                                                   (7U 
                                                    & (IData)(
                                                              (vlTOPp->agu_block__DOT__p5_cmplxAddr 
                                                               >> 0x3bU))))
                                                   ? 
                                                  ((IData)(this->__PVT__rng_mod__DOT__sh_mod__DOT__bits_med) 
                                                   >> 1U)
                                                   : 0U) 
                                                 & (IData)(this->rng_mod__DOT__sh_mod__DOT__bits_out__out__en1))) 
                                             | (((2U 
                                                  == 
                                                  (7U 
                                                   & (IData)(
                                                             (vlTOPp->agu_block__DOT__p5_cmplxAddr 
                                                              >> 0x3bU))))
                                                  ? 
                                                 ((IData)(this->__PVT__rng_mod__DOT__sh_mod__DOT__bits_med) 
                                                  >> 2U)
                                                  : 0U) 
                                                & (IData)(this->rng_mod__DOT__sh_mod__DOT__bits_out__out__en2))) 
                                            | (((3U 
                                                 == 
                                                 (7U 
                                                  & (IData)(
                                                            (vlTOPp->agu_block__DOT__p5_cmplxAddr 
                                                             >> 0x3bU))))
                                                 ? 
                                                ((IData)(this->__PVT__rng_mod__DOT__sh_mod__DOT__bits_med) 
                                                 >> 3U)
                                                 : 0U) 
                                               & (IData)(this->rng_mod__DOT__sh_mod__DOT__bits_out__out__en3))) 
                                           | (((4U 
                                                == 
                                                (7U 
                                                 & (IData)(
                                                           (vlTOPp->agu_block__DOT__p5_cmplxAddr 
                                                            >> 0x3bU))))
                                                ? ((IData)(this->__PVT__rng_mod__DOT__sh_mod__DOT__bits_med) 
                                                   >> 4U)
                                                : 0U) 
                                              & (IData)(this->rng_mod__DOT__sh_mod__DOT__bits_out__out__en4))) 
                                          | (((5U == 
                                               (7U 
                                                & (IData)(
                                                          (vlTOPp->agu_block__DOT__p5_cmplxAddr 
                                                           >> 0x3bU))))
                                               ? ((IData)(this->__PVT__rng_mod__DOT__sh_mod__DOT__bits_med) 
                                                  >> 5U)
                                               : 0U) 
                                             & (IData)(this->rng_mod__DOT__sh_mod__DOT__bits_out__out__en5))) 
                                         | (((6U == 
                                              (7U & (IData)(
                                                            (vlTOPp->agu_block__DOT__p5_cmplxAddr 
                                                             >> 0x3bU))))
                                              ? ((IData)(this->__PVT__rng_mod__DOT__sh_mod__DOT__bits_med) 
                                                 >> 6U)
                                              : 0U) 
                                            & (IData)(this->rng_mod__DOT__sh_mod__DOT__bits_out__out__en6))) 
                                        | (((7U == 
                                             (7U & (IData)(
                                                           (vlTOPp->agu_block__DOT__p5_cmplxAddr 
                                                            >> 0x3bU))))
                                             ? ((IData)(this->__PVT__rng_mod__DOT__sh_mod__DOT__bits_med) 
                                                >> 7U)
                                             : 0U) 
                                           & (IData)(this->rng_mod__DOT__sh_mod__DOT__bits_out__out__en7))) 
                                       & ((((((((IData)(this->rng_mod__DOT__sh_mod__DOT__bits_out__out__en0) 
                                                | (IData)(this->rng_mod__DOT__sh_mod__DOT__bits_out__out__en1)) 
                                               | (IData)(this->rng_mod__DOT__sh_mod__DOT__bits_out__out__en2)) 
                                              | (IData)(this->rng_mod__DOT__sh_mod__DOT__bits_out__out__en3)) 
                                             | (IData)(this->rng_mod__DOT__sh_mod__DOT__bits_out__out__en4)) 
                                            | (IData)(this->rng_mod__DOT__sh_mod__DOT__bits_out__out__en5)) 
                                           | (IData)(this->rng_mod__DOT__sh_mod__DOT__bits_out__out__en6)) 
                                          | (IData)(this->rng_mod__DOT__sh_mod__DOT__bits_out__out__en7)));
}

void Vagu_block_sagu::_settle__TOP__agu_block__DOT__Wagu2_mod__42(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+        Vagu_block_sagu::_settle__TOP__agu_block__DOT__Wagu2_mod__42\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->__PVT__rng_mod__DOT__cmpLow_mod__DOT__nG0 
        = (0xffU & (~ ((~ (0xfeU & ((IData)((vlTOPp->agu_block__DOT__p5_cmplxAddr 
                                             >> 0x34U)) 
                                    << 1U))) & (IData)(this->__PVT__rng_mod__DOT__bits))));
    this->__PVT__rng_mod__DOT__cmpHio_mod__DOT__nG0 
        = (0xffU & (~ ((1U | (0xfeU & ((IData)((vlTOPp->agu_block__DOT__p5_cmplxAddr 
                                                >> 0x2dU)) 
                                       << 1U))) & (~ (IData)(this->__PVT__rng_mod__DOT__bits)))));
}

void Vagu_block_sagu::_settle__TOP__agu_block__DOT__Wagu2_mod__44(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+        Vagu_block_sagu::_settle__TOP__agu_block__DOT__Wagu2_mod__44\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->__PVT__rng_mod__DOT__cmpLow_mod__DOT__nP0 
        = (0xffU & (~ ((~ (0xfeU & ((IData)((vlTOPp->agu_block__DOT__p5_cmplxAddr 
                                             >> 0x34U)) 
                                    << 1U))) | (IData)(this->__PVT__rng_mod__DOT__bits))));
    this->__PVT__rng_mod__DOT__cmpHio_mod__DOT__nP0 
        = (0xffU & (~ (1U | ((0xfeU & ((IData)((vlTOPp->agu_block__DOT__p5_cmplxAddr 
                                                >> 0x2dU)) 
                                       << 1U)) | (~ (IData)(this->__PVT__rng_mod__DOT__bits))))));
}

void Vagu_block_sagu::_settle__TOP__agu_block__DOT__Wagu2_mod__48(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+        Vagu_block_sagu::_settle__TOP__agu_block__DOT__Wagu2_mod__48\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->nextCAddr_mod__DOT__out__out__out2 = ((0x3ffdU 
                                                 & (IData)(this->nextCAddr_mod__DOT__out__out__out2)) 
                                                | (2U 
                                                   & ((0x80U 
                                                       ^ 
                                                       (0x1ffeU 
                                                        & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr))) 
                                                      & ((IData)(this->__PVT__nextCAddr_mod__DOT__nG4) 
                                                         << 1U))));
    this->nextCAddr_mod__DOT__out__out__out4 = ((0x3ffbU 
                                                 & (IData)(this->nextCAddr_mod__DOT__out__out__out4)) 
                                                | (4U 
                                                   & ((0x80U 
                                                       ^ 
                                                       (0x1ffcU 
                                                        & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr))) 
                                                      & ((IData)(this->__PVT__nextCAddr_mod__DOT__nG4) 
                                                         << 1U))));
    this->nextCAddr_mod__DOT__out__out__out6 = ((0x3ff7U 
                                                 & (IData)(this->nextCAddr_mod__DOT__out__out__out6)) 
                                                | (8U 
                                                   & ((0x80U 
                                                       ^ 
                                                       (0x1ff8U 
                                                        & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr))) 
                                                      & ((IData)(this->__PVT__nextCAddr_mod__DOT__nG4) 
                                                         << 1U))));
    this->nextCAddr_mod__DOT__out__out__out8 = ((0x3fefU 
                                                 & (IData)(this->nextCAddr_mod__DOT__out__out__out8)) 
                                                | (0x10U 
                                                   & ((0x80U 
                                                       ^ 
                                                       (0x1ff0U 
                                                        & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr))) 
                                                      & ((IData)(this->__PVT__nextCAddr_mod__DOT__nG4) 
                                                         << 1U))));
    this->nextCAddr_mod__DOT__out__out__out10 = ((0x3fdfU 
                                                  & (IData)(this->nextCAddr_mod__DOT__out__out__out10)) 
                                                 | (0x20U 
                                                    & ((0x80U 
                                                        ^ 
                                                        (0x1fe0U 
                                                         & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr))) 
                                                       & ((IData)(this->__PVT__nextCAddr_mod__DOT__nG4) 
                                                          << 1U))));
    this->nextCAddr_mod__DOT__out__out__out12 = ((0x3fbfU 
                                                  & (IData)(this->nextCAddr_mod__DOT__out__out__out12)) 
                                                 | (0x40U 
                                                    & ((0x80U 
                                                        ^ 
                                                        (0x1fc0U 
                                                         & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr))) 
                                                       & ((IData)(this->__PVT__nextCAddr_mod__DOT__nG4) 
                                                          << 1U))));
    this->nextCAddr_mod__DOT__out__out__out14 = ((0x3f7fU 
                                                  & (IData)(this->nextCAddr_mod__DOT__out__out__out14)) 
                                                 | (0x80U 
                                                    & ((0x80U 
                                                        ^ 
                                                        (0x1f80U 
                                                         & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr))) 
                                                       & ((IData)(this->__PVT__nextCAddr_mod__DOT__nG4) 
                                                          << 1U))));
    this->nextCAddr_mod__DOT__out__out__out16 = ((0x3effU 
                                                  & (IData)(this->nextCAddr_mod__DOT__out__out__out16)) 
                                                 | (0x100U 
                                                    & ((IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr) 
                                                       & ((IData)(this->__PVT__nextCAddr_mod__DOT__nG4) 
                                                          << 1U))));
    this->nextCAddr_mod__DOT__out__out__out18 = ((0x3dffU 
                                                  & (IData)(this->nextCAddr_mod__DOT__out__out__out18)) 
                                                 | (0x200U 
                                                    & ((IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr) 
                                                       & ((IData)(this->__PVT__nextCAddr_mod__DOT__nG4) 
                                                          << 1U))));
    this->nextCAddr_mod__DOT__out__out__out20 = ((0x3bffU 
                                                  & (IData)(this->nextCAddr_mod__DOT__out__out__out20)) 
                                                 | (0x400U 
                                                    & ((IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr) 
                                                       & ((IData)(this->__PVT__nextCAddr_mod__DOT__nG4) 
                                                          << 1U))));
    this->nextCAddr_mod__DOT__out__out__out22 = ((0x37ffU 
                                                  & (IData)(this->nextCAddr_mod__DOT__out__out__out22)) 
                                                 | (0x800U 
                                                    & ((IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr) 
                                                       & ((IData)(this->__PVT__nextCAddr_mod__DOT__nG4) 
                                                          << 1U))));
    this->nextCAddr_mod__DOT__out__out__out24 = ((0x2fffU 
                                                  & (IData)(this->nextCAddr_mod__DOT__out__out__out24)) 
                                                 | (0x1000U 
                                                    & ((IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr) 
                                                       & ((IData)(this->__PVT__nextCAddr_mod__DOT__nG4) 
                                                          << 1U))));
    this->nextCAddr_mod__DOT__out__out__out26 = (0x1fffU 
                                                 & (IData)(this->nextCAddr_mod__DOT__out__out__out26));
}

void Vagu_block_sagu::_settle__TOP__agu_block__DOT__Wagu2_mod__60(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+        Vagu_block_sagu::_settle__TOP__agu_block__DOT__Wagu2_mod__60\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->nextCAddr_mod__DOT__out__out__out1 = ((0x3ffeU 
                                                 & (IData)(this->nextCAddr_mod__DOT__out__out__out1)) 
                                                | (1U 
                                                   & ((~ 
                                                       (0x1fffU 
                                                        & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr))) 
                                                      & (~ (IData)(this->__PVT__nextCAddr_mod__DOT__nC1)))));
    this->nextCAddr_mod__DOT__out__out__out3 = ((0x3ffdU 
                                                 & (IData)(this->nextCAddr_mod__DOT__out__out__out3)) 
                                                | (2U 
                                                   & (((IData)(0x80U) 
                                                       ^ ~ 
                                                       (0x1fffU 
                                                        & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr))) 
                                                      & ((~ 
                                                          ((IData)(this->__PVT__nextCAddr_mod__DOT__nC1) 
                                                           >> 1U)) 
                                                         << 1U))));
    this->nextCAddr_mod__DOT__out__out__out5 = ((0x3ffbU 
                                                 & (IData)(this->nextCAddr_mod__DOT__out__out__out5)) 
                                                | (4U 
                                                   & (((IData)(0x80U) 
                                                       ^ ~ 
                                                       (0x1fffU 
                                                        & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr))) 
                                                      & ((~ 
                                                          ((IData)(this->__PVT__nextCAddr_mod__DOT__nC1) 
                                                           >> 2U)) 
                                                         << 2U))));
    this->nextCAddr_mod__DOT__out__out__out7 = ((0x3ff7U 
                                                 & (IData)(this->nextCAddr_mod__DOT__out__out__out7)) 
                                                | (8U 
                                                   & (((IData)(0x80U) 
                                                       ^ ~ 
                                                       (0x1fffU 
                                                        & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr))) 
                                                      & ((~ 
                                                          ((IData)(this->__PVT__nextCAddr_mod__DOT__nC1) 
                                                           >> 3U)) 
                                                         << 3U))));
    this->nextCAddr_mod__DOT__out__out__out9 = ((0x3fefU 
                                                 & (IData)(this->nextCAddr_mod__DOT__out__out__out9)) 
                                                | (0x10U 
                                                   & (((IData)(0x80U) 
                                                       ^ ~ 
                                                       (0x1fffU 
                                                        & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr))) 
                                                      & ((~ 
                                                          ((IData)(this->__PVT__nextCAddr_mod__DOT__nC1) 
                                                           >> 4U)) 
                                                         << 4U))));
    this->nextCAddr_mod__DOT__out__out__out11 = ((0x3fdfU 
                                                  & (IData)(this->nextCAddr_mod__DOT__out__out__out11)) 
                                                 | (0x20U 
                                                    & (((IData)(0x80U) 
                                                        ^ ~ 
                                                        (0x1fffU 
                                                         & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr))) 
                                                       & ((~ 
                                                           ((IData)(this->__PVT__nextCAddr_mod__DOT__nC1) 
                                                            >> 5U)) 
                                                          << 5U))));
    this->nextCAddr_mod__DOT__out__out__out13 = ((0x3fbfU 
                                                  & (IData)(this->nextCAddr_mod__DOT__out__out__out13)) 
                                                 | (0x40U 
                                                    & (((IData)(0x80U) 
                                                        ^ ~ 
                                                        (0x1fffU 
                                                         & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr))) 
                                                       & ((~ 
                                                           ((IData)(this->__PVT__nextCAddr_mod__DOT__nC1) 
                                                            >> 6U)) 
                                                          << 6U))));
    this->nextCAddr_mod__DOT__out__out__out15 = ((0x3f7fU 
                                                  & (IData)(this->nextCAddr_mod__DOT__out__out__out15)) 
                                                 | (0x80U 
                                                    & (((IData)(0x80U) 
                                                        ^ ~ 
                                                        (0x1fffU 
                                                         & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr))) 
                                                       & ((~ 
                                                           ((IData)(this->__PVT__nextCAddr_mod__DOT__nC1) 
                                                            >> 7U)) 
                                                          << 7U))));
    this->nextCAddr_mod__DOT__out__out__out17 = ((0x3effU 
                                                  & (IData)(this->nextCAddr_mod__DOT__out__out__out17)) 
                                                 | (0x100U 
                                                    & (((IData)(0x80U) 
                                                        ^ ~ 
                                                        (0x1fffU 
                                                         & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr))) 
                                                       & ((~ 
                                                           ((IData)(this->__PVT__nextCAddr_mod__DOT__nC1) 
                                                            >> 8U)) 
                                                          << 8U))));
    this->nextCAddr_mod__DOT__out__out__out19 = ((0x3dffU 
                                                  & (IData)(this->nextCAddr_mod__DOT__out__out__out19)) 
                                                 | (0x200U 
                                                    & (((IData)(0x80U) 
                                                        ^ ~ 
                                                        (0x1fffU 
                                                         & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr))) 
                                                       & ((~ 
                                                           ((IData)(this->__PVT__nextCAddr_mod__DOT__nC1) 
                                                            >> 9U)) 
                                                          << 9U))));
    this->nextCAddr_mod__DOT__out__out__out21 = ((0x3bffU 
                                                  & (IData)(this->nextCAddr_mod__DOT__out__out__out21)) 
                                                 | (0x400U 
                                                    & (((IData)(0x80U) 
                                                        ^ ~ 
                                                        (0x1fffU 
                                                         & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr))) 
                                                       & ((~ 
                                                           ((IData)(this->__PVT__nextCAddr_mod__DOT__nC1) 
                                                            >> 0xaU)) 
                                                          << 0xaU))));
    this->nextCAddr_mod__DOT__out__out__out23 = ((0x37ffU 
                                                  & (IData)(this->nextCAddr_mod__DOT__out__out__out23)) 
                                                 | (0x800U 
                                                    & (((IData)(0x80U) 
                                                        ^ ~ 
                                                        (0x1fffU 
                                                         & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr))) 
                                                       & ((~ 
                                                           ((IData)(this->__PVT__nextCAddr_mod__DOT__nC1) 
                                                            >> 0xbU)) 
                                                          << 0xbU))));
    this->nextCAddr_mod__DOT__out__out__out25 = ((0x2fffU 
                                                  & (IData)(this->nextCAddr_mod__DOT__out__out__out25)) 
                                                 | (0x1000U 
                                                    & (((IData)(0x80U) 
                                                        ^ ~ 
                                                        (0x1fffU 
                                                         & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr))) 
                                                       & ((~ 
                                                           ((IData)(this->__PVT__nextCAddr_mod__DOT__nC1) 
                                                            >> 0xcU)) 
                                                          << 0xcU))));
    this->nextCAddr_mod__DOT__out__out__out27 = ((0x1fffU 
                                                  & (IData)(this->nextCAddr_mod__DOT__out__out__out27)) 
                                                 | (0x2000U 
                                                    & (((IData)(0x80U) 
                                                        ^ ~ 
                                                        (0x1fffU 
                                                         & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr))) 
                                                       & ((~ 
                                                           ((IData)(this->__PVT__nextCAddr_mod__DOT__nC1) 
                                                            >> 0xdU)) 
                                                          << 0xdU))));
}

void Vagu_block_sagu::_settle__TOP__agu_block__DOT__Wagu2_mod__68(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+        Vagu_block_sagu::_settle__TOP__agu_block__DOT__Wagu2_mod__68\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->addrNext__out9 = ((((((((((((((((((((((((
                                                   (((1U 
                                                      & ((IData)(this->nextCAddr_mod__DOT__out__out__out0) 
                                                         & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr))) 
                                                     | (1U 
                                                        & ((IData)(this->nextCAddr_mod__DOT__out__out__out1) 
                                                           & (~ 
                                                              (0x1fffU 
                                                               & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr)))))) 
                                                    | (2U 
                                                       & ((IData)(this->nextCAddr_mod__DOT__out__out__out2) 
                                                          & (0x80U 
                                                             ^ 
                                                             (0x1ffeU 
                                                              & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr)))))) 
                                                   | (2U 
                                                      & ((IData)(this->nextCAddr_mod__DOT__out__out__out3) 
                                                         & ((IData)(0x80U) 
                                                            ^ ~ 
                                                            (0x1fffU 
                                                             & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr)))))) 
                                                  | (4U 
                                                     & ((IData)(this->nextCAddr_mod__DOT__out__out__out4) 
                                                        & (0x80U 
                                                           ^ 
                                                           (0x1ffcU 
                                                            & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr)))))) 
                                                 | (4U 
                                                    & ((IData)(this->nextCAddr_mod__DOT__out__out__out5) 
                                                       & ((IData)(0x80U) 
                                                          ^ ~ 
                                                          (0x1fffU 
                                                           & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr)))))) 
                                                | (8U 
                                                   & ((IData)(this->nextCAddr_mod__DOT__out__out__out6) 
                                                      & (0x80U 
                                                         ^ 
                                                         (0x1ff8U 
                                                          & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr)))))) 
                                               | (8U 
                                                  & ((IData)(this->nextCAddr_mod__DOT__out__out__out7) 
                                                     & ((IData)(0x80U) 
                                                        ^ ~ 
                                                        (0x1fffU 
                                                         & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr)))))) 
                                              | (0x10U 
                                                 & ((IData)(this->nextCAddr_mod__DOT__out__out__out8) 
                                                    & (0x80U 
                                                       ^ 
                                                       (0x1ff0U 
                                                        & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr)))))) 
                                             | (0x10U 
                                                & ((IData)(this->nextCAddr_mod__DOT__out__out__out9) 
                                                   & ((IData)(0x80U) 
                                                      ^ ~ 
                                                      (0x1fffU 
                                                       & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr)))))) 
                                            | (0x20U 
                                               & ((IData)(this->nextCAddr_mod__DOT__out__out__out10) 
                                                  & (0x80U 
                                                     ^ 
                                                     (0x1fe0U 
                                                      & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr)))))) 
                                           | (0x20U 
                                              & ((IData)(this->nextCAddr_mod__DOT__out__out__out11) 
                                                 & ((IData)(0x80U) 
                                                    ^ ~ 
                                                    (0x1fffU 
                                                     & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr)))))) 
                                          | (0x40U 
                                             & ((IData)(this->nextCAddr_mod__DOT__out__out__out12) 
                                                & (0x80U 
                                                   ^ 
                                                   (0x1fc0U 
                                                    & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr)))))) 
                                         | (0x40U & 
                                            ((IData)(this->nextCAddr_mod__DOT__out__out__out13) 
                                             & ((IData)(0x80U) 
                                                ^ ~ 
                                                (0x1fffU 
                                                 & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr)))))) 
                                        | (0x80U & 
                                           ((IData)(this->nextCAddr_mod__DOT__out__out__out14) 
                                            & (0x80U 
                                               ^ (0x1f80U 
                                                  & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr)))))) 
                                       | (0x80U & ((IData)(this->nextCAddr_mod__DOT__out__out__out15) 
                                                   & ((IData)(0x80U) 
                                                      ^ ~ 
                                                      (0x1fffU 
                                                       & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr)))))) 
                                      | (0x100U & ((IData)(this->nextCAddr_mod__DOT__out__out__out16) 
                                                   & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr)))) 
                                     | (0x100U & ((IData)(this->nextCAddr_mod__DOT__out__out__out17) 
                                                  & ((IData)(0x80U) 
                                                     ^ ~ 
                                                     (0x1fffU 
                                                      & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr)))))) 
                                    | (0x200U & ((IData)(this->nextCAddr_mod__DOT__out__out__out18) 
                                                 & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr)))) 
                                   | (0x200U & ((IData)(this->nextCAddr_mod__DOT__out__out__out19) 
                                                & ((IData)(0x80U) 
                                                   ^ ~ 
                                                   (0x1fffU 
                                                    & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr)))))) 
                                  | (0x400U & ((IData)(this->nextCAddr_mod__DOT__out__out__out20) 
                                               & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr)))) 
                                 | (0x400U & ((IData)(this->nextCAddr_mod__DOT__out__out__out21) 
                                              & ((IData)(0x80U) 
                                                 ^ ~ 
                                                 (0x1fffU 
                                                  & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr)))))) 
                                | (0x800U & ((IData)(this->nextCAddr_mod__DOT__out__out__out22) 
                                             & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr)))) 
                               | (0x800U & ((IData)(this->nextCAddr_mod__DOT__out__out__out23) 
                                            & ((IData)(0x80U) 
                                               ^ ~ 
                                               (0x1fffU 
                                                & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr)))))) 
                              | (0x1000U & ((IData)(this->nextCAddr_mod__DOT__out__out__out24) 
                                            & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr)))) 
                             | (0x1000U & ((IData)(this->nextCAddr_mod__DOT__out__out__out25) 
                                           & ((IData)(0x80U) 
                                              ^ ~ (0x1fffU 
                                                   & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr)))))) 
                            | (0x2000U & ((IData)(this->nextCAddr_mod__DOT__out__out__out27) 
                                          & ((IData)(0x80U) 
                                             ^ ~ (0x1fffU 
                                                  & (IData)(vlTOPp->agu_block__DOT__p5_cmplxAddr))))));
}

void Vagu_block_sagu::_settle__TOP__agu_block__DOT__Wagu2_mod__74(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+        Vagu_block_sagu::_settle__TOP__agu_block__DOT__Wagu2_mod__74\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->mOp_addrEven = ((VL_ULL(0xfffffffe0) & this->mOp_addrEven) 
                          | (IData)((IData)((0x1fU 
                                             & ((1U 
                                                 & (IData)(
                                                           (vlTOPp->agu_block__DOT__p5_cmplxAddr 
                                                            >> 7U)))
                                                 ? 
                                                ((IData)(this->__PVT__addrNext) 
                                                 >> 8U)
                                                 : (IData)(
                                                           (vlTOPp->agu_block__DOT__p5_cmplxAddr 
                                                            >> 8U)))))));
    this->mOp_addrOdd = ((VL_ULL(0xfffffffe0) & this->mOp_addrOdd) 
                         | (IData)((IData)((0x1fU & 
                                            ((1U & (IData)(
                                                           (vlTOPp->agu_block__DOT__p5_cmplxAddr 
                                                            >> 7U)))
                                              ? (IData)(
                                                        (vlTOPp->agu_block__DOT__p5_cmplxAddr 
                                                         >> 8U))
                                              : ((IData)(this->__PVT__addrNext) 
                                                 >> 8U))))));
}

void Vagu_block_sagu::_settle__TOP__agu_block__DOT__Wagu2_mod__76(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+        Vagu_block_sagu::_settle__TOP__agu_block__DOT__Wagu2_mod__76\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->mOp_addrEven = ((VL_ULL(0x1f) & this->mOp_addrEven) 
                          | ((QData)((IData)((0x7fffffffU 
                                              & ((1U 
                                                  & ((IData)(
                                                             (vlTOPp->agu_block__DOT__p5_cmplxAddr 
                                                              >> 7U)) 
                                                     & ((IData)(this->__PVT__addrNext) 
                                                        >> 0xdU)))
                                                  ? (IData)(__PVT__tlb_mod->read_data_next)
                                                  : (IData)(__PVT__tlb_mod->read_data))))) 
                             << 5U));
    this->mOp_addrOdd = ((VL_ULL(0x1f) & this->mOp_addrOdd) 
                         | ((QData)((IData)((0x7fffffffU 
                                             & ((1U 
                                                 & ((~ (IData)(
                                                               (vlTOPp->agu_block__DOT__p5_cmplxAddr 
                                                                >> 7U))) 
                                                    & ((IData)(this->__PVT__addrNext) 
                                                       >> 0xdU)))
                                                 ? (IData)(__PVT__tlb_mod->read_data_next)
                                                 : (IData)(__PVT__tlb_mod->read_data))))) 
                            << 5U));
}

void Vagu_block_sagu::_settle__TOP__agu_block__DOT__Wagu2_mod__78(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+        Vagu_block_sagu::_settle__TOP__agu_block__DOT__Wagu2_mod__78\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->__PVT__cout_secq = ((((IData)(vlTOPp->agu_block__DOT__p5_mex_en_reg) 
                                | (IData)(vlTOPp->agu_block__DOT__p5_sec_in_reg)) 
                               & ((~ ((IData)(this->__PVT__rng_mod__DOT__cmpLow_mod__DOT__nC) 
                                      >> 7U)) | ((IData)(vlTOPp->agu_block__DOT____Vcellinp__Wagu2_mod__ptrdiff) 
                                                 & (~ (IData)(
                                                              (vlTOPp->agu_block__DOT__p5_cmplxAddr 
                                                               >> 0x2cU)))))) 
                              & ((~ ((IData)(this->__PVT__rng_mod__DOT__cmpHio_mod__DOT__nC) 
                                     >> 7U)) | ((IData)(vlTOPp->agu_block__DOT____Vcellinp__Wagu2_mod__ptrdiff) 
                                                & (IData)(
                                                          (vlTOPp->agu_block__DOT__p5_cmplxAddr 
                                                           >> 0x2cU)))));
}

void Vagu_block_sagu::_ctor_var_reset() {
    VL_DEBUG_IF(VL_DBG_MSGF("+        Vagu_block_sagu::_ctor_var_reset\n"); );
    // Body
    clk = VL_RAND_RESET_I(1);
    rst = VL_RAND_RESET_I(1);
    except = VL_RAND_RESET_I(1);
    except_gate = VL_RAND_RESET_I(1);
    except_in_vm = VL_RAND_RESET_I(1);
    except_in_km = VL_RAND_RESET_I(1);
    read_clkEn = VL_RAND_RESET_I(1);
    __PVT__doStall = VL_RAND_RESET_I(1);
    bus_hold = VL_RAND_RESET_I(1);
    mex_addr = VL_RAND_RESET_Q(44);
    mex_en = VL_RAND_RESET_I(1);
    op = VL_RAND_RESET_I(13);
    shiftSize = VL_RAND_RESET_I(4);
    regno = VL_RAND_RESET_I(9);
    LSQ_no = VL_RAND_RESET_I(9);
    II_no = VL_RAND_RESET_I(10);
    WQ_no = VL_RAND_RESET_I(8);
    thread = VL_RAND_RESET_I(1);
    lsflag = VL_RAND_RESET_I(1);
    cmplxAddr = VL_RAND_RESET_Q(64);
    cin_secq = VL_RAND_RESET_I(1);
    ptrdiff = VL_RAND_RESET_I(1);
    tlbMiss = VL_RAND_RESET_I(1);
    pageFault = VL_RAND_RESET_I(1);
    faultCode = VL_RAND_RESET_I(8);
    faultNo = VL_RAND_RESET_I(9);
    __PVT__mOp_register = VL_RAND_RESET_I(9);
    mOp_type = VL_RAND_RESET_I(2);
    mOp_LSQ = VL_RAND_RESET_I(9);
    mOp_II = VL_RAND_RESET_I(10);
    mOp_WQ = VL_RAND_RESET_I(8);
    mOp_addrEven = VL_RAND_RESET_Q(36);
    mOp_addrOdd = VL_RAND_RESET_Q(36);
    mOp_addrMain = VL_RAND_RESET_Q(44);
    mOp_sz = VL_RAND_RESET_I(5);
    __PVT__mOp_st = VL_RAND_RESET_I(1);
    mOp_en = VL_RAND_RESET_I(1);
    mOp_secq = VL_RAND_RESET_I(1);
    __PVT__mOp_rsEn = VL_RAND_RESET_I(1);
    __PVT__mOp_thread = VL_RAND_RESET_I(1);
    mOp_lsflag = VL_RAND_RESET_I(1);
    mOp_banks = VL_RAND_RESET_I(32);
    mOp_bank0 = VL_RAND_RESET_I(5);
    mOp_odd = VL_RAND_RESET_I(1);
    mOp_addr_low = VL_RAND_RESET_I(2);
    mOp_split = VL_RAND_RESET_I(1);
    writeTlb_IP = VL_RAND_RESET_Q(51);
    writeTlb_wen = VL_RAND_RESET_I(1);
    writeTlb_force_way = VL_RAND_RESET_I(3);
    writeTlb_force_way_en = VL_RAND_RESET_I(1);
    writeTlb_data0 = VL_RAND_RESET_Q(41);
    writeTlb_data1 = VL_RAND_RESET_Q(41);
    writeTlb_data2 = VL_RAND_RESET_Q(41);
    csrss_no = VL_RAND_RESET_I(16);
    csrss_en = VL_RAND_RESET_I(1);
    csrss_thr = VL_RAND_RESET_I(1);
    csrss_data = VL_RAND_RESET_Q(64);
    __PVT__opsize = VL_RAND_RESET_I(3);
    __PVT__mex_en_reg = VL_RAND_RESET_I(1);
    __PVT__mex_en_reg2 = VL_RAND_RESET_I(1);
    __PVT__banks0 = VL_RAND_RESET_I(32);
    __PVT__pageFault_t_reg = VL_RAND_RESET_I(2);
    __PVT__addrNext = VL_RAND_RESET_I(14);
    __PVT__addrTlb = VL_RAND_RESET_Q(52);
    __PVT__tlb_clkEn = VL_RAND_RESET_I(1);
    __PVT__read_clkEn_reg = VL_RAND_RESET_I(1);
    __PVT__read_clkEn_reg2 = VL_RAND_RESET_I(1);
    __PVT__op_reg = VL_RAND_RESET_I(13);
    __PVT__bus_hold_reg = VL_RAND_RESET_I(1);
    __PVT__bus_hold_reg2 = VL_RAND_RESET_I(1);
    __PVT__LSQ_no_reg = VL_RAND_RESET_I(9);
    __PVT__II_no_reg = VL_RAND_RESET_I(10);
    __PVT__WQ_no_reg = VL_RAND_RESET_I(8);
    __PVT__lsflag_reg = VL_RAND_RESET_I(1);
    __PVT__rcn_mask = VL_RAND_RESET_I(2);
    __PVT__except_reg = VL_RAND_RESET_I(1);
    __PVT__cout_secq = VL_RAND_RESET_I(1);
    __PVT__fault_cann_reg = VL_RAND_RESET_I(1);
    __PVT__mflags = VL_RAND_RESET_Q(64);
    __PVT__pproc = VL_RAND_RESET_I(24);
    __PVT__sproc = VL_RAND_RESET_I(24);
    __PVT__proc = VL_RAND_RESET_I(24);
    __PVT__vproc = VL_RAND_RESET_I(24);
    __PVT__fault_tlb = VL_RAND_RESET_I(2);
    __pinNumber3__en0 = 0;
    mOp_split__out = VL_RAND_RESET_I(1);
    mOp_split__en = VL_RAND_RESET_I(1);
    mOp_split__out__en7 = 0;
    addrNext__out9 = 0;
    __PVT__nextCAddr_mod__DOT__P1 = VL_RAND_RESET_I(14);
    __PVT__nextCAddr_mod__DOT__G1 = VL_RAND_RESET_I(14);
    __PVT__nextCAddr_mod__DOT__nP2 = VL_RAND_RESET_I(14);
    __PVT__nextCAddr_mod__DOT__nG2 = VL_RAND_RESET_I(14);
    __PVT__nextCAddr_mod__DOT__P3 = VL_RAND_RESET_I(14);
    __PVT__nextCAddr_mod__DOT__G3 = VL_RAND_RESET_I(14);
    __PVT__nextCAddr_mod__DOT__nG4 = VL_RAND_RESET_I(14);
    __PVT__nextCAddr_mod__DOT__nC1 = VL_RAND_RESET_I(14);
    nextCAddr_mod__DOT__out__out__out0 = 0;
    nextCAddr_mod__DOT__out__out__out1 = 0;
    nextCAddr_mod__DOT__out__out__out2 = 0;
    nextCAddr_mod__DOT__out__out__out3 = 0;
    nextCAddr_mod__DOT__out__out__out4 = 0;
    nextCAddr_mod__DOT__out__out__out5 = 0;
    nextCAddr_mod__DOT__out__out__out6 = 0;
    nextCAddr_mod__DOT__out__out__out7 = 0;
    nextCAddr_mod__DOT__out__out__out8 = 0;
    nextCAddr_mod__DOT__out__out__out9 = 0;
    nextCAddr_mod__DOT__out__out__out10 = 0;
    nextCAddr_mod__DOT__out__out__out11 = 0;
    nextCAddr_mod__DOT__out__out__out12 = 0;
    nextCAddr_mod__DOT__out__out__out13 = 0;
    nextCAddr_mod__DOT__out__out__out14 = 0;
    nextCAddr_mod__DOT__out__out__out15 = 0;
    nextCAddr_mod__DOT__out__out__out16 = 0;
    nextCAddr_mod__DOT__out__out__out17 = 0;
    nextCAddr_mod__DOT__out__out__out18 = 0;
    nextCAddr_mod__DOT__out__out__out19 = 0;
    nextCAddr_mod__DOT__out__out__out20 = 0;
    nextCAddr_mod__DOT__out__out__out21 = 0;
    nextCAddr_mod__DOT__out__out__out22 = 0;
    nextCAddr_mod__DOT__out__out__out23 = 0;
    nextCAddr_mod__DOT__out__out__out24 = 0;
    nextCAddr_mod__DOT__out__out__out25 = 0;
    nextCAddr_mod__DOT__out__out__out26 = 0;
    nextCAddr_mod__DOT__out__out__out27 = 0;
    __PVT__rng_mod__DOT__bits = VL_RAND_RESET_I(8);
    __PVT__rng_mod__DOT__cmpLow_mod__DOT__nP0 = VL_RAND_RESET_I(8);
    __PVT__rng_mod__DOT__cmpLow_mod__DOT__nG0 = VL_RAND_RESET_I(8);
    __PVT__rng_mod__DOT__cmpLow_mod__DOT__P1 = VL_RAND_RESET_I(8);
    __PVT__rng_mod__DOT__cmpLow_mod__DOT__G1 = VL_RAND_RESET_I(8);
    __PVT__rng_mod__DOT__cmpLow_mod__DOT__nP2 = VL_RAND_RESET_I(8);
    __PVT__rng_mod__DOT__cmpLow_mod__DOT__nG2 = VL_RAND_RESET_I(8);
    __PVT__rng_mod__DOT__cmpLow_mod__DOT__P3 = VL_RAND_RESET_I(8);
    __PVT__rng_mod__DOT__cmpLow_mod__DOT__G3 = VL_RAND_RESET_I(8);
    __PVT__rng_mod__DOT__cmpLow_mod__DOT__nC = VL_RAND_RESET_I(8);
    __PVT__rng_mod__DOT__cmpHio_mod__DOT__nP0 = VL_RAND_RESET_I(8);
    __PVT__rng_mod__DOT__cmpHio_mod__DOT__nG0 = VL_RAND_RESET_I(8);
    __PVT__rng_mod__DOT__cmpHio_mod__DOT__P1 = VL_RAND_RESET_I(8);
    __PVT__rng_mod__DOT__cmpHio_mod__DOT__G1 = VL_RAND_RESET_I(8);
    __PVT__rng_mod__DOT__cmpHio_mod__DOT__nP2 = VL_RAND_RESET_I(8);
    __PVT__rng_mod__DOT__cmpHio_mod__DOT__nG2 = VL_RAND_RESET_I(8);
    __PVT__rng_mod__DOT__cmpHio_mod__DOT__P3 = VL_RAND_RESET_I(8);
    __PVT__rng_mod__DOT__cmpHio_mod__DOT__G3 = VL_RAND_RESET_I(8);
    __PVT__rng_mod__DOT__cmpHio_mod__DOT__nC = VL_RAND_RESET_I(8);
    __PVT__rng_mod__DOT__sh_mod__DOT__bits_med = VL_RAND_RESET_I(16);
    rng_mod__DOT__sh_mod__DOT__bits_med__en = VL_RAND_RESET_I(16);
    rng_mod__DOT__sh_mod__DOT__bits_out__out__en0 = 0;
    rng_mod__DOT__sh_mod__DOT__bits_out__out__en1 = 0;
    rng_mod__DOT__sh_mod__DOT__bits_out__out__en2 = 0;
    rng_mod__DOT__sh_mod__DOT__bits_out__out__en3 = 0;
    rng_mod__DOT__sh_mod__DOT__bits_out__out__en4 = 0;
    rng_mod__DOT__sh_mod__DOT__bits_out__out__en5 = 0;
    rng_mod__DOT__sh_mod__DOT__bits_out__out__en6 = 0;
    rng_mod__DOT__sh_mod__DOT__bits_out__out__en7 = 0;
}
