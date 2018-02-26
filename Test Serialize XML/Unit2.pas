unit Unit2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.Rtti, Vcl.StdCtrls;

type
  TForm2 = class(TForm)
    btnXmlSerialize: TButton;
    Memo1: TMemo;
    procedure FormCreate(Sender: TObject);
    procedure btnXmlSerializeClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;


  TRttiXmlAttribute = class(TCustomAttribute)
  private
    FElementName: string;
  public
    property ElementName: string read FElementName write FElementName;
    constructor Create(const AElementName: string);
  end;

  TIntArray = array of Integer;

  TAdress = class
  private
    FAdress1: string;
  published
    property Adress1: string read FAdress1 write FAdress1;
  end;

  TPerson = class
  private
    FFirstName: string;
    FLastName: string;
    FAdress: TAdress;
  published
    property FirstName: string read FFirstName write FFirstName;
    property LastName: string read FLastName write FLastName;
    property Adress: TAdress read FAdress write FAdress;
  end;


  TComplexType = class
  private
    FFieldInt: Integer;
    FFieldStr: string;
    FFieldDouble: double;
    FIntArray: TIntArray;
    FPerson: TPerson;
    FPersonArray1: TArray<TPerson>;
    FPersonArray2: TArray<TPerson>;
  published
    property FieldInt: Integer read FFieldInt write FFieldInt;
    property FieldStr: string read FFieldStr write FFieldStr;
    property FieldDouble: double read FFieldDouble write FFieldDouble;
    property IntArray: TIntArray read FIntArray write FIntArray;
    property Person: TPerson read FPerson write FPerson;
    property PersonArray1: TArray<TPerson> read FPersonArray1 write FPersonArray1;
    property PersonArray2: TArray<TPerson> read FPersonArray2 write FPersonArray2;
  end;

var
  Form2: TForm2;
  AComplexType: TComplexType;
  AContext: TRttiContext;

implementation

{$R *.dfm}

procedure L(const Msg: string);
begin
  Form2.Memo1.Lines.Add(Msg);
end;

procedure Serialize(AObject: TObject);
var
  I: Integer;
  AValue: TValue;
  ARttiType: TRttiType;
  AProperty: TRttiProperty;
  Properties: TArray<TRttiProperty>;
begin
  ARttiType := AContext.GetType(AObject.ClassInfo);

  for AProperty in ARttiType.GetDeclaredProperties do
  begin
    AValue := AProperty.GetValue(AObject);
    if AValue.IsObject and not AValue.IsEmpty then
    begin
      L('<' + AProperty.Name + '>');
      Serialize(AValue.AsObject);
      L('<' + AProperty.Name + '/>');
    end;

    if not AValue.IsObject and not AValue.IsArray then
    begin
      L('<' + AProperty.Name + '>' + AValue.ToString + '<' +
        AProperty.Name + '/>');
    end;

    if AValue.IsArray then
    begin
      L('  ');
      L('<' + AProperty.Name + '>');
      for I := 0 to Pred(AValue.GetArrayLength) do
      begin
        if AValue.GetArrayElement(I).IsObject then
        begin
          L('<' + AValue.GetArrayElement(I).AsObject.ClassName + '>');
          Serialize(AValue.GetArrayElement(I).AsObject);
          L('<' + AValue.GetArrayElement(I).AsObject.ClassName + '/>');
        end;
      end;
      L('<' + AProperty.Name + '/>');
    end;
  end;
end;

procedure TForm2.btnXmlSerializeClick(Sender: TObject);
var
  PersonArray: TArray<TPerson>;
  IntArray: TIntArray;
begin
  AComplexType := TComplexType.Create;
  AComplexType.FieldInt := 31;
  AComplexType.FieldStr := 'iso';
  AComplexType.FFieldDouble := 31.32;

  SetLength(IntArray, 2);
  IntArray[0] := 1;
  IntArray[1] := 2;
  AComplexType.IntArray := IntArray;

  AComplexType.Person := TPerson.Create;
  AComplexType.Person.Adress := TAdress.Create;
  AComplexType.Person.FirstName := 'FirstName 1';
  AComplexType.Person.LastName := 'LastName 1';
  AComplexType.Person.Adress.Adress1 := 'ÝSTANBUL';

  SetLength(PersonArray, 2);
  PersonArray[0] := TPerson.Create;
  PersonArray[0].Adress := TAdress.Create;
  PersonArray[0].FirstName := 'ÝSMAÝL';
  PersonArray[0].LastName := 'KOCACAN';
  PersonArray[0].Adress.Adress1 := 'BALIKESÝR';

  PersonArray[1] := TPerson.Create;
  PersonArray[1].Adress := TAdress.Create;
  PersonArray[1].FirstName := 'FirstName2';
  PersonArray[1].LastName := 'LastName2';
  PersonArray[1].Adress.Adress1 := 'Adress2';

  AComplexType.PersonArray1 := PersonArray;
  AComplexType.PersonArray2 := PersonArray;

  Serialize(AComplexType);
end;

procedure TForm2.FormCreate(Sender: TObject);
begin
  AContext := TRttiContext.Create;
  ReportMemoryLeaksOnShutdown := true;
end;

{ TRttiXmlAttribute }
constructor TRttiXmlAttribute.Create(const AElementName: string);
begin
  FElementName := AElementName;
end;

end.
