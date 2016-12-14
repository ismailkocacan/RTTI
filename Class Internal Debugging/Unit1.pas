unit Unit1;

interface

type

   // Toplam : 14 Byte
  TA = class
  private
    FFieldA: Integer; // 4 Byte
    FFieldB: Integer; // 4 Byte
    FFieldC: Integer; // 4 Byte
    FFieldD: Byte; // 1 Byte
    FFieldE: Byte; // 1 Byte
  public
    property FieldA: Integer read FFieldA;
    property FieldB: Integer read FFieldB;
    property FieldC: Integer read FFieldC;

    property FieldD: Byte read FFieldD;
    property FieldE: Byte read FFieldE;

    function Adresi: PByte;
    constructor Create;
  end;

implementation



function TA.Adresi: PByte;
begin
  result := PByte(Self);
end;

constructor TA.Create;
begin
  inherited;
  FFieldA := 131;
  FFieldB := 132;
  FFieldC := 133;

  FFieldD := 134;
  FFieldE := 135;
end;

end.
