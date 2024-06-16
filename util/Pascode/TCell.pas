unit tcell;

interface

type
tpascell=class
public
precharge:Word;
shorted_right:Word;
shorted_left:Word;
is_gate:Word;
Width: integer;
constructor Create(a,b,c,d:Word;w:integer);
function connect(where: tpascell; locations: Word):boolean;
function get_driver_stren: integer; virtual;
protected
driven: array[0..5] of tpascell;
driven_gatez: array[0..5] of Word;
value: qword;
public
next_subcell:tpascell;
pvalue: pqword;// access value through pvalue only one per group of and-or
end
/*
 pasbit bits 5:0=3 sets of {is1,is not 0}
 pasbit bits 7:6=2 sets of is_z (z is neither 1 nor 0), only for the first 
2 sets of bits 5:0
 The bits 7:6 is to avoid static logic CPUs to fault due to vector unit 
usage causing EM interference
 note it should never happen that valid code produces an x value. memories 
are _not_ initialised to x aka both 1 and 0.
the not operation must not change z into x, it must keep it z
*/
pasbit=record
val:byte;
end;
operator and(x,y: pasbit) res:pasbit;
operator xor(x,y: pasbit) res:pasbit;
operator or(x,y: pasbit) res: pasbit;
operator not(x:pasbit) y:pasbit;
operator assign(x:string) res : array of pasbit;
operator assign(x:pasbit) res : array of pasbit;
function drive(x:array of pasbit; y:pasbit) : array of pasbit;
function drive2(x,y:array of pasbit; z:pasbit) : array of pasbit;
function zee(num:integer) : array of pasbit;
function zeroes(num:integer) : array of pasbit;
function clkref(num:integer) : pasbit;
function clknref(num:integer) : pasbit;
function redor(x:array of pasbit) : pasbit;
function redand(x:array of pasbit) : pasbit;
function redxor(x:array of pasbit) : pasbit;
function red_is_non_zero(x: array of pasbit) : pasbit;
function red_is_zero(x: array of pasbit) : pasbit;
function cmp_eq(x,y: array of pasbit) : pasbit;
function cmp_ne(x,y: array of pasbit) : pasbit;
// pair of enable and value or enble ifval elseval; if two entries the eleval is z aka both rails low
tioarray=class of tcomponent;
public 
bits:array of pasbit;
drv:array[0..5] of array of tpascell;
driven_gates:array[0..5] of array of Word;
busname:string;
busrplindex:integer;
busreloff:integer;
procedure peek;
procedure poke;
kind:(inpt,outpt,inout,phase);
constructor Create(N: string; o: tcomponent; w:integer);
end

tmodule=class of tcomponent;
public:
cnt_phases:integer;
function phase_handler(phase:integer) : 
set of (res_OK,res_SIM_MISMATCH,res_ASSERT_FAL); virtual;
procedure assert_en(en:boolean; warning : string);
end
