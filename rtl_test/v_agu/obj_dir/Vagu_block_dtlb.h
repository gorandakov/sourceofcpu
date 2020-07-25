// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design internal header
// See Vagu_block.h for the primary calling header

#ifndef _VAGU_BLOCK_DTLB_H_
#define _VAGU_BLOCK_DTLB_H_  // guard

#include "verilated_heavy.h"
#include "verilated_threads.h"

//==========

class Vagu_block__Syms;
class Vagu_block_lru_single0__I0;
class Vagu_block_lru_single0__I1;
class Vagu_block_lru_single0__I2;
class Vagu_block_lru_single0__I3;
class Vagu_block_lru_single0__I4;
class Vagu_block_lru_single0__I5;
class Vagu_block_lru_single0__I6;
class Vagu_block_lru_single0__I7;


//----------

VL_MODULE(Vagu_block_dtlb) {
  public:
    // CELLS
    Vagu_block_lru_single0__I0* __PVT__ways_gen__BRA__0__KET____DOT__lru_mod__DOT__lru_gen__BRA__0__KET____DOT__lru_mod;
    Vagu_block_lru_single0__I0* __PVT__ways_gen__BRA__0__KET____DOT__lru_mod__DOT__lru_gen__BRA__1__KET____DOT__lru_mod;
    Vagu_block_lru_single0__I0* __PVT__ways_gen__BRA__0__KET____DOT__lru_mod__DOT__lru_gen__BRA__2__KET____DOT__lru_mod;
    Vagu_block_lru_single0__I0* __PVT__ways_gen__BRA__0__KET____DOT__lru_mod__DOT__lru_gen__BRA__3__KET____DOT__lru_mod;
    Vagu_block_lru_single0__I0* __PVT__ways_gen__BRA__0__KET____DOT__lru_mod__DOT__lru_gen__BRA__4__KET____DOT__lru_mod;
    Vagu_block_lru_single0__I0* __PVT__ways_gen__BRA__0__KET____DOT__lru_mod__DOT__lru_gen__BRA__5__KET____DOT__lru_mod;
    Vagu_block_lru_single0__I0* __PVT__ways_gen__BRA__0__KET____DOT__lru_mod__DOT__lru_gen__BRA__6__KET____DOT__lru_mod;
    Vagu_block_lru_single0__I0* __PVT__ways_gen__BRA__0__KET____DOT__lru_mod__DOT__lru_gen__BRA__7__KET____DOT__lru_mod;
    Vagu_block_lru_single0__I1* __PVT__ways_gen__BRA__1__KET____DOT__lru_mod__DOT__lru_gen__BRA__0__KET____DOT__lru_mod;
    Vagu_block_lru_single0__I1* __PVT__ways_gen__BRA__1__KET____DOT__lru_mod__DOT__lru_gen__BRA__1__KET____DOT__lru_mod;
    Vagu_block_lru_single0__I1* __PVT__ways_gen__BRA__1__KET____DOT__lru_mod__DOT__lru_gen__BRA__2__KET____DOT__lru_mod;
    Vagu_block_lru_single0__I1* __PVT__ways_gen__BRA__1__KET____DOT__lru_mod__DOT__lru_gen__BRA__3__KET____DOT__lru_mod;
    Vagu_block_lru_single0__I1* __PVT__ways_gen__BRA__1__KET____DOT__lru_mod__DOT__lru_gen__BRA__4__KET____DOT__lru_mod;
    Vagu_block_lru_single0__I1* __PVT__ways_gen__BRA__1__KET____DOT__lru_mod__DOT__lru_gen__BRA__5__KET____DOT__lru_mod;
    Vagu_block_lru_single0__I1* __PVT__ways_gen__BRA__1__KET____DOT__lru_mod__DOT__lru_gen__BRA__6__KET____DOT__lru_mod;
    Vagu_block_lru_single0__I1* __PVT__ways_gen__BRA__1__KET____DOT__lru_mod__DOT__lru_gen__BRA__7__KET____DOT__lru_mod;
    Vagu_block_lru_single0__I2* __PVT__ways_gen__BRA__2__KET____DOT__lru_mod__DOT__lru_gen__BRA__0__KET____DOT__lru_mod;
    Vagu_block_lru_single0__I2* __PVT__ways_gen__BRA__2__KET____DOT__lru_mod__DOT__lru_gen__BRA__1__KET____DOT__lru_mod;
    Vagu_block_lru_single0__I2* __PVT__ways_gen__BRA__2__KET____DOT__lru_mod__DOT__lru_gen__BRA__2__KET____DOT__lru_mod;
    Vagu_block_lru_single0__I2* __PVT__ways_gen__BRA__2__KET____DOT__lru_mod__DOT__lru_gen__BRA__3__KET____DOT__lru_mod;
    Vagu_block_lru_single0__I2* __PVT__ways_gen__BRA__2__KET____DOT__lru_mod__DOT__lru_gen__BRA__4__KET____DOT__lru_mod;
    Vagu_block_lru_single0__I2* __PVT__ways_gen__BRA__2__KET____DOT__lru_mod__DOT__lru_gen__BRA__5__KET____DOT__lru_mod;
    Vagu_block_lru_single0__I2* __PVT__ways_gen__BRA__2__KET____DOT__lru_mod__DOT__lru_gen__BRA__6__KET____DOT__lru_mod;
    Vagu_block_lru_single0__I2* __PVT__ways_gen__BRA__2__KET____DOT__lru_mod__DOT__lru_gen__BRA__7__KET____DOT__lru_mod;
    Vagu_block_lru_single0__I3* __PVT__ways_gen__BRA__3__KET____DOT__lru_mod__DOT__lru_gen__BRA__0__KET____DOT__lru_mod;
    Vagu_block_lru_single0__I3* __PVT__ways_gen__BRA__3__KET____DOT__lru_mod__DOT__lru_gen__BRA__1__KET____DOT__lru_mod;
    Vagu_block_lru_single0__I3* __PVT__ways_gen__BRA__3__KET____DOT__lru_mod__DOT__lru_gen__BRA__2__KET____DOT__lru_mod;
    Vagu_block_lru_single0__I3* __PVT__ways_gen__BRA__3__KET____DOT__lru_mod__DOT__lru_gen__BRA__3__KET____DOT__lru_mod;
    Vagu_block_lru_single0__I3* __PVT__ways_gen__BRA__3__KET____DOT__lru_mod__DOT__lru_gen__BRA__4__KET____DOT__lru_mod;
    Vagu_block_lru_single0__I3* __PVT__ways_gen__BRA__3__KET____DOT__lru_mod__DOT__lru_gen__BRA__5__KET____DOT__lru_mod;
    Vagu_block_lru_single0__I3* __PVT__ways_gen__BRA__3__KET____DOT__lru_mod__DOT__lru_gen__BRA__6__KET____DOT__lru_mod;
    Vagu_block_lru_single0__I3* __PVT__ways_gen__BRA__3__KET____DOT__lru_mod__DOT__lru_gen__BRA__7__KET____DOT__lru_mod;
    Vagu_block_lru_single0__I4* __PVT__ways_gen__BRA__4__KET____DOT__lru_mod__DOT__lru_gen__BRA__0__KET____DOT__lru_mod;
    Vagu_block_lru_single0__I4* __PVT__ways_gen__BRA__4__KET____DOT__lru_mod__DOT__lru_gen__BRA__1__KET____DOT__lru_mod;
    Vagu_block_lru_single0__I4* __PVT__ways_gen__BRA__4__KET____DOT__lru_mod__DOT__lru_gen__BRA__2__KET____DOT__lru_mod;
    Vagu_block_lru_single0__I4* __PVT__ways_gen__BRA__4__KET____DOT__lru_mod__DOT__lru_gen__BRA__3__KET____DOT__lru_mod;
    Vagu_block_lru_single0__I4* __PVT__ways_gen__BRA__4__KET____DOT__lru_mod__DOT__lru_gen__BRA__4__KET____DOT__lru_mod;
    Vagu_block_lru_single0__I4* __PVT__ways_gen__BRA__4__KET____DOT__lru_mod__DOT__lru_gen__BRA__5__KET____DOT__lru_mod;
    Vagu_block_lru_single0__I4* __PVT__ways_gen__BRA__4__KET____DOT__lru_mod__DOT__lru_gen__BRA__6__KET____DOT__lru_mod;
    Vagu_block_lru_single0__I4* __PVT__ways_gen__BRA__4__KET____DOT__lru_mod__DOT__lru_gen__BRA__7__KET____DOT__lru_mod;
    Vagu_block_lru_single0__I5* __PVT__ways_gen__BRA__5__KET____DOT__lru_mod__DOT__lru_gen__BRA__0__KET____DOT__lru_mod;
    Vagu_block_lru_single0__I5* __PVT__ways_gen__BRA__5__KET____DOT__lru_mod__DOT__lru_gen__BRA__1__KET____DOT__lru_mod;
    Vagu_block_lru_single0__I5* __PVT__ways_gen__BRA__5__KET____DOT__lru_mod__DOT__lru_gen__BRA__2__KET____DOT__lru_mod;
    Vagu_block_lru_single0__I5* __PVT__ways_gen__BRA__5__KET____DOT__lru_mod__DOT__lru_gen__BRA__3__KET____DOT__lru_mod;
    Vagu_block_lru_single0__I5* __PVT__ways_gen__BRA__5__KET____DOT__lru_mod__DOT__lru_gen__BRA__4__KET____DOT__lru_mod;
    Vagu_block_lru_single0__I5* __PVT__ways_gen__BRA__5__KET____DOT__lru_mod__DOT__lru_gen__BRA__5__KET____DOT__lru_mod;
    Vagu_block_lru_single0__I5* __PVT__ways_gen__BRA__5__KET____DOT__lru_mod__DOT__lru_gen__BRA__6__KET____DOT__lru_mod;
    Vagu_block_lru_single0__I5* __PVT__ways_gen__BRA__5__KET____DOT__lru_mod__DOT__lru_gen__BRA__7__KET____DOT__lru_mod;
    Vagu_block_lru_single0__I6* __PVT__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__0__KET____DOT__lru_mod;
    Vagu_block_lru_single0__I6* __PVT__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__1__KET____DOT__lru_mod;
    Vagu_block_lru_single0__I6* __PVT__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__2__KET____DOT__lru_mod;
    Vagu_block_lru_single0__I6* __PVT__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__3__KET____DOT__lru_mod;
    Vagu_block_lru_single0__I6* __PVT__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__4__KET____DOT__lru_mod;
    Vagu_block_lru_single0__I6* __PVT__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__5__KET____DOT__lru_mod;
    Vagu_block_lru_single0__I6* __PVT__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__6__KET____DOT__lru_mod;
    Vagu_block_lru_single0__I6* __PVT__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__lru_gen__BRA__7__KET____DOT__lru_mod;
    Vagu_block_lru_single0__I7* __PVT__ways_gen__BRA__7__KET____DOT__lru_mod__DOT__lru_gen__BRA__0__KET____DOT__lru_mod;
    Vagu_block_lru_single0__I7* __PVT__ways_gen__BRA__7__KET____DOT__lru_mod__DOT__lru_gen__BRA__1__KET____DOT__lru_mod;
    Vagu_block_lru_single0__I7* __PVT__ways_gen__BRA__7__KET____DOT__lru_mod__DOT__lru_gen__BRA__2__KET____DOT__lru_mod;
    Vagu_block_lru_single0__I7* __PVT__ways_gen__BRA__7__KET____DOT__lru_mod__DOT__lru_gen__BRA__3__KET____DOT__lru_mod;
    Vagu_block_lru_single0__I7* __PVT__ways_gen__BRA__7__KET____DOT__lru_mod__DOT__lru_gen__BRA__4__KET____DOT__lru_mod;
    Vagu_block_lru_single0__I7* __PVT__ways_gen__BRA__7__KET____DOT__lru_mod__DOT__lru_gen__BRA__5__KET____DOT__lru_mod;
    Vagu_block_lru_single0__I7* __PVT__ways_gen__BRA__7__KET____DOT__lru_mod__DOT__lru_gen__BRA__6__KET____DOT__lru_mod;
    Vagu_block_lru_single0__I7* __PVT__ways_gen__BRA__7__KET____DOT__lru_mod__DOT__lru_gen__BRA__7__KET____DOT__lru_mod;
    
    // PORTS
    // Begin mtask footprint all: 1 3 8 10 15 28 29 
    VL_OUT8(read_hit,0,0);
    // Begin mtask footprint all: 1 3 11 15 24 28 37 
    VL_OUT64(read_data_next,40,0);
    // Begin mtask footprint all: 3 11 15 24 28 29 37 
    VL_OUT64(read_data,40,0);
    // Begin mtask footprint all: 
    VL_IN64(addr,51,0);
    VL_IN64(write_addr,50,0);
    VL_IN64(write_data0,40,0);
    VL_IN64(write_data1,40,0);
    VL_IN64(write_data2,40,0);
    VL_IN(sproc,20,0);
    VL_IN8(rst,0,0);
    VL_IN8(read_clkEn,0,0);
    VL_IN8(sec_wren,0,0);
    VL_IN8(read_way,2,0);
    VL_IN8(write_wen,0,0);
    VL_IN8(write_xstant,0,0);
    VL_IN8(write_invl,0,0);
    VL_IN8(force_way_en,0,0);
    VL_IN8(force_way,2,0);
    VL_OUT8(read_way__out,2,0);
    VL_OUT8(read_way__en,2,0);
    VL_IN8(clk,0,0);
    
    // LOCAL SIGNALS
    // Anonymous structures to workaround compiler member-count bugs
    struct {
        // Begin mtask footprint all: 1 3 4 8 11 15 16 17 18 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 
        CData/*0:0*/ __PVT__init;
        // Begin mtask footprint all: 1 4 8 15 24 37 
        WData/*175:0*/ __PVT__ways_gen__BRA__5__KET____DOT__way_mod__DOT__read_data_ram[6];
        WData/*175:0*/ __PVT__ways_gen__BRA__6__KET____DOT__way_mod__DOT__read_data_ram[6];
        // Begin mtask footprint all: 1 8 15 24 37 
        WData/*175:0*/ __PVT__ways_gen__BRA__0__KET____DOT__way_mod__DOT__read_data_ram[6];
        WData/*175:0*/ __PVT__ways_gen__BRA__1__KET____DOT__way_mod__DOT__read_data_ram[6];
        WData/*175:0*/ __PVT__ways_gen__BRA__2__KET____DOT__way_mod__DOT__read_data_ram[6];
        WData/*175:0*/ __PVT__ways_gen__BRA__3__KET____DOT__way_mod__DOT__read_data_ram[6];
        WData/*175:0*/ __PVT__ways_gen__BRA__4__KET____DOT__way_mod__DOT__read_data_ram[6];
        WData/*175:0*/ __PVT__ways_gen__BRA__7__KET____DOT__way_mod__DOT__read_data_ram[6];
        // Begin mtask footprint all: 15 24 37 
        QData/*40:0*/ __PVT__read_data1;
        // Begin mtask footprint all: 1 8 15 
        CData/*7:0*/ __PVT__read_hit_way;
        // Begin mtask footprint all: 1 8 
        WData/*175:0*/ __PVT__ways_gen__BRA__0__KET____DOT__way_mod__DOT__ram_mod__DOT__ram[16][6];
        WData/*175:0*/ __PVT__ways_gen__BRA__1__KET____DOT__way_mod__DOT__ram_mod__DOT__ram[16][6];
        WData/*175:0*/ __PVT__ways_gen__BRA__2__KET____DOT__way_mod__DOT__ram_mod__DOT__ram[16][6];
        WData/*175:0*/ __PVT__ways_gen__BRA__3__KET____DOT__way_mod__DOT__ram_mod__DOT__ram[16][6];
        WData/*175:0*/ __PVT__ways_gen__BRA__4__KET____DOT__way_mod__DOT__ram_mod__DOT__ram[16][6];
        WData/*175:0*/ __PVT__ways_gen__BRA__7__KET____DOT__way_mod__DOT__ram_mod__DOT__ram[16][6];
        // Begin mtask footprint all: 1 4 8 
        WData/*175:0*/ __PVT__ways_gen__BRA__5__KET____DOT__way_mod__DOT__ram_mod__DOT__ram[16][6];
        WData/*175:0*/ __PVT__ways_gen__BRA__6__KET____DOT__way_mod__DOT__ram_mod__DOT__ram[16][6];
        // Begin mtask footprint all: 1 3 4 7 8 18 26 
        CData/*3:0*/ __PVT__initCount;
        // Begin mtask footprint all: 1 7 8 18 26 
        CData/*3:0*/ __PVT__wrAddrNxt;
        CData/*3:0*/ __PVT__initAdd_mod__DOT__nP1;
        CData/*3:0*/ __PVT__initAdd_mod__DOT__P2;
        // Begin mtask footprint all: 1 
        CData/*2:0*/ __PVT__ways_gen__BRA__0__KET____DOT__way_mod__DOT__ramr_mod__DOT__ram[16];
        CData/*2:0*/ __PVT__ways_gen__BRA__0__KET____DOT__way_mod__DOT__ramw_mod__DOT__ram[16];
        CData/*2:0*/ __PVT__ways_gen__BRA__1__KET____DOT__way_mod__DOT__ramw_mod__DOT__ram[16];
        CData/*2:0*/ __PVT__ways_gen__BRA__2__KET____DOT__way_mod__DOT__ramr_mod__DOT__ram[16];
        CData/*2:0*/ __PVT__ways_gen__BRA__2__KET____DOT__way_mod__DOT__ramw_mod__DOT__ram[16];
        CData/*2:0*/ __PVT__ways_gen__BRA__3__KET____DOT__way_mod__DOT__ramr_mod__DOT__ram[16];
        CData/*2:0*/ __PVT__ways_gen__BRA__3__KET____DOT__way_mod__DOT__ramw_mod__DOT__ram[16];
        CData/*2:0*/ __PVT__ways_gen__BRA__4__KET____DOT__way_mod__DOT__ramr_mod__DOT__ram[16];
        CData/*2:0*/ __PVT__ways_gen__BRA__4__KET____DOT__way_mod__DOT__ramw_mod__DOT__ram[16];
        CData/*2:0*/ __PVT__ways_gen__BRA__5__KET____DOT__way_mod__DOT__ramr_mod__DOT__ram[16];
        CData/*2:0*/ __PVT__ways_gen__BRA__5__KET____DOT__way_mod__DOT__ramw_mod__DOT__ram[16];
        CData/*2:0*/ __PVT__ways_gen__BRA__6__KET____DOT__way_mod__DOT__ramr_mod__DOT__ram[16];
        CData/*2:0*/ __PVT__ways_gen__BRA__6__KET____DOT__way_mod__DOT__ramw_mod__DOT__ram[16];
        CData/*2:0*/ __PVT__ways_gen__BRA__7__KET____DOT__way_mod__DOT__ramr_mod__DOT__ram[16];
        CData/*2:0*/ __PVT__ways_gen__BRA__7__KET____DOT__way_mod__DOT__ramw_mod__DOT__ram[16];
        // Begin mtask footprint all: 1 18 
        IData/*23:0*/ __PVT__lru_wayW;
        // Begin mtask footprint all: 1 18 25 
        IData/*23:0*/ __PVT__lru_way;
        CData/*7:0*/ __PVT__read_hitL_way;
        // Begin mtask footprint all: 1 11 18 25 32 
        CData/*2:0*/ __PVT__hitLru;
        // Begin mtask footprint all: 30 31 32 35 36 
        IData/*23:0*/ __PVT__ways_gen__BRA__4__KET____DOT__lru_mod__DOT__newLRUa;
        // Begin mtask footprint all: 30 31 35 36 37 
        IData/*23:0*/ __PVT__ways_gen__BRA__5__KET____DOT__lru_mod__DOT__newLRUa;
        IData/*23:0*/ __PVT__ways_gen__BRA__6__KET____DOT__lru_mod__DOT__newLRUa;
        IData/*23:0*/ __PVT__ways_gen__BRA__7__KET____DOT__lru_mod__DOT__newLRUa;
        // Begin mtask footprint all: 31 35 36 37 
        IData/*23:0*/ __PVT__ways_gen__BRA__0__KET____DOT__lru_mod__DOT__newLRUa;
        IData/*23:0*/ __PVT__ways_gen__BRA__1__KET____DOT__lru_mod__DOT__newLRUa;
        // Begin mtask footprint all: 35 36 37 
        IData/*23:0*/ __PVT__ways_gen__BRA__2__KET____DOT__lru_mod__DOT__newLRUa;
        // Begin mtask footprint all: 3 4 35 36 37 
        IData/*23:0*/ __PVT__newLru;
        // Begin mtask footprint all: 27 32 35 36 37 
        IData/*23:0*/ __PVT__ways_gen__BRA__3__KET____DOT__lru_mod__DOT__newLRUa;
        // Begin mtask footprint all: 1 3 
        CData/*2:0*/ __PVT__ways_gen__BRA__1__KET____DOT__way_mod__DOT__ramr_mod__DOT__ram[16];
        // Begin mtask footprint all: 1 3 4 
        CData/*2:0*/ __PVT__ways_gen__BRA__0__KET____DOT__way_mod__DOT__write_lru;
        CData/*2:0*/ __PVT__ways_gen__BRA__1__KET____DOT__way_mod__DOT__write_lru;
        CData/*2:0*/ __PVT__ways_gen__BRA__2__KET____DOT__way_mod__DOT__write_lru;
        CData/*2:0*/ __PVT__ways_gen__BRA__3__KET____DOT__way_mod__DOT__write_lru;
        CData/*2:0*/ __PVT__ways_gen__BRA__4__KET____DOT__way_mod__DOT__write_lru;
        CData/*2:0*/ __PVT__ways_gen__BRA__5__KET____DOT__way_mod__DOT__write_lru;
        CData/*2:0*/ __PVT__ways_gen__BRA__6__KET____DOT__way_mod__DOT__write_lru;
        CData/*2:0*/ __PVT__ways_gen__BRA__7__KET____DOT__way_mod__DOT__write_lru;
        // Begin mtask footprint all: 3 4 8 28 29 
        WData/*175:0*/ __PVT__ways_gen__BRA__2__KET____DOT__way_mod__DOT__write_data_new[6];
        WData/*175:0*/ __PVT__ways_gen__BRA__3__KET____DOT__way_mod__DOT__write_data_new[6];
        WData/*175:0*/ __PVT__ways_gen__BRA__4__KET____DOT__way_mod__DOT__write_data_new[6];
        WData/*175:0*/ __PVT__ways_gen__BRA__5__KET____DOT__way_mod__DOT__write_data_new[6];
    };
    struct {
        WData/*175:0*/ __PVT__ways_gen__BRA__6__KET____DOT__way_mod__DOT__write_data_new[6];
        WData/*175:0*/ __PVT__ways_gen__BRA__7__KET____DOT__way_mod__DOT__write_data_new[6];
        // Begin mtask footprint all: 3 4 8 15 28 29 
        WData/*175:0*/ __PVT__ways_gen__BRA__0__KET____DOT__way_mod__DOT__write_data_new[6];
        WData/*175:0*/ __PVT__ways_gen__BRA__1__KET____DOT__way_mod__DOT__write_data_new[6];
    };
    
    // LOCAL VARIABLES
    // Anonymous structures to workaround compiler member-count bugs
    struct {
        // Begin mtask footprint all: 1 11 16 18 23 24 25 26 27 33 34 35 36 
        CData/*0:0*/ __Vcellinp__ways_gen__BRA__0__KET____DOT__lru_mod__en;
        // Begin mtask footprint all: 1 11 16 18 23 24 25 26 27 33 35 
        CData/*2:0*/ __Vcellinp__ways_gen__BRA__0__KET____DOT__lru_mod__lru;
        // Begin mtask footprint all: 1 11 16 17 18 23 24 25 26 27 32 33 35 
        CData/*2:0*/ __Vcellinp__ways_gen__BRA__1__KET____DOT__lru_mod__lru;
        // Begin mtask footprint all: 1 11 16 17 18 23 24 25 26 27 30 31 32 33 34 35 
        CData/*2:0*/ __Vcellinp__ways_gen__BRA__7__KET____DOT__lru_mod__lru;
        // Begin mtask footprint all: 1 11 16 17 18 23 25 26 27 31 32 33 34 35 
        CData/*2:0*/ __Vcellinp__ways_gen__BRA__3__KET____DOT__lru_mod__lru;
        // Begin mtask footprint all: 1 16 17 18 23 24 25 26 27 31 32 33 34 35 
        CData/*2:0*/ __Vcellinp__ways_gen__BRA__2__KET____DOT__lru_mod__lru;
        // Begin mtask footprint all: 1 11 16 17 18 23 24 25 26 30 31 32 33 34 35 37 
        CData/*2:0*/ __Vcellinp__ways_gen__BRA__5__KET____DOT__lru_mod__lru;
        // Begin mtask footprint all: 1 11 16 17 18 23 24 25 26 30 32 33 34 35 
        CData/*2:0*/ __Vcellinp__ways_gen__BRA__4__KET____DOT__lru_mod__lru;
        // Begin mtask footprint all: 1 11 16 17 18 23 24 25 26 27 30 31 32 33 34 35 36 
        CData/*2:0*/ __Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__lru;
        // Begin mtask footprint all: 1 11 16 17 23 26 27 32 
        CData/*0:0*/ __Vcellinp__ways_gen__BRA__1__KET____DOT__lru_mod__en;
        // Begin mtask footprint all: 1 11 16 17 23 26 27 31 32 
        CData/*0:0*/ __Vcellinp__ways_gen__BRA__2__KET____DOT__lru_mod__en;
        CData/*0:0*/ __Vcellinp__ways_gen__BRA__3__KET____DOT__lru_mod__en;
        // Begin mtask footprint all: 1 11 16 17 23 26 27 30 31 32 
        CData/*0:0*/ __Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__en;
        CData/*0:0*/ __Vcellinp__ways_gen__BRA__7__KET____DOT__lru_mod__en;
        // Begin mtask footprint all: 1 11 16 17 23 26 30 32 
        CData/*0:0*/ __Vcellinp__ways_gen__BRA__4__KET____DOT__lru_mod__en;
        // Begin mtask footprint all: 1 11 16 17 23 26 30 31 32 37 
        CData/*0:0*/ __Vcellinp__ways_gen__BRA__5__KET____DOT__lru_mod__en;
        // Begin mtask footprint all: 11 30 31 32 37 
        CData/*2:0*/ __Vcellinp__ways_gen__BRA__5__KET____DOT__lru_mod__hitLRU;
        CData/*2:0*/ __Vcellinp__ways_gen__BRA__7__KET____DOT__lru_mod__hitLRU;
        // Begin mtask footprint all: 11 27 30 31 32 37 
        CData/*2:0*/ __Vcellinp__ways_gen__BRA__6__KET____DOT__lru_mod__hitLRU;
        // Begin mtask footprint all: 11 27 31 32 37 
        CData/*2:0*/ __Vcellinp__ways_gen__BRA__1__KET____DOT__lru_mod__hitLRU;
        CData/*2:0*/ __Vcellinp__ways_gen__BRA__2__KET____DOT__lru_mod__hitLRU;
        CData/*2:0*/ __Vcellinp__ways_gen__BRA__3__KET____DOT__lru_mod__hitLRU;
        // Begin mtask footprint all: 11 30 31 32 
        CData/*2:0*/ __Vcellinp__ways_gen__BRA__4__KET____DOT__lru_mod__hitLRU;
        // Begin mtask footprint all: 30 31 32 35 36 
        IData/*23:0*/ ways_gen__BRA__4__KET____DOT__lru_mod__DOT__newLRUa__en;
        // Begin mtask footprint all: 30 31 32 34 35 36 
        IData/*23:0*/ ways_gen__BRA__4__KET____DOT__lru_mod__DOT__newLRUa__out19;
        IData/*23:0*/ ways_gen__BRA__4__KET____DOT__lru_mod__DOT__newLRUa__out20;
        IData/*23:0*/ ways_gen__BRA__4__KET____DOT__lru_mod__DOT__newLRUa__out21;
        IData/*23:0*/ ways_gen__BRA__4__KET____DOT__lru_mod__DOT__newLRUa__out22;
        // Begin mtask footprint all: 11 25 30 31 32 34 35 36 
        IData/*23:0*/ ways_gen__BRA__4__KET____DOT__lru_mod__DOT__newLRUa__out23;
        IData/*23:0*/ ways_gen__BRA__4__KET____DOT__lru_mod__DOT__newLRUa__out24;
        // Begin mtask footprint all: 30 31 32 33 34 35 36 
        IData/*23:0*/ ways_gen__BRA__4__KET____DOT__lru_mod__DOT__newLRUa__out17;
        IData/*23:0*/ ways_gen__BRA__4__KET____DOT__lru_mod__DOT__newLRUa__out18;
        // Begin mtask footprint all: 30 31 32 33 34 35 36 37 
        IData/*23:0*/ ways_gen__BRA__5__KET____DOT__lru_mod__DOT__newLRUa__out19;
        IData/*23:0*/ ways_gen__BRA__5__KET____DOT__lru_mod__DOT__newLRUa__out20;
        // Begin mtask footprint all: 11 30 31 32 33 34 35 36 37 
        IData/*23:0*/ ways_gen__BRA__5__KET____DOT__lru_mod__DOT__newLRUa__out21;
        IData/*23:0*/ ways_gen__BRA__5__KET____DOT__lru_mod__DOT__newLRUa__out22;
        // Begin mtask footprint all: 11 31 32 33 35 36 37 
        IData/*23:0*/ ways_gen__BRA__1__KET____DOT__lru_mod__DOT__newLRUa__out21;
        IData/*23:0*/ ways_gen__BRA__1__KET____DOT__lru_mod__DOT__newLRUa__out22;
        // Begin mtask footprint all: 11 18 25 27 31 32 33 35 36 37 
        CData/*2:0*/ __Vcellinp__ways_gen__BRA__0__KET____DOT__lru_mod__hitLRU;
        // Begin mtask footprint all: 11 23 25 27 31 35 36 37 
        IData/*23:0*/ ways_gen__BRA__0__KET____DOT__lru_mod__DOT__newLRUa__out17;
        IData/*23:0*/ ways_gen__BRA__0__KET____DOT__lru_mod__DOT__newLRUa__out18;
        IData/*23:0*/ ways_gen__BRA__0__KET____DOT__lru_mod__DOT__newLRUa__out19;
        IData/*23:0*/ ways_gen__BRA__0__KET____DOT__lru_mod__DOT__newLRUa__out20;
        IData/*23:0*/ ways_gen__BRA__0__KET____DOT__lru_mod__DOT__newLRUa__out21;
        IData/*23:0*/ ways_gen__BRA__0__KET____DOT__lru_mod__DOT__newLRUa__out22;
        IData/*23:0*/ ways_gen__BRA__0__KET____DOT__lru_mod__DOT__newLRUa__out23;
        IData/*23:0*/ ways_gen__BRA__0__KET____DOT__lru_mod__DOT__newLRUa__out24;
        // Begin mtask footprint all: 27 31 35 36 37 
        CData/*2:0*/ ways_gen__BRA__0__KET____DOT__lru_mod__DOT__newLRU__out__en12;
        CData/*2:0*/ ways_gen__BRA__0__KET____DOT__lru_mod__DOT__newLRU__out__en13;
        CData/*2:0*/ ways_gen__BRA__0__KET____DOT__lru_mod__DOT__newLRU__out__en14;
        CData/*2:0*/ ways_gen__BRA__0__KET____DOT__lru_mod__DOT__newLRU__out__en15;
        // Begin mtask footprint all: 27 31 33 35 36 37 
        IData/*23:0*/ ways_gen__BRA__0__KET____DOT__lru_mod__DOT__newLRUa__en;
        CData/*2:0*/ ways_gen__BRA__0__KET____DOT__lru_mod__DOT__newLRU__out__en8;
        CData/*2:0*/ ways_gen__BRA__0__KET____DOT__lru_mod__DOT__newLRU__out__en9;
        CData/*2:0*/ ways_gen__BRA__0__KET____DOT__lru_mod__DOT__newLRU__out__en10;
        CData/*2:0*/ ways_gen__BRA__0__KET____DOT__lru_mod__DOT__newLRU__out__en11;
        IData/*23:0*/ ways_gen__BRA__1__KET____DOT__lru_mod__DOT__newLRUa__en;
        CData/*2:0*/ ways_gen__BRA__1__KET____DOT__lru_mod__DOT__newLRU__out__en8;
        CData/*2:0*/ ways_gen__BRA__1__KET____DOT__lru_mod__DOT__newLRU__out__en9;
        CData/*2:0*/ ways_gen__BRA__1__KET____DOT__lru_mod__DOT__newLRU__out__en10;
        CData/*2:0*/ ways_gen__BRA__1__KET____DOT__lru_mod__DOT__newLRU__out__en11;
        CData/*2:0*/ ways_gen__BRA__1__KET____DOT__lru_mod__DOT__newLRU__out__en12;
        CData/*2:0*/ ways_gen__BRA__1__KET____DOT__lru_mod__DOT__newLRU__out__en13;
        CData/*2:0*/ ways_gen__BRA__1__KET____DOT__lru_mod__DOT__newLRU__out__en14;
    };
    struct {
        CData/*2:0*/ ways_gen__BRA__1__KET____DOT__lru_mod__DOT__newLRU__out__en15;
        // Begin mtask footprint all: 31 33 35 36 37 
        CData/*2:0*/ ways_gen__BRA__2__KET____DOT__lru_mod__DOT__newLRU__out__en14;
        CData/*2:0*/ ways_gen__BRA__2__KET____DOT__lru_mod__DOT__newLRU__out__en15;
        // Begin mtask footprint all: 27 30 31 34 35 36 37 
        IData/*23:0*/ ways_gen__BRA__6__KET____DOT__lru_mod__DOT__newLRUa__out17;
        IData/*23:0*/ ways_gen__BRA__6__KET____DOT__lru_mod__DOT__newLRUa__out18;
        IData/*23:0*/ ways_gen__BRA__6__KET____DOT__lru_mod__DOT__newLRUa__out19;
        IData/*23:0*/ ways_gen__BRA__6__KET____DOT__lru_mod__DOT__newLRUa__out20;
        // Begin mtask footprint all: 11 30 31 34 35 36 37 
        IData/*23:0*/ ways_gen__BRA__7__KET____DOT__lru_mod__DOT__newLRUa__out21;
        IData/*23:0*/ ways_gen__BRA__7__KET____DOT__lru_mod__DOT__newLRUa__out22;
        // Begin mtask footprint all: 11 30 31 33 34 35 36 37 
        IData/*23:0*/ ways_gen__BRA__7__KET____DOT__lru_mod__DOT__newLRUa__out19;
        IData/*23:0*/ ways_gen__BRA__7__KET____DOT__lru_mod__DOT__newLRUa__out20;
        // Begin mtask footprint all: 11 30 31 33 35 36 37 
        IData/*23:0*/ ways_gen__BRA__7__KET____DOT__lru_mod__DOT__newLRUa__out17;
        IData/*23:0*/ ways_gen__BRA__7__KET____DOT__lru_mod__DOT__newLRUa__out18;
        // Begin mtask footprint all: 30 31 33 35 36 37 
        IData/*23:0*/ ways_gen__BRA__5__KET____DOT__lru_mod__DOT__newLRUa__en;
        CData/*2:0*/ ways_gen__BRA__5__KET____DOT__lru_mod__DOT__newLRU__out__en8;
        CData/*2:0*/ ways_gen__BRA__5__KET____DOT__lru_mod__DOT__newLRU__out__en9;
        CData/*2:0*/ ways_gen__BRA__5__KET____DOT__lru_mod__DOT__newLRU__out__en10;
        CData/*2:0*/ ways_gen__BRA__5__KET____DOT__lru_mod__DOT__newLRU__out__en11;
        CData/*2:0*/ ways_gen__BRA__5__KET____DOT__lru_mod__DOT__newLRU__out__en12;
        CData/*2:0*/ ways_gen__BRA__5__KET____DOT__lru_mod__DOT__newLRU__out__en13;
        CData/*2:0*/ ways_gen__BRA__5__KET____DOT__lru_mod__DOT__newLRU__out__en14;
        CData/*2:0*/ ways_gen__BRA__5__KET____DOT__lru_mod__DOT__newLRU__out__en15;
        CData/*2:0*/ ways_gen__BRA__6__KET____DOT__lru_mod__DOT__newLRU__out__en14;
        CData/*2:0*/ ways_gen__BRA__6__KET____DOT__lru_mod__DOT__newLRU__out__en15;
        IData/*23:0*/ ways_gen__BRA__7__KET____DOT__lru_mod__DOT__newLRUa__en;
        CData/*2:0*/ ways_gen__BRA__7__KET____DOT__lru_mod__DOT__newLRU__out__en8;
        CData/*2:0*/ ways_gen__BRA__7__KET____DOT__lru_mod__DOT__newLRU__out__en9;
        CData/*2:0*/ ways_gen__BRA__7__KET____DOT__lru_mod__DOT__newLRU__out__en10;
        CData/*2:0*/ ways_gen__BRA__7__KET____DOT__lru_mod__DOT__newLRU__out__en11;
        CData/*2:0*/ ways_gen__BRA__7__KET____DOT__lru_mod__DOT__newLRU__out__en12;
        CData/*2:0*/ ways_gen__BRA__7__KET____DOT__lru_mod__DOT__newLRU__out__en13;
        // Begin mtask footprint all: 30 31 35 36 37 
        IData/*23:0*/ newLru__out64;
        IData/*23:0*/ newLru__out65;
        IData/*23:0*/ newLru__out66;
        CData/*2:0*/ ways_gen__BRA__7__KET____DOT__lru_mod__DOT__newLRU__out__en14;
        CData/*2:0*/ ways_gen__BRA__7__KET____DOT__lru_mod__DOT__newLRU__out__en15;
        // Begin mtask footprint all: 30 31 32 35 36 37 
        IData/*23:0*/ newLru__out63;
        CData/*2:0*/ ways_gen__BRA__4__KET____DOT__lru_mod__DOT__newLRU__out__en8;
        CData/*2:0*/ ways_gen__BRA__4__KET____DOT__lru_mod__DOT__newLRU__out__en9;
        CData/*2:0*/ ways_gen__BRA__4__KET____DOT__lru_mod__DOT__newLRU__out__en10;
        CData/*2:0*/ ways_gen__BRA__4__KET____DOT__lru_mod__DOT__newLRU__out__en11;
        CData/*2:0*/ ways_gen__BRA__4__KET____DOT__lru_mod__DOT__newLRU__out__en12;
        CData/*2:0*/ ways_gen__BRA__4__KET____DOT__lru_mod__DOT__newLRU__out__en13;
        CData/*2:0*/ ways_gen__BRA__4__KET____DOT__lru_mod__DOT__newLRU__out__en14;
        CData/*2:0*/ ways_gen__BRA__4__KET____DOT__lru_mod__DOT__newLRU__out__en15;
        // Begin mtask footprint all: 25 30 31 32 35 36 37 
        IData/*23:0*/ ways_gen__BRA__5__KET____DOT__lru_mod__DOT__newLRUa__out23;
        IData/*23:0*/ ways_gen__BRA__5__KET____DOT__lru_mod__DOT__newLRUa__out24;
        // Begin mtask footprint all: 30 31 32 34 35 36 37 
        IData/*23:0*/ ways_gen__BRA__5__KET____DOT__lru_mod__DOT__newLRUa__out17;
        IData/*23:0*/ ways_gen__BRA__5__KET____DOT__lru_mod__DOT__newLRUa__out18;
        // Begin mtask footprint all: 27 30 31 32 33 34 35 36 37 
        IData/*23:0*/ ways_gen__BRA__6__KET____DOT__lru_mod__DOT__newLRUa__out21;
        IData/*23:0*/ ways_gen__BRA__6__KET____DOT__lru_mod__DOT__newLRUa__out22;
        // Begin mtask footprint all: 27 31 32 33 34 35 36 37 
        IData/*23:0*/ ways_gen__BRA__3__KET____DOT__lru_mod__DOT__newLRUa__out17;
        IData/*23:0*/ ways_gen__BRA__3__KET____DOT__lru_mod__DOT__newLRUa__out18;
        IData/*23:0*/ ways_gen__BRA__3__KET____DOT__lru_mod__DOT__newLRUa__out21;
        IData/*23:0*/ ways_gen__BRA__3__KET____DOT__lru_mod__DOT__newLRUa__out22;
        // Begin mtask footprint all: 27 31 32 34 35 36 37 
        IData/*23:0*/ ways_gen__BRA__2__KET____DOT__lru_mod__DOT__newLRUa__out17;
        IData/*23:0*/ ways_gen__BRA__2__KET____DOT__lru_mod__DOT__newLRUa__out18;
        IData/*23:0*/ ways_gen__BRA__2__KET____DOT__lru_mod__DOT__newLRUa__out19;
        IData/*23:0*/ ways_gen__BRA__2__KET____DOT__lru_mod__DOT__newLRUa__out20;
        IData/*23:0*/ ways_gen__BRA__2__KET____DOT__lru_mod__DOT__newLRUa__out21;
        IData/*23:0*/ ways_gen__BRA__2__KET____DOT__lru_mod__DOT__newLRUa__out22;
        IData/*23:0*/ ways_gen__BRA__2__KET____DOT__lru_mod__DOT__newLRUa__out23;
        IData/*23:0*/ ways_gen__BRA__2__KET____DOT__lru_mod__DOT__newLRUa__out24;
        IData/*23:0*/ ways_gen__BRA__3__KET____DOT__lru_mod__DOT__newLRUa__out23;
    };
    struct {
        IData/*23:0*/ ways_gen__BRA__3__KET____DOT__lru_mod__DOT__newLRUa__out24;
        // Begin mtask footprint all: 11 27 32 33 34 35 36 37 
        IData/*23:0*/ ways_gen__BRA__3__KET____DOT__lru_mod__DOT__newLRUa__out19;
        IData/*23:0*/ ways_gen__BRA__3__KET____DOT__lru_mod__DOT__newLRUa__out20;
        // Begin mtask footprint all: 27 32 35 36 37 
        IData/*23:0*/ newLru__out62;
        // Begin mtask footprint all: 27 32 33 35 36 37 
        CData/*2:0*/ ways_gen__BRA__3__KET____DOT__lru_mod__DOT__newLRU__out__en14;
        CData/*2:0*/ ways_gen__BRA__3__KET____DOT__lru_mod__DOT__newLRU__out__en15;
        // Begin mtask footprint all: 27 31 32 33 35 36 37 
        IData/*23:0*/ ways_gen__BRA__1__KET____DOT__lru_mod__DOT__newLRUa__out17;
        IData/*23:0*/ ways_gen__BRA__1__KET____DOT__lru_mod__DOT__newLRUa__out18;
        IData/*23:0*/ ways_gen__BRA__1__KET____DOT__lru_mod__DOT__newLRUa__out19;
        IData/*23:0*/ ways_gen__BRA__1__KET____DOT__lru_mod__DOT__newLRUa__out20;
        IData/*23:0*/ ways_gen__BRA__1__KET____DOT__lru_mod__DOT__newLRUa__out23;
        IData/*23:0*/ ways_gen__BRA__1__KET____DOT__lru_mod__DOT__newLRUa__out24;
        IData/*23:0*/ ways_gen__BRA__2__KET____DOT__lru_mod__DOT__newLRUa__en;
        CData/*2:0*/ ways_gen__BRA__2__KET____DOT__lru_mod__DOT__newLRU__out__en8;
        CData/*2:0*/ ways_gen__BRA__2__KET____DOT__lru_mod__DOT__newLRU__out__en9;
        CData/*2:0*/ ways_gen__BRA__2__KET____DOT__lru_mod__DOT__newLRU__out__en10;
        CData/*2:0*/ ways_gen__BRA__2__KET____DOT__lru_mod__DOT__newLRU__out__en11;
        CData/*2:0*/ ways_gen__BRA__2__KET____DOT__lru_mod__DOT__newLRU__out__en12;
        CData/*2:0*/ ways_gen__BRA__2__KET____DOT__lru_mod__DOT__newLRU__out__en13;
        IData/*23:0*/ ways_gen__BRA__3__KET____DOT__lru_mod__DOT__newLRUa__en;
        CData/*2:0*/ ways_gen__BRA__3__KET____DOT__lru_mod__DOT__newLRU__out__en8;
        CData/*2:0*/ ways_gen__BRA__3__KET____DOT__lru_mod__DOT__newLRU__out__en9;
        CData/*2:0*/ ways_gen__BRA__3__KET____DOT__lru_mod__DOT__newLRU__out__en10;
        CData/*2:0*/ ways_gen__BRA__3__KET____DOT__lru_mod__DOT__newLRU__out__en11;
        CData/*2:0*/ ways_gen__BRA__3__KET____DOT__lru_mod__DOT__newLRU__out__en12;
        CData/*2:0*/ ways_gen__BRA__3__KET____DOT__lru_mod__DOT__newLRU__out__en13;
        // Begin mtask footprint all: 27 30 31 32 33 35 36 37 
        IData/*23:0*/ ways_gen__BRA__7__KET____DOT__lru_mod__DOT__newLRUa__out23;
        IData/*23:0*/ ways_gen__BRA__7__KET____DOT__lru_mod__DOT__newLRUa__out24;
        // Begin mtask footprint all: 25 27 30 31 32 33 35 36 37 
        IData/*23:0*/ ways_gen__BRA__6__KET____DOT__lru_mod__DOT__newLRUa__out24;
        // Begin mtask footprint all: 25 27 30 31 33 35 36 37 
        IData/*23:0*/ ways_gen__BRA__6__KET____DOT__lru_mod__DOT__newLRUa__out23;
        // Begin mtask footprint all: 27 30 31 33 35 36 37 
        IData/*23:0*/ ways_gen__BRA__6__KET____DOT__lru_mod__DOT__newLRUa__en;
        CData/*2:0*/ ways_gen__BRA__6__KET____DOT__lru_mod__DOT__newLRU__out__en8;
        CData/*2:0*/ ways_gen__BRA__6__KET____DOT__lru_mod__DOT__newLRU__out__en9;
        CData/*2:0*/ ways_gen__BRA__6__KET____DOT__lru_mod__DOT__newLRU__out__en10;
        CData/*2:0*/ ways_gen__BRA__6__KET____DOT__lru_mod__DOT__newLRU__out__en11;
        CData/*2:0*/ ways_gen__BRA__6__KET____DOT__lru_mod__DOT__newLRU__out__en12;
        CData/*2:0*/ ways_gen__BRA__6__KET____DOT__lru_mod__DOT__newLRU__out__en13;
        // Begin mtask footprint all: 31 35 36 37 
        IData/*23:0*/ newLru__out59;
        IData/*23:0*/ newLru__out60;
        // Begin mtask footprint all: 35 36 37 
        IData/*23:0*/ newLru__out61;
        // Begin mtask footprint all: 1 
        CData/*0:0*/ __Vdly__init;
        // Begin mtask footprint all: 1 7 8 18 26 
        CData/*3:0*/ initAdd_mod__DOT__out__out__out0;
        CData/*3:0*/ initAdd_mod__DOT__out__out__out1;
        CData/*3:0*/ initAdd_mod__DOT__out__out__out2;
        CData/*3:0*/ initAdd_mod__DOT__out__out__out3;
        CData/*3:0*/ initAdd_mod__DOT__out__out__out4;
        CData/*3:0*/ initAdd_mod__DOT__out__out__out5;
        CData/*3:0*/ initAdd_mod__DOT__out__out__out6;
        CData/*3:0*/ initAdd_mod__DOT__out__out__out7;
        CData/*3:0*/ __Vdly__initCount;
        // Begin mtask footprint all: 1 3 4 
        WData/*175:0*/ __Vdlyvval__ways_gen__BRA__0__KET____DOT__way_mod__DOT__ram_mod__DOT__ram__v0[6];
        WData/*175:0*/ __Vdlyvval__ways_gen__BRA__1__KET____DOT__way_mod__DOT__ram_mod__DOT__ram__v0[6];
        WData/*175:0*/ __Vdlyvval__ways_gen__BRA__2__KET____DOT__way_mod__DOT__ram_mod__DOT__ram__v0[6];
        WData/*175:0*/ __Vdlyvval__ways_gen__BRA__3__KET____DOT__way_mod__DOT__ram_mod__DOT__ram__v0[6];
        WData/*175:0*/ __Vdlyvval__ways_gen__BRA__4__KET____DOT__way_mod__DOT__ram_mod__DOT__ram__v0[6];
        WData/*175:0*/ __Vdlyvval__ways_gen__BRA__5__KET____DOT__way_mod__DOT__ram_mod__DOT__ram__v0[6];
        WData/*175:0*/ __Vdlyvval__ways_gen__BRA__6__KET____DOT__way_mod__DOT__ram_mod__DOT__ram__v0[6];
        WData/*175:0*/ __Vdlyvval__ways_gen__BRA__7__KET____DOT__way_mod__DOT__ram_mod__DOT__ram__v0[6];
        CData/*3:0*/ __Vdlyvdim0__ways_gen__BRA__0__KET____DOT__way_mod__DOT__ram_mod__DOT__ram__v0;
        CData/*3:0*/ __Vdlyvdim0__ways_gen__BRA__0__KET____DOT__way_mod__DOT__ramr_mod__DOT__ram__v0;
        CData/*2:0*/ __Vdlyvval__ways_gen__BRA__0__KET____DOT__way_mod__DOT__ramr_mod__DOT__ram__v0;
        CData/*0:0*/ __Vdlyvset__ways_gen__BRA__0__KET____DOT__way_mod__DOT__ramr_mod__DOT__ram__v0;
        CData/*3:0*/ __Vdlyvdim0__ways_gen__BRA__0__KET____DOT__way_mod__DOT__ramw_mod__DOT__ram__v0;
        CData/*2:0*/ __Vdlyvval__ways_gen__BRA__0__KET____DOT__way_mod__DOT__ramw_mod__DOT__ram__v0;
    };
    struct {
        CData/*0:0*/ __Vdlyvset__ways_gen__BRA__0__KET____DOT__way_mod__DOT__ramw_mod__DOT__ram__v0;
        CData/*3:0*/ __Vdlyvdim0__ways_gen__BRA__1__KET____DOT__way_mod__DOT__ram_mod__DOT__ram__v0;
        CData/*3:0*/ __Vdlyvdim0__ways_gen__BRA__1__KET____DOT__way_mod__DOT__ramr_mod__DOT__ram__v0;
        CData/*2:0*/ __Vdlyvval__ways_gen__BRA__1__KET____DOT__way_mod__DOT__ramr_mod__DOT__ram__v0;
        CData/*0:0*/ __Vdlyvset__ways_gen__BRA__1__KET____DOT__way_mod__DOT__ramr_mod__DOT__ram__v0;
        CData/*3:0*/ __Vdlyvdim0__ways_gen__BRA__1__KET____DOT__way_mod__DOT__ramw_mod__DOT__ram__v0;
        CData/*2:0*/ __Vdlyvval__ways_gen__BRA__1__KET____DOT__way_mod__DOT__ramw_mod__DOT__ram__v0;
        CData/*0:0*/ __Vdlyvset__ways_gen__BRA__1__KET____DOT__way_mod__DOT__ramw_mod__DOT__ram__v0;
        CData/*3:0*/ __Vdlyvdim0__ways_gen__BRA__2__KET____DOT__way_mod__DOT__ram_mod__DOT__ram__v0;
        CData/*3:0*/ __Vdlyvdim0__ways_gen__BRA__2__KET____DOT__way_mod__DOT__ramr_mod__DOT__ram__v0;
        CData/*2:0*/ __Vdlyvval__ways_gen__BRA__2__KET____DOT__way_mod__DOT__ramr_mod__DOT__ram__v0;
        CData/*0:0*/ __Vdlyvset__ways_gen__BRA__2__KET____DOT__way_mod__DOT__ramr_mod__DOT__ram__v0;
        CData/*3:0*/ __Vdlyvdim0__ways_gen__BRA__2__KET____DOT__way_mod__DOT__ramw_mod__DOT__ram__v0;
        CData/*2:0*/ __Vdlyvval__ways_gen__BRA__2__KET____DOT__way_mod__DOT__ramw_mod__DOT__ram__v0;
        CData/*0:0*/ __Vdlyvset__ways_gen__BRA__2__KET____DOT__way_mod__DOT__ramw_mod__DOT__ram__v0;
        CData/*3:0*/ __Vdlyvdim0__ways_gen__BRA__3__KET____DOT__way_mod__DOT__ram_mod__DOT__ram__v0;
        CData/*3:0*/ __Vdlyvdim0__ways_gen__BRA__3__KET____DOT__way_mod__DOT__ramr_mod__DOT__ram__v0;
        CData/*2:0*/ __Vdlyvval__ways_gen__BRA__3__KET____DOT__way_mod__DOT__ramr_mod__DOT__ram__v0;
        CData/*0:0*/ __Vdlyvset__ways_gen__BRA__3__KET____DOT__way_mod__DOT__ramr_mod__DOT__ram__v0;
        CData/*3:0*/ __Vdlyvdim0__ways_gen__BRA__3__KET____DOT__way_mod__DOT__ramw_mod__DOT__ram__v0;
        CData/*2:0*/ __Vdlyvval__ways_gen__BRA__3__KET____DOT__way_mod__DOT__ramw_mod__DOT__ram__v0;
        CData/*0:0*/ __Vdlyvset__ways_gen__BRA__3__KET____DOT__way_mod__DOT__ramw_mod__DOT__ram__v0;
        CData/*3:0*/ __Vdlyvdim0__ways_gen__BRA__4__KET____DOT__way_mod__DOT__ram_mod__DOT__ram__v0;
        CData/*3:0*/ __Vdlyvdim0__ways_gen__BRA__4__KET____DOT__way_mod__DOT__ramr_mod__DOT__ram__v0;
        CData/*2:0*/ __Vdlyvval__ways_gen__BRA__4__KET____DOT__way_mod__DOT__ramr_mod__DOT__ram__v0;
        CData/*0:0*/ __Vdlyvset__ways_gen__BRA__4__KET____DOT__way_mod__DOT__ramr_mod__DOT__ram__v0;
        CData/*3:0*/ __Vdlyvdim0__ways_gen__BRA__4__KET____DOT__way_mod__DOT__ramw_mod__DOT__ram__v0;
        CData/*2:0*/ __Vdlyvval__ways_gen__BRA__4__KET____DOT__way_mod__DOT__ramw_mod__DOT__ram__v0;
        CData/*0:0*/ __Vdlyvset__ways_gen__BRA__4__KET____DOT__way_mod__DOT__ramw_mod__DOT__ram__v0;
        CData/*3:0*/ __Vdlyvdim0__ways_gen__BRA__5__KET____DOT__way_mod__DOT__ram_mod__DOT__ram__v0;
        CData/*3:0*/ __Vdlyvdim0__ways_gen__BRA__5__KET____DOT__way_mod__DOT__ramr_mod__DOT__ram__v0;
        CData/*2:0*/ __Vdlyvval__ways_gen__BRA__5__KET____DOT__way_mod__DOT__ramr_mod__DOT__ram__v0;
        CData/*0:0*/ __Vdlyvset__ways_gen__BRA__5__KET____DOT__way_mod__DOT__ramr_mod__DOT__ram__v0;
        CData/*3:0*/ __Vdlyvdim0__ways_gen__BRA__5__KET____DOT__way_mod__DOT__ramw_mod__DOT__ram__v0;
        CData/*2:0*/ __Vdlyvval__ways_gen__BRA__5__KET____DOT__way_mod__DOT__ramw_mod__DOT__ram__v0;
        CData/*0:0*/ __Vdlyvset__ways_gen__BRA__5__KET____DOT__way_mod__DOT__ramw_mod__DOT__ram__v0;
        CData/*3:0*/ __Vdlyvdim0__ways_gen__BRA__6__KET____DOT__way_mod__DOT__ram_mod__DOT__ram__v0;
        CData/*3:0*/ __Vdlyvdim0__ways_gen__BRA__6__KET____DOT__way_mod__DOT__ramr_mod__DOT__ram__v0;
        CData/*2:0*/ __Vdlyvval__ways_gen__BRA__6__KET____DOT__way_mod__DOT__ramr_mod__DOT__ram__v0;
        CData/*0:0*/ __Vdlyvset__ways_gen__BRA__6__KET____DOT__way_mod__DOT__ramr_mod__DOT__ram__v0;
        CData/*3:0*/ __Vdlyvdim0__ways_gen__BRA__6__KET____DOT__way_mod__DOT__ramw_mod__DOT__ram__v0;
        CData/*2:0*/ __Vdlyvval__ways_gen__BRA__6__KET____DOT__way_mod__DOT__ramw_mod__DOT__ram__v0;
        CData/*0:0*/ __Vdlyvset__ways_gen__BRA__6__KET____DOT__way_mod__DOT__ramw_mod__DOT__ram__v0;
        CData/*3:0*/ __Vdlyvdim0__ways_gen__BRA__7__KET____DOT__way_mod__DOT__ram_mod__DOT__ram__v0;
        CData/*3:0*/ __Vdlyvdim0__ways_gen__BRA__7__KET____DOT__way_mod__DOT__ramr_mod__DOT__ram__v0;
        CData/*2:0*/ __Vdlyvval__ways_gen__BRA__7__KET____DOT__way_mod__DOT__ramr_mod__DOT__ram__v0;
        CData/*0:0*/ __Vdlyvset__ways_gen__BRA__7__KET____DOT__way_mod__DOT__ramr_mod__DOT__ram__v0;
        CData/*3:0*/ __Vdlyvdim0__ways_gen__BRA__7__KET____DOT__way_mod__DOT__ramw_mod__DOT__ram__v0;
        CData/*2:0*/ __Vdlyvval__ways_gen__BRA__7__KET____DOT__way_mod__DOT__ramw_mod__DOT__ram__v0;
        CData/*0:0*/ __Vdlyvset__ways_gen__BRA__7__KET____DOT__way_mod__DOT__ramw_mod__DOT__ram__v0;
        // Begin mtask footprint all: 1 3 4 5 
        CData/*0:0*/ __Vdlyvset__ways_gen__BRA__0__KET____DOT__way_mod__DOT__ram_mod__DOT__ram__v0;
        CData/*0:0*/ __Vdlyvset__ways_gen__BRA__1__KET____DOT__way_mod__DOT__ram_mod__DOT__ram__v0;
        CData/*0:0*/ __Vdlyvset__ways_gen__BRA__2__KET____DOT__way_mod__DOT__ram_mod__DOT__ram__v0;
        CData/*0:0*/ __Vdlyvset__ways_gen__BRA__3__KET____DOT__way_mod__DOT__ram_mod__DOT__ram__v0;
        CData/*0:0*/ __Vdlyvset__ways_gen__BRA__4__KET____DOT__way_mod__DOT__ram_mod__DOT__ram__v0;
        CData/*0:0*/ __Vdlyvset__ways_gen__BRA__5__KET____DOT__way_mod__DOT__ram_mod__DOT__ram__v0;
        CData/*0:0*/ __Vdlyvset__ways_gen__BRA__6__KET____DOT__way_mod__DOT__ram_mod__DOT__ram__v0;
        CData/*0:0*/ __Vdlyvset__ways_gen__BRA__7__KET____DOT__way_mod__DOT__ram_mod__DOT__ram__v0;
        // Begin mtask footprint all: 1 3 4 8 15 18 24 25 37 
        CData/*0:0*/ __Vcellout__ways_gen__BRA__0__KET____DOT__way_mod__read_hitL;
        CData/*0:0*/ __Vcellout__ways_gen__BRA__1__KET____DOT__way_mod__read_hitL;
        CData/*0:0*/ __Vcellout__ways_gen__BRA__2__KET____DOT__way_mod__read_hitL;
        CData/*0:0*/ __Vcellout__ways_gen__BRA__3__KET____DOT__way_mod__read_hitL;
        CData/*0:0*/ __Vcellout__ways_gen__BRA__4__KET____DOT__way_mod__read_hitL;
        CData/*0:0*/ __Vcellout__ways_gen__BRA__5__KET____DOT__way_mod__read_hitL;
    };
    struct {
        CData/*0:0*/ __Vcellout__ways_gen__BRA__6__KET____DOT__way_mod__read_hitL;
        CData/*0:0*/ __Vcellout__ways_gen__BRA__7__KET____DOT__way_mod__read_hitL;
    };
    
    // INTERNAL VARIABLES
  private:
    Vagu_block__Syms* __VlSymsp;  // Symbol table
  public:
    
    // CONSTRUCTORS
  private:
    VL_UNCOPYABLE(Vagu_block_dtlb);  ///< Copying not allowed
  public:
    Vagu_block_dtlb(const char* name = "TOP");
    ~Vagu_block_dtlb();
    
    // INTERNAL METHODS
    void __Vconfigure(Vagu_block__Syms* symsp, bool first);
  private:
    void _ctor_var_reset() VL_ATTR_COLD;
  public:
    void _sequent__TOP__agu_block__DOT__Wagu2_mod__tlb_mod__179(Vagu_block__Syms* __restrict vlSymsp);
    void _sequent__TOP__agu_block__DOT__Wagu2_mod__tlb_mod__181(Vagu_block__Syms* __restrict vlSymsp);
    void _sequent__TOP__agu_block__DOT__agu2__tlb_mod__180(Vagu_block__Syms* __restrict vlSymsp);
    void _sequent__TOP__agu_block__DOT__rec_agu_mod__DOT__tlb_mod__183(Vagu_block__Syms* __restrict vlSymsp);
    void _settle__TOP__agu_block__DOT__Wagu2_mod__tlb_mod__110(Vagu_block__Syms* __restrict vlSymsp) VL_ATTR_COLD;
    void _settle__TOP__agu_block__DOT__Wagu2_mod__tlb_mod__115(Vagu_block__Syms* __restrict vlSymsp) VL_ATTR_COLD;
    void _settle__TOP__agu_block__DOT__Wagu2_mod__tlb_mod__38(Vagu_block__Syms* __restrict vlSymsp) VL_ATTR_COLD;
    void _settle__TOP__agu_block__DOT__Wagu2_mod__tlb_mod__43(Vagu_block__Syms* __restrict vlSymsp) VL_ATTR_COLD;
    void _settle__TOP__agu_block__DOT__Wagu2_mod__tlb_mod__60(Vagu_block__Syms* __restrict vlSymsp) VL_ATTR_COLD;
    void _settle__TOP__agu_block__DOT__Wagu2_mod__tlb_mod__99(Vagu_block__Syms* __restrict vlSymsp) VL_ATTR_COLD;
    void _settle__TOP__agu_block__DOT__Wagu_mod__tlb_mod__1(Vagu_block__Syms* __restrict vlSymsp) VL_ATTR_COLD;
    void _settle__TOP__agu_block__DOT__Wagu_mod__tlb_mod__101(Vagu_block__Syms* __restrict vlSymsp) VL_ATTR_COLD;
    void _settle__TOP__agu_block__DOT__Wagu_mod__tlb_mod__107(Vagu_block__Syms* __restrict vlSymsp) VL_ATTR_COLD;
    void _settle__TOP__agu_block__DOT__Wagu_mod__tlb_mod__109(Vagu_block__Syms* __restrict vlSymsp) VL_ATTR_COLD;
    void _settle__TOP__agu_block__DOT__Wagu_mod__tlb_mod__114(Vagu_block__Syms* __restrict vlSymsp) VL_ATTR_COLD;
    void _settle__TOP__agu_block__DOT__Wagu_mod__tlb_mod__119(Vagu_block__Syms* __restrict vlSymsp) VL_ATTR_COLD;
    void _settle__TOP__agu_block__DOT__Wagu_mod__tlb_mod__13(Vagu_block__Syms* __restrict vlSymsp) VL_ATTR_COLD;
    void _settle__TOP__agu_block__DOT__Wagu_mod__tlb_mod__132(Vagu_block__Syms* __restrict vlSymsp) VL_ATTR_COLD;
    void _settle__TOP__agu_block__DOT__Wagu_mod__tlb_mod__143(Vagu_block__Syms* __restrict vlSymsp) VL_ATTR_COLD;
    void _settle__TOP__agu_block__DOT__Wagu_mod__tlb_mod__149(Vagu_block__Syms* __restrict vlSymsp) VL_ATTR_COLD;
    void _settle__TOP__agu_block__DOT__Wagu_mod__tlb_mod__155(Vagu_block__Syms* __restrict vlSymsp) VL_ATTR_COLD;
    void _settle__TOP__agu_block__DOT__Wagu_mod__tlb_mod__161(Vagu_block__Syms* __restrict vlSymsp) VL_ATTR_COLD;
    void _settle__TOP__agu_block__DOT__Wagu_mod__tlb_mod__167(Vagu_block__Syms* __restrict vlSymsp) VL_ATTR_COLD;
    void _settle__TOP__agu_block__DOT__Wagu_mod__tlb_mod__173(Vagu_block__Syms* __restrict vlSymsp) VL_ATTR_COLD;
    void _settle__TOP__agu_block__DOT__Wagu_mod__tlb_mod__19(Vagu_block__Syms* __restrict vlSymsp) VL_ATTR_COLD;
    void _settle__TOP__agu_block__DOT__Wagu_mod__tlb_mod__25(Vagu_block__Syms* __restrict vlSymsp) VL_ATTR_COLD;
    void _settle__TOP__agu_block__DOT__Wagu_mod__tlb_mod__31(Vagu_block__Syms* __restrict vlSymsp) VL_ATTR_COLD;
    void _settle__TOP__agu_block__DOT__Wagu_mod__tlb_mod__37(Vagu_block__Syms* __restrict vlSymsp) VL_ATTR_COLD;
    void _settle__TOP__agu_block__DOT__Wagu_mod__tlb_mod__42(Vagu_block__Syms* __restrict vlSymsp) VL_ATTR_COLD;
    void _settle__TOP__agu_block__DOT__Wagu_mod__tlb_mod__47(Vagu_block__Syms* __restrict vlSymsp) VL_ATTR_COLD;
    void _settle__TOP__agu_block__DOT__Wagu_mod__tlb_mod__53(Vagu_block__Syms* __restrict vlSymsp) VL_ATTR_COLD;
    void _settle__TOP__agu_block__DOT__Wagu_mod__tlb_mod__59(Vagu_block__Syms* __restrict vlSymsp) VL_ATTR_COLD;
    void _settle__TOP__agu_block__DOT__Wagu_mod__tlb_mod__65(Vagu_block__Syms* __restrict vlSymsp) VL_ATTR_COLD;
    void _settle__TOP__agu_block__DOT__Wagu_mod__tlb_mod__7(Vagu_block__Syms* __restrict vlSymsp) VL_ATTR_COLD;
    void _settle__TOP__agu_block__DOT__Wagu_mod__tlb_mod__71(Vagu_block__Syms* __restrict vlSymsp) VL_ATTR_COLD;
    void _settle__TOP__agu_block__DOT__Wagu_mod__tlb_mod__77(Vagu_block__Syms* __restrict vlSymsp) VL_ATTR_COLD;
    void _settle__TOP__agu_block__DOT__Wagu_mod__tlb_mod__83(Vagu_block__Syms* __restrict vlSymsp) VL_ATTR_COLD;
    void _settle__TOP__agu_block__DOT__Wagu_mod__tlb_mod__85(Vagu_block__Syms* __restrict vlSymsp);
    void _settle__TOP__agu_block__DOT__Wagu_mod__tlb_mod__90(Vagu_block__Syms* __restrict vlSymsp) VL_ATTR_COLD;
    void _settle__TOP__agu_block__DOT__Wagu_mod__tlb_mod__98(Vagu_block__Syms* __restrict vlSymsp) VL_ATTR_COLD;
    void _settle__TOP__agu_block__DOT__agu0__tlb_mod__111(Vagu_block__Syms* __restrict vlSymsp) VL_ATTR_COLD;
    void _settle__TOP__agu_block__DOT__agu0__tlb_mod__116(Vagu_block__Syms* __restrict vlSymsp) VL_ATTR_COLD;
    void _settle__TOP__agu_block__DOT__agu0__tlb_mod__129(Vagu_block__Syms* __restrict vlSymsp) VL_ATTR_COLD;
    void _settle__TOP__agu_block__DOT__agu0__tlb_mod__138(Vagu_block__Syms* __restrict vlSymsp) VL_ATTR_COLD;
    void _settle__TOP__agu_block__DOT__agu0__tlb_mod__145(Vagu_block__Syms* __restrict vlSymsp) VL_ATTR_COLD;
    void _settle__TOP__agu_block__DOT__agu0__tlb_mod__163(Vagu_block__Syms* __restrict vlSymsp) VL_ATTR_COLD;
    void _settle__TOP__agu_block__DOT__agu0__tlb_mod__169(Vagu_block__Syms* __restrict vlSymsp) VL_ATTR_COLD;
    void _settle__TOP__agu_block__DOT__agu0__tlb_mod__39(Vagu_block__Syms* __restrict vlSymsp) VL_ATTR_COLD;
    void _settle__TOP__agu_block__DOT__agu0__tlb_mod__44(Vagu_block__Syms* __restrict vlSymsp) VL_ATTR_COLD;
    void _settle__TOP__agu_block__DOT__agu0__tlb_mod__61(Vagu_block__Syms* __restrict vlSymsp) VL_ATTR_COLD;
    void _settle__TOP__agu_block__DOT__agu1__DOT__tlb_mod__113(Vagu_block__Syms* __restrict vlSymsp) VL_ATTR_COLD;
    void _settle__TOP__agu_block__DOT__agu1__DOT__tlb_mod__118(Vagu_block__Syms* __restrict vlSymsp) VL_ATTR_COLD;
    void _settle__TOP__agu_block__DOT__agu1__DOT__tlb_mod__140(Vagu_block__Syms* __restrict vlSymsp) VL_ATTR_COLD;
    void _settle__TOP__agu_block__DOT__agu1__DOT__tlb_mod__41(Vagu_block__Syms* __restrict vlSymsp) VL_ATTR_COLD;
    void _settle__TOP__agu_block__DOT__agu1__DOT__tlb_mod__46(Vagu_block__Syms* __restrict vlSymsp) VL_ATTR_COLD;
    void _settle__TOP__agu_block__DOT__agu1__DOT__tlb_mod__63(Vagu_block__Syms* __restrict vlSymsp) VL_ATTR_COLD;
    void _settle__TOP__agu_block__DOT__agu2__tlb_mod__112(Vagu_block__Syms* __restrict vlSymsp) VL_ATTR_COLD;
    void _settle__TOP__agu_block__DOT__agu2__tlb_mod__117(Vagu_block__Syms* __restrict vlSymsp) VL_ATTR_COLD;
    void _settle__TOP__agu_block__DOT__agu2__tlb_mod__139(Vagu_block__Syms* __restrict vlSymsp) VL_ATTR_COLD;
    void _settle__TOP__agu_block__DOT__agu2__tlb_mod__40(Vagu_block__Syms* __restrict vlSymsp) VL_ATTR_COLD;
    void _settle__TOP__agu_block__DOT__agu2__tlb_mod__45(Vagu_block__Syms* __restrict vlSymsp) VL_ATTR_COLD;
    void _settle__TOP__agu_block__DOT__agu2__tlb_mod__62(Vagu_block__Syms* __restrict vlSymsp) VL_ATTR_COLD;
    void _settle__TOP__agu_block__DOT__rec_agu_mod__DOT__tlb_mod__100(Vagu_block__Syms* __restrict vlSymsp) VL_ATTR_COLD;
    void _settle__TOP__agu_block__DOT__rec_agu_mod__DOT__tlb_mod__127(Vagu_block__Syms* __restrict vlSymsp) VL_ATTR_COLD;
    void _settle__TOP__agu_block__DOT__rec_agu_mod__DOT__tlb_mod__136(Vagu_block__Syms* __restrict vlSymsp) VL_ATTR_COLD;
    void _settle__TOP__agu_block__DOT__rec_agu_mod__DOT__tlb_mod__64(Vagu_block__Syms* __restrict vlSymsp) VL_ATTR_COLD;
    void _settle__TOP__agu_block__DOT__rec_agu_mod__DOT__tlb_mod__70(Vagu_block__Syms* __restrict vlSymsp) VL_ATTR_COLD;
    void _settle__TOP__agu_block__DOT__rec_agu_mod__DOT__tlb_mod__82(Vagu_block__Syms* __restrict vlSymsp) VL_ATTR_COLD;
} VL_ATTR_ALIGNED(VL_CACHE_LINE_BYTES);

//----------


#endif  // guard
