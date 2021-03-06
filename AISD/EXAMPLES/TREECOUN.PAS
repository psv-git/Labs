Program TreeCount;   { ���� ��ࠦ���� �� ����୮� ��ॢ� }
  Uses crt;
  Const
    zn= ['+','-','/','*','^'];
    let=['a'..'z'];          { �㪢� }
    dig=['0'..'9'];          { ���� }
    smv=zn+let+dig;          { �����⨬� ᨬ���� �� ����� }
  Type
    ukaz=^uzel;
    uzel=record              { ������� ���設� ��ॢ� }
           key:char ;        { ����, ��� ��� �㪢�    }
           left,right:ukaz   { �뭮���                  }
         end;
  Var
    root,kon:    ukaz;
    a:           array ['a'..'z'] of real;
    { ���ᨢ ���祭�� �����䨪��஢ ��ॢ� }
    s:           set of char;  { ������⢮ ��������� �㪢 }
    n,k:         char;
  Procedure Sozd(t:ukaz);
    { ४��ᨢ��� ��楤�� ᮧ����� ��室���� ��ॢ� }
    { t-㪠��⥫� �� ��७� }
    Begin
      if t<>nil then
        begin
          Repeat
            Write('������ ���祭�� ���設� ');
            Readln(k);
            if not (k in smv) then
              Writeln('���ࠢ���� ᨬ���, ������ ���� ');
          Until k in smv;
          t^.key:=k;
          if not (k in zn) then  { k-�㪢� ��� ��� }
            begin
              t^.left:=nil;
              t^.right:=nil;
              if k in let then   { k-�㪢� }
                s:=s+[k]         { ���������� � ������⢮ }
            end
          else
            begin
              Writeln('���室�� � ������ ��� ���設� ',t^.key);
              New(kon);
              t^.left:=kon
            end;
          Sozd  (t^.left);
          if t^.left<>nil then   { t^.key-�㪢� ��� ��� }
            begin
              Writeln('���室�� � �ࠢ��� ��� ���設� ',t^.key);
              New(kon);
              t^.right:=kon
            end;
          Sozd(t^.right)
        end
    End;
  Procedure PechPo(t:ukaz);
  { �뢮� �� ��࠭ ��ࠦ���� � ����䨪᭮� �ଥ }
  Begin
    if t<>nil then
      begin
        PechPo(t^.left);
        PechPo(t^.right);
        Write(t^.key,' ')
      end
  End;
  Procedure PechPr(t:ukaz);
  { �뢮� �� ��࠭ ��ࠦ���� � ��䨪᭮� �ଥ }
  Begin
    if t<>nil then
    begin
      Write(t^.key,' ');
      PechPr(t^.left);
      PechPr(t^.right)
   end
  End;
  Function f1(t:ukaz):real;
  { ���� ���祭�� ��ࠦ����, ��������� ������ ��ॢ�� }
  Begin
    if t^.left=nil then     { ����: � t^.key ��� ��� �㪢� }
      if t^.key in dig then        { ��� }
        f1:=ord(t^.key)-ord('0')   { �᫮��� ���祭�� }
      else                         { �㪢�-�����䨪��� }
        f1:=a[t^.key]              { ���祭�� �����䨪��� }
    else case t^.key of            { �� ����: � t^.key ���� }
            '+': f1:=f1(t^.left)+f1(t^.right);
            '-': f1:=f1(t^.left)-f1(t^.right);
            '*': f1:=f1(t^.left)*f1(t^.right);
            '/': f1:=f1(t^.left)/f1(t^.right);
            '^': f1:=exp(f1(t^.right)*ln(f1(t^.left)))
         end
  End;
  Begin
    s:=[];          { ���⮥ ������⢮ }
    Clrscr;
    New(root);
    Sozd  (root);
    Writeln('���� �����祭 !');
    Readln;   { ��㧠 }
    PechPo(root);
    Writeln('   - ����䨪᭠� �ଠ');
    Readln;
    PechPr(root);
    Writeln('   - ��䨪᭠� �ଠ');
    Readln;
    For n:='a' to 'z' do  { ���� ���祭�� �����䨪��஢ }
      if n in s then
        begin
          Write (n,'=');
          Readln(a[n]);
        end;
    Writeln('���祭�� ��ࠦ����:  ', f1(root):1:3);
    Readln
  End.
