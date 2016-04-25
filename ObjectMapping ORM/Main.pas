unit Main;

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
  Vcl.StdCtrls;

type



  TFrmMain = class(TForm)
    Memo1: TMemo;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmMain: TFrmMain;

implementation

uses Model;
{$R *.dfm}


procedure TFrmMain.FormCreate(Sender: TObject);
var
 lKisi:TKisi;
begin
  lKisi := TKisi.createFromId(1);
  Memo1.Lines.Add(lKisi.getAdi);
  Memo1.Lines.Add(lKisi.getSoyadi);
  Memo1.Lines.Add(IntToStr(lKisi.getYasi));
  Memo1.Lines.Add(DateToStr(lKisi.getDogumTarihi));
  FreeAndNil(lKisi);
end;

end.
