// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Vagu_block.h for the primary calling header

#include "Vagu_block_lru_single0__I6.h"
#include "Vagu_block__Syms.h"

//==========

VL_CTOR_IMP(Vagu_block_lru_single0__I6) {
    // Reset internal values
    // Reset structure values
    _ctor_var_reset();
}

void Vagu_block_lru_single0__I6::__Vconfigure(Vagu_block__Syms* vlSymsp, bool first) {
    if (0 && first) {}  // Prevent unused
    this->__VlSymsp = vlSymsp;
}

Vagu_block_lru_single0__I6::~Vagu_block_lru_single0__I6() {
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__Wagu_mod__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__0__KET____DOT__lru_mod__1(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__Wagu_mod__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__0__KET____DOT__lru_mod__1\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->adders_gen__DOT__inc_mod__DOT__out__out__out0 
        = (6U & (IData)(this->adders_gen__DOT__inc_mod__DOT__out__out__out0));
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__Wagu_mod__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__0__KET____DOT__lru_mod__55(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__Wagu_mod__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__0__KET____DOT__lru_mod__55\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->__PVT__adders_gen__DOT__cmp_mod__DOT__P1 = 7U;
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__Wagu_mod__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__0__KET____DOT__lru_mod__61(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__Wagu_mod__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__0__KET____DOT__lru_mod__61\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->__PVT__adders_gen__DOT__cmp_mod__DOT__nP2 = 0U;
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__Wagu_mod__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__0__KET____DOT__lru_mod__67(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__Wagu_mod__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__0__KET____DOT__lru_mod__67\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->adders_gen__DOT__inc_mod__DOT__out__out__out1 
        = ((6U & (IData)(this->adders_gen__DOT__inc_mod__DOT__out__out__out1)) 
           | (1U & (~ (IData)(vlSymsp->TOP__agu_block__DOT__Wagu_mod__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru))));
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__Wagu_mod__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__0__KET____DOT__lru_mod__115(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__Wagu_mod__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__0__KET____DOT__lru_mod__115\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->__PVT__adders_gen__DOT__inc_mod__DOT__nP1 
        = ((6U & ((~ (((IData)(vlSymsp->TOP__agu_block__DOT__Wagu_mod__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru) 
                       >> 1U) & (IData)(vlSymsp->TOP__agu_block__DOT__Wagu_mod__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru))) 
                  << 1U)) | (1U & (~ (IData)(vlSymsp->TOP__agu_block__DOT__Wagu_mod__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru))));
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__Wagu_mod__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__0__KET____DOT__lru_mod__163(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__Wagu_mod__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__0__KET____DOT__lru_mod__163\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->newLRU__out__en5 = ((1U & ((~ (IData)(vlSymsp->TOP__agu_block__DOT__Wagu_mod__tlb_mod.__Vcellinp__ways_gen__BRA__0__KET____DOT__lru_mod__en)) 
                                     & (~ (IData)(vlSymsp->TOP__agu_block__DOT__Wagu_mod__tlb_mod.__PVT__init))))
                               ? 7U : 0U);
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__Wagu_mod__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__0__KET____DOT__lru_mod__187(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__Wagu_mod__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__0__KET____DOT__lru_mod__187\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->__pinNumber2__en0 = (7U & (((((1U & ((IData)(vlSymsp->TOP__agu_block__DOT__Wagu_mod__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru) 
                                               | (~ (IData)(vlSymsp->TOP__agu_block__DOT__Wagu_mod__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru)))) 
                                        | (2U & (IData)(vlSymsp->TOP__agu_block__DOT__Wagu_mod__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru))) 
                                       | (2U & ((~ 
                                                 ((IData)(vlSymsp->TOP__agu_block__DOT__Wagu_mod__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru) 
                                                  >> 1U)) 
                                                << 1U))) 
                                      | (4U & (IData)(vlSymsp->TOP__agu_block__DOT__Wagu_mod__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru))) 
                                     | (4U & ((~ ((IData)(vlSymsp->TOP__agu_block__DOT__Wagu_mod__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru) 
                                                  >> 2U)) 
                                              << 2U))));
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__Wagu_mod__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__0__KET____DOT__lru_mod__235(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__Wagu_mod__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__0__KET____DOT__lru_mod__235\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->__PVT__adders_gen__DOT__cmp_mod__DOT__G1 
        = ((6U & ((~ ((~ (IData)(vlSymsp->TOP__agu_block__DOT__Wagu_mod__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru)) 
                      & (~ ((IData)(vlSymsp->TOP__agu_block__DOT__Wagu_mod__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru) 
                            >> 1U)))) << 1U)) | (1U 
                                                 & (IData)(vlSymsp->TOP__agu_block__DOT__Wagu_mod__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru)));
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__Wagu_mod__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__0__KET____DOT__lru_mod__319(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__Wagu_mod__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__0__KET____DOT__lru_mod__319\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->__PVT__adders_gen__DOT__inc_mod__DOT__P2 
        = ((4U & ((~ (((IData)(this->__PVT__adders_gen__DOT__inc_mod__DOT__nP1) 
                       >> 2U) | (IData)(this->__PVT__adders_gen__DOT__inc_mod__DOT__nP1))) 
                  << 2U)) | (3U & (~ (IData)(this->__PVT__adders_gen__DOT__inc_mod__DOT__nP1))));
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__Wagu_mod__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__0__KET____DOT__lru_mod__409(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__Wagu_mod__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__0__KET____DOT__lru_mod__409\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->__PVT__adders_gen__DOT__cmp_mod__DOT__nG2 
        = ((4U & ((~ ((IData)(this->__PVT__adders_gen__DOT__cmp_mod__DOT__G1) 
                      | ((IData)(this->__PVT__adders_gen__DOT__cmp_mod__DOT__G1) 
                         >> 2U))) << 2U)) | (3U & (~ (IData)(this->__PVT__adders_gen__DOT__cmp_mod__DOT__G1))));
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__Wagu_mod__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__0__KET____DOT__lru_mod__457(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__Wagu_mod__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__0__KET____DOT__lru_mod__457\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->adders_gen__DOT__inc_mod__DOT__out__out__out2 
        = ((5U & (IData)(this->adders_gen__DOT__inc_mod__DOT__out__out__out2)) 
           | (2U & ((IData)(vlSymsp->TOP__agu_block__DOT__Wagu_mod__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru) 
                    & ((~ (IData)(this->__PVT__adders_gen__DOT__inc_mod__DOT__P2)) 
                       << 1U))));
    this->adders_gen__DOT__inc_mod__DOT__out__out__out3 
        = ((5U & (IData)(this->adders_gen__DOT__inc_mod__DOT__out__out__out3)) 
           | (2U & (((~ ((IData)(vlSymsp->TOP__agu_block__DOT__Wagu_mod__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru) 
                         >> 1U)) & (IData)(this->__PVT__adders_gen__DOT__inc_mod__DOT__P2)) 
                    << 1U)));
    this->adders_gen__DOT__inc_mod__DOT__out__out__out4 
        = ((3U & (IData)(this->adders_gen__DOT__inc_mod__DOT__out__out__out4)) 
           | (4U & ((IData)(vlSymsp->TOP__agu_block__DOT__Wagu_mod__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru) 
                    & ((~ ((IData)(this->__PVT__adders_gen__DOT__inc_mod__DOT__P2) 
                           >> 1U)) << 2U))));
    this->adders_gen__DOT__inc_mod__DOT__out__out__out5 
        = ((3U & (IData)(this->adders_gen__DOT__inc_mod__DOT__out__out__out5)) 
           | (4U & (((~ ((IData)(vlSymsp->TOP__agu_block__DOT__Wagu_mod__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru) 
                         >> 2U)) << 2U) & ((IData)(this->__PVT__adders_gen__DOT__inc_mod__DOT__P2) 
                                           << 1U))));
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__Wagu_mod__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__0__KET____DOT__lru_mod__505(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__Wagu_mod__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__0__KET____DOT__lru_mod__505\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->__PVT__adders_gen__DOT__cmp_mod__DOT__C = 7U;
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__Wagu_mod__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__0__KET____DOT__lru_mod__577(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__Wagu_mod__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__0__KET____DOT__lru_mod__577\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->newLRU__out__en3 = 0U;
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__Wagu_mod__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__0__KET____DOT__lru_mod__625(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__Wagu_mod__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__0__KET____DOT__lru_mod__625\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->__PVT__hitAfter = (0U != (IData)(vlSymsp->TOP__agu_block__DOT__Wagu_mod__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru));
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__Wagu_mod__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__0__KET____DOT__lru_mod__673(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__Wagu_mod__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__0__KET____DOT__lru_mod__673\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->newLRU__out__en2 = ((((IData)(this->__PVT__hitAfter) 
                                & (~ (IData)(vlSymsp->TOP__agu_block__DOT__Wagu_mod__tlb_mod.__PVT__init))) 
                               & (IData)(vlSymsp->TOP__agu_block__DOT__Wagu_mod__tlb_mod.__Vcellinp__ways_gen__BRA__0__KET____DOT__lru_mod__en))
                               ? 7U : 0U);
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__Wagu_mod__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__0__KET____DOT__lru_mod__721(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__Wagu_mod__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__0__KET____DOT__lru_mod__721\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->newLRU__en = (((((((0U == (IData)(vlSymsp->TOP__agu_block__DOT__Wagu_mod__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru)) 
                             & (~ (IData)(vlSymsp->TOP__agu_block__DOT__Wagu_mod__tlb_mod.__PVT__init))) 
                            & (IData)(vlSymsp->TOP__agu_block__DOT__Wagu_mod__tlb_mod.__Vcellinp__ways_gen__BRA__0__KET____DOT__lru_mod__en))
                            ? 7U : 0U) | (IData)(this->newLRU__out__en2)) 
                         | ((IData)(vlSymsp->TOP__agu_block__DOT__Wagu_mod__tlb_mod.__PVT__init)
                             ? 7U : 0U)) | (IData)(this->newLRU__out__en5));
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__Wagu_mod__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__1__KET____DOT__lru_mod__236(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__Wagu_mod__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__1__KET____DOT__lru_mod__236\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->__PVT__adders_gen__DOT__cmp_mod__DOT__G1 
        = (6U & ((~ (((~ (3U | ((IData)(vlSymsp->TOP__agu_block__DOT__Wagu_mod__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru) 
                                >> 1U))) | (~ (2U & (IData)(vlSymsp->TOP__agu_block__DOT__Wagu_mod__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru)))) 
                     & (~ (3U & ((IData)(vlSymsp->TOP__agu_block__DOT__Wagu_mod__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru) 
                                 >> 1U))))) << 1U));
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__Wagu_mod__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__1__KET____DOT__lru_mod__277(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__Wagu_mod__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__1__KET____DOT__lru_mod__277\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->__PVT__adders_gen__DOT__cmp_mod__DOT__P1 
        = ((6U & ((~ ((~ (3U | ((IData)(vlSymsp->TOP__agu_block__DOT__Wagu_mod__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru) 
                                >> 1U))) | (~ (2U | (IData)(vlSymsp->TOP__agu_block__DOT__Wagu_mod__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru))))) 
                  << 1U)) | (1U & (IData)(vlSymsp->TOP__agu_block__DOT__Wagu_mod__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru)));
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__Wagu_mod__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__1__KET____DOT__lru_mod__367(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__Wagu_mod__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__1__KET____DOT__lru_mod__367\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->__PVT__adders_gen__DOT__cmp_mod__DOT__nP2 
        = ((4U & ((~ (((IData)(this->__PVT__adders_gen__DOT__cmp_mod__DOT__P1) 
                       >> 2U) & (IData)(this->__PVT__adders_gen__DOT__cmp_mod__DOT__P1))) 
                  << 2U)) | (3U & (~ (IData)(this->__PVT__adders_gen__DOT__cmp_mod__DOT__P1))));
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__Wagu_mod__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__1__KET____DOT__lru_mod__410(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__Wagu_mod__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__1__KET____DOT__lru_mod__410\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->__PVT__adders_gen__DOT__cmp_mod__DOT__nG2 
        = ((4U & ((~ ((((IData)(this->__PVT__adders_gen__DOT__cmp_mod__DOT__P1) 
                        >> 2U) & (IData)(this->__PVT__adders_gen__DOT__cmp_mod__DOT__G1)) 
                      | ((IData)(this->__PVT__adders_gen__DOT__cmp_mod__DOT__G1) 
                         >> 2U))) << 2U)) | (3U & (~ (IData)(this->__PVT__adders_gen__DOT__cmp_mod__DOT__G1))));
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__Wagu_mod__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__1__KET____DOT__lru_mod__506(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__Wagu_mod__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__1__KET____DOT__lru_mod__506\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->__PVT__adders_gen__DOT__cmp_mod__DOT__C = 
        (7U & (~ ((IData)(this->__PVT__adders_gen__DOT__cmp_mod__DOT__nP2) 
                  & (IData)(this->__PVT__adders_gen__DOT__cmp_mod__DOT__nG2))));
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__Wagu_mod__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__1__KET____DOT__lru_mod__578(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__Wagu_mod__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__1__KET____DOT__lru_mod__578\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->newLRU__out__en3 = ((((~ ((IData)(this->__PVT__adders_gen__DOT__cmp_mod__DOT__C) 
                                    >> 2U)) & (~ (IData)(vlSymsp->TOP__agu_block__DOT__Wagu_mod__tlb_mod.__PVT__init))) 
                               & (IData)(vlSymsp->TOP__agu_block__DOT__Wagu_mod__tlb_mod.__Vcellinp__ways_gen__BRA__0__KET____DOT__lru_mod__en))
                               ? (IData)(this->__pinNumber2__en0)
                               : 0U);
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__Wagu_mod__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__1__KET____DOT__lru_mod__626(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__Wagu_mod__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__1__KET____DOT__lru_mod__626\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->__PVT__hitAfter = (((IData)(this->__PVT__adders_gen__DOT__cmp_mod__DOT__C) 
                              >> 2U) & (1U != (IData)(vlSymsp->TOP__agu_block__DOT__Wagu_mod__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru)));
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__Wagu_mod__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__1__KET____DOT__lru_mod__722(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__Wagu_mod__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__1__KET____DOT__lru_mod__722\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->newLRU__en = ((((((((1U == (IData)(vlSymsp->TOP__agu_block__DOT__Wagu_mod__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru)) 
                              & (~ (IData)(vlSymsp->TOP__agu_block__DOT__Wagu_mod__tlb_mod.__PVT__init))) 
                             & (IData)(vlSymsp->TOP__agu_block__DOT__Wagu_mod__tlb_mod.__Vcellinp__ways_gen__BRA__0__KET____DOT__lru_mod__en))
                             ? 7U : 0U) | (IData)(this->newLRU__out__en2)) 
                          | (IData)(this->newLRU__out__en3)) 
                         | ((IData)(vlSymsp->TOP__agu_block__DOT__Wagu_mod__tlb_mod.__PVT__init)
                             ? 7U : 0U)) | (IData)(this->newLRU__out__en5));
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__Wagu_mod__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__2__KET____DOT__lru_mod__237(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__Wagu_mod__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__2__KET____DOT__lru_mod__237\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->__PVT__adders_gen__DOT__cmp_mod__DOT__G1 
        = ((6U & ((~ (((~ (2U | ((IData)(vlSymsp->TOP__agu_block__DOT__Wagu_mod__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru) 
                                 >> 1U))) | (~ (1U 
                                                & (IData)(vlSymsp->TOP__agu_block__DOT__Wagu_mod__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru)))) 
                      & (~ (2U & ((IData)(vlSymsp->TOP__agu_block__DOT__Wagu_mod__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru) 
                                  >> 1U))))) << 1U)) 
           | (1U & (IData)(vlSymsp->TOP__agu_block__DOT__Wagu_mod__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru)));
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__Wagu_mod__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__2__KET____DOT__lru_mod__278(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__Wagu_mod__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__2__KET____DOT__lru_mod__278\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->__PVT__adders_gen__DOT__cmp_mod__DOT__P1 
        = (1U | (6U & ((~ ((~ (2U | ((IData)(vlSymsp->TOP__agu_block__DOT__Wagu_mod__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru) 
                                     >> 1U))) | (~ 
                                                 (1U 
                                                  | (IData)(vlSymsp->TOP__agu_block__DOT__Wagu_mod__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru))))) 
                       << 1U)));
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__Wagu_mod__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__2__KET____DOT__lru_mod__627(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__Wagu_mod__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__2__KET____DOT__lru_mod__627\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->__PVT__hitAfter = (((IData)(this->__PVT__adders_gen__DOT__cmp_mod__DOT__C) 
                              >> 2U) & (2U != (IData)(vlSymsp->TOP__agu_block__DOT__Wagu_mod__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru)));
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__Wagu_mod__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__2__KET____DOT__lru_mod__723(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__Wagu_mod__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__2__KET____DOT__lru_mod__723\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->newLRU__en = ((((((((2U == (IData)(vlSymsp->TOP__agu_block__DOT__Wagu_mod__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru)) 
                              & (~ (IData)(vlSymsp->TOP__agu_block__DOT__Wagu_mod__tlb_mod.__PVT__init))) 
                             & (IData)(vlSymsp->TOP__agu_block__DOT__Wagu_mod__tlb_mod.__Vcellinp__ways_gen__BRA__0__KET____DOT__lru_mod__en))
                             ? 7U : 0U) | (IData)(this->newLRU__out__en2)) 
                          | (IData)(this->newLRU__out__en3)) 
                         | ((IData)(vlSymsp->TOP__agu_block__DOT__Wagu_mod__tlb_mod.__PVT__init)
                             ? 7U : 0U)) | (IData)(this->newLRU__out__en5));
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__Wagu_mod__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__3__KET____DOT__lru_mod__238(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__Wagu_mod__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__3__KET____DOT__lru_mod__238\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->__PVT__adders_gen__DOT__cmp_mod__DOT__G1 
        = (4U & (IData)(vlSymsp->TOP__agu_block__DOT__Wagu_mod__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru));
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__Wagu_mod__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__3__KET____DOT__lru_mod__279(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__Wagu_mod__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__3__KET____DOT__lru_mod__279\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->__PVT__adders_gen__DOT__cmp_mod__DOT__P1 
        = ((6U & ((~ ((~ (2U | ((IData)(vlSymsp->TOP__agu_block__DOT__Wagu_mod__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru) 
                                >> 1U))) | (~ (IData)(vlSymsp->TOP__agu_block__DOT__Wagu_mod__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru)))) 
                  << 1U)) | (1U & (IData)(vlSymsp->TOP__agu_block__DOT__Wagu_mod__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru)));
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__Wagu_mod__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__3__KET____DOT__lru_mod__628(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__Wagu_mod__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__3__KET____DOT__lru_mod__628\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->__PVT__hitAfter = (((IData)(this->__PVT__adders_gen__DOT__cmp_mod__DOT__C) 
                              >> 2U) & (3U != (IData)(vlSymsp->TOP__agu_block__DOT__Wagu_mod__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru)));
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__Wagu_mod__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__3__KET____DOT__lru_mod__724(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__Wagu_mod__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__3__KET____DOT__lru_mod__724\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->newLRU__en = ((((((((3U == (IData)(vlSymsp->TOP__agu_block__DOT__Wagu_mod__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru)) 
                              & (~ (IData)(vlSymsp->TOP__agu_block__DOT__Wagu_mod__tlb_mod.__PVT__init))) 
                             & (IData)(vlSymsp->TOP__agu_block__DOT__Wagu_mod__tlb_mod.__Vcellinp__ways_gen__BRA__0__KET____DOT__lru_mod__en))
                             ? 7U : 0U) | (IData)(this->newLRU__out__en2)) 
                          | (IData)(this->newLRU__out__en3)) 
                         | ((IData)(vlSymsp->TOP__agu_block__DOT__Wagu_mod__tlb_mod.__PVT__init)
                             ? 7U : 0U)) | (IData)(this->newLRU__out__en5));
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__Wagu_mod__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__4__KET____DOT__lru_mod__239(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__Wagu_mod__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__4__KET____DOT__lru_mod__239\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->__PVT__adders_gen__DOT__cmp_mod__DOT__G1 
        = ((6U & ((~ (((~ (1U | ((IData)(vlSymsp->TOP__agu_block__DOT__Wagu_mod__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru) 
                                 >> 1U))) | (~ (IData)(vlSymsp->TOP__agu_block__DOT__Wagu_mod__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru))) 
                      & (~ (1U & ((IData)(vlSymsp->TOP__agu_block__DOT__Wagu_mod__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru) 
                                  >> 1U))))) << 1U)) 
           | (1U & (IData)(vlSymsp->TOP__agu_block__DOT__Wagu_mod__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru)));
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__Wagu_mod__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__4__KET____DOT__lru_mod__280(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__Wagu_mod__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__4__KET____DOT__lru_mod__280\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->__PVT__adders_gen__DOT__cmp_mod__DOT__P1 
        = (1U | (6U & (2U | (0xfffffffeU & (IData)(vlSymsp->TOP__agu_block__DOT__Wagu_mod__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru)))));
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__Wagu_mod__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__4__KET____DOT__lru_mod__629(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__Wagu_mod__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__4__KET____DOT__lru_mod__629\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->__PVT__hitAfter = (((IData)(this->__PVT__adders_gen__DOT__cmp_mod__DOT__C) 
                              >> 2U) & (4U != (IData)(vlSymsp->TOP__agu_block__DOT__Wagu_mod__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru)));
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__Wagu_mod__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__4__KET____DOT__lru_mod__725(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__Wagu_mod__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__4__KET____DOT__lru_mod__725\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->newLRU__en = ((((((((4U == (IData)(vlSymsp->TOP__agu_block__DOT__Wagu_mod__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru)) 
                              & (~ (IData)(vlSymsp->TOP__agu_block__DOT__Wagu_mod__tlb_mod.__PVT__init))) 
                             & (IData)(vlSymsp->TOP__agu_block__DOT__Wagu_mod__tlb_mod.__Vcellinp__ways_gen__BRA__0__KET____DOT__lru_mod__en))
                             ? 7U : 0U) | (IData)(this->newLRU__out__en2)) 
                          | (IData)(this->newLRU__out__en3)) 
                         | ((IData)(vlSymsp->TOP__agu_block__DOT__Wagu_mod__tlb_mod.__PVT__init)
                             ? 7U : 0U)) | (IData)(this->newLRU__out__en5));
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__Wagu_mod__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__5__KET____DOT__lru_mod__240(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__Wagu_mod__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__5__KET____DOT__lru_mod__240\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->__PVT__adders_gen__DOT__cmp_mod__DOT__G1 
        = (6U & ((~ (((~ (1U | ((IData)(vlSymsp->TOP__agu_block__DOT__Wagu_mod__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru) 
                                >> 1U))) | (~ (2U & (IData)(vlSymsp->TOP__agu_block__DOT__Wagu_mod__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru)))) 
                     & (~ (1U & ((IData)(vlSymsp->TOP__agu_block__DOT__Wagu_mod__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru) 
                                 >> 1U))))) << 1U));
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__Wagu_mod__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__5__KET____DOT__lru_mod__281(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__Wagu_mod__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__5__KET____DOT__lru_mod__281\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->__PVT__adders_gen__DOT__cmp_mod__DOT__P1 
        = ((6U & ((~ ((~ (1U | ((IData)(vlSymsp->TOP__agu_block__DOT__Wagu_mod__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru) 
                                >> 1U))) | (~ (2U | (IData)(vlSymsp->TOP__agu_block__DOT__Wagu_mod__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru))))) 
                  << 1U)) | (1U & (IData)(vlSymsp->TOP__agu_block__DOT__Wagu_mod__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru)));
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__Wagu_mod__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__5__KET____DOT__lru_mod__630(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__Wagu_mod__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__5__KET____DOT__lru_mod__630\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->__PVT__hitAfter = (((IData)(this->__PVT__adders_gen__DOT__cmp_mod__DOT__C) 
                              >> 2U) & (5U != (IData)(vlSymsp->TOP__agu_block__DOT__Wagu_mod__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru)));
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__Wagu_mod__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__5__KET____DOT__lru_mod__726(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__Wagu_mod__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__5__KET____DOT__lru_mod__726\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->newLRU__en = ((((((((5U == (IData)(vlSymsp->TOP__agu_block__DOT__Wagu_mod__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru)) 
                              & (~ (IData)(vlSymsp->TOP__agu_block__DOT__Wagu_mod__tlb_mod.__PVT__init))) 
                             & (IData)(vlSymsp->TOP__agu_block__DOT__Wagu_mod__tlb_mod.__Vcellinp__ways_gen__BRA__0__KET____DOT__lru_mod__en))
                             ? 7U : 0U) | (IData)(this->newLRU__out__en2)) 
                          | (IData)(this->newLRU__out__en3)) 
                         | ((IData)(vlSymsp->TOP__agu_block__DOT__Wagu_mod__tlb_mod.__PVT__init)
                             ? 7U : 0U)) | (IData)(this->newLRU__out__en5));
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__Wagu_mod__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__6__KET____DOT__lru_mod__241(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__Wagu_mod__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__6__KET____DOT__lru_mod__241\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->__PVT__adders_gen__DOT__cmp_mod__DOT__G1 
        = ((6U & ((~ ((~ ((IData)(vlSymsp->TOP__agu_block__DOT__Wagu_mod__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru) 
                          >> 1U)) | (~ (1U & (IData)(vlSymsp->TOP__agu_block__DOT__Wagu_mod__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru))))) 
                  << 1U)) | (1U & (IData)(vlSymsp->TOP__agu_block__DOT__Wagu_mod__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru)));
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__Wagu_mod__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__6__KET____DOT__lru_mod__282(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__Wagu_mod__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__6__KET____DOT__lru_mod__282\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->__PVT__adders_gen__DOT__cmp_mod__DOT__P1 
        = (1U | (6U & ((~ ((~ ((IData)(vlSymsp->TOP__agu_block__DOT__Wagu_mod__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru) 
                               >> 1U)) | (~ (1U | (IData)(vlSymsp->TOP__agu_block__DOT__Wagu_mod__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru))))) 
                       << 1U)));
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__Wagu_mod__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__6__KET____DOT__lru_mod__631(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__Wagu_mod__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__6__KET____DOT__lru_mod__631\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->__PVT__hitAfter = (((IData)(this->__PVT__adders_gen__DOT__cmp_mod__DOT__C) 
                              >> 2U) & (6U != (IData)(vlSymsp->TOP__agu_block__DOT__Wagu_mod__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru)));
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__Wagu_mod__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__6__KET____DOT__lru_mod__727(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__Wagu_mod__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__6__KET____DOT__lru_mod__727\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->newLRU__en = ((((((((6U == (IData)(vlSymsp->TOP__agu_block__DOT__Wagu_mod__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru)) 
                              & (~ (IData)(vlSymsp->TOP__agu_block__DOT__Wagu_mod__tlb_mod.__PVT__init))) 
                             & (IData)(vlSymsp->TOP__agu_block__DOT__Wagu_mod__tlb_mod.__Vcellinp__ways_gen__BRA__0__KET____DOT__lru_mod__en))
                             ? 7U : 0U) | (IData)(this->newLRU__out__en2)) 
                          | (IData)(this->newLRU__out__en3)) 
                         | ((IData)(vlSymsp->TOP__agu_block__DOT__Wagu_mod__tlb_mod.__PVT__init)
                             ? 7U : 0U)) | (IData)(this->newLRU__out__en5));
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__Wagu_mod__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__7__KET____DOT__lru_mod__49(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__Wagu_mod__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__7__KET____DOT__lru_mod__49\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->__PVT__adders_gen__DOT__cmp_mod__DOT__G1 = 0U;
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__Wagu_mod__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__7__KET____DOT__lru_mod__283(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__Wagu_mod__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__7__KET____DOT__lru_mod__283\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->__PVT__adders_gen__DOT__cmp_mod__DOT__P1 
        = ((6U & ((~ ((~ ((IData)(vlSymsp->TOP__agu_block__DOT__Wagu_mod__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru) 
                          >> 1U)) | (~ (IData)(vlSymsp->TOP__agu_block__DOT__Wagu_mod__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru)))) 
                  << 1U)) | (1U & (IData)(vlSymsp->TOP__agu_block__DOT__Wagu_mod__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru)));
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__Wagu_mod__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__7__KET____DOT__lru_mod__416(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__Wagu_mod__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__7__KET____DOT__lru_mod__416\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->__PVT__adders_gen__DOT__cmp_mod__DOT__nG2 = 7U;
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__Wagu_mod__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__7__KET____DOT__lru_mod__512(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__Wagu_mod__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__7__KET____DOT__lru_mod__512\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->__PVT__adders_gen__DOT__cmp_mod__DOT__C = 
        (7U & (~ (IData)(this->__PVT__adders_gen__DOT__cmp_mod__DOT__nP2)));
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__Wagu_mod__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__7__KET____DOT__lru_mod__632(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__Wagu_mod__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__7__KET____DOT__lru_mod__632\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->__PVT__hitAfter = (((IData)(this->__PVT__adders_gen__DOT__cmp_mod__DOT__C) 
                              >> 2U) & (7U != (IData)(vlSymsp->TOP__agu_block__DOT__Wagu_mod__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru)));
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__Wagu_mod__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__7__KET____DOT__lru_mod__728(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__Wagu_mod__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__7__KET____DOT__lru_mod__728\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->newLRU__en = ((((((((7U == (IData)(vlSymsp->TOP__agu_block__DOT__Wagu_mod__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru)) 
                              & (~ (IData)(vlSymsp->TOP__agu_block__DOT__Wagu_mod__tlb_mod.__PVT__init))) 
                             & (IData)(vlSymsp->TOP__agu_block__DOT__Wagu_mod__tlb_mod.__Vcellinp__ways_gen__BRA__0__KET____DOT__lru_mod__en))
                             ? 7U : 0U) | (IData)(this->newLRU__out__en2)) 
                          | (IData)(this->newLRU__out__en3)) 
                         | ((IData)(vlSymsp->TOP__agu_block__DOT__Wagu_mod__tlb_mod.__PVT__init)
                             ? 7U : 0U)) | (IData)(this->newLRU__out__en5));
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__Wagu2_mod__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__0__KET____DOT__lru_mod__75(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__Wagu2_mod__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__0__KET____DOT__lru_mod__75\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->adders_gen__DOT__inc_mod__DOT__out__out__out1 
        = ((6U & (IData)(this->adders_gen__DOT__inc_mod__DOT__out__out__out1)) 
           | (1U & (~ (IData)(vlSymsp->TOP__agu_block__DOT__Wagu2_mod__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru))));
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__Wagu2_mod__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__0__KET____DOT__lru_mod__123(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__Wagu2_mod__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__0__KET____DOT__lru_mod__123\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->__PVT__adders_gen__DOT__inc_mod__DOT__nP1 
        = ((6U & ((~ (((IData)(vlSymsp->TOP__agu_block__DOT__Wagu2_mod__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru) 
                       >> 1U) & (IData)(vlSymsp->TOP__agu_block__DOT__Wagu2_mod__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru))) 
                  << 1U)) | (1U & (~ (IData)(vlSymsp->TOP__agu_block__DOT__Wagu2_mod__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru))));
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__Wagu2_mod__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__0__KET____DOT__lru_mod__171(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__Wagu2_mod__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__0__KET____DOT__lru_mod__171\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->newLRU__out__en5 = ((1U & ((~ (IData)(vlSymsp->TOP__agu_block__DOT__Wagu2_mod__tlb_mod.__Vcellinp__ways_gen__BRA__0__KET____DOT__lru_mod__en)) 
                                     & (~ (IData)(vlSymsp->TOP__agu_block__DOT__Wagu2_mod__tlb_mod.__PVT__init))))
                               ? 7U : 0U);
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__Wagu2_mod__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__0__KET____DOT__lru_mod__195(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__Wagu2_mod__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__0__KET____DOT__lru_mod__195\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->__pinNumber2__en0 = (7U & (((((1U & ((IData)(vlSymsp->TOP__agu_block__DOT__Wagu2_mod__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru) 
                                               | (~ (IData)(vlSymsp->TOP__agu_block__DOT__Wagu2_mod__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru)))) 
                                        | (2U & (IData)(vlSymsp->TOP__agu_block__DOT__Wagu2_mod__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru))) 
                                       | (2U & ((~ 
                                                 ((IData)(vlSymsp->TOP__agu_block__DOT__Wagu2_mod__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru) 
                                                  >> 1U)) 
                                                << 1U))) 
                                      | (4U & (IData)(vlSymsp->TOP__agu_block__DOT__Wagu2_mod__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru))) 
                                     | (4U & ((~ ((IData)(vlSymsp->TOP__agu_block__DOT__Wagu2_mod__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru) 
                                                  >> 2U)) 
                                              << 2U))));
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__Wagu2_mod__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__0__KET____DOT__lru_mod__242(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__Wagu2_mod__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__0__KET____DOT__lru_mod__242\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->__PVT__adders_gen__DOT__cmp_mod__DOT__G1 
        = ((6U & ((~ ((~ (IData)(vlSymsp->TOP__agu_block__DOT__Wagu2_mod__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru)) 
                      & (~ ((IData)(vlSymsp->TOP__agu_block__DOT__Wagu2_mod__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru) 
                            >> 1U)))) << 1U)) | (1U 
                                                 & (IData)(vlSymsp->TOP__agu_block__DOT__Wagu2_mod__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru)));
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__Wagu2_mod__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__0__KET____DOT__lru_mod__465(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__Wagu2_mod__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__0__KET____DOT__lru_mod__465\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->adders_gen__DOT__inc_mod__DOT__out__out__out2 
        = ((5U & (IData)(this->adders_gen__DOT__inc_mod__DOT__out__out__out2)) 
           | (2U & ((IData)(vlSymsp->TOP__agu_block__DOT__Wagu2_mod__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru) 
                    & ((~ (IData)(this->__PVT__adders_gen__DOT__inc_mod__DOT__P2)) 
                       << 1U))));
    this->adders_gen__DOT__inc_mod__DOT__out__out__out3 
        = ((5U & (IData)(this->adders_gen__DOT__inc_mod__DOT__out__out__out3)) 
           | (2U & (((~ ((IData)(vlSymsp->TOP__agu_block__DOT__Wagu2_mod__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru) 
                         >> 1U)) & (IData)(this->__PVT__adders_gen__DOT__inc_mod__DOT__P2)) 
                    << 1U)));
    this->adders_gen__DOT__inc_mod__DOT__out__out__out4 
        = ((3U & (IData)(this->adders_gen__DOT__inc_mod__DOT__out__out__out4)) 
           | (4U & ((IData)(vlSymsp->TOP__agu_block__DOT__Wagu2_mod__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru) 
                    & ((~ ((IData)(this->__PVT__adders_gen__DOT__inc_mod__DOT__P2) 
                           >> 1U)) << 2U))));
    this->adders_gen__DOT__inc_mod__DOT__out__out__out5 
        = ((3U & (IData)(this->adders_gen__DOT__inc_mod__DOT__out__out__out5)) 
           | (4U & (((~ ((IData)(vlSymsp->TOP__agu_block__DOT__Wagu2_mod__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru) 
                         >> 2U)) << 2U) & ((IData)(this->__PVT__adders_gen__DOT__inc_mod__DOT__P2) 
                                           << 1U))));
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__Wagu2_mod__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__0__KET____DOT__lru_mod__633(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__Wagu2_mod__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__0__KET____DOT__lru_mod__633\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->__PVT__hitAfter = (0U != (IData)(vlSymsp->TOP__agu_block__DOT__Wagu2_mod__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru));
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__Wagu2_mod__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__0__KET____DOT__lru_mod__681(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__Wagu2_mod__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__0__KET____DOT__lru_mod__681\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->newLRU__out__en2 = ((((IData)(this->__PVT__hitAfter) 
                                & (~ (IData)(vlSymsp->TOP__agu_block__DOT__Wagu2_mod__tlb_mod.__PVT__init))) 
                               & (IData)(vlSymsp->TOP__agu_block__DOT__Wagu2_mod__tlb_mod.__Vcellinp__ways_gen__BRA__0__KET____DOT__lru_mod__en))
                               ? 7U : 0U);
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__Wagu2_mod__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__0__KET____DOT__lru_mod__729(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__Wagu2_mod__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__0__KET____DOT__lru_mod__729\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->newLRU__en = (((((((0U == (IData)(vlSymsp->TOP__agu_block__DOT__Wagu2_mod__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru)) 
                             & (~ (IData)(vlSymsp->TOP__agu_block__DOT__Wagu2_mod__tlb_mod.__PVT__init))) 
                            & (IData)(vlSymsp->TOP__agu_block__DOT__Wagu2_mod__tlb_mod.__Vcellinp__ways_gen__BRA__0__KET____DOT__lru_mod__en))
                            ? 7U : 0U) | (IData)(this->newLRU__out__en2)) 
                         | ((IData)(vlSymsp->TOP__agu_block__DOT__Wagu2_mod__tlb_mod.__PVT__init)
                             ? 7U : 0U)) | (IData)(this->newLRU__out__en5));
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__Wagu2_mod__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__1__KET____DOT__lru_mod__243(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__Wagu2_mod__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__1__KET____DOT__lru_mod__243\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->__PVT__adders_gen__DOT__cmp_mod__DOT__G1 
        = (6U & ((~ (((~ (3U | ((IData)(vlSymsp->TOP__agu_block__DOT__Wagu2_mod__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru) 
                                >> 1U))) | (~ (2U & (IData)(vlSymsp->TOP__agu_block__DOT__Wagu2_mod__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru)))) 
                     & (~ (3U & ((IData)(vlSymsp->TOP__agu_block__DOT__Wagu2_mod__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru) 
                                 >> 1U))))) << 1U));
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__Wagu2_mod__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__1__KET____DOT__lru_mod__284(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__Wagu2_mod__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__1__KET____DOT__lru_mod__284\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->__PVT__adders_gen__DOT__cmp_mod__DOT__P1 
        = ((6U & ((~ ((~ (3U | ((IData)(vlSymsp->TOP__agu_block__DOT__Wagu2_mod__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru) 
                                >> 1U))) | (~ (2U | (IData)(vlSymsp->TOP__agu_block__DOT__Wagu2_mod__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru))))) 
                  << 1U)) | (1U & (IData)(vlSymsp->TOP__agu_block__DOT__Wagu2_mod__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru)));
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__Wagu2_mod__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__1__KET____DOT__lru_mod__586(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__Wagu2_mod__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__1__KET____DOT__lru_mod__586\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->newLRU__out__en3 = ((((~ ((IData)(this->__PVT__adders_gen__DOT__cmp_mod__DOT__C) 
                                    >> 2U)) & (~ (IData)(vlSymsp->TOP__agu_block__DOT__Wagu2_mod__tlb_mod.__PVT__init))) 
                               & (IData)(vlSymsp->TOP__agu_block__DOT__Wagu2_mod__tlb_mod.__Vcellinp__ways_gen__BRA__0__KET____DOT__lru_mod__en))
                               ? (IData)(this->__pinNumber2__en0)
                               : 0U);
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__Wagu2_mod__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__1__KET____DOT__lru_mod__634(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__Wagu2_mod__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__1__KET____DOT__lru_mod__634\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->__PVT__hitAfter = (((IData)(this->__PVT__adders_gen__DOT__cmp_mod__DOT__C) 
                              >> 2U) & (1U != (IData)(vlSymsp->TOP__agu_block__DOT__Wagu2_mod__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru)));
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__Wagu2_mod__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__1__KET____DOT__lru_mod__730(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__Wagu2_mod__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__1__KET____DOT__lru_mod__730\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->newLRU__en = ((((((((1U == (IData)(vlSymsp->TOP__agu_block__DOT__Wagu2_mod__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru)) 
                              & (~ (IData)(vlSymsp->TOP__agu_block__DOT__Wagu2_mod__tlb_mod.__PVT__init))) 
                             & (IData)(vlSymsp->TOP__agu_block__DOT__Wagu2_mod__tlb_mod.__Vcellinp__ways_gen__BRA__0__KET____DOT__lru_mod__en))
                             ? 7U : 0U) | (IData)(this->newLRU__out__en2)) 
                          | (IData)(this->newLRU__out__en3)) 
                         | ((IData)(vlSymsp->TOP__agu_block__DOT__Wagu2_mod__tlb_mod.__PVT__init)
                             ? 7U : 0U)) | (IData)(this->newLRU__out__en5));
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__Wagu2_mod__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__2__KET____DOT__lru_mod__244(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__Wagu2_mod__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__2__KET____DOT__lru_mod__244\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->__PVT__adders_gen__DOT__cmp_mod__DOT__G1 
        = ((6U & ((~ (((~ (2U | ((IData)(vlSymsp->TOP__agu_block__DOT__Wagu2_mod__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru) 
                                 >> 1U))) | (~ (1U 
                                                & (IData)(vlSymsp->TOP__agu_block__DOT__Wagu2_mod__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru)))) 
                      & (~ (2U & ((IData)(vlSymsp->TOP__agu_block__DOT__Wagu2_mod__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru) 
                                  >> 1U))))) << 1U)) 
           | (1U & (IData)(vlSymsp->TOP__agu_block__DOT__Wagu2_mod__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru)));
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__Wagu2_mod__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__2__KET____DOT__lru_mod__285(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__Wagu2_mod__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__2__KET____DOT__lru_mod__285\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->__PVT__adders_gen__DOT__cmp_mod__DOT__P1 
        = (1U | (6U & ((~ ((~ (2U | ((IData)(vlSymsp->TOP__agu_block__DOT__Wagu2_mod__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru) 
                                     >> 1U))) | (~ 
                                                 (1U 
                                                  | (IData)(vlSymsp->TOP__agu_block__DOT__Wagu2_mod__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru))))) 
                       << 1U)));
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__Wagu2_mod__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__2__KET____DOT__lru_mod__635(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__Wagu2_mod__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__2__KET____DOT__lru_mod__635\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->__PVT__hitAfter = (((IData)(this->__PVT__adders_gen__DOT__cmp_mod__DOT__C) 
                              >> 2U) & (2U != (IData)(vlSymsp->TOP__agu_block__DOT__Wagu2_mod__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru)));
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__Wagu2_mod__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__2__KET____DOT__lru_mod__731(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__Wagu2_mod__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__2__KET____DOT__lru_mod__731\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->newLRU__en = ((((((((2U == (IData)(vlSymsp->TOP__agu_block__DOT__Wagu2_mod__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru)) 
                              & (~ (IData)(vlSymsp->TOP__agu_block__DOT__Wagu2_mod__tlb_mod.__PVT__init))) 
                             & (IData)(vlSymsp->TOP__agu_block__DOT__Wagu2_mod__tlb_mod.__Vcellinp__ways_gen__BRA__0__KET____DOT__lru_mod__en))
                             ? 7U : 0U) | (IData)(this->newLRU__out__en2)) 
                          | (IData)(this->newLRU__out__en3)) 
                         | ((IData)(vlSymsp->TOP__agu_block__DOT__Wagu2_mod__tlb_mod.__PVT__init)
                             ? 7U : 0U)) | (IData)(this->newLRU__out__en5));
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__Wagu2_mod__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__3__KET____DOT__lru_mod__245(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__Wagu2_mod__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__3__KET____DOT__lru_mod__245\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->__PVT__adders_gen__DOT__cmp_mod__DOT__G1 
        = (4U & (IData)(vlSymsp->TOP__agu_block__DOT__Wagu2_mod__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru));
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__Wagu2_mod__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__3__KET____DOT__lru_mod__286(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__Wagu2_mod__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__3__KET____DOT__lru_mod__286\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->__PVT__adders_gen__DOT__cmp_mod__DOT__P1 
        = ((6U & ((~ ((~ (2U | ((IData)(vlSymsp->TOP__agu_block__DOT__Wagu2_mod__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru) 
                                >> 1U))) | (~ (IData)(vlSymsp->TOP__agu_block__DOT__Wagu2_mod__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru)))) 
                  << 1U)) | (1U & (IData)(vlSymsp->TOP__agu_block__DOT__Wagu2_mod__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru)));
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__Wagu2_mod__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__3__KET____DOT__lru_mod__636(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__Wagu2_mod__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__3__KET____DOT__lru_mod__636\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->__PVT__hitAfter = (((IData)(this->__PVT__adders_gen__DOT__cmp_mod__DOT__C) 
                              >> 2U) & (3U != (IData)(vlSymsp->TOP__agu_block__DOT__Wagu2_mod__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru)));
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__Wagu2_mod__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__3__KET____DOT__lru_mod__732(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__Wagu2_mod__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__3__KET____DOT__lru_mod__732\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->newLRU__en = ((((((((3U == (IData)(vlSymsp->TOP__agu_block__DOT__Wagu2_mod__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru)) 
                              & (~ (IData)(vlSymsp->TOP__agu_block__DOT__Wagu2_mod__tlb_mod.__PVT__init))) 
                             & (IData)(vlSymsp->TOP__agu_block__DOT__Wagu2_mod__tlb_mod.__Vcellinp__ways_gen__BRA__0__KET____DOT__lru_mod__en))
                             ? 7U : 0U) | (IData)(this->newLRU__out__en2)) 
                          | (IData)(this->newLRU__out__en3)) 
                         | ((IData)(vlSymsp->TOP__agu_block__DOT__Wagu2_mod__tlb_mod.__PVT__init)
                             ? 7U : 0U)) | (IData)(this->newLRU__out__en5));
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__Wagu2_mod__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__4__KET____DOT__lru_mod__246(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__Wagu2_mod__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__4__KET____DOT__lru_mod__246\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->__PVT__adders_gen__DOT__cmp_mod__DOT__G1 
        = ((6U & ((~ (((~ (1U | ((IData)(vlSymsp->TOP__agu_block__DOT__Wagu2_mod__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru) 
                                 >> 1U))) | (~ (IData)(vlSymsp->TOP__agu_block__DOT__Wagu2_mod__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru))) 
                      & (~ (1U & ((IData)(vlSymsp->TOP__agu_block__DOT__Wagu2_mod__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru) 
                                  >> 1U))))) << 1U)) 
           | (1U & (IData)(vlSymsp->TOP__agu_block__DOT__Wagu2_mod__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru)));
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__Wagu2_mod__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__4__KET____DOT__lru_mod__287(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__Wagu2_mod__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__4__KET____DOT__lru_mod__287\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->__PVT__adders_gen__DOT__cmp_mod__DOT__P1 
        = (1U | (6U & (2U | (0xfffffffeU & (IData)(vlSymsp->TOP__agu_block__DOT__Wagu2_mod__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru)))));
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__Wagu2_mod__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__4__KET____DOT__lru_mod__637(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__Wagu2_mod__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__4__KET____DOT__lru_mod__637\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->__PVT__hitAfter = (((IData)(this->__PVT__adders_gen__DOT__cmp_mod__DOT__C) 
                              >> 2U) & (4U != (IData)(vlSymsp->TOP__agu_block__DOT__Wagu2_mod__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru)));
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__Wagu2_mod__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__4__KET____DOT__lru_mod__733(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__Wagu2_mod__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__4__KET____DOT__lru_mod__733\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->newLRU__en = ((((((((4U == (IData)(vlSymsp->TOP__agu_block__DOT__Wagu2_mod__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru)) 
                              & (~ (IData)(vlSymsp->TOP__agu_block__DOT__Wagu2_mod__tlb_mod.__PVT__init))) 
                             & (IData)(vlSymsp->TOP__agu_block__DOT__Wagu2_mod__tlb_mod.__Vcellinp__ways_gen__BRA__0__KET____DOT__lru_mod__en))
                             ? 7U : 0U) | (IData)(this->newLRU__out__en2)) 
                          | (IData)(this->newLRU__out__en3)) 
                         | ((IData)(vlSymsp->TOP__agu_block__DOT__Wagu2_mod__tlb_mod.__PVT__init)
                             ? 7U : 0U)) | (IData)(this->newLRU__out__en5));
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__Wagu2_mod__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__5__KET____DOT__lru_mod__247(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__Wagu2_mod__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__5__KET____DOT__lru_mod__247\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->__PVT__adders_gen__DOT__cmp_mod__DOT__G1 
        = (6U & ((~ (((~ (1U | ((IData)(vlSymsp->TOP__agu_block__DOT__Wagu2_mod__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru) 
                                >> 1U))) | (~ (2U & (IData)(vlSymsp->TOP__agu_block__DOT__Wagu2_mod__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru)))) 
                     & (~ (1U & ((IData)(vlSymsp->TOP__agu_block__DOT__Wagu2_mod__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru) 
                                 >> 1U))))) << 1U));
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__Wagu2_mod__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__5__KET____DOT__lru_mod__288(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__Wagu2_mod__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__5__KET____DOT__lru_mod__288\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->__PVT__adders_gen__DOT__cmp_mod__DOT__P1 
        = ((6U & ((~ ((~ (1U | ((IData)(vlSymsp->TOP__agu_block__DOT__Wagu2_mod__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru) 
                                >> 1U))) | (~ (2U | (IData)(vlSymsp->TOP__agu_block__DOT__Wagu2_mod__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru))))) 
                  << 1U)) | (1U & (IData)(vlSymsp->TOP__agu_block__DOT__Wagu2_mod__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru)));
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__Wagu2_mod__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__5__KET____DOT__lru_mod__638(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__Wagu2_mod__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__5__KET____DOT__lru_mod__638\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->__PVT__hitAfter = (((IData)(this->__PVT__adders_gen__DOT__cmp_mod__DOT__C) 
                              >> 2U) & (5U != (IData)(vlSymsp->TOP__agu_block__DOT__Wagu2_mod__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru)));
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__Wagu2_mod__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__5__KET____DOT__lru_mod__734(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__Wagu2_mod__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__5__KET____DOT__lru_mod__734\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->newLRU__en = ((((((((5U == (IData)(vlSymsp->TOP__agu_block__DOT__Wagu2_mod__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru)) 
                              & (~ (IData)(vlSymsp->TOP__agu_block__DOT__Wagu2_mod__tlb_mod.__PVT__init))) 
                             & (IData)(vlSymsp->TOP__agu_block__DOT__Wagu2_mod__tlb_mod.__Vcellinp__ways_gen__BRA__0__KET____DOT__lru_mod__en))
                             ? 7U : 0U) | (IData)(this->newLRU__out__en2)) 
                          | (IData)(this->newLRU__out__en3)) 
                         | ((IData)(vlSymsp->TOP__agu_block__DOT__Wagu2_mod__tlb_mod.__PVT__init)
                             ? 7U : 0U)) | (IData)(this->newLRU__out__en5));
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__Wagu2_mod__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__6__KET____DOT__lru_mod__248(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__Wagu2_mod__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__6__KET____DOT__lru_mod__248\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->__PVT__adders_gen__DOT__cmp_mod__DOT__G1 
        = ((6U & ((~ ((~ ((IData)(vlSymsp->TOP__agu_block__DOT__Wagu2_mod__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru) 
                          >> 1U)) | (~ (1U & (IData)(vlSymsp->TOP__agu_block__DOT__Wagu2_mod__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru))))) 
                  << 1U)) | (1U & (IData)(vlSymsp->TOP__agu_block__DOT__Wagu2_mod__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru)));
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__Wagu2_mod__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__6__KET____DOT__lru_mod__289(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__Wagu2_mod__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__6__KET____DOT__lru_mod__289\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->__PVT__adders_gen__DOT__cmp_mod__DOT__P1 
        = (1U | (6U & ((~ ((~ ((IData)(vlSymsp->TOP__agu_block__DOT__Wagu2_mod__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru) 
                               >> 1U)) | (~ (1U | (IData)(vlSymsp->TOP__agu_block__DOT__Wagu2_mod__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru))))) 
                       << 1U)));
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__Wagu2_mod__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__6__KET____DOT__lru_mod__639(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__Wagu2_mod__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__6__KET____DOT__lru_mod__639\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->__PVT__hitAfter = (((IData)(this->__PVT__adders_gen__DOT__cmp_mod__DOT__C) 
                              >> 2U) & (6U != (IData)(vlSymsp->TOP__agu_block__DOT__Wagu2_mod__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru)));
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__Wagu2_mod__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__6__KET____DOT__lru_mod__735(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__Wagu2_mod__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__6__KET____DOT__lru_mod__735\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->newLRU__en = ((((((((6U == (IData)(vlSymsp->TOP__agu_block__DOT__Wagu2_mod__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru)) 
                              & (~ (IData)(vlSymsp->TOP__agu_block__DOT__Wagu2_mod__tlb_mod.__PVT__init))) 
                             & (IData)(vlSymsp->TOP__agu_block__DOT__Wagu2_mod__tlb_mod.__Vcellinp__ways_gen__BRA__0__KET____DOT__lru_mod__en))
                             ? 7U : 0U) | (IData)(this->newLRU__out__en2)) 
                          | (IData)(this->newLRU__out__en3)) 
                         | ((IData)(vlSymsp->TOP__agu_block__DOT__Wagu2_mod__tlb_mod.__PVT__init)
                             ? 7U : 0U)) | (IData)(this->newLRU__out__en5));
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__Wagu2_mod__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__7__KET____DOT__lru_mod__290(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__Wagu2_mod__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__7__KET____DOT__lru_mod__290\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->__PVT__adders_gen__DOT__cmp_mod__DOT__P1 
        = ((6U & ((~ ((~ ((IData)(vlSymsp->TOP__agu_block__DOT__Wagu2_mod__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru) 
                          >> 1U)) | (~ (IData)(vlSymsp->TOP__agu_block__DOT__Wagu2_mod__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru)))) 
                  << 1U)) | (1U & (IData)(vlSymsp->TOP__agu_block__DOT__Wagu2_mod__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru)));
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__Wagu2_mod__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__7__KET____DOT__lru_mod__640(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__Wagu2_mod__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__7__KET____DOT__lru_mod__640\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->__PVT__hitAfter = (((IData)(this->__PVT__adders_gen__DOT__cmp_mod__DOT__C) 
                              >> 2U) & (7U != (IData)(vlSymsp->TOP__agu_block__DOT__Wagu2_mod__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru)));
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__Wagu2_mod__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__7__KET____DOT__lru_mod__736(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__Wagu2_mod__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__7__KET____DOT__lru_mod__736\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->newLRU__en = ((((((((7U == (IData)(vlSymsp->TOP__agu_block__DOT__Wagu2_mod__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru)) 
                              & (~ (IData)(vlSymsp->TOP__agu_block__DOT__Wagu2_mod__tlb_mod.__PVT__init))) 
                             & (IData)(vlSymsp->TOP__agu_block__DOT__Wagu2_mod__tlb_mod.__Vcellinp__ways_gen__BRA__0__KET____DOT__lru_mod__en))
                             ? 7U : 0U) | (IData)(this->newLRU__out__en2)) 
                          | (IData)(this->newLRU__out__en3)) 
                         | ((IData)(vlSymsp->TOP__agu_block__DOT__Wagu2_mod__tlb_mod.__PVT__init)
                             ? 7U : 0U)) | (IData)(this->newLRU__out__en5));
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__agu0__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__0__KET____DOT__lru_mod__83(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__agu0__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__0__KET____DOT__lru_mod__83\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->adders_gen__DOT__inc_mod__DOT__out__out__out1 
        = ((6U & (IData)(this->adders_gen__DOT__inc_mod__DOT__out__out__out1)) 
           | (1U & (~ (IData)(vlSymsp->TOP__agu_block__DOT__agu0__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru))));
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__agu0__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__0__KET____DOT__lru_mod__131(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__agu0__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__0__KET____DOT__lru_mod__131\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->__PVT__adders_gen__DOT__inc_mod__DOT__nP1 
        = ((6U & ((~ (((IData)(vlSymsp->TOP__agu_block__DOT__agu0__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru) 
                       >> 1U) & (IData)(vlSymsp->TOP__agu_block__DOT__agu0__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru))) 
                  << 1U)) | (1U & (~ (IData)(vlSymsp->TOP__agu_block__DOT__agu0__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru))));
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__agu0__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__0__KET____DOT__lru_mod__203(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__agu0__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__0__KET____DOT__lru_mod__203\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->__pinNumber2__en0 = (7U & (((((1U & ((IData)(vlSymsp->TOP__agu_block__DOT__agu0__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru) 
                                               | (~ (IData)(vlSymsp->TOP__agu_block__DOT__agu0__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru)))) 
                                        | (2U & (IData)(vlSymsp->TOP__agu_block__DOT__agu0__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru))) 
                                       | (2U & ((~ 
                                                 ((IData)(vlSymsp->TOP__agu_block__DOT__agu0__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru) 
                                                  >> 1U)) 
                                                << 1U))) 
                                      | (4U & (IData)(vlSymsp->TOP__agu_block__DOT__agu0__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru))) 
                                     | (4U & ((~ ((IData)(vlSymsp->TOP__agu_block__DOT__agu0__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru) 
                                                  >> 2U)) 
                                              << 2U))));
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__agu0__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__0__KET____DOT__lru_mod__249(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__agu0__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__0__KET____DOT__lru_mod__249\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->__PVT__adders_gen__DOT__cmp_mod__DOT__G1 
        = ((6U & ((~ ((~ (IData)(vlSymsp->TOP__agu_block__DOT__agu0__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru)) 
                      & (~ ((IData)(vlSymsp->TOP__agu_block__DOT__agu0__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru) 
                            >> 1U)))) << 1U)) | (1U 
                                                 & (IData)(vlSymsp->TOP__agu_block__DOT__agu0__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru)));
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__agu0__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__0__KET____DOT__lru_mod__473(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__agu0__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__0__KET____DOT__lru_mod__473\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->adders_gen__DOT__inc_mod__DOT__out__out__out2 
        = ((5U & (IData)(this->adders_gen__DOT__inc_mod__DOT__out__out__out2)) 
           | (2U & ((IData)(vlSymsp->TOP__agu_block__DOT__agu0__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru) 
                    & ((~ (IData)(this->__PVT__adders_gen__DOT__inc_mod__DOT__P2)) 
                       << 1U))));
    this->adders_gen__DOT__inc_mod__DOT__out__out__out3 
        = ((5U & (IData)(this->adders_gen__DOT__inc_mod__DOT__out__out__out3)) 
           | (2U & (((~ ((IData)(vlSymsp->TOP__agu_block__DOT__agu0__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru) 
                         >> 1U)) & (IData)(this->__PVT__adders_gen__DOT__inc_mod__DOT__P2)) 
                    << 1U)));
    this->adders_gen__DOT__inc_mod__DOT__out__out__out4 
        = ((3U & (IData)(this->adders_gen__DOT__inc_mod__DOT__out__out__out4)) 
           | (4U & ((IData)(vlSymsp->TOP__agu_block__DOT__agu0__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru) 
                    & ((~ ((IData)(this->__PVT__adders_gen__DOT__inc_mod__DOT__P2) 
                           >> 1U)) << 2U))));
    this->adders_gen__DOT__inc_mod__DOT__out__out__out5 
        = ((3U & (IData)(this->adders_gen__DOT__inc_mod__DOT__out__out__out5)) 
           | (4U & (((~ ((IData)(vlSymsp->TOP__agu_block__DOT__agu0__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru) 
                         >> 2U)) << 2U) & ((IData)(this->__PVT__adders_gen__DOT__inc_mod__DOT__P2) 
                                           << 1U))));
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__agu0__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__0__KET____DOT__lru_mod__553(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__agu0__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__0__KET____DOT__lru_mod__553\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->newLRU__out__en5 = ((1U & ((~ (IData)(vlSymsp->TOP__agu_block__DOT__agu0__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__en)) 
                                     & (~ (IData)(vlSymsp->TOP__agu_block__DOT__agu0__tlb_mod.__PVT__init))))
                               ? 7U : 0U);
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__agu0__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__0__KET____DOT__lru_mod__641(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__agu0__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__0__KET____DOT__lru_mod__641\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->__PVT__hitAfter = (0U != (IData)(vlSymsp->TOP__agu_block__DOT__agu0__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru));
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__agu0__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__0__KET____DOT__lru_mod__689(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__agu0__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__0__KET____DOT__lru_mod__689\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->newLRU__out__en2 = ((((IData)(this->__PVT__hitAfter) 
                                & (~ (IData)(vlSymsp->TOP__agu_block__DOT__agu0__tlb_mod.__PVT__init))) 
                               & (IData)(vlSymsp->TOP__agu_block__DOT__agu0__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__en))
                               ? 7U : 0U);
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__agu0__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__0__KET____DOT__lru_mod__737(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__agu0__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__0__KET____DOT__lru_mod__737\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->newLRU__en = (((((((0U == (IData)(vlSymsp->TOP__agu_block__DOT__agu0__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru)) 
                             & (~ (IData)(vlSymsp->TOP__agu_block__DOT__agu0__tlb_mod.__PVT__init))) 
                            & (IData)(vlSymsp->TOP__agu_block__DOT__agu0__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__en))
                            ? 7U : 0U) | (IData)(this->newLRU__out__en2)) 
                         | ((IData)(vlSymsp->TOP__agu_block__DOT__agu0__tlb_mod.__PVT__init)
                             ? 7U : 0U)) | (IData)(this->newLRU__out__en5));
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__agu0__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__1__KET____DOT__lru_mod__250(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__agu0__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__1__KET____DOT__lru_mod__250\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->__PVT__adders_gen__DOT__cmp_mod__DOT__G1 
        = (6U & ((~ (((~ (3U | ((IData)(vlSymsp->TOP__agu_block__DOT__agu0__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru) 
                                >> 1U))) | (~ (2U & (IData)(vlSymsp->TOP__agu_block__DOT__agu0__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru)))) 
                     & (~ (3U & ((IData)(vlSymsp->TOP__agu_block__DOT__agu0__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru) 
                                 >> 1U))))) << 1U));
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__agu0__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__1__KET____DOT__lru_mod__291(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__agu0__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__1__KET____DOT__lru_mod__291\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->__PVT__adders_gen__DOT__cmp_mod__DOT__P1 
        = ((6U & ((~ ((~ (3U | ((IData)(vlSymsp->TOP__agu_block__DOT__agu0__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru) 
                                >> 1U))) | (~ (2U | (IData)(vlSymsp->TOP__agu_block__DOT__agu0__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru))))) 
                  << 1U)) | (1U & (IData)(vlSymsp->TOP__agu_block__DOT__agu0__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru)));
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__agu0__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__1__KET____DOT__lru_mod__594(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__agu0__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__1__KET____DOT__lru_mod__594\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->newLRU__out__en3 = ((((~ ((IData)(this->__PVT__adders_gen__DOT__cmp_mod__DOT__C) 
                                    >> 2U)) & (~ (IData)(vlSymsp->TOP__agu_block__DOT__agu0__tlb_mod.__PVT__init))) 
                               & (IData)(vlSymsp->TOP__agu_block__DOT__agu0__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__en))
                               ? (IData)(this->__pinNumber2__en0)
                               : 0U);
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__agu0__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__1__KET____DOT__lru_mod__642(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__agu0__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__1__KET____DOT__lru_mod__642\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->__PVT__hitAfter = (((IData)(this->__PVT__adders_gen__DOT__cmp_mod__DOT__C) 
                              >> 2U) & (1U != (IData)(vlSymsp->TOP__agu_block__DOT__agu0__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru)));
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__agu0__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__1__KET____DOT__lru_mod__738(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__agu0__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__1__KET____DOT__lru_mod__738\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->newLRU__en = ((((((((1U == (IData)(vlSymsp->TOP__agu_block__DOT__agu0__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru)) 
                              & (~ (IData)(vlSymsp->TOP__agu_block__DOT__agu0__tlb_mod.__PVT__init))) 
                             & (IData)(vlSymsp->TOP__agu_block__DOT__agu0__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__en))
                             ? 7U : 0U) | (IData)(this->newLRU__out__en2)) 
                          | (IData)(this->newLRU__out__en3)) 
                         | ((IData)(vlSymsp->TOP__agu_block__DOT__agu0__tlb_mod.__PVT__init)
                             ? 7U : 0U)) | (IData)(this->newLRU__out__en5));
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__agu0__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__2__KET____DOT__lru_mod__251(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__agu0__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__2__KET____DOT__lru_mod__251\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->__PVT__adders_gen__DOT__cmp_mod__DOT__G1 
        = ((6U & ((~ (((~ (2U | ((IData)(vlSymsp->TOP__agu_block__DOT__agu0__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru) 
                                 >> 1U))) | (~ (1U 
                                                & (IData)(vlSymsp->TOP__agu_block__DOT__agu0__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru)))) 
                      & (~ (2U & ((IData)(vlSymsp->TOP__agu_block__DOT__agu0__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru) 
                                  >> 1U))))) << 1U)) 
           | (1U & (IData)(vlSymsp->TOP__agu_block__DOT__agu0__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru)));
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__agu0__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__2__KET____DOT__lru_mod__292(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__agu0__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__2__KET____DOT__lru_mod__292\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->__PVT__adders_gen__DOT__cmp_mod__DOT__P1 
        = (1U | (6U & ((~ ((~ (2U | ((IData)(vlSymsp->TOP__agu_block__DOT__agu0__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru) 
                                     >> 1U))) | (~ 
                                                 (1U 
                                                  | (IData)(vlSymsp->TOP__agu_block__DOT__agu0__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru))))) 
                       << 1U)));
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__agu0__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__2__KET____DOT__lru_mod__643(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__agu0__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__2__KET____DOT__lru_mod__643\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->__PVT__hitAfter = (((IData)(this->__PVT__adders_gen__DOT__cmp_mod__DOT__C) 
                              >> 2U) & (2U != (IData)(vlSymsp->TOP__agu_block__DOT__agu0__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru)));
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__agu0__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__2__KET____DOT__lru_mod__739(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__agu0__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__2__KET____DOT__lru_mod__739\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->newLRU__en = ((((((((2U == (IData)(vlSymsp->TOP__agu_block__DOT__agu0__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru)) 
                              & (~ (IData)(vlSymsp->TOP__agu_block__DOT__agu0__tlb_mod.__PVT__init))) 
                             & (IData)(vlSymsp->TOP__agu_block__DOT__agu0__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__en))
                             ? 7U : 0U) | (IData)(this->newLRU__out__en2)) 
                          | (IData)(this->newLRU__out__en3)) 
                         | ((IData)(vlSymsp->TOP__agu_block__DOT__agu0__tlb_mod.__PVT__init)
                             ? 7U : 0U)) | (IData)(this->newLRU__out__en5));
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__agu0__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__3__KET____DOT__lru_mod__252(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__agu0__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__3__KET____DOT__lru_mod__252\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->__PVT__adders_gen__DOT__cmp_mod__DOT__G1 
        = (4U & (IData)(vlSymsp->TOP__agu_block__DOT__agu0__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru));
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__agu0__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__3__KET____DOT__lru_mod__293(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__agu0__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__3__KET____DOT__lru_mod__293\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->__PVT__adders_gen__DOT__cmp_mod__DOT__P1 
        = ((6U & ((~ ((~ (2U | ((IData)(vlSymsp->TOP__agu_block__DOT__agu0__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru) 
                                >> 1U))) | (~ (IData)(vlSymsp->TOP__agu_block__DOT__agu0__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru)))) 
                  << 1U)) | (1U & (IData)(vlSymsp->TOP__agu_block__DOT__agu0__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru)));
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__agu0__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__3__KET____DOT__lru_mod__644(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__agu0__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__3__KET____DOT__lru_mod__644\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->__PVT__hitAfter = (((IData)(this->__PVT__adders_gen__DOT__cmp_mod__DOT__C) 
                              >> 2U) & (3U != (IData)(vlSymsp->TOP__agu_block__DOT__agu0__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru)));
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__agu0__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__3__KET____DOT__lru_mod__740(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__agu0__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__3__KET____DOT__lru_mod__740\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->newLRU__en = ((((((((3U == (IData)(vlSymsp->TOP__agu_block__DOT__agu0__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru)) 
                              & (~ (IData)(vlSymsp->TOP__agu_block__DOT__agu0__tlb_mod.__PVT__init))) 
                             & (IData)(vlSymsp->TOP__agu_block__DOT__agu0__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__en))
                             ? 7U : 0U) | (IData)(this->newLRU__out__en2)) 
                          | (IData)(this->newLRU__out__en3)) 
                         | ((IData)(vlSymsp->TOP__agu_block__DOT__agu0__tlb_mod.__PVT__init)
                             ? 7U : 0U)) | (IData)(this->newLRU__out__en5));
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__agu0__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__4__KET____DOT__lru_mod__253(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__agu0__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__4__KET____DOT__lru_mod__253\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->__PVT__adders_gen__DOT__cmp_mod__DOT__G1 
        = ((6U & ((~ (((~ (1U | ((IData)(vlSymsp->TOP__agu_block__DOT__agu0__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru) 
                                 >> 1U))) | (~ (IData)(vlSymsp->TOP__agu_block__DOT__agu0__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru))) 
                      & (~ (1U & ((IData)(vlSymsp->TOP__agu_block__DOT__agu0__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru) 
                                  >> 1U))))) << 1U)) 
           | (1U & (IData)(vlSymsp->TOP__agu_block__DOT__agu0__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru)));
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__agu0__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__4__KET____DOT__lru_mod__294(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__agu0__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__4__KET____DOT__lru_mod__294\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->__PVT__adders_gen__DOT__cmp_mod__DOT__P1 
        = (1U | (6U & (2U | (0xfffffffeU & (IData)(vlSymsp->TOP__agu_block__DOT__agu0__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru)))));
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__agu0__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__4__KET____DOT__lru_mod__645(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__agu0__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__4__KET____DOT__lru_mod__645\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->__PVT__hitAfter = (((IData)(this->__PVT__adders_gen__DOT__cmp_mod__DOT__C) 
                              >> 2U) & (4U != (IData)(vlSymsp->TOP__agu_block__DOT__agu0__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru)));
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__agu0__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__4__KET____DOT__lru_mod__741(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__agu0__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__4__KET____DOT__lru_mod__741\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->newLRU__en = ((((((((4U == (IData)(vlSymsp->TOP__agu_block__DOT__agu0__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru)) 
                              & (~ (IData)(vlSymsp->TOP__agu_block__DOT__agu0__tlb_mod.__PVT__init))) 
                             & (IData)(vlSymsp->TOP__agu_block__DOT__agu0__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__en))
                             ? 7U : 0U) | (IData)(this->newLRU__out__en2)) 
                          | (IData)(this->newLRU__out__en3)) 
                         | ((IData)(vlSymsp->TOP__agu_block__DOT__agu0__tlb_mod.__PVT__init)
                             ? 7U : 0U)) | (IData)(this->newLRU__out__en5));
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__agu0__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__5__KET____DOT__lru_mod__254(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__agu0__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__5__KET____DOT__lru_mod__254\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->__PVT__adders_gen__DOT__cmp_mod__DOT__G1 
        = (6U & ((~ (((~ (1U | ((IData)(vlSymsp->TOP__agu_block__DOT__agu0__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru) 
                                >> 1U))) | (~ (2U & (IData)(vlSymsp->TOP__agu_block__DOT__agu0__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru)))) 
                     & (~ (1U & ((IData)(vlSymsp->TOP__agu_block__DOT__agu0__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru) 
                                 >> 1U))))) << 1U));
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__agu0__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__5__KET____DOT__lru_mod__295(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__agu0__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__5__KET____DOT__lru_mod__295\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->__PVT__adders_gen__DOT__cmp_mod__DOT__P1 
        = ((6U & ((~ ((~ (1U | ((IData)(vlSymsp->TOP__agu_block__DOT__agu0__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru) 
                                >> 1U))) | (~ (2U | (IData)(vlSymsp->TOP__agu_block__DOT__agu0__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru))))) 
                  << 1U)) | (1U & (IData)(vlSymsp->TOP__agu_block__DOT__agu0__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru)));
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__agu0__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__5__KET____DOT__lru_mod__646(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__agu0__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__5__KET____DOT__lru_mod__646\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->__PVT__hitAfter = (((IData)(this->__PVT__adders_gen__DOT__cmp_mod__DOT__C) 
                              >> 2U) & (5U != (IData)(vlSymsp->TOP__agu_block__DOT__agu0__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru)));
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__agu0__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__5__KET____DOT__lru_mod__742(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__agu0__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__5__KET____DOT__lru_mod__742\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->newLRU__en = ((((((((5U == (IData)(vlSymsp->TOP__agu_block__DOT__agu0__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru)) 
                              & (~ (IData)(vlSymsp->TOP__agu_block__DOT__agu0__tlb_mod.__PVT__init))) 
                             & (IData)(vlSymsp->TOP__agu_block__DOT__agu0__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__en))
                             ? 7U : 0U) | (IData)(this->newLRU__out__en2)) 
                          | (IData)(this->newLRU__out__en3)) 
                         | ((IData)(vlSymsp->TOP__agu_block__DOT__agu0__tlb_mod.__PVT__init)
                             ? 7U : 0U)) | (IData)(this->newLRU__out__en5));
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__agu0__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__6__KET____DOT__lru_mod__255(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__agu0__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__6__KET____DOT__lru_mod__255\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->__PVT__adders_gen__DOT__cmp_mod__DOT__G1 
        = ((6U & ((~ ((~ ((IData)(vlSymsp->TOP__agu_block__DOT__agu0__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru) 
                          >> 1U)) | (~ (1U & (IData)(vlSymsp->TOP__agu_block__DOT__agu0__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru))))) 
                  << 1U)) | (1U & (IData)(vlSymsp->TOP__agu_block__DOT__agu0__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru)));
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__agu0__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__6__KET____DOT__lru_mod__296(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__agu0__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__6__KET____DOT__lru_mod__296\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->__PVT__adders_gen__DOT__cmp_mod__DOT__P1 
        = (1U | (6U & ((~ ((~ ((IData)(vlSymsp->TOP__agu_block__DOT__agu0__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru) 
                               >> 1U)) | (~ (1U | (IData)(vlSymsp->TOP__agu_block__DOT__agu0__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru))))) 
                       << 1U)));
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__agu0__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__6__KET____DOT__lru_mod__647(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__agu0__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__6__KET____DOT__lru_mod__647\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->__PVT__hitAfter = (((IData)(this->__PVT__adders_gen__DOT__cmp_mod__DOT__C) 
                              >> 2U) & (6U != (IData)(vlSymsp->TOP__agu_block__DOT__agu0__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru)));
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__agu0__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__6__KET____DOT__lru_mod__743(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__agu0__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__6__KET____DOT__lru_mod__743\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->newLRU__en = ((((((((6U == (IData)(vlSymsp->TOP__agu_block__DOT__agu0__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru)) 
                              & (~ (IData)(vlSymsp->TOP__agu_block__DOT__agu0__tlb_mod.__PVT__init))) 
                             & (IData)(vlSymsp->TOP__agu_block__DOT__agu0__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__en))
                             ? 7U : 0U) | (IData)(this->newLRU__out__en2)) 
                          | (IData)(this->newLRU__out__en3)) 
                         | ((IData)(vlSymsp->TOP__agu_block__DOT__agu0__tlb_mod.__PVT__init)
                             ? 7U : 0U)) | (IData)(this->newLRU__out__en5));
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__agu0__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__7__KET____DOT__lru_mod__297(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__agu0__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__7__KET____DOT__lru_mod__297\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->__PVT__adders_gen__DOT__cmp_mod__DOT__P1 
        = ((6U & ((~ ((~ ((IData)(vlSymsp->TOP__agu_block__DOT__agu0__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru) 
                          >> 1U)) | (~ (IData)(vlSymsp->TOP__agu_block__DOT__agu0__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru)))) 
                  << 1U)) | (1U & (IData)(vlSymsp->TOP__agu_block__DOT__agu0__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru)));
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__agu0__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__7__KET____DOT__lru_mod__648(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__agu0__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__7__KET____DOT__lru_mod__648\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->__PVT__hitAfter = (((IData)(this->__PVT__adders_gen__DOT__cmp_mod__DOT__C) 
                              >> 2U) & (7U != (IData)(vlSymsp->TOP__agu_block__DOT__agu0__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru)));
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__agu0__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__7__KET____DOT__lru_mod__744(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__agu0__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__7__KET____DOT__lru_mod__744\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->newLRU__en = ((((((((7U == (IData)(vlSymsp->TOP__agu_block__DOT__agu0__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru)) 
                              & (~ (IData)(vlSymsp->TOP__agu_block__DOT__agu0__tlb_mod.__PVT__init))) 
                             & (IData)(vlSymsp->TOP__agu_block__DOT__agu0__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__en))
                             ? 7U : 0U) | (IData)(this->newLRU__out__en2)) 
                          | (IData)(this->newLRU__out__en3)) 
                         | ((IData)(vlSymsp->TOP__agu_block__DOT__agu0__tlb_mod.__PVT__init)
                             ? 7U : 0U)) | (IData)(this->newLRU__out__en5));
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__agu2__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__0__KET____DOT__lru_mod__91(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__agu2__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__0__KET____DOT__lru_mod__91\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->adders_gen__DOT__inc_mod__DOT__out__out__out1 
        = ((6U & (IData)(this->adders_gen__DOT__inc_mod__DOT__out__out__out1)) 
           | (1U & (~ (IData)(vlSymsp->TOP__agu_block__DOT__agu2__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru))));
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__agu2__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__0__KET____DOT__lru_mod__139(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__agu2__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__0__KET____DOT__lru_mod__139\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->__PVT__adders_gen__DOT__inc_mod__DOT__nP1 
        = ((6U & ((~ (((IData)(vlSymsp->TOP__agu_block__DOT__agu2__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru) 
                       >> 1U) & (IData)(vlSymsp->TOP__agu_block__DOT__agu2__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru))) 
                  << 1U)) | (1U & (~ (IData)(vlSymsp->TOP__agu_block__DOT__agu2__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru))));
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__agu2__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__0__KET____DOT__lru_mod__211(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__agu2__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__0__KET____DOT__lru_mod__211\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->__pinNumber2__en0 = (7U & (((((1U & ((IData)(vlSymsp->TOP__agu_block__DOT__agu2__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru) 
                                               | (~ (IData)(vlSymsp->TOP__agu_block__DOT__agu2__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru)))) 
                                        | (2U & (IData)(vlSymsp->TOP__agu_block__DOT__agu2__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru))) 
                                       | (2U & ((~ 
                                                 ((IData)(vlSymsp->TOP__agu_block__DOT__agu2__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru) 
                                                  >> 1U)) 
                                                << 1U))) 
                                      | (4U & (IData)(vlSymsp->TOP__agu_block__DOT__agu2__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru))) 
                                     | (4U & ((~ ((IData)(vlSymsp->TOP__agu_block__DOT__agu2__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru) 
                                                  >> 2U)) 
                                              << 2U))));
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__agu2__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__0__KET____DOT__lru_mod__256(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__agu2__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__0__KET____DOT__lru_mod__256\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->__PVT__adders_gen__DOT__cmp_mod__DOT__G1 
        = ((6U & ((~ ((~ (IData)(vlSymsp->TOP__agu_block__DOT__agu2__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru)) 
                      & (~ ((IData)(vlSymsp->TOP__agu_block__DOT__agu2__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru) 
                            >> 1U)))) << 1U)) | (1U 
                                                 & (IData)(vlSymsp->TOP__agu_block__DOT__agu2__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru)));
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__agu2__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__0__KET____DOT__lru_mod__481(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__agu2__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__0__KET____DOT__lru_mod__481\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->adders_gen__DOT__inc_mod__DOT__out__out__out2 
        = ((5U & (IData)(this->adders_gen__DOT__inc_mod__DOT__out__out__out2)) 
           | (2U & ((IData)(vlSymsp->TOP__agu_block__DOT__agu2__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru) 
                    & ((~ (IData)(this->__PVT__adders_gen__DOT__inc_mod__DOT__P2)) 
                       << 1U))));
    this->adders_gen__DOT__inc_mod__DOT__out__out__out3 
        = ((5U & (IData)(this->adders_gen__DOT__inc_mod__DOT__out__out__out3)) 
           | (2U & (((~ ((IData)(vlSymsp->TOP__agu_block__DOT__agu2__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru) 
                         >> 1U)) & (IData)(this->__PVT__adders_gen__DOT__inc_mod__DOT__P2)) 
                    << 1U)));
    this->adders_gen__DOT__inc_mod__DOT__out__out__out4 
        = ((3U & (IData)(this->adders_gen__DOT__inc_mod__DOT__out__out__out4)) 
           | (4U & ((IData)(vlSymsp->TOP__agu_block__DOT__agu2__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru) 
                    & ((~ ((IData)(this->__PVT__adders_gen__DOT__inc_mod__DOT__P2) 
                           >> 1U)) << 2U))));
    this->adders_gen__DOT__inc_mod__DOT__out__out__out5 
        = ((3U & (IData)(this->adders_gen__DOT__inc_mod__DOT__out__out__out5)) 
           | (4U & (((~ ((IData)(vlSymsp->TOP__agu_block__DOT__agu2__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru) 
                         >> 2U)) << 2U) & ((IData)(this->__PVT__adders_gen__DOT__inc_mod__DOT__P2) 
                                           << 1U))));
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__agu2__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__0__KET____DOT__lru_mod__561(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__agu2__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__0__KET____DOT__lru_mod__561\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->newLRU__out__en5 = ((1U & ((~ (IData)(vlSymsp->TOP__agu_block__DOT__agu2__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__en)) 
                                     & (~ (IData)(vlSymsp->TOP__agu_block__DOT__agu2__tlb_mod.__PVT__init))))
                               ? 7U : 0U);
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__agu2__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__0__KET____DOT__lru_mod__649(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__agu2__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__0__KET____DOT__lru_mod__649\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->__PVT__hitAfter = (0U != (IData)(vlSymsp->TOP__agu_block__DOT__agu2__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru));
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__agu2__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__0__KET____DOT__lru_mod__697(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__agu2__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__0__KET____DOT__lru_mod__697\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->newLRU__out__en2 = ((((IData)(this->__PVT__hitAfter) 
                                & (~ (IData)(vlSymsp->TOP__agu_block__DOT__agu2__tlb_mod.__PVT__init))) 
                               & (IData)(vlSymsp->TOP__agu_block__DOT__agu2__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__en))
                               ? 7U : 0U);
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__agu2__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__0__KET____DOT__lru_mod__745(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__agu2__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__0__KET____DOT__lru_mod__745\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->newLRU__en = (((((((0U == (IData)(vlSymsp->TOP__agu_block__DOT__agu2__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru)) 
                             & (~ (IData)(vlSymsp->TOP__agu_block__DOT__agu2__tlb_mod.__PVT__init))) 
                            & (IData)(vlSymsp->TOP__agu_block__DOT__agu2__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__en))
                            ? 7U : 0U) | (IData)(this->newLRU__out__en2)) 
                         | ((IData)(vlSymsp->TOP__agu_block__DOT__agu2__tlb_mod.__PVT__init)
                             ? 7U : 0U)) | (IData)(this->newLRU__out__en5));
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__agu2__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__1__KET____DOT__lru_mod__257(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__agu2__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__1__KET____DOT__lru_mod__257\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->__PVT__adders_gen__DOT__cmp_mod__DOT__G1 
        = (6U & ((~ (((~ (3U | ((IData)(vlSymsp->TOP__agu_block__DOT__agu2__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru) 
                                >> 1U))) | (~ (2U & (IData)(vlSymsp->TOP__agu_block__DOT__agu2__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru)))) 
                     & (~ (3U & ((IData)(vlSymsp->TOP__agu_block__DOT__agu2__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru) 
                                 >> 1U))))) << 1U));
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__agu2__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__1__KET____DOT__lru_mod__298(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__agu2__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__1__KET____DOT__lru_mod__298\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->__PVT__adders_gen__DOT__cmp_mod__DOT__P1 
        = ((6U & ((~ ((~ (3U | ((IData)(vlSymsp->TOP__agu_block__DOT__agu2__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru) 
                                >> 1U))) | (~ (2U | (IData)(vlSymsp->TOP__agu_block__DOT__agu2__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru))))) 
                  << 1U)) | (1U & (IData)(vlSymsp->TOP__agu_block__DOT__agu2__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru)));
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__agu2__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__1__KET____DOT__lru_mod__602(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__agu2__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__1__KET____DOT__lru_mod__602\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->newLRU__out__en3 = ((((~ ((IData)(this->__PVT__adders_gen__DOT__cmp_mod__DOT__C) 
                                    >> 2U)) & (~ (IData)(vlSymsp->TOP__agu_block__DOT__agu2__tlb_mod.__PVT__init))) 
                               & (IData)(vlSymsp->TOP__agu_block__DOT__agu2__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__en))
                               ? (IData)(this->__pinNumber2__en0)
                               : 0U);
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__agu2__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__1__KET____DOT__lru_mod__650(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__agu2__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__1__KET____DOT__lru_mod__650\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->__PVT__hitAfter = (((IData)(this->__PVT__adders_gen__DOT__cmp_mod__DOT__C) 
                              >> 2U) & (1U != (IData)(vlSymsp->TOP__agu_block__DOT__agu2__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru)));
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__agu2__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__1__KET____DOT__lru_mod__746(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__agu2__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__1__KET____DOT__lru_mod__746\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->newLRU__en = ((((((((1U == (IData)(vlSymsp->TOP__agu_block__DOT__agu2__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru)) 
                              & (~ (IData)(vlSymsp->TOP__agu_block__DOT__agu2__tlb_mod.__PVT__init))) 
                             & (IData)(vlSymsp->TOP__agu_block__DOT__agu2__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__en))
                             ? 7U : 0U) | (IData)(this->newLRU__out__en2)) 
                          | (IData)(this->newLRU__out__en3)) 
                         | ((IData)(vlSymsp->TOP__agu_block__DOT__agu2__tlb_mod.__PVT__init)
                             ? 7U : 0U)) | (IData)(this->newLRU__out__en5));
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__agu2__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__2__KET____DOT__lru_mod__258(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__agu2__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__2__KET____DOT__lru_mod__258\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->__PVT__adders_gen__DOT__cmp_mod__DOT__G1 
        = ((6U & ((~ (((~ (2U | ((IData)(vlSymsp->TOP__agu_block__DOT__agu2__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru) 
                                 >> 1U))) | (~ (1U 
                                                & (IData)(vlSymsp->TOP__agu_block__DOT__agu2__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru)))) 
                      & (~ (2U & ((IData)(vlSymsp->TOP__agu_block__DOT__agu2__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru) 
                                  >> 1U))))) << 1U)) 
           | (1U & (IData)(vlSymsp->TOP__agu_block__DOT__agu2__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru)));
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__agu2__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__2__KET____DOT__lru_mod__299(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__agu2__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__2__KET____DOT__lru_mod__299\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->__PVT__adders_gen__DOT__cmp_mod__DOT__P1 
        = (1U | (6U & ((~ ((~ (2U | ((IData)(vlSymsp->TOP__agu_block__DOT__agu2__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru) 
                                     >> 1U))) | (~ 
                                                 (1U 
                                                  | (IData)(vlSymsp->TOP__agu_block__DOT__agu2__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru))))) 
                       << 1U)));
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__agu2__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__2__KET____DOT__lru_mod__651(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__agu2__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__2__KET____DOT__lru_mod__651\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->__PVT__hitAfter = (((IData)(this->__PVT__adders_gen__DOT__cmp_mod__DOT__C) 
                              >> 2U) & (2U != (IData)(vlSymsp->TOP__agu_block__DOT__agu2__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru)));
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__agu2__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__2__KET____DOT__lru_mod__747(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__agu2__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__2__KET____DOT__lru_mod__747\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->newLRU__en = ((((((((2U == (IData)(vlSymsp->TOP__agu_block__DOT__agu2__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru)) 
                              & (~ (IData)(vlSymsp->TOP__agu_block__DOT__agu2__tlb_mod.__PVT__init))) 
                             & (IData)(vlSymsp->TOP__agu_block__DOT__agu2__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__en))
                             ? 7U : 0U) | (IData)(this->newLRU__out__en2)) 
                          | (IData)(this->newLRU__out__en3)) 
                         | ((IData)(vlSymsp->TOP__agu_block__DOT__agu2__tlb_mod.__PVT__init)
                             ? 7U : 0U)) | (IData)(this->newLRU__out__en5));
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__agu2__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__3__KET____DOT__lru_mod__259(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__agu2__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__3__KET____DOT__lru_mod__259\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->__PVT__adders_gen__DOT__cmp_mod__DOT__G1 
        = (4U & (IData)(vlSymsp->TOP__agu_block__DOT__agu2__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru));
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__agu2__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__3__KET____DOT__lru_mod__300(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__agu2__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__3__KET____DOT__lru_mod__300\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->__PVT__adders_gen__DOT__cmp_mod__DOT__P1 
        = ((6U & ((~ ((~ (2U | ((IData)(vlSymsp->TOP__agu_block__DOT__agu2__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru) 
                                >> 1U))) | (~ (IData)(vlSymsp->TOP__agu_block__DOT__agu2__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru)))) 
                  << 1U)) | (1U & (IData)(vlSymsp->TOP__agu_block__DOT__agu2__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru)));
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__agu2__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__3__KET____DOT__lru_mod__652(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__agu2__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__3__KET____DOT__lru_mod__652\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->__PVT__hitAfter = (((IData)(this->__PVT__adders_gen__DOT__cmp_mod__DOT__C) 
                              >> 2U) & (3U != (IData)(vlSymsp->TOP__agu_block__DOT__agu2__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru)));
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__agu2__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__3__KET____DOT__lru_mod__748(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__agu2__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__3__KET____DOT__lru_mod__748\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->newLRU__en = ((((((((3U == (IData)(vlSymsp->TOP__agu_block__DOT__agu2__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru)) 
                              & (~ (IData)(vlSymsp->TOP__agu_block__DOT__agu2__tlb_mod.__PVT__init))) 
                             & (IData)(vlSymsp->TOP__agu_block__DOT__agu2__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__en))
                             ? 7U : 0U) | (IData)(this->newLRU__out__en2)) 
                          | (IData)(this->newLRU__out__en3)) 
                         | ((IData)(vlSymsp->TOP__agu_block__DOT__agu2__tlb_mod.__PVT__init)
                             ? 7U : 0U)) | (IData)(this->newLRU__out__en5));
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__agu2__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__4__KET____DOT__lru_mod__260(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__agu2__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__4__KET____DOT__lru_mod__260\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->__PVT__adders_gen__DOT__cmp_mod__DOT__G1 
        = ((6U & ((~ (((~ (1U | ((IData)(vlSymsp->TOP__agu_block__DOT__agu2__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru) 
                                 >> 1U))) | (~ (IData)(vlSymsp->TOP__agu_block__DOT__agu2__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru))) 
                      & (~ (1U & ((IData)(vlSymsp->TOP__agu_block__DOT__agu2__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru) 
                                  >> 1U))))) << 1U)) 
           | (1U & (IData)(vlSymsp->TOP__agu_block__DOT__agu2__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru)));
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__agu2__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__4__KET____DOT__lru_mod__301(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__agu2__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__4__KET____DOT__lru_mod__301\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->__PVT__adders_gen__DOT__cmp_mod__DOT__P1 
        = (1U | (6U & (2U | (0xfffffffeU & (IData)(vlSymsp->TOP__agu_block__DOT__agu2__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru)))));
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__agu2__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__4__KET____DOT__lru_mod__653(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__agu2__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__4__KET____DOT__lru_mod__653\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->__PVT__hitAfter = (((IData)(this->__PVT__adders_gen__DOT__cmp_mod__DOT__C) 
                              >> 2U) & (4U != (IData)(vlSymsp->TOP__agu_block__DOT__agu2__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru)));
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__agu2__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__4__KET____DOT__lru_mod__749(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__agu2__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__4__KET____DOT__lru_mod__749\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->newLRU__en = ((((((((4U == (IData)(vlSymsp->TOP__agu_block__DOT__agu2__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru)) 
                              & (~ (IData)(vlSymsp->TOP__agu_block__DOT__agu2__tlb_mod.__PVT__init))) 
                             & (IData)(vlSymsp->TOP__agu_block__DOT__agu2__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__en))
                             ? 7U : 0U) | (IData)(this->newLRU__out__en2)) 
                          | (IData)(this->newLRU__out__en3)) 
                         | ((IData)(vlSymsp->TOP__agu_block__DOT__agu2__tlb_mod.__PVT__init)
                             ? 7U : 0U)) | (IData)(this->newLRU__out__en5));
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__agu2__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__5__KET____DOT__lru_mod__261(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__agu2__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__5__KET____DOT__lru_mod__261\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->__PVT__adders_gen__DOT__cmp_mod__DOT__G1 
        = (6U & ((~ (((~ (1U | ((IData)(vlSymsp->TOP__agu_block__DOT__agu2__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru) 
                                >> 1U))) | (~ (2U & (IData)(vlSymsp->TOP__agu_block__DOT__agu2__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru)))) 
                     & (~ (1U & ((IData)(vlSymsp->TOP__agu_block__DOT__agu2__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru) 
                                 >> 1U))))) << 1U));
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__agu2__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__5__KET____DOT__lru_mod__302(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__agu2__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__5__KET____DOT__lru_mod__302\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->__PVT__adders_gen__DOT__cmp_mod__DOT__P1 
        = ((6U & ((~ ((~ (1U | ((IData)(vlSymsp->TOP__agu_block__DOT__agu2__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru) 
                                >> 1U))) | (~ (2U | (IData)(vlSymsp->TOP__agu_block__DOT__agu2__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru))))) 
                  << 1U)) | (1U & (IData)(vlSymsp->TOP__agu_block__DOT__agu2__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru)));
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__agu2__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__5__KET____DOT__lru_mod__654(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__agu2__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__5__KET____DOT__lru_mod__654\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->__PVT__hitAfter = (((IData)(this->__PVT__adders_gen__DOT__cmp_mod__DOT__C) 
                              >> 2U) & (5U != (IData)(vlSymsp->TOP__agu_block__DOT__agu2__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru)));
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__agu2__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__5__KET____DOT__lru_mod__750(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__agu2__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__5__KET____DOT__lru_mod__750\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->newLRU__en = ((((((((5U == (IData)(vlSymsp->TOP__agu_block__DOT__agu2__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru)) 
                              & (~ (IData)(vlSymsp->TOP__agu_block__DOT__agu2__tlb_mod.__PVT__init))) 
                             & (IData)(vlSymsp->TOP__agu_block__DOT__agu2__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__en))
                             ? 7U : 0U) | (IData)(this->newLRU__out__en2)) 
                          | (IData)(this->newLRU__out__en3)) 
                         | ((IData)(vlSymsp->TOP__agu_block__DOT__agu2__tlb_mod.__PVT__init)
                             ? 7U : 0U)) | (IData)(this->newLRU__out__en5));
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__agu2__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__6__KET____DOT__lru_mod__262(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__agu2__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__6__KET____DOT__lru_mod__262\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->__PVT__adders_gen__DOT__cmp_mod__DOT__G1 
        = ((6U & ((~ ((~ ((IData)(vlSymsp->TOP__agu_block__DOT__agu2__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru) 
                          >> 1U)) | (~ (1U & (IData)(vlSymsp->TOP__agu_block__DOT__agu2__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru))))) 
                  << 1U)) | (1U & (IData)(vlSymsp->TOP__agu_block__DOT__agu2__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru)));
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__agu2__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__6__KET____DOT__lru_mod__303(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__agu2__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__6__KET____DOT__lru_mod__303\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->__PVT__adders_gen__DOT__cmp_mod__DOT__P1 
        = (1U | (6U & ((~ ((~ ((IData)(vlSymsp->TOP__agu_block__DOT__agu2__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru) 
                               >> 1U)) | (~ (1U | (IData)(vlSymsp->TOP__agu_block__DOT__agu2__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru))))) 
                       << 1U)));
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__agu2__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__6__KET____DOT__lru_mod__655(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__agu2__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__6__KET____DOT__lru_mod__655\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->__PVT__hitAfter = (((IData)(this->__PVT__adders_gen__DOT__cmp_mod__DOT__C) 
                              >> 2U) & (6U != (IData)(vlSymsp->TOP__agu_block__DOT__agu2__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru)));
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__agu2__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__6__KET____DOT__lru_mod__751(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__agu2__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__6__KET____DOT__lru_mod__751\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->newLRU__en = ((((((((6U == (IData)(vlSymsp->TOP__agu_block__DOT__agu2__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru)) 
                              & (~ (IData)(vlSymsp->TOP__agu_block__DOT__agu2__tlb_mod.__PVT__init))) 
                             & (IData)(vlSymsp->TOP__agu_block__DOT__agu2__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__en))
                             ? 7U : 0U) | (IData)(this->newLRU__out__en2)) 
                          | (IData)(this->newLRU__out__en3)) 
                         | ((IData)(vlSymsp->TOP__agu_block__DOT__agu2__tlb_mod.__PVT__init)
                             ? 7U : 0U)) | (IData)(this->newLRU__out__en5));
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__agu2__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__7__KET____DOT__lru_mod__304(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__agu2__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__7__KET____DOT__lru_mod__304\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->__PVT__adders_gen__DOT__cmp_mod__DOT__P1 
        = ((6U & ((~ ((~ ((IData)(vlSymsp->TOP__agu_block__DOT__agu2__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru) 
                          >> 1U)) | (~ (IData)(vlSymsp->TOP__agu_block__DOT__agu2__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru)))) 
                  << 1U)) | (1U & (IData)(vlSymsp->TOP__agu_block__DOT__agu2__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru)));
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__agu2__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__7__KET____DOT__lru_mod__656(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__agu2__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__7__KET____DOT__lru_mod__656\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->__PVT__hitAfter = (((IData)(this->__PVT__adders_gen__DOT__cmp_mod__DOT__C) 
                              >> 2U) & (7U != (IData)(vlSymsp->TOP__agu_block__DOT__agu2__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru)));
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__agu2__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__7__KET____DOT__lru_mod__752(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__agu2__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__7__KET____DOT__lru_mod__752\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->newLRU__en = ((((((((7U == (IData)(vlSymsp->TOP__agu_block__DOT__agu2__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru)) 
                              & (~ (IData)(vlSymsp->TOP__agu_block__DOT__agu2__tlb_mod.__PVT__init))) 
                             & (IData)(vlSymsp->TOP__agu_block__DOT__agu2__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__en))
                             ? 7U : 0U) | (IData)(this->newLRU__out__en2)) 
                          | (IData)(this->newLRU__out__en3)) 
                         | ((IData)(vlSymsp->TOP__agu_block__DOT__agu2__tlb_mod.__PVT__init)
                             ? 7U : 0U)) | (IData)(this->newLRU__out__en5));
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__agu1__DOT__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__0__KET____DOT__lru_mod__99(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__agu1__DOT__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__0__KET____DOT__lru_mod__99\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->adders_gen__DOT__inc_mod__DOT__out__out__out1 
        = ((6U & (IData)(this->adders_gen__DOT__inc_mod__DOT__out__out__out1)) 
           | (1U & (~ (IData)(vlSymsp->TOP__agu_block__DOT__agu1__DOT__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru))));
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__agu1__DOT__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__0__KET____DOT__lru_mod__147(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__agu1__DOT__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__0__KET____DOT__lru_mod__147\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->__PVT__adders_gen__DOT__inc_mod__DOT__nP1 
        = ((6U & ((~ (((IData)(vlSymsp->TOP__agu_block__DOT__agu1__DOT__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru) 
                       >> 1U) & (IData)(vlSymsp->TOP__agu_block__DOT__agu1__DOT__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru))) 
                  << 1U)) | (1U & (~ (IData)(vlSymsp->TOP__agu_block__DOT__agu1__DOT__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru))));
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__agu1__DOT__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__0__KET____DOT__lru_mod__219(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__agu1__DOT__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__0__KET____DOT__lru_mod__219\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->__pinNumber2__en0 = (7U & (((((1U & ((IData)(vlSymsp->TOP__agu_block__DOT__agu1__DOT__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru) 
                                               | (~ (IData)(vlSymsp->TOP__agu_block__DOT__agu1__DOT__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru)))) 
                                        | (2U & (IData)(vlSymsp->TOP__agu_block__DOT__agu1__DOT__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru))) 
                                       | (2U & ((~ 
                                                 ((IData)(vlSymsp->TOP__agu_block__DOT__agu1__DOT__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru) 
                                                  >> 1U)) 
                                                << 1U))) 
                                      | (4U & (IData)(vlSymsp->TOP__agu_block__DOT__agu1__DOT__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru))) 
                                     | (4U & ((~ ((IData)(vlSymsp->TOP__agu_block__DOT__agu1__DOT__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru) 
                                                  >> 2U)) 
                                              << 2U))));
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__agu1__DOT__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__0__KET____DOT__lru_mod__263(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__agu1__DOT__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__0__KET____DOT__lru_mod__263\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->__PVT__adders_gen__DOT__cmp_mod__DOT__G1 
        = ((6U & ((~ ((~ (IData)(vlSymsp->TOP__agu_block__DOT__agu1__DOT__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru)) 
                      & (~ ((IData)(vlSymsp->TOP__agu_block__DOT__agu1__DOT__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru) 
                            >> 1U)))) << 1U)) | (1U 
                                                 & (IData)(vlSymsp->TOP__agu_block__DOT__agu1__DOT__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru)));
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__agu1__DOT__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__0__KET____DOT__lru_mod__489(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__agu1__DOT__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__0__KET____DOT__lru_mod__489\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->adders_gen__DOT__inc_mod__DOT__out__out__out2 
        = ((5U & (IData)(this->adders_gen__DOT__inc_mod__DOT__out__out__out2)) 
           | (2U & ((IData)(vlSymsp->TOP__agu_block__DOT__agu1__DOT__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru) 
                    & ((~ (IData)(this->__PVT__adders_gen__DOT__inc_mod__DOT__P2)) 
                       << 1U))));
    this->adders_gen__DOT__inc_mod__DOT__out__out__out3 
        = ((5U & (IData)(this->adders_gen__DOT__inc_mod__DOT__out__out__out3)) 
           | (2U & (((~ ((IData)(vlSymsp->TOP__agu_block__DOT__agu1__DOT__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru) 
                         >> 1U)) & (IData)(this->__PVT__adders_gen__DOT__inc_mod__DOT__P2)) 
                    << 1U)));
    this->adders_gen__DOT__inc_mod__DOT__out__out__out4 
        = ((3U & (IData)(this->adders_gen__DOT__inc_mod__DOT__out__out__out4)) 
           | (4U & ((IData)(vlSymsp->TOP__agu_block__DOT__agu1__DOT__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru) 
                    & ((~ ((IData)(this->__PVT__adders_gen__DOT__inc_mod__DOT__P2) 
                           >> 1U)) << 2U))));
    this->adders_gen__DOT__inc_mod__DOT__out__out__out5 
        = ((3U & (IData)(this->adders_gen__DOT__inc_mod__DOT__out__out__out5)) 
           | (4U & (((~ ((IData)(vlSymsp->TOP__agu_block__DOT__agu1__DOT__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru) 
                         >> 2U)) << 2U) & ((IData)(this->__PVT__adders_gen__DOT__inc_mod__DOT__P2) 
                                           << 1U))));
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__agu1__DOT__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__0__KET____DOT__lru_mod__569(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__agu1__DOT__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__0__KET____DOT__lru_mod__569\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->newLRU__out__en5 = ((1U & ((~ (IData)(vlSymsp->TOP__agu_block__DOT__agu1__DOT__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__en)) 
                                     & (~ (IData)(vlSymsp->TOP__agu_block__DOT__agu1__DOT__tlb_mod.__PVT__init))))
                               ? 7U : 0U);
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__agu1__DOT__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__0__KET____DOT__lru_mod__657(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__agu1__DOT__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__0__KET____DOT__lru_mod__657\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->__PVT__hitAfter = (0U != (IData)(vlSymsp->TOP__agu_block__DOT__agu1__DOT__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru));
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__agu1__DOT__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__0__KET____DOT__lru_mod__705(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__agu1__DOT__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__0__KET____DOT__lru_mod__705\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->newLRU__out__en2 = ((((IData)(this->__PVT__hitAfter) 
                                & (~ (IData)(vlSymsp->TOP__agu_block__DOT__agu1__DOT__tlb_mod.__PVT__init))) 
                               & (IData)(vlSymsp->TOP__agu_block__DOT__agu1__DOT__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__en))
                               ? 7U : 0U);
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__agu1__DOT__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__0__KET____DOT__lru_mod__753(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__agu1__DOT__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__0__KET____DOT__lru_mod__753\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->newLRU__en = (((((((0U == (IData)(vlSymsp->TOP__agu_block__DOT__agu1__DOT__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru)) 
                             & (~ (IData)(vlSymsp->TOP__agu_block__DOT__agu1__DOT__tlb_mod.__PVT__init))) 
                            & (IData)(vlSymsp->TOP__agu_block__DOT__agu1__DOT__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__en))
                            ? 7U : 0U) | (IData)(this->newLRU__out__en2)) 
                         | ((IData)(vlSymsp->TOP__agu_block__DOT__agu1__DOT__tlb_mod.__PVT__init)
                             ? 7U : 0U)) | (IData)(this->newLRU__out__en5));
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__agu1__DOT__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__1__KET____DOT__lru_mod__264(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__agu1__DOT__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__1__KET____DOT__lru_mod__264\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->__PVT__adders_gen__DOT__cmp_mod__DOT__G1 
        = (6U & ((~ (((~ (3U | ((IData)(vlSymsp->TOP__agu_block__DOT__agu1__DOT__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru) 
                                >> 1U))) | (~ (2U & (IData)(vlSymsp->TOP__agu_block__DOT__agu1__DOT__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru)))) 
                     & (~ (3U & ((IData)(vlSymsp->TOP__agu_block__DOT__agu1__DOT__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru) 
                                 >> 1U))))) << 1U));
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__agu1__DOT__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__1__KET____DOT__lru_mod__305(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__agu1__DOT__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__1__KET____DOT__lru_mod__305\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->__PVT__adders_gen__DOT__cmp_mod__DOT__P1 
        = ((6U & ((~ ((~ (3U | ((IData)(vlSymsp->TOP__agu_block__DOT__agu1__DOT__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru) 
                                >> 1U))) | (~ (2U | (IData)(vlSymsp->TOP__agu_block__DOT__agu1__DOT__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru))))) 
                  << 1U)) | (1U & (IData)(vlSymsp->TOP__agu_block__DOT__agu1__DOT__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru)));
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__agu1__DOT__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__1__KET____DOT__lru_mod__610(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__agu1__DOT__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__1__KET____DOT__lru_mod__610\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->newLRU__out__en3 = ((((~ ((IData)(this->__PVT__adders_gen__DOT__cmp_mod__DOT__C) 
                                    >> 2U)) & (~ (IData)(vlSymsp->TOP__agu_block__DOT__agu1__DOT__tlb_mod.__PVT__init))) 
                               & (IData)(vlSymsp->TOP__agu_block__DOT__agu1__DOT__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__en))
                               ? (IData)(this->__pinNumber2__en0)
                               : 0U);
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__agu1__DOT__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__1__KET____DOT__lru_mod__658(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__agu1__DOT__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__1__KET____DOT__lru_mod__658\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->__PVT__hitAfter = (((IData)(this->__PVT__adders_gen__DOT__cmp_mod__DOT__C) 
                              >> 2U) & (1U != (IData)(vlSymsp->TOP__agu_block__DOT__agu1__DOT__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru)));
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__agu1__DOT__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__1__KET____DOT__lru_mod__754(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__agu1__DOT__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__1__KET____DOT__lru_mod__754\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->newLRU__en = ((((((((1U == (IData)(vlSymsp->TOP__agu_block__DOT__agu1__DOT__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru)) 
                              & (~ (IData)(vlSymsp->TOP__agu_block__DOT__agu1__DOT__tlb_mod.__PVT__init))) 
                             & (IData)(vlSymsp->TOP__agu_block__DOT__agu1__DOT__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__en))
                             ? 7U : 0U) | (IData)(this->newLRU__out__en2)) 
                          | (IData)(this->newLRU__out__en3)) 
                         | ((IData)(vlSymsp->TOP__agu_block__DOT__agu1__DOT__tlb_mod.__PVT__init)
                             ? 7U : 0U)) | (IData)(this->newLRU__out__en5));
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__agu1__DOT__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__2__KET____DOT__lru_mod__265(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__agu1__DOT__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__2__KET____DOT__lru_mod__265\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->__PVT__adders_gen__DOT__cmp_mod__DOT__G1 
        = ((6U & ((~ (((~ (2U | ((IData)(vlSymsp->TOP__agu_block__DOT__agu1__DOT__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru) 
                                 >> 1U))) | (~ (1U 
                                                & (IData)(vlSymsp->TOP__agu_block__DOT__agu1__DOT__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru)))) 
                      & (~ (2U & ((IData)(vlSymsp->TOP__agu_block__DOT__agu1__DOT__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru) 
                                  >> 1U))))) << 1U)) 
           | (1U & (IData)(vlSymsp->TOP__agu_block__DOT__agu1__DOT__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru)));
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__agu1__DOT__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__2__KET____DOT__lru_mod__306(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__agu1__DOT__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__2__KET____DOT__lru_mod__306\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->__PVT__adders_gen__DOT__cmp_mod__DOT__P1 
        = (1U | (6U & ((~ ((~ (2U | ((IData)(vlSymsp->TOP__agu_block__DOT__agu1__DOT__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru) 
                                     >> 1U))) | (~ 
                                                 (1U 
                                                  | (IData)(vlSymsp->TOP__agu_block__DOT__agu1__DOT__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru))))) 
                       << 1U)));
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__agu1__DOT__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__2__KET____DOT__lru_mod__659(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__agu1__DOT__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__2__KET____DOT__lru_mod__659\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->__PVT__hitAfter = (((IData)(this->__PVT__adders_gen__DOT__cmp_mod__DOT__C) 
                              >> 2U) & (2U != (IData)(vlSymsp->TOP__agu_block__DOT__agu1__DOT__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru)));
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__agu1__DOT__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__2__KET____DOT__lru_mod__755(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__agu1__DOT__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__2__KET____DOT__lru_mod__755\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->newLRU__en = ((((((((2U == (IData)(vlSymsp->TOP__agu_block__DOT__agu1__DOT__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru)) 
                              & (~ (IData)(vlSymsp->TOP__agu_block__DOT__agu1__DOT__tlb_mod.__PVT__init))) 
                             & (IData)(vlSymsp->TOP__agu_block__DOT__agu1__DOT__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__en))
                             ? 7U : 0U) | (IData)(this->newLRU__out__en2)) 
                          | (IData)(this->newLRU__out__en3)) 
                         | ((IData)(vlSymsp->TOP__agu_block__DOT__agu1__DOT__tlb_mod.__PVT__init)
                             ? 7U : 0U)) | (IData)(this->newLRU__out__en5));
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__agu1__DOT__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__3__KET____DOT__lru_mod__266(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__agu1__DOT__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__3__KET____DOT__lru_mod__266\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->__PVT__adders_gen__DOT__cmp_mod__DOT__G1 
        = (4U & (IData)(vlSymsp->TOP__agu_block__DOT__agu1__DOT__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru));
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__agu1__DOT__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__3__KET____DOT__lru_mod__307(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__agu1__DOT__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__3__KET____DOT__lru_mod__307\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->__PVT__adders_gen__DOT__cmp_mod__DOT__P1 
        = ((6U & ((~ ((~ (2U | ((IData)(vlSymsp->TOP__agu_block__DOT__agu1__DOT__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru) 
                                >> 1U))) | (~ (IData)(vlSymsp->TOP__agu_block__DOT__agu1__DOT__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru)))) 
                  << 1U)) | (1U & (IData)(vlSymsp->TOP__agu_block__DOT__agu1__DOT__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru)));
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__agu1__DOT__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__3__KET____DOT__lru_mod__660(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__agu1__DOT__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__3__KET____DOT__lru_mod__660\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->__PVT__hitAfter = (((IData)(this->__PVT__adders_gen__DOT__cmp_mod__DOT__C) 
                              >> 2U) & (3U != (IData)(vlSymsp->TOP__agu_block__DOT__agu1__DOT__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru)));
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__agu1__DOT__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__3__KET____DOT__lru_mod__756(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__agu1__DOT__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__3__KET____DOT__lru_mod__756\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->newLRU__en = ((((((((3U == (IData)(vlSymsp->TOP__agu_block__DOT__agu1__DOT__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru)) 
                              & (~ (IData)(vlSymsp->TOP__agu_block__DOT__agu1__DOT__tlb_mod.__PVT__init))) 
                             & (IData)(vlSymsp->TOP__agu_block__DOT__agu1__DOT__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__en))
                             ? 7U : 0U) | (IData)(this->newLRU__out__en2)) 
                          | (IData)(this->newLRU__out__en3)) 
                         | ((IData)(vlSymsp->TOP__agu_block__DOT__agu1__DOT__tlb_mod.__PVT__init)
                             ? 7U : 0U)) | (IData)(this->newLRU__out__en5));
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__agu1__DOT__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__4__KET____DOT__lru_mod__267(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__agu1__DOT__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__4__KET____DOT__lru_mod__267\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->__PVT__adders_gen__DOT__cmp_mod__DOT__G1 
        = ((6U & ((~ (((~ (1U | ((IData)(vlSymsp->TOP__agu_block__DOT__agu1__DOT__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru) 
                                 >> 1U))) | (~ (IData)(vlSymsp->TOP__agu_block__DOT__agu1__DOT__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru))) 
                      & (~ (1U & ((IData)(vlSymsp->TOP__agu_block__DOT__agu1__DOT__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru) 
                                  >> 1U))))) << 1U)) 
           | (1U & (IData)(vlSymsp->TOP__agu_block__DOT__agu1__DOT__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru)));
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__agu1__DOT__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__4__KET____DOT__lru_mod__308(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__agu1__DOT__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__4__KET____DOT__lru_mod__308\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->__PVT__adders_gen__DOT__cmp_mod__DOT__P1 
        = (1U | (6U & (2U | (0xfffffffeU & (IData)(vlSymsp->TOP__agu_block__DOT__agu1__DOT__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru)))));
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__agu1__DOT__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__4__KET____DOT__lru_mod__661(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__agu1__DOT__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__4__KET____DOT__lru_mod__661\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->__PVT__hitAfter = (((IData)(this->__PVT__adders_gen__DOT__cmp_mod__DOT__C) 
                              >> 2U) & (4U != (IData)(vlSymsp->TOP__agu_block__DOT__agu1__DOT__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru)));
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__agu1__DOT__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__4__KET____DOT__lru_mod__757(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__agu1__DOT__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__4__KET____DOT__lru_mod__757\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->newLRU__en = ((((((((4U == (IData)(vlSymsp->TOP__agu_block__DOT__agu1__DOT__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru)) 
                              & (~ (IData)(vlSymsp->TOP__agu_block__DOT__agu1__DOT__tlb_mod.__PVT__init))) 
                             & (IData)(vlSymsp->TOP__agu_block__DOT__agu1__DOT__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__en))
                             ? 7U : 0U) | (IData)(this->newLRU__out__en2)) 
                          | (IData)(this->newLRU__out__en3)) 
                         | ((IData)(vlSymsp->TOP__agu_block__DOT__agu1__DOT__tlb_mod.__PVT__init)
                             ? 7U : 0U)) | (IData)(this->newLRU__out__en5));
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__agu1__DOT__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__5__KET____DOT__lru_mod__268(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__agu1__DOT__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__5__KET____DOT__lru_mod__268\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->__PVT__adders_gen__DOT__cmp_mod__DOT__G1 
        = (6U & ((~ (((~ (1U | ((IData)(vlSymsp->TOP__agu_block__DOT__agu1__DOT__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru) 
                                >> 1U))) | (~ (2U & (IData)(vlSymsp->TOP__agu_block__DOT__agu1__DOT__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru)))) 
                     & (~ (1U & ((IData)(vlSymsp->TOP__agu_block__DOT__agu1__DOT__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru) 
                                 >> 1U))))) << 1U));
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__agu1__DOT__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__5__KET____DOT__lru_mod__309(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__agu1__DOT__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__5__KET____DOT__lru_mod__309\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->__PVT__adders_gen__DOT__cmp_mod__DOT__P1 
        = ((6U & ((~ ((~ (1U | ((IData)(vlSymsp->TOP__agu_block__DOT__agu1__DOT__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru) 
                                >> 1U))) | (~ (2U | (IData)(vlSymsp->TOP__agu_block__DOT__agu1__DOT__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru))))) 
                  << 1U)) | (1U & (IData)(vlSymsp->TOP__agu_block__DOT__agu1__DOT__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru)));
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__agu1__DOT__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__5__KET____DOT__lru_mod__662(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__agu1__DOT__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__5__KET____DOT__lru_mod__662\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->__PVT__hitAfter = (((IData)(this->__PVT__adders_gen__DOT__cmp_mod__DOT__C) 
                              >> 2U) & (5U != (IData)(vlSymsp->TOP__agu_block__DOT__agu1__DOT__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru)));
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__agu1__DOT__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__5__KET____DOT__lru_mod__758(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__agu1__DOT__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__5__KET____DOT__lru_mod__758\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->newLRU__en = ((((((((5U == (IData)(vlSymsp->TOP__agu_block__DOT__agu1__DOT__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru)) 
                              & (~ (IData)(vlSymsp->TOP__agu_block__DOT__agu1__DOT__tlb_mod.__PVT__init))) 
                             & (IData)(vlSymsp->TOP__agu_block__DOT__agu1__DOT__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__en))
                             ? 7U : 0U) | (IData)(this->newLRU__out__en2)) 
                          | (IData)(this->newLRU__out__en3)) 
                         | ((IData)(vlSymsp->TOP__agu_block__DOT__agu1__DOT__tlb_mod.__PVT__init)
                             ? 7U : 0U)) | (IData)(this->newLRU__out__en5));
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__agu1__DOT__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__6__KET____DOT__lru_mod__269(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__agu1__DOT__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__6__KET____DOT__lru_mod__269\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->__PVT__adders_gen__DOT__cmp_mod__DOT__G1 
        = ((6U & ((~ ((~ ((IData)(vlSymsp->TOP__agu_block__DOT__agu1__DOT__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru) 
                          >> 1U)) | (~ (1U & (IData)(vlSymsp->TOP__agu_block__DOT__agu1__DOT__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru))))) 
                  << 1U)) | (1U & (IData)(vlSymsp->TOP__agu_block__DOT__agu1__DOT__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru)));
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__agu1__DOT__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__6__KET____DOT__lru_mod__310(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__agu1__DOT__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__6__KET____DOT__lru_mod__310\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->__PVT__adders_gen__DOT__cmp_mod__DOT__P1 
        = (1U | (6U & ((~ ((~ ((IData)(vlSymsp->TOP__agu_block__DOT__agu1__DOT__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru) 
                               >> 1U)) | (~ (1U | (IData)(vlSymsp->TOP__agu_block__DOT__agu1__DOT__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru))))) 
                       << 1U)));
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__agu1__DOT__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__6__KET____DOT__lru_mod__663(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__agu1__DOT__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__6__KET____DOT__lru_mod__663\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->__PVT__hitAfter = (((IData)(this->__PVT__adders_gen__DOT__cmp_mod__DOT__C) 
                              >> 2U) & (6U != (IData)(vlSymsp->TOP__agu_block__DOT__agu1__DOT__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru)));
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__agu1__DOT__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__6__KET____DOT__lru_mod__759(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__agu1__DOT__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__6__KET____DOT__lru_mod__759\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->newLRU__en = ((((((((6U == (IData)(vlSymsp->TOP__agu_block__DOT__agu1__DOT__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru)) 
                              & (~ (IData)(vlSymsp->TOP__agu_block__DOT__agu1__DOT__tlb_mod.__PVT__init))) 
                             & (IData)(vlSymsp->TOP__agu_block__DOT__agu1__DOT__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__en))
                             ? 7U : 0U) | (IData)(this->newLRU__out__en2)) 
                          | (IData)(this->newLRU__out__en3)) 
                         | ((IData)(vlSymsp->TOP__agu_block__DOT__agu1__DOT__tlb_mod.__PVT__init)
                             ? 7U : 0U)) | (IData)(this->newLRU__out__en5));
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__agu1__DOT__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__7__KET____DOT__lru_mod__311(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__agu1__DOT__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__7__KET____DOT__lru_mod__311\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->__PVT__adders_gen__DOT__cmp_mod__DOT__P1 
        = ((6U & ((~ ((~ ((IData)(vlSymsp->TOP__agu_block__DOT__agu1__DOT__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru) 
                          >> 1U)) | (~ (IData)(vlSymsp->TOP__agu_block__DOT__agu1__DOT__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru)))) 
                  << 1U)) | (1U & (IData)(vlSymsp->TOP__agu_block__DOT__agu1__DOT__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru)));
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__agu1__DOT__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__7__KET____DOT__lru_mod__664(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__agu1__DOT__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__7__KET____DOT__lru_mod__664\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->__PVT__hitAfter = (((IData)(this->__PVT__adders_gen__DOT__cmp_mod__DOT__C) 
                              >> 2U) & (7U != (IData)(vlSymsp->TOP__agu_block__DOT__agu1__DOT__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru)));
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__agu1__DOT__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__7__KET____DOT__lru_mod__760(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__agu1__DOT__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__7__KET____DOT__lru_mod__760\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->newLRU__en = ((((((((7U == (IData)(vlSymsp->TOP__agu_block__DOT__agu1__DOT__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru)) 
                              & (~ (IData)(vlSymsp->TOP__agu_block__DOT__agu1__DOT__tlb_mod.__PVT__init))) 
                             & (IData)(vlSymsp->TOP__agu_block__DOT__agu1__DOT__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__en))
                             ? 7U : 0U) | (IData)(this->newLRU__out__en2)) 
                          | (IData)(this->newLRU__out__en3)) 
                         | ((IData)(vlSymsp->TOP__agu_block__DOT__agu1__DOT__tlb_mod.__PVT__init)
                             ? 7U : 0U)) | (IData)(this->newLRU__out__en5));
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__rec_agu_mod__DOT__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__0__KET____DOT__lru_mod__107(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__rec_agu_mod__DOT__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__0__KET____DOT__lru_mod__107\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->adders_gen__DOT__inc_mod__DOT__out__out__out1 
        = ((6U & (IData)(this->adders_gen__DOT__inc_mod__DOT__out__out__out1)) 
           | (1U & (~ (IData)(vlSymsp->TOP__agu_block__DOT__rec_agu_mod__DOT__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru))));
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__rec_agu_mod__DOT__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__0__KET____DOT__lru_mod__155(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__rec_agu_mod__DOT__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__0__KET____DOT__lru_mod__155\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->__PVT__adders_gen__DOT__inc_mod__DOT__nP1 
        = ((6U & ((~ (((IData)(vlSymsp->TOP__agu_block__DOT__rec_agu_mod__DOT__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru) 
                       >> 1U) & (IData)(vlSymsp->TOP__agu_block__DOT__rec_agu_mod__DOT__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru))) 
                  << 1U)) | (1U & (~ (IData)(vlSymsp->TOP__agu_block__DOT__rec_agu_mod__DOT__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru))));
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__rec_agu_mod__DOT__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__0__KET____DOT__lru_mod__179(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__rec_agu_mod__DOT__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__0__KET____DOT__lru_mod__179\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->newLRU__out__en5 = ((1U & ((~ (IData)(vlSymsp->TOP__agu_block__DOT__rec_agu_mod__DOT__tlb_mod.__Vcellinp__ways_gen__BRA__0__KET____DOT__lru_mod__en)) 
                                     & (~ (IData)(vlSymsp->TOP__agu_block__DOT__rec_agu_mod__DOT__tlb_mod.__PVT__init))))
                               ? 7U : 0U);
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__rec_agu_mod__DOT__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__0__KET____DOT__lru_mod__227(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__rec_agu_mod__DOT__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__0__KET____DOT__lru_mod__227\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->__pinNumber2__en0 = (7U & (((((1U & ((IData)(vlSymsp->TOP__agu_block__DOT__rec_agu_mod__DOT__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru) 
                                               | (~ (IData)(vlSymsp->TOP__agu_block__DOT__rec_agu_mod__DOT__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru)))) 
                                        | (2U & (IData)(vlSymsp->TOP__agu_block__DOT__rec_agu_mod__DOT__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru))) 
                                       | (2U & ((~ 
                                                 ((IData)(vlSymsp->TOP__agu_block__DOT__rec_agu_mod__DOT__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru) 
                                                  >> 1U)) 
                                                << 1U))) 
                                      | (4U & (IData)(vlSymsp->TOP__agu_block__DOT__rec_agu_mod__DOT__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru))) 
                                     | (4U & ((~ ((IData)(vlSymsp->TOP__agu_block__DOT__rec_agu_mod__DOT__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru) 
                                                  >> 2U)) 
                                              << 2U))));
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__rec_agu_mod__DOT__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__0__KET____DOT__lru_mod__270(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__rec_agu_mod__DOT__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__0__KET____DOT__lru_mod__270\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->__PVT__adders_gen__DOT__cmp_mod__DOT__G1 
        = ((6U & ((~ ((~ (IData)(vlSymsp->TOP__agu_block__DOT__rec_agu_mod__DOT__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru)) 
                      & (~ ((IData)(vlSymsp->TOP__agu_block__DOT__rec_agu_mod__DOT__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru) 
                            >> 1U)))) << 1U)) | (1U 
                                                 & (IData)(vlSymsp->TOP__agu_block__DOT__rec_agu_mod__DOT__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru)));
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__rec_agu_mod__DOT__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__0__KET____DOT__lru_mod__497(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__rec_agu_mod__DOT__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__0__KET____DOT__lru_mod__497\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->adders_gen__DOT__inc_mod__DOT__out__out__out2 
        = ((5U & (IData)(this->adders_gen__DOT__inc_mod__DOT__out__out__out2)) 
           | (2U & ((IData)(vlSymsp->TOP__agu_block__DOT__rec_agu_mod__DOT__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru) 
                    & ((~ (IData)(this->__PVT__adders_gen__DOT__inc_mod__DOT__P2)) 
                       << 1U))));
    this->adders_gen__DOT__inc_mod__DOT__out__out__out3 
        = ((5U & (IData)(this->adders_gen__DOT__inc_mod__DOT__out__out__out3)) 
           | (2U & (((~ ((IData)(vlSymsp->TOP__agu_block__DOT__rec_agu_mod__DOT__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru) 
                         >> 1U)) & (IData)(this->__PVT__adders_gen__DOT__inc_mod__DOT__P2)) 
                    << 1U)));
    this->adders_gen__DOT__inc_mod__DOT__out__out__out4 
        = ((3U & (IData)(this->adders_gen__DOT__inc_mod__DOT__out__out__out4)) 
           | (4U & ((IData)(vlSymsp->TOP__agu_block__DOT__rec_agu_mod__DOT__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru) 
                    & ((~ ((IData)(this->__PVT__adders_gen__DOT__inc_mod__DOT__P2) 
                           >> 1U)) << 2U))));
    this->adders_gen__DOT__inc_mod__DOT__out__out__out5 
        = ((3U & (IData)(this->adders_gen__DOT__inc_mod__DOT__out__out__out5)) 
           | (4U & (((~ ((IData)(vlSymsp->TOP__agu_block__DOT__rec_agu_mod__DOT__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru) 
                         >> 2U)) << 2U) & ((IData)(this->__PVT__adders_gen__DOT__inc_mod__DOT__P2) 
                                           << 1U))));
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__rec_agu_mod__DOT__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__0__KET____DOT__lru_mod__665(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__rec_agu_mod__DOT__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__0__KET____DOT__lru_mod__665\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->__PVT__hitAfter = (0U != (IData)(vlSymsp->TOP__agu_block__DOT__rec_agu_mod__DOT__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru));
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__rec_agu_mod__DOT__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__0__KET____DOT__lru_mod__713(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__rec_agu_mod__DOT__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__0__KET____DOT__lru_mod__713\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->newLRU__out__en2 = ((((IData)(this->__PVT__hitAfter) 
                                & (~ (IData)(vlSymsp->TOP__agu_block__DOT__rec_agu_mod__DOT__tlb_mod.__PVT__init))) 
                               & (IData)(vlSymsp->TOP__agu_block__DOT__rec_agu_mod__DOT__tlb_mod.__Vcellinp__ways_gen__BRA__0__KET____DOT__lru_mod__en))
                               ? 7U : 0U);
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__rec_agu_mod__DOT__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__0__KET____DOT__lru_mod__761(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__rec_agu_mod__DOT__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__0__KET____DOT__lru_mod__761\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->newLRU__en = (((((((0U == (IData)(vlSymsp->TOP__agu_block__DOT__rec_agu_mod__DOT__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru)) 
                             & (~ (IData)(vlSymsp->TOP__agu_block__DOT__rec_agu_mod__DOT__tlb_mod.__PVT__init))) 
                            & (IData)(vlSymsp->TOP__agu_block__DOT__rec_agu_mod__DOT__tlb_mod.__Vcellinp__ways_gen__BRA__0__KET____DOT__lru_mod__en))
                            ? 7U : 0U) | (IData)(this->newLRU__out__en2)) 
                         | ((IData)(vlSymsp->TOP__agu_block__DOT__rec_agu_mod__DOT__tlb_mod.__PVT__init)
                             ? 7U : 0U)) | (IData)(this->newLRU__out__en5));
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__rec_agu_mod__DOT__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__1__KET____DOT__lru_mod__271(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__rec_agu_mod__DOT__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__1__KET____DOT__lru_mod__271\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->__PVT__adders_gen__DOT__cmp_mod__DOT__G1 
        = (6U & ((~ (((~ (3U | ((IData)(vlSymsp->TOP__agu_block__DOT__rec_agu_mod__DOT__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru) 
                                >> 1U))) | (~ (2U & (IData)(vlSymsp->TOP__agu_block__DOT__rec_agu_mod__DOT__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru)))) 
                     & (~ (3U & ((IData)(vlSymsp->TOP__agu_block__DOT__rec_agu_mod__DOT__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru) 
                                 >> 1U))))) << 1U));
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__rec_agu_mod__DOT__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__1__KET____DOT__lru_mod__312(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__rec_agu_mod__DOT__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__1__KET____DOT__lru_mod__312\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->__PVT__adders_gen__DOT__cmp_mod__DOT__P1 
        = ((6U & ((~ ((~ (3U | ((IData)(vlSymsp->TOP__agu_block__DOT__rec_agu_mod__DOT__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru) 
                                >> 1U))) | (~ (2U | (IData)(vlSymsp->TOP__agu_block__DOT__rec_agu_mod__DOT__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru))))) 
                  << 1U)) | (1U & (IData)(vlSymsp->TOP__agu_block__DOT__rec_agu_mod__DOT__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru)));
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__rec_agu_mod__DOT__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__1__KET____DOT__lru_mod__618(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__rec_agu_mod__DOT__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__1__KET____DOT__lru_mod__618\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->newLRU__out__en3 = ((((~ ((IData)(this->__PVT__adders_gen__DOT__cmp_mod__DOT__C) 
                                    >> 2U)) & (~ (IData)(vlSymsp->TOP__agu_block__DOT__rec_agu_mod__DOT__tlb_mod.__PVT__init))) 
                               & (IData)(vlSymsp->TOP__agu_block__DOT__rec_agu_mod__DOT__tlb_mod.__Vcellinp__ways_gen__BRA__0__KET____DOT__lru_mod__en))
                               ? (IData)(this->__pinNumber2__en0)
                               : 0U);
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__rec_agu_mod__DOT__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__1__KET____DOT__lru_mod__666(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__rec_agu_mod__DOT__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__1__KET____DOT__lru_mod__666\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->__PVT__hitAfter = (((IData)(this->__PVT__adders_gen__DOT__cmp_mod__DOT__C) 
                              >> 2U) & (1U != (IData)(vlSymsp->TOP__agu_block__DOT__rec_agu_mod__DOT__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru)));
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__rec_agu_mod__DOT__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__1__KET____DOT__lru_mod__762(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__rec_agu_mod__DOT__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__1__KET____DOT__lru_mod__762\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->newLRU__en = ((((((((1U == (IData)(vlSymsp->TOP__agu_block__DOT__rec_agu_mod__DOT__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru)) 
                              & (~ (IData)(vlSymsp->TOP__agu_block__DOT__rec_agu_mod__DOT__tlb_mod.__PVT__init))) 
                             & (IData)(vlSymsp->TOP__agu_block__DOT__rec_agu_mod__DOT__tlb_mod.__Vcellinp__ways_gen__BRA__0__KET____DOT__lru_mod__en))
                             ? 7U : 0U) | (IData)(this->newLRU__out__en2)) 
                          | (IData)(this->newLRU__out__en3)) 
                         | ((IData)(vlSymsp->TOP__agu_block__DOT__rec_agu_mod__DOT__tlb_mod.__PVT__init)
                             ? 7U : 0U)) | (IData)(this->newLRU__out__en5));
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__rec_agu_mod__DOT__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__2__KET____DOT__lru_mod__272(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__rec_agu_mod__DOT__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__2__KET____DOT__lru_mod__272\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->__PVT__adders_gen__DOT__cmp_mod__DOT__G1 
        = ((6U & ((~ (((~ (2U | ((IData)(vlSymsp->TOP__agu_block__DOT__rec_agu_mod__DOT__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru) 
                                 >> 1U))) | (~ (1U 
                                                & (IData)(vlSymsp->TOP__agu_block__DOT__rec_agu_mod__DOT__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru)))) 
                      & (~ (2U & ((IData)(vlSymsp->TOP__agu_block__DOT__rec_agu_mod__DOT__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru) 
                                  >> 1U))))) << 1U)) 
           | (1U & (IData)(vlSymsp->TOP__agu_block__DOT__rec_agu_mod__DOT__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru)));
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__rec_agu_mod__DOT__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__2__KET____DOT__lru_mod__313(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__rec_agu_mod__DOT__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__2__KET____DOT__lru_mod__313\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->__PVT__adders_gen__DOT__cmp_mod__DOT__P1 
        = (1U | (6U & ((~ ((~ (2U | ((IData)(vlSymsp->TOP__agu_block__DOT__rec_agu_mod__DOT__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru) 
                                     >> 1U))) | (~ 
                                                 (1U 
                                                  | (IData)(vlSymsp->TOP__agu_block__DOT__rec_agu_mod__DOT__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru))))) 
                       << 1U)));
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__rec_agu_mod__DOT__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__2__KET____DOT__lru_mod__667(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__rec_agu_mod__DOT__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__2__KET____DOT__lru_mod__667\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->__PVT__hitAfter = (((IData)(this->__PVT__adders_gen__DOT__cmp_mod__DOT__C) 
                              >> 2U) & (2U != (IData)(vlSymsp->TOP__agu_block__DOT__rec_agu_mod__DOT__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru)));
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__rec_agu_mod__DOT__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__2__KET____DOT__lru_mod__763(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__rec_agu_mod__DOT__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__2__KET____DOT__lru_mod__763\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->newLRU__en = ((((((((2U == (IData)(vlSymsp->TOP__agu_block__DOT__rec_agu_mod__DOT__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru)) 
                              & (~ (IData)(vlSymsp->TOP__agu_block__DOT__rec_agu_mod__DOT__tlb_mod.__PVT__init))) 
                             & (IData)(vlSymsp->TOP__agu_block__DOT__rec_agu_mod__DOT__tlb_mod.__Vcellinp__ways_gen__BRA__0__KET____DOT__lru_mod__en))
                             ? 7U : 0U) | (IData)(this->newLRU__out__en2)) 
                          | (IData)(this->newLRU__out__en3)) 
                         | ((IData)(vlSymsp->TOP__agu_block__DOT__rec_agu_mod__DOT__tlb_mod.__PVT__init)
                             ? 7U : 0U)) | (IData)(this->newLRU__out__en5));
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__rec_agu_mod__DOT__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__3__KET____DOT__lru_mod__273(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__rec_agu_mod__DOT__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__3__KET____DOT__lru_mod__273\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->__PVT__adders_gen__DOT__cmp_mod__DOT__G1 
        = (4U & (IData)(vlSymsp->TOP__agu_block__DOT__rec_agu_mod__DOT__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru));
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__rec_agu_mod__DOT__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__3__KET____DOT__lru_mod__314(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__rec_agu_mod__DOT__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__3__KET____DOT__lru_mod__314\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->__PVT__adders_gen__DOT__cmp_mod__DOT__P1 
        = ((6U & ((~ ((~ (2U | ((IData)(vlSymsp->TOP__agu_block__DOT__rec_agu_mod__DOT__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru) 
                                >> 1U))) | (~ (IData)(vlSymsp->TOP__agu_block__DOT__rec_agu_mod__DOT__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru)))) 
                  << 1U)) | (1U & (IData)(vlSymsp->TOP__agu_block__DOT__rec_agu_mod__DOT__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru)));
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__rec_agu_mod__DOT__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__3__KET____DOT__lru_mod__668(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__rec_agu_mod__DOT__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__3__KET____DOT__lru_mod__668\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->__PVT__hitAfter = (((IData)(this->__PVT__adders_gen__DOT__cmp_mod__DOT__C) 
                              >> 2U) & (3U != (IData)(vlSymsp->TOP__agu_block__DOT__rec_agu_mod__DOT__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru)));
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__rec_agu_mod__DOT__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__3__KET____DOT__lru_mod__764(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__rec_agu_mod__DOT__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__3__KET____DOT__lru_mod__764\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->newLRU__en = ((((((((3U == (IData)(vlSymsp->TOP__agu_block__DOT__rec_agu_mod__DOT__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru)) 
                              & (~ (IData)(vlSymsp->TOP__agu_block__DOT__rec_agu_mod__DOT__tlb_mod.__PVT__init))) 
                             & (IData)(vlSymsp->TOP__agu_block__DOT__rec_agu_mod__DOT__tlb_mod.__Vcellinp__ways_gen__BRA__0__KET____DOT__lru_mod__en))
                             ? 7U : 0U) | (IData)(this->newLRU__out__en2)) 
                          | (IData)(this->newLRU__out__en3)) 
                         | ((IData)(vlSymsp->TOP__agu_block__DOT__rec_agu_mod__DOT__tlb_mod.__PVT__init)
                             ? 7U : 0U)) | (IData)(this->newLRU__out__en5));
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__rec_agu_mod__DOT__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__4__KET____DOT__lru_mod__274(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__rec_agu_mod__DOT__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__4__KET____DOT__lru_mod__274\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->__PVT__adders_gen__DOT__cmp_mod__DOT__G1 
        = ((6U & ((~ (((~ (1U | ((IData)(vlSymsp->TOP__agu_block__DOT__rec_agu_mod__DOT__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru) 
                                 >> 1U))) | (~ (IData)(vlSymsp->TOP__agu_block__DOT__rec_agu_mod__DOT__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru))) 
                      & (~ (1U & ((IData)(vlSymsp->TOP__agu_block__DOT__rec_agu_mod__DOT__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru) 
                                  >> 1U))))) << 1U)) 
           | (1U & (IData)(vlSymsp->TOP__agu_block__DOT__rec_agu_mod__DOT__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru)));
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__rec_agu_mod__DOT__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__4__KET____DOT__lru_mod__315(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__rec_agu_mod__DOT__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__4__KET____DOT__lru_mod__315\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->__PVT__adders_gen__DOT__cmp_mod__DOT__P1 
        = (1U | (6U & (2U | (0xfffffffeU & (IData)(vlSymsp->TOP__agu_block__DOT__rec_agu_mod__DOT__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru)))));
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__rec_agu_mod__DOT__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__4__KET____DOT__lru_mod__669(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__rec_agu_mod__DOT__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__4__KET____DOT__lru_mod__669\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->__PVT__hitAfter = (((IData)(this->__PVT__adders_gen__DOT__cmp_mod__DOT__C) 
                              >> 2U) & (4U != (IData)(vlSymsp->TOP__agu_block__DOT__rec_agu_mod__DOT__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru)));
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__rec_agu_mod__DOT__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__4__KET____DOT__lru_mod__765(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__rec_agu_mod__DOT__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__4__KET____DOT__lru_mod__765\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->newLRU__en = ((((((((4U == (IData)(vlSymsp->TOP__agu_block__DOT__rec_agu_mod__DOT__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru)) 
                              & (~ (IData)(vlSymsp->TOP__agu_block__DOT__rec_agu_mod__DOT__tlb_mod.__PVT__init))) 
                             & (IData)(vlSymsp->TOP__agu_block__DOT__rec_agu_mod__DOT__tlb_mod.__Vcellinp__ways_gen__BRA__0__KET____DOT__lru_mod__en))
                             ? 7U : 0U) | (IData)(this->newLRU__out__en2)) 
                          | (IData)(this->newLRU__out__en3)) 
                         | ((IData)(vlSymsp->TOP__agu_block__DOT__rec_agu_mod__DOT__tlb_mod.__PVT__init)
                             ? 7U : 0U)) | (IData)(this->newLRU__out__en5));
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__rec_agu_mod__DOT__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__5__KET____DOT__lru_mod__275(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__rec_agu_mod__DOT__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__5__KET____DOT__lru_mod__275\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->__PVT__adders_gen__DOT__cmp_mod__DOT__G1 
        = (6U & ((~ (((~ (1U | ((IData)(vlSymsp->TOP__agu_block__DOT__rec_agu_mod__DOT__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru) 
                                >> 1U))) | (~ (2U & (IData)(vlSymsp->TOP__agu_block__DOT__rec_agu_mod__DOT__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru)))) 
                     & (~ (1U & ((IData)(vlSymsp->TOP__agu_block__DOT__rec_agu_mod__DOT__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru) 
                                 >> 1U))))) << 1U));
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__rec_agu_mod__DOT__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__5__KET____DOT__lru_mod__316(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__rec_agu_mod__DOT__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__5__KET____DOT__lru_mod__316\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->__PVT__adders_gen__DOT__cmp_mod__DOT__P1 
        = ((6U & ((~ ((~ (1U | ((IData)(vlSymsp->TOP__agu_block__DOT__rec_agu_mod__DOT__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru) 
                                >> 1U))) | (~ (2U | (IData)(vlSymsp->TOP__agu_block__DOT__rec_agu_mod__DOT__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru))))) 
                  << 1U)) | (1U & (IData)(vlSymsp->TOP__agu_block__DOT__rec_agu_mod__DOT__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru)));
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__rec_agu_mod__DOT__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__5__KET____DOT__lru_mod__670(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__rec_agu_mod__DOT__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__5__KET____DOT__lru_mod__670\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->__PVT__hitAfter = (((IData)(this->__PVT__adders_gen__DOT__cmp_mod__DOT__C) 
                              >> 2U) & (5U != (IData)(vlSymsp->TOP__agu_block__DOT__rec_agu_mod__DOT__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru)));
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__rec_agu_mod__DOT__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__5__KET____DOT__lru_mod__766(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__rec_agu_mod__DOT__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__5__KET____DOT__lru_mod__766\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->newLRU__en = ((((((((5U == (IData)(vlSymsp->TOP__agu_block__DOT__rec_agu_mod__DOT__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru)) 
                              & (~ (IData)(vlSymsp->TOP__agu_block__DOT__rec_agu_mod__DOT__tlb_mod.__PVT__init))) 
                             & (IData)(vlSymsp->TOP__agu_block__DOT__rec_agu_mod__DOT__tlb_mod.__Vcellinp__ways_gen__BRA__0__KET____DOT__lru_mod__en))
                             ? 7U : 0U) | (IData)(this->newLRU__out__en2)) 
                          | (IData)(this->newLRU__out__en3)) 
                         | ((IData)(vlSymsp->TOP__agu_block__DOT__rec_agu_mod__DOT__tlb_mod.__PVT__init)
                             ? 7U : 0U)) | (IData)(this->newLRU__out__en5));
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__rec_agu_mod__DOT__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__6__KET____DOT__lru_mod__276(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__rec_agu_mod__DOT__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__6__KET____DOT__lru_mod__276\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->__PVT__adders_gen__DOT__cmp_mod__DOT__G1 
        = ((6U & ((~ ((~ ((IData)(vlSymsp->TOP__agu_block__DOT__rec_agu_mod__DOT__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru) 
                          >> 1U)) | (~ (1U & (IData)(vlSymsp->TOP__agu_block__DOT__rec_agu_mod__DOT__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru))))) 
                  << 1U)) | (1U & (IData)(vlSymsp->TOP__agu_block__DOT__rec_agu_mod__DOT__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru)));
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__rec_agu_mod__DOT__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__6__KET____DOT__lru_mod__317(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__rec_agu_mod__DOT__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__6__KET____DOT__lru_mod__317\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->__PVT__adders_gen__DOT__cmp_mod__DOT__P1 
        = (1U | (6U & ((~ ((~ ((IData)(vlSymsp->TOP__agu_block__DOT__rec_agu_mod__DOT__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru) 
                               >> 1U)) | (~ (1U | (IData)(vlSymsp->TOP__agu_block__DOT__rec_agu_mod__DOT__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru))))) 
                       << 1U)));
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__rec_agu_mod__DOT__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__6__KET____DOT__lru_mod__671(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__rec_agu_mod__DOT__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__6__KET____DOT__lru_mod__671\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->__PVT__hitAfter = (((IData)(this->__PVT__adders_gen__DOT__cmp_mod__DOT__C) 
                              >> 2U) & (6U != (IData)(vlSymsp->TOP__agu_block__DOT__rec_agu_mod__DOT__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru)));
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__rec_agu_mod__DOT__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__6__KET____DOT__lru_mod__767(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__rec_agu_mod__DOT__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__6__KET____DOT__lru_mod__767\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->newLRU__en = ((((((((6U == (IData)(vlSymsp->TOP__agu_block__DOT__rec_agu_mod__DOT__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru)) 
                              & (~ (IData)(vlSymsp->TOP__agu_block__DOT__rec_agu_mod__DOT__tlb_mod.__PVT__init))) 
                             & (IData)(vlSymsp->TOP__agu_block__DOT__rec_agu_mod__DOT__tlb_mod.__Vcellinp__ways_gen__BRA__0__KET____DOT__lru_mod__en))
                             ? 7U : 0U) | (IData)(this->newLRU__out__en2)) 
                          | (IData)(this->newLRU__out__en3)) 
                         | ((IData)(vlSymsp->TOP__agu_block__DOT__rec_agu_mod__DOT__tlb_mod.__PVT__init)
                             ? 7U : 0U)) | (IData)(this->newLRU__out__en5));
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__rec_agu_mod__DOT__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__7__KET____DOT__lru_mod__318(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__rec_agu_mod__DOT__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__7__KET____DOT__lru_mod__318\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->__PVT__adders_gen__DOT__cmp_mod__DOT__P1 
        = ((6U & ((~ ((~ ((IData)(vlSymsp->TOP__agu_block__DOT__rec_agu_mod__DOT__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru) 
                          >> 1U)) | (~ (IData)(vlSymsp->TOP__agu_block__DOT__rec_agu_mod__DOT__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru)))) 
                  << 1U)) | (1U & (IData)(vlSymsp->TOP__agu_block__DOT__rec_agu_mod__DOT__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru)));
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__rec_agu_mod__DOT__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__7__KET____DOT__lru_mod__672(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__rec_agu_mod__DOT__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__7__KET____DOT__lru_mod__672\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->__PVT__hitAfter = (((IData)(this->__PVT__adders_gen__DOT__cmp_mod__DOT__C) 
                              >> 2U) & (7U != (IData)(vlSymsp->TOP__agu_block__DOT__rec_agu_mod__DOT__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru)));
}

void Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__rec_agu_mod__DOT__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__7__KET____DOT__lru_mod__768(Vagu_block__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_settle__TOP__agu_block__DOT__rec_agu_mod__DOT__tlb_mod__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__7__KET____DOT__lru_mod__768\n"); );
    Vagu_block* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    this->newLRU__en = ((((((((7U == (IData)(vlSymsp->TOP__agu_block__DOT__rec_agu_mod__DOT__tlb_mod.__Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru)) 
                              & (~ (IData)(vlSymsp->TOP__agu_block__DOT__rec_agu_mod__DOT__tlb_mod.__PVT__init))) 
                             & (IData)(vlSymsp->TOP__agu_block__DOT__rec_agu_mod__DOT__tlb_mod.__Vcellinp__ways_gen__BRA__0__KET____DOT__lru_mod__en))
                             ? 7U : 0U) | (IData)(this->newLRU__out__en2)) 
                          | (IData)(this->newLRU__out__en3)) 
                         | ((IData)(vlSymsp->TOP__agu_block__DOT__rec_agu_mod__DOT__tlb_mod.__PVT__init)
                             ? 7U : 0U)) | (IData)(this->newLRU__out__en5));
}

void Vagu_block_lru_single0__I6::_ctor_var_reset() {
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vagu_block_lru_single0__I6::_ctor_var_reset\n"); );
    // Body
    __PVT__lru = VL_RAND_RESET_I(3);
    __PVT__newLRU = VL_RAND_RESET_I(3);
    __PVT__hitLRU = VL_RAND_RESET_I(3);
    __PVT__init = VL_RAND_RESET_I(1);
    __PVT__en = VL_RAND_RESET_I(1);
    __PVT__hitAfter = VL_RAND_RESET_I(1);
    __pinNumber2__en0 = 0;
    newLRU__out = VL_RAND_RESET_I(3);
    newLRU__en = VL_RAND_RESET_I(3);
    newLRU__out__en2 = 0;
    newLRU__out__en3 = 0;
    newLRU__out__en5 = 0;
    __PVT__adders_gen__DOT__cmp_mod__DOT__P1 = VL_RAND_RESET_I(3);
    __PVT__adders_gen__DOT__cmp_mod__DOT__G1 = VL_RAND_RESET_I(3);
    __PVT__adders_gen__DOT__cmp_mod__DOT__nP2 = VL_RAND_RESET_I(3);
    __PVT__adders_gen__DOT__cmp_mod__DOT__nG2 = VL_RAND_RESET_I(3);
    __PVT__adders_gen__DOT__cmp_mod__DOT__C = VL_RAND_RESET_I(3);
    __PVT__adders_gen__DOT__inc_mod__DOT__nP1 = VL_RAND_RESET_I(3);
    __PVT__adders_gen__DOT__inc_mod__DOT__P2 = VL_RAND_RESET_I(3);
    adders_gen__DOT__inc_mod__DOT__out__out__out0 = 0;
    adders_gen__DOT__inc_mod__DOT__out__out__out1 = 0;
    adders_gen__DOT__inc_mod__DOT__out__out__out2 = 0;
    adders_gen__DOT__inc_mod__DOT__out__out__out3 = 0;
    adders_gen__DOT__inc_mod__DOT__out__out__out4 = 0;
    adders_gen__DOT__inc_mod__DOT__out__out__out5 = 0;
}
