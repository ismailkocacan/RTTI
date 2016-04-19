{
 http://docwiki.embarcadero.com/Libraries/Seattle/en/System.Rtti.TRawVirtualClass
}
program TestRawVirtualClass;

{$APPTYPE CONSOLE}
{$R *.res}

uses
  System.SysUtils, TypInfo, System.Rtti;

type

  IStorage = Interface(IInterface)
    ['{ECB92B25-3289-486E-88E2-A2602AE4A61B}']
    procedure Save;
  end;

  TStorageXml = class(TInterfacedObject, IStorage)
  public
    procedure Save;
  end;

  TStorageSql = class(TInterfacedObject, IStorage)
  public
    procedure Save;
  end;

procedure TStorageXml.Save;
begin
  Writeln('Saved Data As Xml');
end;

procedure TStorageSql.Save;
begin
  Writeln('Saved Data As SQL');
end;

//Creating TStorageXml and TStorageSQL instances with "Create" contructor.
procedure StandartWay;
var
  storage: IStorage;
begin
  storage := TStorageXml.Create;
  storage.Save;
  storage := TStorageSql.Create;
  storage.Save;
end;

// Creating TStorageXml and TStorageSQL instances dynamically(without using constructor)
procedure DynamicWay;
var
  i: IStorage;
  raw: TRawVirtualClass;
  vTable: TRawVirtualClass.TVTable;
  guids: TArray<TGUID>;
begin
  SetLength(guids, 1);
  guids[0] := GetTypeData(TypeInfo(IStorage))^.Guid;
  raw := TRawVirtualClass.Create(guids, vTable);
  raw := TRawVirtualClass.GetInstanceFromInterface(@i);
  TStorageXml(raw).Save;
  TStorageSql(raw).Save;
end;

begin
  try
    StandartWay;
    DynamicWay;
    ReadLn;
  except on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;

end.
