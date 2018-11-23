uses
	bitset;
var
	a,b,c:TBitSet;
	i:longint;
begin
	a:=TBitSet.Create(1);
	b:=TBitSet.Create(1);
	a.Value[1]:=true;
	a.Value[3]:=true;
	a.Value[5]:=true;
	b.Value[1]:=true;
	b.Value[2]:=true;
	b.value[4]:=true;
	(a and b).Print;
	(a or b).Print;
	(a xor b).Print;
	(not a).Print;
	a.Destroy;
	b.Destroy;
end.