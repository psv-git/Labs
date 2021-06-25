UNIT SupportUnit;

INTERFACE

CONST
  TreeSize = 5;                              { ������ ������ }
  MaxStrLen = 50;                            { ����� ������ �� ����� }
TYPE
  ParseState = (SkipChar, Letter, Forward, NextWord, Hyphen);
  OrderState = (Null, Swap);
  Ptr = ^NodeProt;
  RecordProt =  RECORD                        { �������� ������ �� ������ }
                  Str: STRING[MaxStrLen];     { ������ ��� ����� }
                  Count: CARDINAL;            { ���������� ���������� ������� ����� � ������ }
                END;
  NodeProt =  RECORD                          { �������� ���� �� ����� }
                Rec: RecordProt;
                Left: Ptr;
                Right: Ptr;
              END;
  FileOfRecords = FILE OF RecordProt;

PROCEDURE CreateNode(VAR MNode: Ptr);

IMPLEMENTATION

{ ������� ������ }
PROCEDURE CreateNode(VAR MNode: Ptr);
BEGIN
  NEW(MNode);
  MNode^.Rec.Str := '';
  MNode^.Rec.Count := 1;
  MNode^.Left := NIL;
  MNode^.Right := NIL;
END;

BEGIN
END.
