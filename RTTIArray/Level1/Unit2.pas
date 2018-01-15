unit Unit2;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.StdCtrls,
  System.Rtti;

type
  TForm2 = class(TForm)
    Button1: TButton;
    Memo1: TMemo;
    Button2: TButton;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure ReadArray(PBegin: PByte; PEnd: PByte); overload;
    procedure ReadArray(const AValue: TValue); overload;
  end;

  TKisi = class
  private
    FAdi: string;
    FSoyadi: string;
  published
    property Adi: string read FAdi write FAdi;
    property Soyadi: string read FSoyadi write FSoyadi;
  end;

  TKisiArray = array of TKisi;

  TData = class
  private
    FX: Integer;
    FY: Integer;
  published
    property X: Integer read FX write FX;
    property Y: Integer read FY write FY;
  end;

  TDataArray = array of TData;

var
  Form2: TForm2;
  KisiArray: TKisiArray;
  DataArray: TDataArray;

implementation

{$R *.dfm}

procedure Dbg(AMessage: string);
begin
  Form2.Memo1.Lines.Add(AMessage);
end;

procedure TForm2.ReadArray(PBegin: PByte; PEnd: PByte);
var
  ObjPointer: Pointer;
  AObject: TObject;
  AContext: TRttiContext;
  ARttiType: TRttiType;
  AProperty: TRttiProperty;
  Properties: TArray<TRttiProperty>;
begin
  AContext := TRttiContext.Create;
  try
    while PBegin <= PEnd do
    begin
      ObjPointer := Pointer(PBegin);
      AObject := Pointer(ObjPointer^);
      ARttiType := AContext.GetType(AObject.ClassInfo);
      Properties := ARttiType.GetDeclaredProperties();
      for AProperty in Properties do
      begin
        Dbg(AProperty.Name + ': ' + AProperty.GetValue(AObject).ToString);
      end;
      Inc(PBegin, SizeOf(Pointer));
    end;
  finally
    AContext.Free;
  end;
end;

procedure TForm2.ReadArray(const AValue: TValue);
var
  I: Integer;
  ARttiType: TRttiType;
  ARttiElementType: TRttiType;

  AContext: TRttiContext;
  AObject: TObject;
  AProperty: TRttiProperty;
  Properties: TArray<TRttiProperty>;
  AArrayElement: TValue;
begin
  if not AValue.IsArray then
    raise Exception.Create('Veri dizi deðil !');

  AContext := TRttiContext.Create;
  try
    ARttiType := AContext.GetType(AValue.TypeInfo);
    for I := 0 to Pred(AValue.GetArrayLength) do
    begin
      AArrayElement := AValue.GetArrayElement(I);
      if not AArrayElement.IsObject then continue;
      AObject := AArrayElement.AsObject;
      ARttiType := AContext.GetType(AObject.ClassInfo);
      Properties := ARttiType.GetDeclaredProperties();
      for AProperty in Properties do
      begin
        Dbg(AProperty.Name + ':' + AProperty.GetValue(AObject).ToString);
      end;
    end;
  finally
    AContext.Free;
  end;
end;

procedure TForm2.Button1Click(Sender: TObject);
begin
  ReadArray(@KisiArray[Low(KisiArray)], @KisiArray[High(KisiArray)]);
  ReadArray(@DataArray[Low(DataArray)], @DataArray[High(DataArray)]);
end;

procedure TForm2.Button2Click(Sender: TObject);
begin
  ReadArray(TValue.From(KisiArray));
  ReadArray(TValue.From(DataArray));
end;

procedure TForm2.FormClose(Sender: TObject; var Action: TCloseAction);
var
  I: Integer;
begin
  for I := Low(KisiArray) to High(KisiArray) do
    KisiArray[I].Free;
  SetLength(KisiArray, 0);

  for I := Low(DataArray) to High(DataArray) do
    DataArray[I].Free;
  SetLength(DataArray, 0);
end;

procedure TForm2.FormCreate(Sender: TObject);
const
  ELEMENT_COUNT = 31;
var
  I: Integer;
begin
  ReportMemoryLeaksOnShutdown := true;

  SetLength(KisiArray, ELEMENT_COUNT);
  for I := 0 to ELEMENT_COUNT - 1 do
  begin
    KisiArray[I] := TKisi.Create;
    KisiArray[I].Adi := Format('Test Adý %d', [I]);
    KisiArray[I].Soyadi := Format('Test Soyadý %d', [I]);
  end;

  SetLength(DataArray, ELEMENT_COUNT);
  for I := 0 to ELEMENT_COUNT - 1 do
  begin
    DataArray[I] := TData.Create;
    DataArray[I].X := Random(ELEMENT_COUNT);
    DataArray[I].Y := Random(ELEMENT_COUNT);
  end;

end;

end.
