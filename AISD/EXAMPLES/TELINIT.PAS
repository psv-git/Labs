Program TelefonInit;
{������ ���ଠ樨 � ��������� ⥫�䮭��}
  Uses Crt;
  Type
    Telefon=record
              flag: boolean;{ true-���� ���ଠ��, false-���}
              name: string  { ��� �������� }
            end;
   Var
     f: file of Telefon;
     i,nom,code: integer;
     number: string[3];
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
     Rewrite(f);
     For i:=0 to 999 do
       Begin
         Buf.flag:=False;
         Write(f,buf)
       end;
     b:=true;
     While b do
       Begin
         Write('������ ����� ⥫�䮭�: ');
         ReadLn(number);
         Val(number,nom,code);
         if (code<>0) or ((nom>999) or (nom<0)) then
           begin
             Writeln('�訡��� ���� !');
             ReadLn
           end
         else
           begin
             Write('������ ��� �������� ⥫�䮭�: ');
             ReadLn(Buf.name);
             Buf.flag:=true;
             Seek(f,nom);
             Write(f,Buf)
           end;
         Write('�㤥� �த������ ���� (��/���) ? ');
         ReadLn(Otvet);
         if Otvet='���' then b:=false
       end;
     Close(f);
     WriteLn('�ᥣ� ��襣� !!! ');
     ReadLn
   End.

