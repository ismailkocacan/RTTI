{ Invokable interface IMyWebService }

unit MyWebServiceIntf;

interface

uses Soap.InvokeRegistry, System.Types, Soap.XSBuiltIns;

type

  TPerson = class(TRemotable)
  private
    FFirstName: string;
    FLastName: string;
    FAge: Byte;
  published
    property FirstName: string read FFirstName write FFirstName;
    property LastName: string read FLastName write FLastName;
    property Age: Byte read FAge write FAge;
  end;

  TPersonArray = array of TPerson;

  { Invokable interfaces must derive from IInvokable }
  IMyWebService = interface(IInvokable)
  ['{B7EC6B96-A70A-4F88-B226-5297A3BDCC80}']

    { Methods of Invokable interface must not use the default }
    { calling convention; stdcall is recommended }
    function GetPersonList():TPersonArray stdcall;
  end;

implementation

initialization
  { Invokable interfaces must be registered }
  InvRegistry.RegisterInterface(TypeInfo(IMyWebService));

end.
