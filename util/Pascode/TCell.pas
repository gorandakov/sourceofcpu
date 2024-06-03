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

pasbit=record
val:byte;
end;
operator and(x,y: pasbit) res:pasbit;
operator or(x,y: pasbit) res: pasbit;
operator not(x:pasbit) y:pasbit;
operator equals(x: array of pasbit) res: pasbit;
// pair of enable and value or enble ifval elseval; if two entries the eleval is z aka both rails low
tioarray=class of tcomponent;
public 
bits:array of pasbit;
drv:array[0..5] of array of tpascell;
driven_gates:array[0..5] of array of Word;
procedure peek;
procedure poke;
kind:(inpt,outpt,inout);
constructor Create(N: string; o: tcomponent; w:integer);
end