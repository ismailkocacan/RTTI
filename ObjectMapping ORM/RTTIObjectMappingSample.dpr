program RTTIObjectMappingSample;

uses
  Vcl.Forms,
  Main in 'Main.pas' {FrmMain},
  RttiObjectMapping in 'RttiObjectMapping.pas',
  DataAccess in 'DataAccess.pas',
  Model in 'Model.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmMain, FrmMain);
  Application.Run;
end.
