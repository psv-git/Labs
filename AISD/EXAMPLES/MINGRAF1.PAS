Program Mingraf1;
{ �뤥����� �������쭮�� ��� �� ��砫�, ����� � ����� }
{ �ᯮ������ �⥪, ���⠭���� ����⮪ - � ��㡨�� }
  uses crt;
  Type
    prizn=0..1;
    uzel=record
           zapr: prizn;         { 1-���設� ����饭�, 0-��� }
           l: array[1..2] of integer; { ����� ���। � ����� }
         end;
  Var
    m,n,i,j,k,nb,nk,top,len: integer;
    matr: array[1..20,1..20] of prizn;  { ����� ᬥ����� }
    stek: array[1..20] of integer;
    { �⥪ ���設, ��� �뭮��� ������ ���⠢�塞 ����� }
    ver:  array[1..20] of uzel;   { ������-����� ���設� }
  Procedure Rasstan(napr: integer);
    { ���⠭���� ���� � ���ᨢ�� l1 ��� l2 }
    { napr=1-���⠭���� �� ��砫쭮� ���設� � ����筮� }
    { napr=2-���⠭���� �� ����筮� ���設� � ��砫쭮� }
    Begin
      top:=1;  { ���設� �⥪� }
      if napr=1 then stek[1]:=nb   { nb-��砫쭠� ���設� }
      else stek[1]:=nk;            { nk-����筠�  ���設� }
      ver[stek[1]].l[napr]:=0;
      While top>0 do
        begin
          i:=stek[top];
          top:=top-1;
          if ver[i].l[napr]<len then
            { �� ���⨣�� ���ᨬ��쭮� ����� }
            For j:=1 to n do
              begin
                if napr=1 then k:=matr[i,j]
                else k:=matr[j,i];
                if k=1 then    { ���� ��� }
                  begin
                    m:=ver[i].l[napr]+1;
                    if m<ver[j].l[napr] then
                    { ����. ����� ��� �� ����襬 ����.}
                      begin
                        ver[j].l[napr]:=m;
                        top:=top+1;
                        stek[top]:=j  { ����ᥭ�� � �⥪ }
                      end
                  end
              end
        end
    End;
    Procedure Pech;   { �ᯥ�⪠ ������ ᬥ����� }
      Begin
        For i:=1 to n do
          begin
            Writeln;
            for j:=1 to n do
              Write(matr[i,j],' ')
          end
      End;
  Begin  { �᭮���� �ணࠬ�� }
    Clrscr; { ���⪠ ��࠭� }
    Write('������ �᫮ ���設 ');
    Readln(n);
    For i:=1 to n do
      for j:=1 to n do
        matr[i,j]:=0;
    For i:=1 to n do
      begin
        Writeln('���������� ���設�� ',i,':');
        k:=999;
        While k>0 do
          begin
            Write('������ ����� ��।���� �뭠 ���設� ',
                   i,' ');
            Readln(k);  { k<0-�ਧ��� ���� ᯨ᪠ �뭮��� }
            if (k>0) and (k<=n) then
              begin
                matr[i,k]:=1;
                ver[i].l[1]:=999; {  ��� ���饣� }
                ver[i].l[2]:=999; {  ���᪠ �����㬠 }
                ver[i].zapr:=0    {  ����� ���  }
              end
          end
      end;
      Write('������ ����� ��砫쭮� ���設� ');
      Readln(nb);
      Write('������ ����� ����筮� ���設�  ');
      Readln(nk);
      Write('������ ���ᨬ����� �����      ');
      Readln(len);
      Writeln;
      Writeln('���� ����� ᬥ�����:');
      Pech;
      Readln;  { ��㧠 }
      Rasstan(1);  { ���⠭���� ���� ���। }
      if ver[nk].l[1]>len then
 { ���設� nk �� ����砫��� ��� �����, 祬 �� LEN ����쥢 }
        begin
          Writeln(' ���  ���� !!!');
          Exit
        end;
      Rasstan(2);  { ���⠭���� ���� �����  }
      For i:=1 to n do   { ���⠭���� ����⮢ �� ���設� }
        if ver[i].l[1]+ver[i].l[2]>len then ver[i].zapr:=1;
      For i:=1 to n do    { ��ࠢ����� ������ ᬥ����� }
        if ver[i].zapr=1 then   { i-� ���設� ����饭� }
          for j:=1 to n do
            begin
              matr[i,j]:=0;
              matr[j,i]:=0
            end;
      For i:=1 to n do    { ������ �� ������ ᬥ����� }
        For j:=1 to n do
          if matr[i,j]=1 then
            if ver[i].l[1]+1+ver[j].l[2]>len then
              matr[i,j]:=0;
     Writeln;
     Writeln('����� ����� ᬥ�����:');
     Pech;
     Readln
  End.
