Program Piramida;   { ��ࠬ����쭠� ���஢�� }
  Uses Crt;
  Const m=100; { ���ਬ�� }
  Type index=0..m;
  Var
    a: array [1..m] of integer;
    l,r,n: index;
    i,j,k,x: integer;
    b: boolean;
  Procedure Vvod(var n: index);
  { n-䠪��᪮� �᫮ ������⮢ }
    Begin
      b:=true; n:=0;
      While b do
        begin
          Write('������ ����: ');
          ReadLn(k);
          if k>0 then
	    begin
              n:=n+1;
	      a[n]:=k;
            end
          else b:=false
        end;
    End;
  Procedure Vivod;
    Begin
      WriteLn;
      For i:=1 to n do
        Write(' ',a[i])
    End;
  Procedure Proseiv;  { ��ᥨ����� }
    Begin
      b:=true; i:=l; j:=2*l; x:=a[l];
      While (j<=r) and b do
        begin
          if j<r then  { ���� ���� �॥���� � a[l] }
            if a[j]>a[j+1] then j:=j+1;
          if x>a[j] then
            begin { ��� �� �஢��� }
              a[i]:=a[j]; i:=j; j:=2*j
            end
          else b:=false
          { � 2 ��᫥���� ������� IF ����� �ࠢ����� '<', }
          { �᫨ � ��७� ��ࠬ��� ���뫠���� MAX ���祭��   }
        end;
        a[i]:=x;
    End;
  Begin   { �᭮���� �ணࠬ�� }
    ClrScr;
    Vvod(n);
    l:=(n div 2)+1; r:=n;
    While l>1 do
      begin
        l:=l-1;
        Proseiv
      end;
    { ����� ���஢�� ��ࠬ��� �� ���� }
    { ᥩ�� l=1 }
    While r>1 do
      begin 
        x:=a[1]; a[1]:=a[r]; a[r]:=x; r:=r-1;
        Proseiv
      end;
    Vivod;
    ReadLn
  End.
