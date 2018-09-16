{
一个简单的矩阵运算库
（只）支持加、减、数乘、乘
除非你能保证满足运算条件，否则请在运算完后查看errmsg
采用动态内存实现，使用完请Destroy
注意：横纵坐标从0开始
FPC5719 2018.9
}
{$MODE OBJFPC}
unit matrix;

interface

type
	generic TMatrix<T>=class
		public type
			PT=^T;
		private
			data:PT;
			h,w:DWord;
		public
			constructor Create();
			constructor Create(hh,ww:DWord);overload;
			destructor Destroy();override;
			procedure SetSize(hh,ww:DWord);
			property Height:DWord read h;
			property Width:DWord read w;
			function GetValue(i,j:DWord):T;
			procedure SetValue(i,j:DWord;d:T);
			property Items[i,j:DWord]:T read GetValue write SetValue;
	end;
	
	generic TMatrixOperator<T>=class
		public type
			TM=specialize TMatrix<T>;
		private
			errmsg:string;
		public
			constructor Create();
			function Add(a,b:TM):TM;
			function Sub(a,b:TM):TM;
			function Mul(a:TM;b:T):TM;
			function Mul(a,b:TM):TM;
			function GetErr:string;
	end;

implementation

constructor TMatrix.Create();
begin
	data:=NIL;
end;
constructor TMatrix.Create(hh,ww:DWord);overload;
begin
	data:=NIL;
	h:=hh;
	w:=ww;
	data:=GetMem(h*w*sizeof(T));
end;
destructor TMatrix.Destroy();
begin
	FreeMem(data);
end;
procedure TMatrix.SetSize(hh,ww:DWord);
begin
	h:=hh;
	w:=ww;
	FreeMem(data);
	data:=GetMem(h*w*sizeof(T));
end;
function TMatrix.GetValue(i,j:DWord):T;
begin
	if(i>h)or(j>w)then
		exit;
	exit(data[(i-1)*w+j]);
end;
procedure TMatrix.SetValue(i,j:DWord;d:T);
begin
	if(i>h)or(j>w)then
		exit;
	data[(i-1)*w+j]:=d;
end;

constructor TMatrixOperator.Create();
begin
	errmsg:='';
end;
function TMatrixOperator.Add(a,b:TM):TM;
var
	i,j:longint;
	res:TM;
begin
	if(a.w<>b.w)or(a.h<>b.h)then begin
		errmsg:='Different sizes between parameters!';
		exit;
	end;
	res:=TM.Create(a.h,a.w);
	for i:=0 to res.h-1 do
		for j:=0 to res.w-1 do
			res.Items[i,j]:=a.Items[i,j]+b.Items[i,j];
	exit(res);
end;
function TMatrixOperator.Sub(a,b:TM):TM;
var
	i,j:longint;
	res:TM;
begin
	if(a.w<>b.w)or(a.h<>b.h)then begin
		errmsg:='Different sizes between parameters!';
		exit;
	end;
	res:=TM.Create(a.h,a.w);
	for i:=0 to res.h-1 do
		for j:=0 to res.w-1 do
			res.Items[i,j]:=a.Items[i,j]-b.Items[i,j];
	exit(res);
end;
function TMatrixOperator.Mul(a:TM;b:T):TM;
var
	i,j:longint;
	res:TM;
begin
	res:=TM.Create(a.h,a.w);
	for i:=0 to res.h-1 do
		for j:=0 to res.w-1 do
			res.Items[i,j]:=a.Items[i,j]*b;
	exit(res);
end;
function TMatrixOperator.Mul(a,b:TM):TM;
var
	i,j,k:longint;
	res:TM;
begin
	if(a.w<>b.h)then begin
		errmsg:='Different sizes between parameters!';
		exit;
	end;
	res:=TM.Create(a.h,b.w);
	for i:=0 to a.h-1 do
		for j:=0 to b.w-1 do
			for k:=0 to a.w-1 do
				res.Items[i,j]:=res.Items[i,j]+a.Items[i,k]*b.Items[k,j];
	exit(res);
end;
function TMatrixOperator.GetErr:string;
var
	s:string;
begin
	s:=errmsg;
	errmsg:='';
	exit(s);
end;

end.