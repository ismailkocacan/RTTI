program Client;

uses
  Vcl.Forms,
  UnitClient in 'UnitClient.pas' {Form2},
  IMyWebService1 in 'IMyWebService1.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.
