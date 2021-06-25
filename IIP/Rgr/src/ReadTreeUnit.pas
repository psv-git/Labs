UNIT ReadTreeUnit;

INTERFACE

USES
  SupportUnit;

FUNCTION ReadTree(VAR FTxt: TEXT): Ptr;

IMPLEMENTATION

FUNCTION LowCase(VAR Ch: CHAR): CHAR;
BEGIN
  IF Ch IN ['�' .. '�']
  THEN
    CASE Ch OF
      '�': Ch := '�'; '�': Ch := '�'; '�': Ch := '�'; '�': Ch := '�'; '�': Ch := '�'; '�': Ch := '�';
      '�': Ch := '�'; '�': Ch := '�'; '�': Ch := '�'; '�': Ch := '�'; '�': Ch := '�'; '�': Ch := '�';
      '�': Ch := '�'; '�': Ch := '�'; '�': Ch := '�'; '�': Ch := '�'; '�': Ch := '�'; '�': Ch := '�';
      '�': Ch := '�'; '�': Ch := '�'; '�': Ch := '�'; '�': Ch := '�'; '�': Ch := '�'; '�': Ch := '�';
      '�': Ch := '�'; '�': Ch := '�'; '�': Ch := '�'; '�': Ch := '�'; '�': Ch := '�'; '�': Ch := '�';
      '�': Ch := '�'; '�': Ch := '�'; '�': Ch := '�';
    END;
  IF Ch IN ['A' .. 'Z']
  THEN
    CASE Ch OF
      'A': Ch := 'a'; 'B': Ch := 'b'; 'C': Ch := 'c'; 'D': Ch := 'd'; 'E': Ch := 'e'; 'F': Ch := 'f';
      'G': Ch := 'g'; 'H': Ch := 'h'; 'I': Ch := 'i'; 'J': Ch := 'j'; 'K': Ch := 'k'; 'L': Ch := 'l';
      'M': Ch := 'm'; 'N': Ch := 'n'; 'O': Ch := 'o'; 'P': Ch := 'p'; 'Q': Ch := 'q'; 'R': Ch := 'r';
      'S': Ch := 's'; 'T': Ch := 't'; 'U': Ch := 'u'; 'V': Ch := 'v'; 'W': Ch := 'w'; 'X': Ch := 'x';
      'Y': Ch := 'y'; 'Z': Ch := 'z';
    END;
  LowCase := Ch;
END;

{ �������� �� ����� ��� CheckParseState }
FUNCTION IsLetter(VAR Ch: CHAR): BOOLEAN;
BEGIN
  CASE (Ch IN ['a' .. 'z']) OR (Ch IN ['A' .. 'Z']) OR (Ch IN ['�' .. '�']) OR (Ch IN ['�' .. '�']) OF
    TRUE: IsLetter := TRUE;
    FALSE: IsLetter := FALSE;
  END;
END;

{ �������� ������� ��� ReadWord }
PROCEDURE CheckParseState(VAR Ch: CHAR; VAR State: ParseState);
BEGIN
  IF ((State = SkipChar) OR (State = NextWord) OR (State = Hyphen)) AND IsLetter(Ch) THEN State := Letter ELSE
  IF (State = Letter) AND (Ch = '-') THEN State := Forward ELSE
  IF (State = Forward) AND IsLetter(Ch) THEN State := Hyphen ELSE
  IF ((State = Letter) OR (State = Forward) OR (State = Hyphen)) AND NOT IsLetter(Ch) THEN State := NextWord ELSE
  IF (State = NextWord) AND NOT IsLetter(Ch) THEN State := SkipChar;
END;

{ ��������� ����� � ������ �� �����; �����, ����������� ���������� �����, ������������� }
FUNCTION ReadWord(VAR FTxt: TEXT): Ptr;
VAR
  Ch: CHAR;
  MNode: Ptr;
  TmpStr: STRING;
  State: ParseState;
  ReadCount: CARDINAL;
BEGIN
  MNode := NIL;
  State := SkipChar;
  TmpStr := '';
  ReadCount := 0;                                            { ������������ ���������� �������� �������� }
  WHILE NOT EOF(FTxt) AND (State <> NextWord)
  DO
    BEGIN
      READ(FTxt, Ch);
      CheckParseState(Ch, State);                            { ������������� ������ ������� }
      IF State = Letter                                      { ��������� ������ � ������� ����� ������ }
      THEN
        BEGIN
          ReadCount := ReadCount + 1;
          IF Length(TmpStr) < MaxStrLen
          THEN
            TmpStr := TmpStr + LowCase(Ch)                   { ��������� � ������ ����� }
        END
      ELSE
        IF State = Hyphen                                    { ��������� ������ � ������� ����� ������ }
        THEN
          BEGIN
            ReadCount := ReadCount + 2;
            IF Length(TmpStr) < MaxStrLen
            THEN
              TmpStr := TmpStr + '-' + LowCase(Ch);          { ��������� � ������ ����� � ����� }
          END;
    END;
  IF (State = NextWord) AND (ReadCount <= MaxStrLen)         { ����� ����� � ���-�� �������� �������� �� ��������� ����� ������ }
  THEN
    BEGIN
      CreateNode(MNode);                                     { ������� ������ }
      MNode^.Rec.Str := TmpStr;                              { ��������� � ������ ����� }
    END;
  ReadWord := MNode;
END;

{ ����������� ������ � ������ }
FUNCTION AttachNode(VAR Root, MNode: Ptr): BOOLEAN;
VAR
  Result: BOOLEAN;
BEGIN
  Result := FALSE;
  IF Root^.Rec.Str = MNode^.Rec.Str        { ��� ���������� ���� ����������� ������� ����� � ������� �������� }
  THEN
    BEGIN
      Root^.Rec.Count := Root^.Rec.Count + 1;
      DISPOSE(MNode);
    END
  ELSE
    IF Root^.Rec.Str > MNode^.Rec.Str      { ���� ������ � ������� Root ������.. }
    THEN
      IF Root^.Left <> NIL                 { ..� ����� ���� �������, ���������� � ���� }
      THEN
        Result := AttachNode(Root^.Left, MNode)
      ELSE
        BEGIN
          Root^.Left := MNode;             { ���� ����� ��������� ��� �� ������ ������� ����� }
          AttachNode := TRUE;
        END
    ELSE
      IF Root^.Right <> NIL                { ���� ������ � ������� Root ������ � ������ ���� �������, ���������� � ���� }
      THEN
        Result := AttachNode(Root^.Right, MNode)
      ELSE
        BEGIN
          Root^.Right := MNode;            { ���� ������ ��������� ��� �� ������ ������� ������ }
          AttachNode := TRUE;
        END;
  AttachNode := Result;
END;

{ ��������� ����� �� ����� � ������������� ������� }
FUNCTION ReadTree(VAR FTxt: TEXT): Ptr;
VAR
  Root, MNode: Ptr;
  NodeCount: CARDINAL;
BEGIN
  Root := ReadWord(FTxt);                              { ������ ������ }
  IF Root <> NIL
  THEN
    BEGIN
      NodeCount := 1;
      WHILE NOT EOF(FTxt) AND (NodeCount < TreeSize)
      DO
        BEGIN
          MNode := ReadWord(FTxt);                     { ������ ���� }
          IF MNode <> NIL                              { ���� ���� ���� ��������� }
          THEN
            IF AttachNode(Root, MNode)        { ��������� ���� � ������ }
            THEN
              NodeCount := NodeCount + 1;
        END;
    END;
  ReadTree := Root;
END;

BEGIN
END.

