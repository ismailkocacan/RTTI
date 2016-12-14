unit UnitGenericPointer;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, TypInfo;

type
  TForm2 = class(TForm)
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}



procedure Hesapla(P: Pointer; Info: PTypeInfo); overload;
var
  AInteger: PInteger;
  ABoolean: PBoolean;
  AByte: PByte;
begin

  if Info = TypeInfo(Byte) then
  begin
    AByte := P;
    ShowMessage('Veri Tipi Byte :' + IntToStr(AByte^));
  end;

  if Info = TypeInfo(Integer) then
  begin
    AInteger := P;
    ShowMessage('Veri Tipi Integer :' + IntToStr(AInteger^));
  end;

  if Info = TypeInfo(Boolean) then
  begin
    ABoolean := P;
    ShowMessage('Veri Tipi Boolean :' + BoolToStr(ABoolean^, true));
  end;

end;


procedure TForm2.FormCreate(Sender: TObject);
var
  AInt: Integer;
  ABoolean: Boolean;
  AByte: Byte;
  ACardinal: Cardinal;
begin

  AInt := 313131;
  Hesapla(@AInt, TypeInfo(Integer));

  AByte := 255;
  Hesapla(@AByte, TypeInfo(Byte));

  ABoolean := false;
  Hesapla(@ABoolean, TypeInfo(Boolean));

  ACardinal := 50;
  Hesapla(@ACardinal, TypeInfo(Cardinal));
end;

end.
