Program Tree;
{ ����� � �-��� ��ॢ�� }
  uses crt;
  Type
    ukaz=^uzel;
    stri=string[20];
    uzel=record          { ���ଠ�� � ���設� ��ॢ� }
           pr: char; { ��� ���設�: 'o'-�, 'a'-���, 'l'-���� }
           name: stri;   { �������� }
           nov: 0..15;   { ����� ������� }
           left,right: ukaz;
      { ���� � �ࠢ� �뭮��� ����୮�� ��ॢ� }
           count: integer;
      { ���ᨬ��쭠� �㬬�ୠ� ������� �।� ������⮢ }
      { �����ॢ�, ����饣� �� ������ ���設� }
           zapret: char { �ਧ��� �����: 'z'-����,'r'-��� }
         end;
  Var
    prizn: char;
    m,k: integer;
    kon,root,rab: ukaz;
    namer: stri;
  Procedure Sozd(t:ukaz);  { ���� �-��� ��ॢ� }
    Begin
      if t<>nil then
        begin
          Write('������ �������� ');
          Readln(t^.name);
          Write('������ ������⥫� ������� ');
          Readln(t^.nov);
          t^.count:=0;
          t^.zapret:='r';  { ���� �� ࠧ�襭� }
          Write('���設� ',t^.name,' ���� ��ॢ�(�/�) ?  ');
          Readln(prizn);
          if prizn='�' then    { ���� }
            begin
              t^.left:=nil;
              t^.pr:='l'
            end
          else   { �� ���� }
            begin
              Write('�� ���-���設�(�/�) ? ');
              Readln(prizn);
              if prizn='�' then t^.pr:='o'
              else  t^.pr:='a';
              Writeln('���室�� � ������ ��� ���設� ',t^.name);
              New(kon);
              t^.left:=kon
            end;
          Sozd(t^.left);
          if t=root then
            begin
              t^.right:=nil;
              Exit   { �ࠢ��� �ᥤ� ���� �� ����� ���� }
            end;
          Write('� ���設� ',t^.name,
                ' ������� �ࠢ� �ᥤ�(�/�) ? ');
          Readln(prizn);
          if prizn='�' then t^.right:=nil
            { '�'-�ਧ��� ������⢨� �ᥤ�� }
          else
            begin
              Writeln('���室�� � �ࠢ��� �ᥤ� ���設� ',t^.name);
              New(kon);
              t^.right:=kon;
            end;
          Sozd(t^.right)
        end
    End;
  Procedure Rasch(t:ukaz);  { �. �.2 �����⬠ }
    Begin
      if t<>nil then
        Begin
          Rasch(t^.left);
          Rasch(t^.right);
          if t^.left<>nil then
            { �� ������ ���設� }
            if t^.pr='a' then  { �-���設� }
              begin
                kon:=t^.left;
                While kon<>nil do
                  begin
                    t^.count:=t^.count+kon^.count;
                    kon:=kon^.right
                  end
              end
            else { ���-���設� }
              begin
                kon:=t^.left;
                m:=-1;
                While kon<>nil do
                  begin
                    kon^.zapret:='z'; { ᭠砫� ����� }
                    if kon^.count>m then
                      begin
                        m:=kon^.count;
                        rab:=kon
                      end;
                    kon:=kon^.right   { ᫥���騩 �� }
                  end;
                t^.count:=m;
                rab^.zapret:='r'; { ��⠢��� ������ ���設� }
              end;
          t^.count:=t^.count+t^.nov;
                { ��� ��������� �業�� ��� }
        end
    End;
  Procedure Pech(t:ukaz);
   { ����� ᢥ��� ���� ���襣� (������饭����) ������� }
    Begin
      if t<> nil then
        begin
          if t^.pr='a' then namer:=' (�-���設�) '
          else  if t^.pr='o' then namer:=' (���-���設�) '
                else namer:=' (���� ��ॢ�) ';
          if t^.zapret<>'z' then
            begin
              Write(t^.name,namer);
              Writeln(' �業�� ������� - ',t^.count);
            end;
            Pech(t^.left);
            Pech(t^.right)
        end
    End;
  Begin
    Clrscr;
    New(root);
    Sozd(root);
    Writeln('��ॢ� ᮧ���� !');
    Readln;   { ��㧠 }
    Rasch(root);
    Writeln('����� �஢���� !');
    Readln;
    Writeln('���訩 ������� !');
    Pech(root);
    Readln
  End.
