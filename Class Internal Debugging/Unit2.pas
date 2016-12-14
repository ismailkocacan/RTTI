unit Unit2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,Unit1;

type
  TForm2 = class(TForm)
    Memo1: TMemo;
    btnOku: TButton;
    btnYaz: TButton;
    procedure btnOkuClick(Sender: TObject);
    procedure btnYazClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;




var
  Form2: TForm2;
  A: TA;
  P: PByte;
  I: Integer;


implementation

{$R *.dfm}




procedure Yazdir(Value: string);
begin
  Form2.Memo1.Lines.Add(Value);
end;


procedure TForm2.btnOkuClick(Sender: TObject);
begin
  Yazdir('A.FieldA: '+IntToStr(A.FieldA));

  P := PByte(A);
  //if P = A.Adresi then Yazdir('Adresim Aynı');
  for I := 1 to A.InstanceSize do
  begin
    Yazdir('$' + IntToHex(Integer(P), 1) + ' ' + IntToStr(P^));
    Inc(P);
  end;
end;

procedure TForm2.btnYazClick(Sender: TObject);
begin
  Memo1.Clear;
  P := PByte(A);
  for I := 1 to A.InstanceSize do
  begin
    if I = 5 then
    begin
      //ShowMessage('Eski Değer :' + IntToStr(P^));
      P^ := 50;
    end;
    Inc(P);
  end;
end;

procedure TForm2.FormCreate(Sender: TObject);
begin
  A := TA.Create;
  //A.FFieldA := 50;  [dcc32 Error] Unit2.pas(79): E2361 Cannot access private symbol TA.FFieldA
  Text := 'A Değişkeni Kapladığı Alan: '+IntToStr(A.InstanceSize);
end;




end.
