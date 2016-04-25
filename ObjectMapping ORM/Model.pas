unit Model;

interface

uses
 System.SysUtils,
 DataAccess,
 RttiObjectMapping;

type

  TKisi = class
  const
    QUERY='select * from Kisi where id=%s';
  private
    id: Integer;
    adi: string;
    soyadi: string;
    yasi: Byte;
    dogumTarihi: TDateTime;
  public
    function getId():Integer;
    function getAdi():string;
    function getSoyadi():string;
    function getYasi():Byte;
    function getDogumTarihi:TDateTime;
    constructor createFromId(id: Integer);
    destructor Destroy;
  end;

implementation


{ TKisi }
constructor TKisi.createFromId(id: Integer);
begin
  TRttiObjectMapping.map(createDataset(Format(QUERY, [IntToStr(id)])), Self);
end;

destructor TKisi.Destroy;
begin
  inherited;
end;

function TKisi.getAdi: string;
begin
  Result:=Self.adi;
end;

function TKisi.getDogumTarihi: TDateTime;
begin
  Result:=Self.dogumTarihi;
end;

function TKisi.getId: Integer;
begin
  Result:=Self.id;
end;

function TKisi.getSoyadi: string;
begin
  Result:=Self.soyadi;
end;

function TKisi.getYasi: Byte;
begin
  Result:=Self.yasi;
end;

end.
