{$MODE DELPHI}
unit functional;

interface

uses
	pds_list;
	
type
	TStream<T>=class
		private type
			TL=TList<T>;
		private
			data:TL;
		public
			constructor Create();
			destructor Destroy();override;
			procedure PushBack(v:T);
			procedure PushFront(v:T);
			procedure PopBack(v:T);
			procedure PopFront(v:T);
			procedure Map();
	end;

implementation

end.