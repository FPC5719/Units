{$MODE OBJFPC}
uses matrix;
type
	MatInt=specialize TMatrix<longint>;
	OprInt=specialize TMatrixOperator<longint>;
var
	a,b,c:MatInt;
	o:OprInt;
begin
	a:=MatInt.Create(2,3);
	a.Items[0,0]:=1;
	a.Items[0,1]:=2;
	a.Items[0,2]:=3;
	a.Items[1,0]:=4;
	a.Items[1,1]:=5;
	a.Items[1,2]:=6;
	b:=MatInt.Create(3,2);
	b.Items[0,0]:=2;
	b.Items[0,1]:=3;
	b.Items[1,0]:=3;
	b.Items[1,1]:=2;
	b.Items[2,0]:=3;
	b.Items[2,1]:=3;
	o:=OprInt.Create();
	c:=o.Mul(a,b);
	writeln(c.Items[1,1]);
end.