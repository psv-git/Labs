Program Puti;  { ���� ��⥩ � ��㡨�� �� �ਥ��஢����� ��� }
  Uses crt;
  Const
    max=10;
  Type
    mat=array[1..max,1..max] of integer; { ����� ᬥ����� }
    put=1..max;       { ����� ���設� � ��� }
  Var
    matr : mat;
    gr: array [1..max] of integer; { ⥪�騩 ���� }
    zapret: array [1..max] of boolean; 
    { ����� ���設: false-���設� ����饭� }
    a,b,ver,k,j,i: integer;
    l: boolean;
    ch: char;

  Procedure ReadMat(var matr: mat);
    { ���� ������ ᬥ����� }
    Begin
      TextBackGround(Black);
      TextColor(White);
      Clrscr;
      Write('������ ������⢮ ���設:  ');
      Readln(ver);
      For i:=1 to ver do
        For j:=1 to ver do
          begin
            matr[i,j]:=0;
            matr[j,i]:=0
          end;
      Repeat
        Write('������ �裡 � ���� ���� ���設 (99-�����) ');
        Read(i);
        if i<>99 then Read(j);
        if (i>0) and (i<=ver) and (j>0) and (j<=ver) then
           matr[i,j]:=1
        else if i<>99 then Writeln('�訡�� ����� ')
      Until i=99;
      Writeln('���� �����祭 !');
      Writeln;
      Readln    { ��㧠 }
    End;

  Procedure Wiwod(matr: mat);
    Begin
      Window(46,2,75,22);         { ���� �뢮�� १���⮢ }
      TextBackGround(Cyan);
      Clrscr;
      TextColor(LightGreen);
      Write('  ');
      For i:=1 to ver do
        Write(i:2);               { ����� �⮫�殢 ������ }
      Writeln;
      For i:=1 to ver do
        begin
          TextColor(LightGreen);
          Write(i:2);             { ����� ��ப ������ }
          TextColor(White);
          For j:=1 to ver do
            Write(matr[i,j]:2);
          Writeln
        end
     End;

   Procedure PoiskPut(t: integer);
   { ���� ��� ��⥩ �� ��� }
     Var i: integer;
     Begin
       gr[j]:=t; { ���������� � ���� ⥪�饩 ���設� }
       Zapret[t]:=false;
       j:=j+1;
       if t=b then  { b-����筠� ���設� }
         begin
           Write('������ ����:  ');
           For i:=1 to j-1 do       { �뢮� ��� }
             Write(gr[i],'  ');
           Writeln;
           Readln;    { ��㧠 }
         end
       else
         For i:=1 to ver do
           if Zapret[i] and (matr[t,i]=1) then
    { ���� � ��㡨��: �롮� �த������� ��� ��� 横��  }
             PoiskPut(i);
    { ����� ����뢠���� ��᫥ ��宦����� ��।���� ��� }
    { ��� � ��砥 ��������� � �㯨�                     }
    { �᪫�祭�� �� ������⢠ ���設 ��� ��᫥���� ���設� }
       j:=j-1;      { ������ � �।����� ���設� }
       Zapret[t]:=true;   {��⨥ �����}
     End;

   Begin             { �᭮���� �ணࠬ�� }
     Clrscr;         { ���⪠ ��࠭�     }
     ReadMat(matr); { ���� ������ ᬥ����� }
     l:=true;
     While l do
       begin
         Wiwod(matr);
         Writeln;
         Write('������ ��砫��� ���設�:  ');
         Readln(a);
         Write('������ ������� ���設�:  ');
         Readln(b);
         Writeln;
         For i:=1 to ver do
           Zapret[i]:=true;  {�� ����設� ᭠砫� ࠧ�襭�}
         j:=1;
         PoiskPut(a);  { ����᫥��� ��� ��⥩             }
         Writeln('��⥩ ����� ��� ! ');
         Write('������� ����[�/�] ? ');
         Readln(ch);
         if ch='�' then l:=false   { ��� ��室� �� 横�� }
       end
   End.
