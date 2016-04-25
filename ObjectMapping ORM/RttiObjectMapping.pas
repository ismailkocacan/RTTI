unit RttiObjectMapping;

interface

uses
  Data.DB,
  System.Rtti;

type

  TRttiObjectMapping = class
  public
    class procedure map(dataset: TDataSet; instance: TObject);
  end;

implementation

{ TRttiObjectMapping }
class procedure TRttiObjectMapping.map(dataset: TDataSet; instance: TObject);
var
  cntx: TRttiContext;
  objField: TRttiField;
  dbFieldName: string;

  I: Integer;
  value: TValue;
begin
  cntx := TRttiContext.Create;
  for I := 0 to dataset.FieldCount - 1 do
  begin
    dbFieldName := dataset.Fields[I].DisplayName;
    for objField in cntx.GetType(instance.ClassType).GetFields do
    begin
      if dbFieldName = objField.Name then
      begin
        value := TValue.From(dataset.Fields[I].value);
        objField.SetValue(instance, value);
        Break;
      end;
    end;
  end;
  dataset.Close;
  dataset.Free;
  cntx.Free;
end;

end.
