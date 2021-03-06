Program Syntax;  { ������ ���������� ᪮���, �⥪ �� 㪠��⥫�� }
  Type
     ukaz=^stek;
     stek=record       { ������� �⥪� }
            ch: char;  { ᨬ��� (���뢠�騥 ᪮���) }
            next:ukaz  { ᫥���騩 ������� }
          end;
  Var
     top,kon: ukaz;
     vir: string[80];  { ��室��� ��ࠦ���� }
     i,n: integer;
     a,b,pr: char;
  Procedure Dob;
    { ���������� � �⥪; a-������塞� ᨬ��� }
    Begin
      New(kon);
      kon^.next:=top;
      kon^.ch:=a;
      top:=kon
    End;
  Procedure Udal(var pr:char);
    { �᪫�祭�� �� �⥪�; pr='e'-�ਧ��� �訡�� }
    Begin
      pr:='o';
      if top=nil then pr:='e'
      else
        case a of
          ')': if top^.ch<>'(' then pr:='e';
          ']': if top^.ch<>'[' then pr:='e';
          '}': if top^.ch<>'{' then pr:='e';
        end;
      if pr<>'e' then
        begin  { 㤠����� ������� �� ���設� }
          kon:=top;
          top:=top^.next;
          Dispose(kon);
        end
    End;
  Begin    { ��砫� �᭮���� �ணࠬ�� }
    Writeln('������ ��ࠦ����');
    Readln(vir);
    top:=nil;
    n:=length(vir);   { ����� ��ࠦ���� }
    For i:=1 to n  do
      begin
        a:=vir[i];    { ��।��� ᨬ��� }
        case a of
          '(','[','{':   Dob;
    { ���������� � �⥪ ���뢠�饩 ᪮��� }
           ')',']','}':
             begin
               Udal(pr);
    { �஢�ઠ ���設� �⥪�; 㤠�����, �᫨ ��� �訡�� }
               if pr='e' then
                 begin
                   Writeln('�訡�� � ����樨 ',i);
                   Readln;    { ��㧠 }
                   Exit       { ��室 �� �ணࠬ�� � DOS }
                 end
             end
        end
      end;
    if top<>nil then
      (* � ���� �� ���⮩ �⥪ *)
      Writeln('��� ��᫥���� ����뢠��� ᪮���')
    else
      Writeln('�� � ���浪� !!!');
    Readln    { ������⥫쭠� ��㧠 }
  End.
