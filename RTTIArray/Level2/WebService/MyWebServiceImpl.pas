{ Invokable implementation File for TMyWebService which implements IMyWebService }

unit MyWebServiceImpl;

interface

uses Soap.InvokeRegistry, System.Types, Soap.XSBuiltIns, MyWebServiceIntf,
  System.SysUtils;

type

  { TMyWebService }
  TMyWebService = class(TInvokableClass, IMyWebService)
  public
    function GetPersonList(): TPersonArray stdcall;
  end;

implementation

function TMyWebService.GetPersonList(): TPersonArray stdcall;
const
  COUNT = 30;
var
  I: Integer;
begin
  SetLength(Result, COUNT);
  for I := 0 to COUNT do
  begin
    Result[I] := TPerson.Create;
    Result[I].FirstName := Format('First Name %d', [I]);
    Result[I].LastName := Format('Last Name %d', [I]);
    Result[I].Age := Random(100);
  end;
end;

initialization

{ Invokable classes must be registered }
InvRegistry.RegisterInvokableClass(TMyWebService);

end.
