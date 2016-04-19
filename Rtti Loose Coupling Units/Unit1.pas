unit Unit1;

interface

uses
    Windows
  , Messages
  , SysUtils
  , Variants
  , Classes
  , Graphics
  , Controls
  , Forms
  , Dialogs
  , StdCtrls
  , Rtti
  ;

type
  TForm1 = class(TForm)
    btnShowForm2: TButton;
    btnShowForm3: TButton;

    procedure btnShowForm2Click(Sender: TObject);
    procedure btnShowForm3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}


function  rttiFormActivator(typeQualifiedName : string; isModal:Boolean=false) : TValue;
var
 context      : TRttiContext;
 rttTyp       : TRttiType;
 instanceType : TRttiInstanceType;
 instance     : TValue;
begin

 try
   context   := TRttiContext.Create();
   rttTyp    := context.FindType(typeQualifiedName);

   instanceType := rttTyp.AsInstance;
   instance     := instanceType.GetMethod('Create').Invoke(instanceType.MetaclassType,[nil]) ;

   Result := instance;

   case isModal of
      true  :   instanceType.GetMethod('ShowModal').Invoke(instance,[]);
      false :   instanceType.GetMethod('Show').Invoke(instance,[]);
   end;

 except on E: Exception do
   raise Exception.Create(typeQualifiedName+ ' Tipi register edilmemiþ !');
 end;

end;

procedure TForm1.btnShowForm2Click(Sender: TObject);
begin
  rttiFormActivator('Unit2.TForm2',true);
end;

procedure TForm1.btnShowForm3Click(Sender: TObject);
begin
  rttiFormActivator('Unit3.TForm3');
end;

end.
