unit UnitClient;

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
  Data.DB,
  Datasnap.DBClient,
  Vcl.Grids,
  Vcl.DBGrids,
  Vcl.StdCtrls,
  System.Generics.Defaults,
  System.Generics.Collections,
  System.Rtti,
  IMyWebService1;

type
  TForm2 = class(TForm)
    btnCreateDataset: TButton;
    DBGrid1: TDBGrid;
    btnCallWebService: TButton;
    ClientDataSet1: TClientDataSet;
    DataSource1: TDataSource;
    procedure FormCreate(Sender: TObject);
    procedure btnCallWebServiceClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCreateDatasetClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure ReadArray(const AnArray:TValue);
  end;

var
  Form2: TForm2;
  PersonList : TPersonArray;

implementation

{$R *.dfm}

procedure TForm2.btnCallWebServiceClick(Sender: TObject);
begin
 PersonList := GetIMyWebService(true,'',nil).GetPersonList;
end;

procedure TForm2.btnCreateDatasetClick(Sender: TObject);
begin
  ReadArray(TValue.From(PersonList));
end;

procedure TForm2.FormClose(Sender: TObject; var Action: TCloseAction);
var
  I: Integer;
begin
  for I := Low(PersonList) to High(PersonList) do
    PersonList[I].Free;
  SetLength(PersonList, 0);
end;

procedure TForm2.FormCreate(Sender: TObject);
begin
 ReportMemoryLeaksOnShutdown := true;
end;

procedure TForm2.ReadArray(const AnArray: TValue);
var
  AContext: TRttiContext;
  ARttiType: TRttiType;
  AProperty: TRttiProperty;
  AProperties: TArray<TRttiProperty>;
  ARttiElementType: TRttiType;
  ATypeName: string;

  ADbField: TField;
  ATypeInfo: Pointer;

  I, J : Integer;
  AValue: TValue;
  AInstanceType: TRttiInstanceType;
  AnArrayElement: TValue;
  AObject : TObject;
  FieldValues : array of TVarRec;
  AHashTable: TDictionary<TTypeKind, Pointer>;
begin
  if not AnArray.IsArray then
    raise Exception.Create('Veri dizi deðil !');

  AContext := TRttiContext.Create;
  AHashTable := TDictionary<TTypeKind, Pointer>.Create;

  try
    AHashTable.Add(tkUString, TStringField.ClassInfo);
    AHashTable.Add(tkInteger, TIntegerField.ClassInfo);

    ARttiType := AContext.GetType(AnArray.TypeInfo);
    ARttiElementType := TRttiDynamicArrayType(ARttiType).ElementType;
    AProperties := ARttiElementType.GetDeclaredProperties;

    for AProperty in AProperties do
    begin
      if (not AHashTable.TryGetValue(AProperty.PropertyType.TypeKind, ATypeInfo)) then continue;
      ARttiType := AContext.GetType(ATypeInfo);
      AInstanceType := ARttiType.AsInstance;
      AValue := AInstanceType.GetMethod('Create').Invoke(AInstanceType.MetaclassType, [ClientDataSet1]);
      ADbField := TField(AValue.AsObject);
      ADbField.FieldName := AProperty.Name;
      ADbField.DataSet := ClientDataSet1;
    end;

    ClientDataSet1.CreateDataSet;
    ClientDataSet1.Open;

    for I := 0 to Pred(AnArray.GetArrayLength) do
    begin
      AnArrayElement := AnArray.GetArrayElement(I);
      if not AnArrayElement.IsObject then continue;
      AObject :=  AnArrayElement.AsObject;
      ARttiType := AContext.GetType(AObject.ClassInfo);
      AProperties := ARttiType.GetDeclaredProperties();
      J := 0;
      SetLength(FieldValues,Length(AProperties));
      for AProperty in AProperties do
      begin
        FieldValues[J] := AProperty.GetValue(AObject).AsVarRec;
        Inc(J);
      end;
      ClientDataSet1.AppendRecord(FieldValues);
      SetLength(FieldValues,0);
    end;
  finally
    AContext.Free;
    AHashTable.Free;
  end;

end;

end.
