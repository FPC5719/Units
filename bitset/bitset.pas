{
一个简单的BitSet，类似于C++
使用动态实现，请及时Destroy
支持操作：单位设置，and、or、xor、not
FPC5719 2018.11
}
{$MODE OBJFPC}
unit bitset;

interface

type
	TBitSet=class
	private
		data:^byte;
		len:longint;
	public
		constructor Create;
		constructor Create(l:longint);
		destructor Destroy;override;
		procedure SetBit(pos:longint;val:boolean);
		function GetBit(pos:longint):boolean;
		property Value[x:longint]:boolean read GetBit write SetBit;
		procedure Print;
	end;
	
operator and(a,b:TBitSet) res:TBitSet;
operator or(a,b:TBitSet) res:TBitSet;
operator xor(a,b:TBitSet) res:TBitSet;
operator not(a:TBitSet) res:TBitSet;

implementation

uses
	math;

constructor TBitSet.Create;
begin
	len:=0;
	data:=NIL;
end;
constructor TBitSet.Create(l:longint);
begin
	len:=l;
	data:=GetMem(len);
	fillchar(data^,len,0);
end;
destructor TBitSet.Destroy;
begin
	FreeMem(data);
end;
procedure TBitSet.SetBit(pos:longint;val:boolean);
var
	t1,t2:longint;
begin
	t1:=pos div 8;
	t2:=pos mod 8;
	if (t1>len)or(t1=len)and(t2>0) then
		exit;
	if val then
		data[t1]:=data[t1] or (1 shl t2)
	else
		data[t1]:=data[t1] and not (1 shl t2);
end;
function TBitSet.GetBit(pos:longint):boolean;
var
	t1,t2:longint;
begin
	t1:=pos div 8;
	t2:=pos mod 8;
	if (t1>len)or(t1=len)and(t2>0) then
		exit(false);
	exit((data[t1] and (1 shl t2))>0);
end;
procedure TBitset.Print;
var
	i:longint;
begin
	for i:=0 to len*8-1 do
		write(Value[i]:6);
	writeln;
end;

operator and(a,b:TBitSet) res:TBitSet;
var
	i,mx:longint;
begin
	mx:=max(a.len,b.len);
	res:=TBitSet.Create(mx);
	for i:=0 to mx*8-1 do
		res.Value[i]:=a.Value[i] and b.Value[i];
end;
operator or(a,b:TBitSet) res:TBitSet;
var
	i,mx:longint;
begin
	mx:=max(a.len,b.len);
	res:=TBitSet.Create(mx);
	for i:=0 to mx*8-1 do
		res.Value[i]:=a.Value[i] or b.Value[i];
end;
operator xor(a,b:TBitSet) res:TBitSet;
var
	i,mx:longint;
begin
	mx:=max(a.len,b.len);
	res:=TBitSet.Create(mx);
	for i:=0 to mx*8-1 do
		res.Value[i]:=a.Value[i] xor b.Value[i];
end;
operator not(a:TBitSet) res:TBitSet;
var
	i:longint;
begin
	res:=TBitSet.Create(a.len);
	for i:=0 to a.len*8-1 do
		res.Value[i]:=not a.Value[i];
end;

end.