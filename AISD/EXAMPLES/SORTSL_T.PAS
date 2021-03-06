Program SortSlian;
  { 3-����筠�, 2-䠧��� ���஢�� ����⢥��� ᫨ﭨ�� }
  { �� ⥪�⮢�� 䠩���, ���� 楫� � ������⥫�� }
  { 2 ��ࠬ��� ��������� ��ப�: <�室��� 䠩�> <��室��� 䠩�> 
    � VP21 ��� 5 ᥪ. �� 100000 ����ᥩ}
{  Uses Crt;}
  Var
    name:  string;  { ��� ��室���� 䠩�� }
    a,b,c: text;    { ����� }
    k,l: longint;
    key,key1,key2: longint;
    e:   boolean;

  Procedure Soob(mess: string);  { ���਩��� ᮮ�饭�� � ��室�� }
    Begin
      Writeln(mess);
      Readln;   { ��㧠 }
      Halt      { ����� }
    End;

  Procedure CopyFile(var f1,f2:text);
    Begin
      Reset(f1);
      Rewrite(f2);
      While not eof(f1) do
        begin
          ReadLn(f1,key);
          WriteLn(f2,key);
        end;
      Close(f1);
      Close(f2);
    End;

  Procedure Pech(var f:text);
    Begin
      Reset(f);
      While not eof(f) do
        begin
          ReadLn(f,key);
          Write(key,' ')
        end;
      Writeln
    End;

  Procedure CopyElem(var x,y: text;
                     var buf: longint; var e: boolean);
    { ����஢���� ������� � ���뢠��� ᫥���饣� }
    { � K � �஢�મ� ���� �ਨ (E=TRUE) }
    Begin
      k:=buf;
      WriteLn(y,buf);
      if not eof(x) then ReadLn(x,buf)
      else buf:=-7;  { ���⨣��� ����� 䠩�� }
      e:=(buf<k)     { E=TRUE � ���� �ਨ  }
    End;

  Procedure CopySer(var x,y: text; var buf:longint);
    { ����஢���� �ਨ �� X � Y }
    { � ��砫� buf-���� ������� ⥪�饩 �ਨ �� X }
    { � ����  buf-���� ������� ᫥���饩 ��� -7 (����� X) }
    Begin
      if buf>0 then   { 䠩� X �� ��⠭ }
        Repeat
          CopyElem(x,y,buf,e)
        Until e
    End;

  Procedure Raspred;
    { ��।������  A ---> B � C }
    Begin
      Reset(a);
      ReadLn(a,key);  { ���� ������� �� A }
      Rewrite(b);
      Rewrite(c);
      Repeat
        CopySer(a,b,key);  { key-���� ������� ᫥���饩 �ਨ }
        if key>0 then  { 䠩� A ᪮��஢�� �� ���� }
          CopySer(a,c,key)
      Until key<0
    End;

  Procedure Slian;
    { ᫨ﭨ� B � C--->A }
    Var
      e1,e2:  boolean;
    Procedure SlianSer;
      { ᫨ﭨ� �਩ �� B � C ---> A }
      { key1 � key2 - ���� �������� �਩ }
      { key1<0 - ���� 䠩� B ��⠭, key2<0 - 䠩� C ��⠭ }
      Begin
        Repeat
          e1:=false;
          e2:=false;
          if (key1>0) and ((key1<key2) or (key2<0)) then
          { 䠩� B �� ��⠭ � ⥪�騩 ������� B �����, }
          { 祬 � C, ���� 䠩� C ��������� ��⠭ }
            begin
              CopyElem(b,a,key1,e1);
              if e1 then       { ���⨣��� ����� �ਨ �� B }
                  CopySer(c,a,key2)
            end
          else
            begin
              CopyElem(c,a,key2,e2);
              if e2 then       { ���⨣��� ����� �ਨ �� C }
                 CopySer(b,a,key1)
            end
        Until e1 or e2
      End;

    Begin    { ��砫� Slian }
      Reset(b);
      Reset(c);
      if not (eof(b) or eof(c)) then
        begin          { ��� 䠩�� �� ����� }
          Rewrite(a);
          ReadLn(b,key1);
          ReadLn(c,key2);
          l:=0;  { ���稪 �᫠ �਩ }
          While (key1>0) or (key2>0) do
            begin
              SlianSer;
              l:=l+1
            end
        end
    End;

  Begin   { ��砫� �᭮���� �ணࠬ�� }
{    ClrScr; }  { ���⪠ ��࠭� }
    if ParamCount<>2 then Soob('�訡��! ��ࠬ���� ��������� ��ப�: '+
                               '<�室��� 䠩�> <��室��� 䠩�>')
    else Assign(b,ParamStr(1));
    name:=ParamStr(1);
    {$I-}     { �⪫�祭�� ���뢠��� �� �訡�� ����� }
    Reset(b);               { b - �室��� 䠩� }
    {$I+}
    if IoResult<>0 then Soob('�訡�� ������ 䠩�� '+name);
    Assign(a,ParamStr(2));  { a - ��室��� 䠩� }
    CopyFile(b,a);
    Assign(b,'rab1');
    Assign(c,'rab2');
    l:=0;       { l-�᫮ �਩ ��᫥ ᫨ﭨ� - ��ࠬ��� }
    Repeat
{      Writeln('���� A: '); Pech(a);}
      Raspred;                      { 䠧� ��।������ }
{      Writeln('���� B: '); Pech(b);
      Writeln('���� C: '); Pech(c);  }
{      ReadLn;       }                { ��㧠 }
      Slian                         { 䠧� ᫨ﭨ� }
    Until l<=1;   { L=0, �᫨ ��室�� 䠩� �����஢�� }
    Writeln('���� A � ����: ');
{    Pech(a);
    ReadLn;  }
    Close(a);
    Close(b); Erase(b);
    Close(c); Erase(c);
  End.
