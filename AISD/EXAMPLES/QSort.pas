Program QSort; { ������ ���஢�� ���� }
  Uses Crt;
  Const M=100; 
  Type  index=0..m;
  Var
    A: array [1..M] of integer;
    K, R, N: index;
    I, J, L, X, W: integer;
    B: boolean;
  Procedure Vvod(var N: index);
  { N-䠪��᪮� �᫮ ����⮢ }
    Begin
      B:=True; N:=0;
      While B do
        begin
          Write('������ ���� (-1 - �����): ');
          ReadLn(L);
          if L>=0 then
      	    begin
              N:=N+1;
	       A[N]:=l
            end
          else B:=False
        end;
    End;
  Procedure Vivod;
    Begin
      WriteLn;
      For I:=1 to N do
        Write(' ', A[I])
    End;
  Procedure Sort(K, R: index);
    Begin
      I:=K;   { ������ ������ }
      J:=R;   { ���孨� ������ }
      X:=A[(K+R) div 2];
      Repeat
        While A[I]<X do I:=I+1;
        While A[J]>X do J:=J-1;
        if I<=J then { A[I]>=X>=A[J] }
          begin
            W:=A[I]; A[I]:=A[J]; A[J]:=W;
            I:=I+1; J:=J-1   { �⠫� A[I-1]<=X<=A[J+1] }
          end
      Until I>J;
      { A[L]<=X ��� L=K,K+1,...,J }
      { A[L]>=X ��� L=I,...,R   }
      if K<J then Sort(K, J);
      if I<R then Sort(I, R)
    End;
  Begin
    ClrScr;
    Vvod(n);
    Sort(1, N);
    Vivod;
    ReadLn
  End.
