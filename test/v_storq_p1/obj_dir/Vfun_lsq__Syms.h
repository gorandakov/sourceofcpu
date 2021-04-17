// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Symbol table internal header
//
// Internal details; most calling programs do not need this header,
// unless using verilator public meta comments.

#ifndef _Vfun_lsq__Syms_H_
#define _Vfun_lsq__Syms_H_

#include "verilated_heavy.h"

// INCLUDE MODULE CLASSES
#include "Vfun_lsq.h"

// SYMS CLASS
class Vfun_lsq__Syms : public VerilatedSyms {
  public:
    
    // LOCAL STATE
    const char* __Vm_namep;
    bool __Vm_didInit;
    
    // SUBCELL STATE
    Vfun_lsq*                      TOPp;
    
    // CREATORS
    Vfun_lsq__Syms(Vfun_lsq* topp, const char* namep);
    ~Vfun_lsq__Syms() {}
    
    // METHODS
    inline const char* name() { return __Vm_namep; }
    
} VL_ATTR_ALIGNED(64);

#endif  // guard
