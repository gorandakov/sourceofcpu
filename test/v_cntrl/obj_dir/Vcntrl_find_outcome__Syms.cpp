// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Symbol table implementation internals

#include "Vcntrl_find_outcome__Syms.h"
#include "Vcntrl_find_outcome.h"



// FUNCTIONS
Vcntrl_find_outcome__Syms::Vcntrl_find_outcome__Syms(Vcntrl_find_outcome* topp, const char* namep)
    // Setup locals
    : __Vm_namep(namep)
    , __Vm_didInit(false)
    // Setup submodule names
{
    // Pointer to top level
    TOPp = topp;
    // Setup each module's pointers to their submodules
    // Setup each module's pointer back to symbol table (for public functions)
    TOPp->__Vconfigure(this, true);
}
