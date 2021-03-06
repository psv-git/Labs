Program Heshirov;
Uses CRT;
Const
  M=977;     { ࠧ��� ⠡���� - ���⮥ �᫮ }
  M1=976;    {   M1=M-1      }
  LIM=1000;  { �।��쭮� �᫮ ����⮪ ࠧ��饭�� � ⠡��� }
  NUM=20;    { �᫮ ���⮢ ���������� ⠡���� �� 0 �� 95 % }
Type
  field=record
          key:word;     { ���� ࠧ��頥��� ����� }
          flag:boolean  { TRUE - ���� � ⠡��� ᢮����� }
        end;
  tsize=0..M1;
  table=array [0..M1] of field;
  result=array[ 0..100] of real;
  count=array[0..100] of integer;
Var
  t:table;          { ������塞�� ⠡��� }
  h:tsize;          { ������ � ⠡���    }
  i,j,a:integer;
  k,n:word;
  r:result;         { १����� �� ��業⠬ }
  c:count;          { ���稪� �᫠ ��஢���� �� ��業⠬ }
Begin
  TextBackground(3);
  ClrScr;
  TextColor(14);
  TextBackground(0);
  GoToXY(35,3);
  Writeln('�����������');
  TextColor(11);                { 梥� ᨬ����� }
  TextBackground(0);            { 梥� 䮭� }
  GoToXY(6,4);
  Write('����ᨬ���� �᫠ ��������� �஡ �� �����樥��',
        ' ���������� ⠡����');
  For a:=0 to 100 do
    begin
      r[a]:=0;
      c[a]:=0
    end;
  For j:=1 to NUM do
    begin
      n:=0;          { ���稪 �᫠ 㤠��� ࠧ��饭�� }
      For h:=0 to M1 do  { ���⪠ ⠡���� }
        t[h].flag:=TRUE;
      Randomize;   { ��砩��� ���樠������ ��� Random }
      Repeat
        i:=0;
        k:=Random(65000);  { ��砩�� ���� }
        h:=k mod M;        { �ਢ������ � �������� 0-M1 }
        While not (t[h].flag and (t[h].key<>k) and (i<LIM)) do
          {     ���� �� ������� ᢮������ ����        }
          { ���� ��� ����७��, ����⮪ �� ����� LIM }
          begin
            Inc(i);
            h:=(k+i*i) mod M
          end;
        if t[h].flag then      { ������� ᢮������ ���� }
           begin
             Inc(n);
             t[h].key:=k;
             t[h].flag:=FALSE  { �ਧ��� ���������� }
           end;
        a:=Round(n/M*100);      { ��業� ���������� ⠡���� }
        r[a]:=r[a]+i+1;   { �ᥣ� ����⮪ ��� �⮣� ��業� }
        Inc(c[a])         { �᫮ ࠧ��頥��� ����ᥩ }
      Until a>=95         {  ���������� ⠡���� ���� �� 95 % }
    end;
    For a:=0 to 95 do
      r[a]:=r[a]/c[a];     { �।��� �᫮ ����⮪ }
    TextColor(13);
    TextBackground(1);
    GoToXY(1,10);               { ��砫� ��ப� 10 }
    { �뤠� ࠬ�� ⠡���� � १���⠬� }
    Write('�');
    For i:=1 to 19 do
      if r[5*i]>10 then Write('�����')
      else Write('����');
    Write(#8,'�');     { #8 - ������ ����� �� 1 ������ }
    GoToXY(1,12);
    Write('�');
    For i:=1 to 19 do
      if r[5*i]>10 then Write('�����')
      else Write('����');
    Write(#8,'�');
    GoToXY(1,11);
    Write('�');
    GoToXY(1,13);
    Write('�');
    { ���������� ��ப� ��業⮢ (�� 5 �� 95 � 蠣�� 5) }
    GoToXY(2,11);
    For i:=1 to 19 do
      if r[5*i]>10 then Write(' ',5*i:2,'%�')
      else Write(5*i:2,'%�');
    { �뤠� ������� १���⮢ }
    GoToXY(2,13);
    For i:=1 to 19 do
      if r[5*i]>10 then Write(r[5*i]:4:1,'�')
      else Write(r[5*i]:3:1,'�');
    { �����襭�� ���ᮢ�� ࠬ�� }
    GoToXY(1,14);
    Write('�');
    For i:=1 to 19 do
      if r[5*i]>10 then Write('�����')
      else Write('����');
    Write(#8,'�');
    TextColor(10);
    TextBackground(4);
    GoToXY(4,23);
    Write('Press any key...');
    Repeat
    Until KeyPressed   { �������� �� ������ ������ }
  End.
