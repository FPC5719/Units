{$MODE DELPHI}
unit pds_list;

interface

type
	TList<T>=class
		public type
			PN=^TN;
			TN=record
				left,right:PN;
				val:T;
			end;
		private
			head,tail:PN;
		public
			constructor Create();
			destructor Destroy();override;
			function Insert(pos:DWord;data:T):boolean;
			function Delete(pos:DWord):boolean;
			function Left():PN;
			function Right():PN;
	end;

implementation

constructor TList<T>.Create();
begin
	new(head);
	head.left:=head;
	head.right:=head;
	tail:=head;
end;
destructor TList<T>.Destroy();
var
	i:PN;
begin
	i:=head;
	while(i<>tail)do begin
		dispose(i);
		i:=i.right;
	end;
	dispose(i);
end;
function TList<T>.Insert(pos:DWord;data:T):boolean;
var
	p,t:PN;
	i:DWord;
begin
	p:=head;
	for i:=1 to pos do begin
		if(p=tail)then
			exit(false);
		p:=p.right;
	end;
	new(t);
	t.left:=p;
	t.right:=p.right;
	p.right.left:=t;
	p.right:=t;
	t.val:=data;
	while(tail.right<>head)do
		tail:=tail.right;
	exit(true);
end;
function TList<T>.Delete(pos:DWord):boolean;
var
	p:PN;
	i:DWord;
begin
	p:=head;
	for i:=1 to pos do begin
		if(p=tail)then
			exit(false);
		p:=p.right;
	end;
	p.left.right:=p.right;
	p.right.left:=p.left;
	dispose(p);
	exit(true);
end;
function TList<T>.Left():PN;
begin
	if(head.right=head)then
		exit(NIL);
	exit(head.right);
end;
function TList<T>.Right():PN;
begin
	exit(tail);
end;

end.