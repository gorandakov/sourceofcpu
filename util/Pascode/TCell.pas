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
public
next_subcell:tpascell;
end