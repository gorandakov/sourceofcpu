// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design internal header
// See Vfu_alu.h for the primary calling header

#ifndef _VFU_ALU_ALU_SHIFT_H_
#define _VFU_ALU_ALU_SHIFT_H_  // guard

#include "verilated.h"

//==========

class Vfu_alu__Syms;

//----------

VL_MODULE(Vfu_alu_alu_shift) {
  public:
    
    // PORTS
    VL_IN8(clk,0,0);
    VL_IN8(rst,0,0);
    VL_IN8(except,0,0);
    VL_IN8(except_thread,0,0);
    VL_IN8(sz,3,0);
    VL_IN8(bit_en,3,0);
    VL_IN8(arith,0,0);
    VL_IN8(dir,0,0);
    VL_IN8(dataEn,0,0);
    VL_IN8(nDataAlt,0,0);
    VL_IN8(valS,5,0);
    VL_IN16(operation,12,0);
    VL_IN16(retData,8,0);
    VL_OUT16(retData__out,8,0);
    VL_OUT16(retData__en,8,0);
    VL_IN64(val1,63,0);
    VL_IN64(val2,63,0);
    VL_IN64(valRes,63,0);
    VL_OUT64(valRes__out,63,0);
    VL_OUT64(valRes__en,63,0);
    
    // LOCAL SIGNALS
    CData/*0:0*/ __PVT__is_shift;
    CData/*0:0*/ __PVT__is_shift_reg;
    CData/*3:0*/ __PVT__coutL_reg;
    CData/*0:0*/ __PVT__coutR_reg;
    CData/*0:0*/ __PVT__dir_reg;
    CData/*3:0*/ __PVT__sz_reg;
    CData/*0:0*/ __PVT__main_shift_mod__DOT__fill_bit;
    CData/*7:0*/ __PVT__main_shift_mod__DOT__eq2;
    SData/*14:0*/ __PVT__main_shift_mod__DOT__eq;
    WData/*79:0*/ __PVT__main_shift_mod__DOT__val_int[3];
    QData/*63:0*/ __PVT__valres0;
    QData/*63:0*/ __PVT__valres0_reg;
    QData/*63:0*/ __PVT__main_shift_mod__DOT__valP0;
    
    // LOCAL VARIABLES
    // Anonymous structures to workaround compiler member-count bugs
    struct {
        CData/*3:0*/ coutL__out7;
        CData/*3:0*/ main_shift_mod__DOT__coutL__out__out137;
        CData/*3:0*/ main_shift_mod__DOT__coutL__out__out138;
        CData/*3:0*/ main_shift_mod__DOT__coutL__out__out139;
        CData/*3:0*/ main_shift_mod__DOT__coutL__out__out140;
        CData/*3:0*/ main_shift_mod__DOT__coutL__out__out141;
        CData/*3:0*/ main_shift_mod__DOT__coutL__out__out142;
        CData/*3:0*/ main_shift_mod__DOT__coutL__out__out143;
        CData/*3:0*/ main_shift_mod__DOT__coutL__out__out144;
        CData/*3:0*/ main_shift_mod__DOT__coutL__out__out145;
        CData/*3:0*/ main_shift_mod__DOT__coutL__out__out146;
        CData/*3:0*/ main_shift_mod__DOT__coutL__out__out147;
        CData/*3:0*/ main_shift_mod__DOT__coutL__out__out148;
        CData/*3:0*/ main_shift_mod__DOT__coutL__out__out149;
        CData/*3:0*/ main_shift_mod__DOT__coutL__out__out150;
        CData/*3:0*/ main_shift_mod__DOT__coutL__out__out151;
        CData/*3:0*/ main_shift_mod__DOT__coutL__out__out152;
        CData/*3:0*/ main_shift_mod__DOT__coutL__out__out153;
        SData/*8:0*/ retData__out__out3;
        WData/*79:0*/ main_shift_mod__DOT__val_int__out154[3];
        WData/*79:0*/ main_shift_mod__DOT__val_int__out155[3];
        WData/*79:0*/ main_shift_mod__DOT__val_int__out156[3];
        WData/*79:0*/ main_shift_mod__DOT__val_int__out157[3];
        WData/*79:0*/ main_shift_mod__DOT__val_int__out158[3];
        WData/*79:0*/ main_shift_mod__DOT__val_int__out159[3];
        WData/*79:0*/ main_shift_mod__DOT__val_int__out160[3];
        WData/*79:0*/ main_shift_mod__DOT__val_int__out161[3];
        WData/*79:0*/ main_shift_mod__DOT__val_int__out162[3];
        WData/*79:0*/ main_shift_mod__DOT__val_int__out163[3];
        WData/*79:0*/ main_shift_mod__DOT__val_int__out164[3];
        WData/*79:0*/ main_shift_mod__DOT__val_int__out165[3];
        WData/*79:0*/ main_shift_mod__DOT__val_int__out166[3];
        WData/*79:0*/ main_shift_mod__DOT__val_int__out167[3];
        WData/*79:0*/ main_shift_mod__DOT__val_int__out168[3];
        WData/*79:0*/ main_shift_mod__DOT__val_int__out169[3];
        WData/*79:0*/ main_shift_mod__DOT__val_int__out170[3];
        WData/*79:0*/ main_shift_mod__DOT__val_int__out171[3];
        WData/*79:0*/ main_shift_mod__DOT__val_int__out172[3];
        WData/*79:0*/ main_shift_mod__DOT__val_int__out173[3];
        WData/*79:0*/ main_shift_mod__DOT__val_int__out174[3];
        WData/*79:0*/ main_shift_mod__DOT__val_int__out175[3];
        WData/*79:0*/ main_shift_mod__DOT__val_int__out176[3];
        WData/*79:0*/ main_shift_mod__DOT__val_int__out177[3];
        WData/*79:0*/ main_shift_mod__DOT__val_int__out178[3];
        WData/*79:0*/ main_shift_mod__DOT__val_int__out179[3];
        WData/*79:0*/ main_shift_mod__DOT__val_int__out180[3];
        WData/*79:0*/ main_shift_mod__DOT__val_int__out181[3];
        WData/*79:0*/ main_shift_mod__DOT__val_int__out182[3];
        WData/*79:0*/ main_shift_mod__DOT__val_int__out183[3];
        WData/*79:0*/ main_shift_mod__DOT__val_int__out184[3];
        WData/*79:0*/ main_shift_mod__DOT__val_int__out185[3];
        WData/*79:0*/ main_shift_mod__DOT__val_int__out186[3];
        WData/*79:0*/ main_shift_mod__DOT__val_int__out187[3];
        WData/*79:0*/ main_shift_mod__DOT__val_int__out188[3];
        WData/*79:0*/ main_shift_mod__DOT__val_int__out189[3];
        WData/*79:0*/ main_shift_mod__DOT__val_int__out190[3];
        WData/*79:0*/ main_shift_mod__DOT__val_int__out191[3];
        WData/*79:0*/ main_shift_mod__DOT__val_int__out192[3];
        WData/*79:0*/ main_shift_mod__DOT__val_int__out193[3];
        WData/*79:0*/ main_shift_mod__DOT__val_int__out194[3];
        WData/*79:0*/ main_shift_mod__DOT__val_int__out195[3];
        WData/*79:0*/ main_shift_mod__DOT__val_int__out196[3];
        WData/*79:0*/ main_shift_mod__DOT__val_int__out197[3];
        WData/*79:0*/ main_shift_mod__DOT__val_int__out198[3];
    };
    struct {
        WData/*79:0*/ main_shift_mod__DOT__val_int__out199[3];
        WData/*79:0*/ main_shift_mod__DOT__val_int__out200[3];
        WData/*79:0*/ main_shift_mod__DOT__val_int__out201[3];
        WData/*79:0*/ main_shift_mod__DOT__val_int__out202[3];
        WData/*79:0*/ main_shift_mod__DOT__val_int__out203[3];
        WData/*79:0*/ main_shift_mod__DOT__val_int__out204[3];
        WData/*79:0*/ main_shift_mod__DOT__val_int__out205[3];
        WData/*79:0*/ main_shift_mod__DOT__val_int__out206[3];
        WData/*79:0*/ main_shift_mod__DOT__val_int__out207[3];
        WData/*79:0*/ main_shift_mod__DOT__val_int__out208[3];
        WData/*79:0*/ main_shift_mod__DOT__val_int__out209[3];
        WData/*79:0*/ main_shift_mod__DOT__val_int__out210[3];
        WData/*79:0*/ main_shift_mod__DOT__val_int__out211[3];
        WData/*79:0*/ main_shift_mod__DOT__val_int__out212[3];
        WData/*79:0*/ main_shift_mod__DOT__val_int__out213[3];
        WData/*79:0*/ main_shift_mod__DOT__val_int__out214[3];
        WData/*79:0*/ main_shift_mod__DOT__val_int__out215[3];
        WData/*79:0*/ main_shift_mod__DOT__val_int__out216[3];
        WData/*79:0*/ main_shift_mod__DOT__val_int__out217[3];
        WData/*79:0*/ main_shift_mod__DOT__val_int__out218[3];
        WData/*79:0*/ main_shift_mod__DOT__val_int__out219[3];
        WData/*79:0*/ main_shift_mod__DOT__val_int__out220[3];
        WData/*79:0*/ main_shift_mod__DOT__val_int__out221[3];
        WData/*79:0*/ main_shift_mod__DOT__val_int__out222[3];
        WData/*79:0*/ main_shift_mod__DOT__val_int__out223[3];
        WData/*79:0*/ main_shift_mod__DOT__val_int__out224[3];
        WData/*79:0*/ main_shift_mod__DOT__val_int__out225[3];
        WData/*79:0*/ main_shift_mod__DOT__val_int__out226[3];
        WData/*79:0*/ main_shift_mod__DOT__val_int__out227[3];
        QData/*63:0*/ __pinNumber7__en0;
        QData/*63:0*/ valRes__out__en4;
        QData/*63:0*/ valres0__out5;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__out0;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__en0;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__out1;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__en1;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__out2;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__en2;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__out3;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__en3;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__out4;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__en4;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__out5;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__en5;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__out6;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__en6;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__out7;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__en7;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__out8;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__en8;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__out9;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__en9;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__out10;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__en10;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__out11;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__en11;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__out12;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__en12;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__out13;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__en13;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__out14;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__en14;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__out15;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__en15;
    };
    struct {
        QData/*63:0*/ main_shift_mod__DOT__valres__out__out16;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__en16;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__out17;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__en17;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__out18;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__en18;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__out19;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__en19;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__out20;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__en20;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__out21;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__en21;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__out22;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__en22;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__out23;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__en23;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__out24;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__en24;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__out25;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__en25;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__out26;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__en26;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__out27;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__en27;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__out28;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__en28;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__out29;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__en29;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__out30;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__en30;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__out31;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__en31;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__out32;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__en32;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__out33;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__en33;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__out34;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__en34;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__out35;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__en35;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__out36;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__en36;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__out37;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__en37;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__out38;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__en38;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__out39;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__en39;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__out40;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__en40;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__out41;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__en41;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__out42;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__en42;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__out43;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__en43;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__out44;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__en44;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__out45;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__en45;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__out46;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__en46;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__out47;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__en47;
    };
    struct {
        QData/*63:0*/ main_shift_mod__DOT__valres__out__out48;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__en48;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__out49;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__en49;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__out50;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__en50;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__out51;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__en51;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__out52;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__en52;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__out53;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__en53;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__out54;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__en54;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__out55;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__en55;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__out56;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__en56;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__out57;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__en57;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__out58;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__en58;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__out59;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__en59;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__out60;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__en60;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__out61;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__en61;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__out62;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__en62;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__out63;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__en63;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__out64;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__en64;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__out65;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__en65;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__out66;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__en66;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__out67;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__en67;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__out68;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__en68;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__out69;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__en69;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__out70;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__en70;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__out71;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__en71;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__out72;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__en72;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__out73;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__en73;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__out74;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__en74;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__out75;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__en75;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__out76;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__en76;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__out77;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__en77;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__out78;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__en78;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__out79;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__en79;
    };
    struct {
        QData/*63:0*/ main_shift_mod__DOT__valres__out__out80;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__en80;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__out81;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__en81;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__out82;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__en82;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__out83;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__en83;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__out84;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__en84;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__out85;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__en85;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__out86;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__en86;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__out87;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__en87;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__out88;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__en88;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__out89;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__en89;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__out90;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__en90;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__out91;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__en91;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__out92;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__en92;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__out93;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__en93;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__out94;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__en94;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__out95;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__en95;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__out96;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__en96;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__out97;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__en97;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__out98;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__en98;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__out99;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__en99;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__out100;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__en100;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__out101;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__en101;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__out102;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__en102;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__out103;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__en103;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__out104;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__en104;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__out105;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__en105;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__out106;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__en106;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__out107;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__en107;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__out108;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__en108;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__out109;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__en109;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__out110;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__en110;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__out111;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__en111;
    };
    struct {
        QData/*63:0*/ main_shift_mod__DOT__valres__out__out112;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__en112;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__out113;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__en113;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__out114;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__en114;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__out115;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__en115;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__out116;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__en116;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__out117;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__en117;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__out118;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__en118;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__out119;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__en119;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__out120;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__en120;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__out121;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__en121;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__out122;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__en122;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__out123;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__en123;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__out124;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__en124;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__out125;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__en125;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__out126;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__en126;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__out127;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__en127;
        QData/*63:0*/ main_shift_mod__DOT__valres__out__out128;
    };
    
    // INTERNAL VARIABLES
  private:
    Vfu_alu__Syms* __VlSymsp;  // Symbol table
  public:
    
    // CONSTRUCTORS
  private:
    VL_UNCOPYABLE(Vfu_alu_alu_shift);  ///< Copying not allowed
  public:
    Vfu_alu_alu_shift(const char* name = "TOP");
    ~Vfu_alu_alu_shift();
    
    // INTERNAL METHODS
    void __Vconfigure(Vfu_alu__Syms* symsp, bool first);
  private:
    void _ctor_var_reset() VL_ATTR_COLD;
  public:
    void _sequent__TOP__fu_alu__DOT__sh2_alu__4(Vfu_alu__Syms* __restrict vlSymsp);
    void _sequent__TOP__fu_alu__DOT__sh2_alu__7(Vfu_alu__Syms* __restrict vlSymsp);
    void _sequent__TOP__fu_alu__DOT__sh4_alu__5(Vfu_alu__Syms* __restrict vlSymsp);
    void _sequent__TOP__fu_alu__DOT__sh4_alu__8(Vfu_alu__Syms* __restrict vlSymsp);
    void _sequent__TOP__fu_alu__DOT__sh6_alu__6(Vfu_alu__Syms* __restrict vlSymsp);
    void _sequent__TOP__fu_alu__DOT__sh6_alu__9(Vfu_alu__Syms* __restrict vlSymsp);
    void _settle__TOP__fu_alu__DOT__sh2_alu__1(Vfu_alu__Syms* __restrict vlSymsp) VL_ATTR_COLD;
    void _settle__TOP__fu_alu__DOT__sh4_alu__2(Vfu_alu__Syms* __restrict vlSymsp) VL_ATTR_COLD;
    void _settle__TOP__fu_alu__DOT__sh6_alu__3(Vfu_alu__Syms* __restrict vlSymsp) VL_ATTR_COLD;
} VL_ATTR_ALIGNED(VL_CACHE_LINE_BYTES);

//----------


#endif  // guard
