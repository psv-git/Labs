Program Raschet;   { ���� �㬬� ��ᮢ ����쥢 �� ����୮� ��ॢ� }
  uses Crt;
  type
    ukaz=^usel;
    usel=record
           key: integer;
           ves: real;
           left,right: ukaz
         end;
  var
    root,kon: ukaz;
    k,l,n: integer;
    ch: char;
    v,s:real;
  Procedure Sozd(t:ukaz);
    Begin
      if t<>nil then
        begin
          Write('������ ����� ���設� ');
          Readln(t^.key);
          {if t^.key<>0 then
            begin
              Write(' ������ ��� ���設� ',t^.key,' ');
              Readln(t^.ves);
            end; }
          t^.ves:=0;
          Write('� ���設� ',t^.key,
                ' ������� ���� ��(�/�) ? ');
          Readln(ch);
          if ch='�' then t^.left:=nil
          else
            begin
              Writeln('���室�� � ������ ��� ���設� ',t^.key);
              New(kon);
              t^.left:=kon
            end;
          Sozd(t^.left);
          Write('� ���設� ',t^.key,
                ' ������� �ࠢ� ��(�/�) ? ');
          Readln(ch);
          if ch='�' then t^.right:=nil
          else
            begin
              Writeln('���室�� � �ࠢ��� ��� ���設� ',t^.key);
              New(kon);
              t^.right:=kon
            end;
          Sozd(t^.right);
          if t^.left=nil then
            begin
              Write(' ������ ��� ���設� ',t^.key,' ');
              Readln(t^.ves);
            end
        end
    End;
  Procedure RaschSt(t:ukaz; var s:real);
  { ���� � �⥪�� }
        Type
          point=^stek;
          stek=record
                 ver:  usel;
                 next: point;
                 ns: integer { ���.�뭠,�� ���.��諨 ���� }
               end;
        Var
          top,kon: point;
          k:ukaz;
        Procedure Dob(p:ukaz);
          Begin
            New(kon);
            kon^.ver:=p^;
            kon^.next:=top;
            top:=kon;
          End;
        Procedure Udal;
          Begin
            kon:=top;
            top:=top^.next;
            if top^.ns=1 then  { 室��� ������ }
              begin
                top^.ns:=2;
                top^.ver.left:=nil
              end
            else top^.ver.right:=nil;
            Dispose(kon);
          End;
        Begin     { ��砫� ��楤��� RaschSt }
          s:=0;
          top:=nil;
          k:=t;
          Dob(k); { ����ᥭ�� � �⥪ ���� }
          While top<>nil do
            if top^.ver.left<>nil then
              begin
                top^.ns:=1;  { ��諨 �� ����� ��⪥ }
                top^.ver.ves:=0;
                Dob(top^.ver.left)
              end
            else
              if top^.ver.right<>nil then
                begin
                  top^.ns:=2;  { ��諨 �� �ࠢ�� ��⪥ }
                  Dob(top^.ver.right)
                end
              else
                begin
                  s:=s+top^.ver.ves;
                  Udal
                end
  End;
  Procedure RaschRec(t:ukaz; var s:real);
  { ���� � ४��ᨥ� }
          Begin
            if t=root then s:=0;
            if t<>nil then
              Begin
                RaschRec(t^.left,s);
                RaschRec(t^.right,s);
                if t^.left=nil then    { ��� �뭮��� }
                  s:=s+t^.ves
              end
          End;
      Begin     { ��砫� �᭮���� �ணࠬ�� }
        Clrscr;
        New(root);
        Sozd(root);
        Writeln('��ॢ� ᮧ���� !');
        Readln;   { ��㧠 }
        RaschSt(root,s);  { ���� � �⥪�� ᭨��-�����  }
        Writeln('s=',s);
        Writeln('����� � �⥪�� !');
        Readln;
        RaschRec(root,s);  { ���� � ४��ᨥ� }
        Writeln('s=',s);
        Writeln('����� � ४��ᨥ� ᭨��-����� !');
        Writeln('��� � �� !');
        Readln
      End.
