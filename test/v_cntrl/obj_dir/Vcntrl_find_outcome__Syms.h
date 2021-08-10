// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Symbol table internal header
//
// Internal details; most calling programs do not need this header,
// unless using verilator public meta comments.

#ifndef _VCNTRL_FIND_OUTCOME__SYMS_H_
#define _VCNTRL_FIND_OUTCOME__SYMS_H_  // guard

#include "verilated.h"

// INCLUDE MODULE CLASSES
#include "Vcntrl_find_outcome.h"

// SYMS CLASS
class Vcntrl_find_outcome__Syms : public VerilatedSyms {
  public:
    
    // LOCAL STATE
    const char* __Vm_namep;
    bool __Vm_didInit;
    
    // SUBCELL STATE
    Vcntrl_find_outcome*           TOPp;
    
    // CREATORS
    Vcntrl_find_outcome__Syms(Vcntrl_find_outcome* topp, const char* namep);
    ~Vcntrl_find_outcome__Syms() {}
    
    // METHODS
    inline const char* name() { return __Vm_namep; }
    
} VL_ATTR_ALIGNED(VL_CACHE_LINE_BYTES);

#endif  // guard
