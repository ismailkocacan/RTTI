// ************************************************************************ //
// The types declared in this file were generated from data read from the
// WSDL File described below:
// WSDL     : http://localhost:8080/wsdl/IMyWebService
//  >Import : http://localhost:8080/wsdl/IMyWebService>0
// Version  : 1.0
// (16.01.2018 02:10:06 - - $Rev: 86412 $)
// ************************************************************************ //

unit IMyWebService1;

interface

uses Soap.InvokeRegistry, Soap.SOAPHTTPClient, System.Types, Soap.XSBuiltIns;

type

  // ************************************************************************ //
  // The following types, referred to in the WSDL document are not being represented
  // in this file. They are either aliases[@] of other types represented or were referred
  // to but never[!] declared in the document. The types from the latter category
  // typically map to predefined/known XML or Embarcadero types; however, they could also 
  // indicate incorrect WSDL documents that failed to declare or import a schema type.
  // ************************************************************************ //
  // !:string          - "http://www.w3.org/2001/XMLSchema"[Gbl]
  // !:unsignedByte    - "http://www.w3.org/2001/XMLSchema"[Gbl]

  TPerson              = class;                 { "urn:MyWebServiceIntf"[GblCplx] }

  TPersonArray = array of TPerson;              { "urn:MyWebServiceIntf"[GblCplx] }


  // ************************************************************************ //
  // XML       : TPerson, global, <complexType>
  // Namespace : urn:MyWebServiceIntf
  // ************************************************************************ //
  TPerson = class(TRemotable)
  private
    FFirstName: string;
    FLastName: string;
    FAge: Byte;
  published
    property FirstName: string  read FFirstName write FFirstName;
    property LastName:  string  read FLastName write FLastName;
    property Age:       Byte    read FAge write FAge;
  end;


  // ************************************************************************ //
  // Namespace : urn:MyWebServiceIntf-IMyWebService
  // soapAction: urn:MyWebServiceIntf-IMyWebService#GetPersonList
  // transport : http://schemas.xmlsoap.org/soap/http
  // style     : rpc
  // use       : encoded
  // binding   : IMyWebServicebinding
  // service   : IMyWebServiceservice
  // port      : IMyWebServicePort
  // URL       : http://localhost:8080/soap/IMyWebService
  // ************************************************************************ //
  IMyWebService = interface(IInvokable)
  ['{5D96A2E5-B484-D05E-BB11-10B93D0E4336}']
    function  GetPersonList: TPersonArray; stdcall;
  end;

function GetIMyWebService(UseWSDL: Boolean=System.False; Addr: string=''; HTTPRIO: THTTPRIO = nil): IMyWebService;


implementation
  uses System.SysUtils;

function GetIMyWebService(UseWSDL: Boolean; Addr: string; HTTPRIO: THTTPRIO): IMyWebService;
const
  defWSDL = 'http://localhost:8080/wsdl/IMyWebService';
  defURL  = 'http://localhost:8080/soap/IMyWebService';
  defSvc  = 'IMyWebServiceservice';
  defPrt  = 'IMyWebServicePort';
var
  RIO: THTTPRIO;
begin
  Result := nil;
  if (Addr = '') then
  begin
    if UseWSDL then
      Addr := defWSDL
    else
      Addr := defURL;
  end;
  if HTTPRIO = nil then
    RIO := THTTPRIO.Create(nil)
  else
    RIO := HTTPRIO;
  try
    Result := (RIO as IMyWebService);
    if UseWSDL then
    begin
      RIO.WSDLLocation := Addr;
      RIO.Service := defSvc;
      RIO.Port := defPrt;
    end else
      RIO.URL := Addr;
  finally
    if (Result = nil) and (HTTPRIO = nil) then
      RIO.Free;
  end;
end;


initialization
  { IMyWebService }
  InvRegistry.RegisterInterface(TypeInfo(IMyWebService), 'urn:MyWebServiceIntf-IMyWebService', '');
  InvRegistry.RegisterDefaultSOAPAction(TypeInfo(IMyWebService), 'urn:MyWebServiceIntf-IMyWebService#GetPersonList');
  RemClassRegistry.RegisterXSInfo(TypeInfo(TPersonArray), 'urn:MyWebServiceIntf', 'TPersonArray');
  RemClassRegistry.RegisterXSClass(TPerson, 'urn:MyWebServiceIntf', 'TPerson');

end.