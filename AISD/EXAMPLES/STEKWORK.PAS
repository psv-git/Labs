  Program StekWork;  { ��楤��� ࠡ��� � �⥪�� }
  uses crt;
    type
      ukaz=^stek;
      stek=record
             name: string[20];
             next: ukaz
           end;
    var
      top,kon: ukaz;
      rname: string[20];
      c,pr:char;
      b: boolean;
      n: integer;
    Procedure SozdDob;
      Var b: boolean;
      Begin
        b:=true;
        While b do
          begin
            Write('������ ��।��� ������� ');
            Readln(rname);
            if rname='�����' then b:=false
            else
              begin
                New(kon);
                { ᮧ����� ������� �⥪�, �� ����� 㪠�뢠�� kon }
                kon^.next:=top;
                kon^.name:=rname;
                top:=kon
              end
          end;
        End;
      Procedure Udal;
        Var b: boolean;
        Begin
          b:=true;
          While b do
            begin
              if top=nil then
                begin
                  Writeln('����⪠ 㤠���� �� ���⮣� �⥪� !!!');
                  b:=false
                end
              else
                begin
                  Writeln('������� ������� �⥪� < ',top^.name,' >(��/���) ?');
                  Readln(rname);
                  if rname='��' then
                    begin
                      kon:=top;
                      top:=top^.next;
                      Dispose(kon);
                      { 㤠����� ��襩 ���設� �⥪� }
                    end
                  else b:=false
                end
            end
        End;
      Procedure Pech;
        Begin
          if top=nil then
            Writeln('  �⥪ ���� !!!')
          else
            begin
              kon:=top;
              Writeln('  ����ﭨ� �⥪�:');
              While kon<>nil do
                begin
                  Writeln(kon^.name);
                  kon:=kon^.next
                end
            end
      End;
    { ������ �������� ��������� }
    Begin
      ClrScr;
      top:=nil;
      b:=true;
      While b do
        begin
          Writeln('   �롥�� ०�� ࠡ���:');
          Writeln('1-���������� � �⥪');
          Writeln('2-㤠����� �� �⥪�');
          Writeln('3-�뤠� �� ��࠭');
          Writeln('4-����� ࠡ���');
          Readln(n);
          case n of
            1:   SozdDob;
            2:   Udal;
            3:   Pech;
            4:   b:=false
          end
        end
    End.
