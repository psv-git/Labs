Program CiklList;  { ࠡ�� � ����楢�� ��।�� }
Uses crt;
Type  Ukaz = ^List;
      List = Record
               Key  : Integer;
               Next : Ukaz;
             End;
{      ����楢�� ��।�; 㪠��⥫� �� ��砫� � �����        }
{      ������ ������� ���몠���� �� ��砫�                 }
Var   p,q,r : Ukaz;  { r - 㪠��⥫� �� ������ �������     }
      Knew,k,tmp,CouElem : Integer;
{      CouElem - �᫮ ������⮢ � ��।�                   }
{------------------------------------------------------------}
{                   ���⠭���� � ��।�.                    }
{------------------------------------------------------------}
Procedure MakeList;
Begin
  While True Do
    Begin
      Write('���� : ');
      ReadLn(Knew);
      If Knew = 0 Then
        Begin
          WriteLn('�ᥣ� ������⮢: ',CouElem);
          Exit
        End;
      New(q);
      If CouElem=0 Then
        q^.next :=q   { ���� ������� 㪠�뢠�� ᠬ �� ᥡ� }
      Else
        Begin
          q^.next:=r^.next;     { r^.next --> ��砫� ��।� }
          r^.next := q      { ��� � ��訬 ���殬 ��।�  }
        End;
      q^.key := Knew;
      r:=q;                  { ���� ������� - ����� ��।� }
      Inc(CouElem);
    End
End;
{------------------------------------------------------------}
{                   �த������� ��।�.                     }
{------------------------------------------------------------}
Procedure Go;
Var    Count : Integer;
Begin
  p:=r^.next;                  { 㪠��⥫� �� ��砫� ��।� }
  WriteLn('���� ��砫쭮� ����樨 ',p^.key);
  Dec(CouElem);
  If CouElem>0 Then
    begin
      q:=p^.next;             { ��ன ������� }
      r^.next:=q;
      WriteLn('���� ����� ��砫쭮� ����樨 ',q^.key)
    end
  Else WriteLn('��।� ����');
  Dispose(p)
End;
{------------------------------------------------------------}
{    ��⠢�� � �।��� ��। ������⮬ � ������� ���箬.   }
{------------------------------------------------------------}
Procedure IncList;
Var c : Integer;
    g : Ukaz;
Begin
  c:=0;
  Write('��। ������⮬ � ���箬 ');
  ReadLn(k);
  p:=r^.next;                 { ��砫� ��।� }
  Repeat
    If p^.key = k Then        { �饬 ������� � �㦭� ���箬 }
      Begin
        New(g);               { � ��⠢�塞 ��। ��� ����  }
        g^:=p^;
        p^.next := g;
        Write('���� : ');
        ReadLn(Knew);
        If Knew = 0 Then Exit;
        p^.key:=Knew;
        If c=CouElem-1 Then r:=g; {  ��⠢�� ��। ���殬    }
        Inc(CouElem);
        Exit
      End
    Else
      Begin
         p := p^.next;    {  �த�������� �� ��।�         }
         Inc(c)
      End
  Until c=CouElem;     { 横� �� ������ � ��室��� ������ }
  WriteLn('� ᯨ᪥ ������� � ���箬 ',k,' ���')
End;
{------------------------------------------------------------}
{              �������� �� �।��� ��।�.                 }
{------------------------------------------------------------}
Procedure DelFromList;
Var c :  Integer;
Begin
  c:=0;
  Write('� ����� ���箬 ? ');
  ReadLn(k);
  p:=r^.next;           { ��砫� ��।� }
  Repeat
    If p^.key = k Then
      Begin                  { �饬 ������� � �㦭� ���箬  }
        If p = r^.next Then Go { 㤠����� �� ��砫� ��।�  }
        Else
          Begin
            q^.next := p^.next;
            If p=r Then  r:=q;   {   ����� ��।�           }
            Dispose(p);
            Dec(CouElem);
          End;
        Exit
      End
    Else
      Begin
         q:=p;            {  ��������� �।��騩 �������   }
         p := p^.next;    {  �த�������� �� ��।�        }
         Inc(c)
      End
  Until c=CouElem;    { 横� �� ������ � ��室��� ������ }
  WriteLn('� ᯨ᪥ ������� � ���箬 ',k,' ���')
End;
{------------------------------------------------------------}
{                �뤠� ��।� �� ��࠭.                    }
{------------------------------------------------------------}
Procedure OutList;
Var Count,i : Integer;
Begin
  p:=r^.next;                     { ��砫� ��।� }
  For i:=1 To CouElem Do
    begin
      Write(p^.key,' ');
      p:=p^.next
    end;
  WriteLn;
  WriteLn('�ᥣ� ������⮢: ',CouElem)
End;
{------------------------------------------------------------}
{                   �������� �ணࠬ��.                      }
{------------------------------------------------------------}
Begin
  Clrscr;
  CouElem:=0;            { ���稪 �᫠ ������⮢ � ��।� }
  Repeat
    Writeln;
    WriteLn('1.���⠢��� � ��।� (���� 0-�ਧ��� ����)');
    WriteLn('2.�த������ ��।�');
    WriteLn('3.��⠢��� �������');
    WriteLn('4.������� �������');
    WriteLn('5.�������� ��� ��।�');
    WriteLn('6.��室');
    Write('�롨ࠥ� : ');
    ReadLn(Tmp);         {  ����� �㭪� ���� }
    Case Tmp Of
      1 : MakeList;
      2 : If CouElem <> 0 Then Go
          Else WriteLn('��।� ���, ������ �롮�');
      3 : If CouElem <> 0 Then IncList
          Else WriteLn('��।� ���, ������ �롮�');
      4 : If CouElem <> 0 Then DelFromList
          Else WriteLn('��।� ���, ������ �롮�');
      5 : If CouElem <> 0 Then OutList
          Else WriteLn('��।� ����');
      6 : Halt
    End
  Until False;
End.
