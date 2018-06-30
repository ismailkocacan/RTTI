program Project2;

{$APPTYPE CONSOLE}
{$R *.res}

uses
  System.SysUtils,
  System.Classes;

type


  TData = class
  private
    FI: Integer;
    FD: double;
    // FS: string;
  published
    property I: Integer read FI write FI;
    property D: double read FD write FD;
    // property S: string read FS write FS;
  end;

procedure Serialize();
var
  Data: TData;
  ObjPointer: Pointer;
  Stream: TBytesStream;
begin
  Data := TData.Create;
  Stream := TBytesStream.Create;
  try
    Data.I := 21;
    Data.D := 22.3;
    // Data.S := 'MyData';
    ObjPointer := @Data;

    Stream.WriteData(Pointer(ObjPointer^), Data.InstanceSize);
    // Stream.Position := 0;
    Stream.SaveToFile(Data.ClassName + '.bin');
  finally
    Data.Free;
    Stream.Free;
  end;
end;

procedure DeSerialize();
var
  Data: TData;
  ObjPointer: Pointer;
  Stream: TBytesStream;
begin
  Data := TData.Create;
  Stream := TBytesStream.Create;
  try
    ObjPointer := @Data;
    Stream.LoadFromFile(Data.ClassName + '.bin');
    //Stream.Position := 0;
    Stream.ReadData(Pointer(ObjPointer^), Stream.Size);
  finally
    Data.Free;
    Stream.Free;
  end;
end;

begin
  ReportMemoryLeaksOnShutdown := true;
  Serialize();
  DeSerialize();

end.
