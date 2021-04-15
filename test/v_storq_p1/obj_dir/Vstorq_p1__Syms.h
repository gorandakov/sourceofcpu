// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Symbol table internal header
//
// Internal details; most calling programs do not need this header,
// unless using verilator public meta comments.

#ifndef _Vstorq_p1__Syms_H_
#define _Vstorq_p1__Syms_H_

#include "verilated_heavy.h"

// INCLUDE MODULE CLASSES
#include "Vstorq_p1.h"

// SYMS CLASS
class Vstorq_p1__Syms : public VerilatedSyms {
  public:
    
    // LOCAL STATE
    const char* __Vm_namep;
    bool __Vm_didInit;
    
    // SUBCELL STATE
    Vstorq_p1*                     TOPp;
    
    // CREATORS
    Vstorq_p1__Syms(Vstorq_p1* topp, const char* namep);
    ~Vstorq_p1__Syms() {}
    
    // METHODS
    inline const char* name() { return __Vm_namep; }
    
} VL_ATTR_ALIGNED(64);

#endif  // guard
