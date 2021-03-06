Program TreeIO;
{ ���� ��ॢ� �� 䠩��, �।�⠢����� ������ ��ॢ�� � ��, 
  �뢮� � 䠩�
���� ��ॢ� �� 䠩�� � �窠�� � �ଠ�
Ann
.Boris
..Cat
..Dora
...Eva
...Fred
..Goga
...Helmut
....Marta
.....Bred
.....Stiv
.....Jon
......Tom
...Nata
.Nina

�뢮� ��ॢ� � 䠩� � �ᥢ����䨪�� � �⨫� Far 
Ann
�Boris
��Cat
��Dora
���Eva
���Fred
��Goga
� �Helmut
� ��Marta
� � �Bred
� � �Stiv
� � �Jon
� �  �Tom
� �Nata
�Nina
}
Type
  ukaz=^uzel;
  uzel=record
         name: string;     {��� ���設�}
         left,right: ukaz; {�뭮���}
         fath: ukaz;       {��� � ��室��� ��ॢ�}
         urov: integer;    {�஢��� ��室���� ��ॢ�, ��稭�� � 0}
         Flag: boolean;    {�ਧ��� ��᫥����� �뭠}
       end;
Var
  t,kon,root,p: ukaz;
  i,k,m,Len: integer;
  S,R: string;
  Fin,Fout: text;
Procedure PechPr(t:ukaz);  
{�뤠� � 䠩� � �ᥢ����䨪�� � ���浪� ᢥ��� ����}
Var
  j: integer;
  St: string;   {��� �ନ஢���� ��ப� �뤠�}
Begin
  if t<>nil then
    Begin
      St:=t^.name;
      if t^.urov>0 then         {�� ��७�}
        if t^.Flag then         {��᫥���� ��}
          St:=Chr(192)+St       { ᨬ��� � }
        else
          St:=Chr(195)+St;      { ᨬ��� � }
      p:=t;
      For j:=1 to t^.urov-1 do  {����� � ����ᨬ��� �� �஢��}
        begin
          p:=p^.fath;
          if p^.Flag then       {���� ���設� ��᫥���� ��}
            St:=' '+St
          else
            St:=Chr(179)+St;    { ᨬ��� � }
        end;
      WriteLn(Fout,St);
      PechPr(t^.left);
      PechPr(t^.right);
    end
End;
Begin
  Assign(Fin,'input.txt');
  Reset(Fin);
  New(root);
  ReadLn(Fin,S);
  root^.name:=S;
  root^.urov:=0;
  root^.Flag:=true; {�ਧ��� ��᫥����� �뭠-��� ���� �� ��易⥫쭮}
  root^.fath:=nil;  {���}
  m:=0;             {�஢��� ���設�}
  t:=root;          {�।���� ���設� ��� ᫥���饩 � 䠩��}
  While not Eof(Fin) do
    begin
      ReadLn(Fin,S);
      k:=0;
      Len:=Length(S);
      While S[k+1]='.' do k:=k+1;   {k-�஢��� ���設�, ��稭�� � 0}
      R:=Copy(S,k+1,Len-k);         {��� ���設�}
      New(kon);
      kon^.name:=R;
      kon^.left:=nil;
      kon^.right:=nil;
      kon^.urov:=k;
      if k>m then               {���室 �� ᫥���騩 �஢���}
        begin
          t^.left:=kon;
          kon^.fath:=t;
          kon^.Flag:=true;      {�ਧ��� ��᫥����� �뭠}
        end
      else
        if k=m then             {�� �� �஢���}
          begin
            t^.right:=kon;
            kon^.fath:=t^.fath; {��� �� ��, �� � ���}
            t^.Flag:=false;     {��⨥ �ਧ���� ��᫥����� �뭠}
            kon^.Flag:=true;    {�ਧ��� ��᫥����� �뭠}
          end
        else                    {���ꥬ �� ��ॢ� �� m-k �஢���}
          begin
            p:=t;
            For i:=1 to m-k do
              p:=p^.fath;
            {p-�।���� ���設� ⮣� �� �஢��}
            kon^.fath:=p^.fath; {��� � ��室��� ��ॢ� �� ��, �� � ���}
            p^.right:=kon;
            p^.Flag:=false;     {��⨥ �ਧ���� ��᫥����� �뭠}
            kon^.Flag:=true;    {�ਧ��� ��᫥����� �뭠}
          end;
      m:=k;       {��������� ⥪�騩 �஢���}
      t:=kon;     {��� ࠡ��� � ᫥���饩 ���設��}
    end;          {����� While}
   Close(Fin);
   Assign(Fout,'output.txt');
   Rewrite(Fout);
   PechPr(root);  {�뤠� ��ॢ� � 䠩�}
   Close(Fout);
  End.
