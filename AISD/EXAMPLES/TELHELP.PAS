Program TelefonHelp;
{ ���� ���ଠ樨 � ��������� ⥫�䮭�� }
  Uses Crt;
  Type
    Telefon=record
              flag: boolean;{ true-���� ���ଠ��, false-���}
              name: string  { ��� �������� }
            end;
   Var
     f: file of Telefon;
     i,nom,code: integer;
     number: String[3];
     Buf: Telefon;
     b: boolean;
     Otvet: string;
   Begin
     ClrScr;
     If ParamCount<1 then
       Begin
         Writeln('������ ��� 䠩��');
         Exit
       End;
     Assign(f,ParamStr(1));
     {$I-}
     Reset(f);
     {$I+}
     if IOResult<>0 then
       Begin
         Writeln('���� ',ParamStr(1),' �� ����㯥�');
         ReadLn;
         Exit
       End;
     b:=true;
     While b do
       Begin
         Write('������ ����� ⥫�䮭�: ');
         ReadLn(number);
         Val(number,nom,code);
         if code<>0 then Writeln('�訡��� ���� !')
         else
           begin
             Seek(f,nom);
             Read(f,Buf);
             if Buf.flag then
               Writeln('�������� ⥫�䮭� ',number,' ',Buf.name)
             else
               Writeln('���ଠ�� � ⥫�䮭� ',number,' ���������');
           end;
         Readln;
         Write('�㤥� �த������ ���� (��/���) ? ');
         ReadLn(Otvet);
         if Otvet='���' then b:=false
       end;
     Close(f);
     WriteLn('�ᥣ� ��襣� !!! ');
     ReadLn
   End.
