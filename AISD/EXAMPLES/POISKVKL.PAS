Program PoiskVkl;
{ ���� � ����祭��� �� ����୮� ��ॢ� }
Uses crt;
Type
  ref= ^word;
  stri= string[20];
  word=record
         key: stri;
         count: integer;
         left,right: ref
       end;
Var
  root: ref;
  rab: stri;
  b: boolean;
Procedure Search(x: stri; Var p: ref);
  Begin
    if p=nil then { ᫮�� ���-������� ! }
      begin
        new(p);
        with p^ do
          begin
            key:=x;
            count:=1; left:=nil; right:=nil
          end
       end
     else
       if x<p^.key then Search(x,p^.left)
       else
         if x>p^.key then Search(x,p^.right)
         else { ��諨 ᫮�� }
           p^.count:=p^.count+1
  End;
Procedure Delete(x: stri; var p: ref);
{ ������ �᢮��������� ! }
  Var
    q: ref;
  Procedure Del(var r: ref);
  { ����饭�� ᠬ� �ࠢ� ������⮬ ������ �����ॢ� }
    Begin
      if r^.right<>nil then Del(r^.right)
      else
        begin { r-ᠬ� �ࠢ� ������ �����ॢ� }
          q^.key:=r^.key;
          q^.count:=r^.count;
          q:=r;
          r:=r^.left;  { �����㫨 ����� �����ॢ� }
          Dispose(q)
        end
    End;
  Begin
    if p=nil then
      Writeln('����� ��� � ��ॢ� !')
    else
     if x<p^.key then Delete(x,p^.left)
     else
       if x>p^.key then Delete(x,p^.right)
       else { x=p^.key - ��諨 ᫮�� }
         if p^.count>1 then p^.count:=p^.count-1
         else
           begin  { 㤠����� ᫮�� }
             q:=p;
             if q^.right=nil then
               begin
	               p:=q^.left; { �����㫨 ����� �����ॢ� }
                 Dispose(q)
               end
             else if q^.left=nil then
                    begin
	                    p:=q^.right; { �����㫨 ����� �����ॢ� }
                      Dispose(q)
                    end
                  else Del(q^.left);   { ������ }
           end
  End;
Procedure PrintTree(w: ref; l: integer);
{ w-��७�, l-�᫮ �祪(�஢���) }
  Var
    i: integer;
  Begin    
    if w<>nil then
      with w^ do
        begin
          PrintTree(left,l+1);
          for i:=1 to l do
            Write('.');
          Writeln(key,' ',count);
          PrintTree(right,l+1)
        end
  End;
  Begin
    ClrScr;
    rab:=' ';
    root:=nil;
    b:=true;
    While b do
      begin
        Write('������ ᫮�� ��� ����� ');
        Readln(rab);
        if rab<>'�' then
          begin
            Search(rab,root);
            PrintTree(root,0)
          end
        else b:=false
      end;
    b:=true;
    While b do
      begin
        Write('������ ᫮�� ��� 㤠����� ');
        Readln(rab);
        if rab<>'�' then
          begin
            Delete(rab,root);
            PrintTree(root,0)
          end
        else b:=false
      end;
  End. 