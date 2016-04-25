unit DataAccess;

interface

uses
  Forms,
  Data.DB,
  Data.Win.ADODB;

function createConnection: TADOConnection;
function createDataset(sql: string): TDataSet;

implementation

function createConnection: TADOConnection;
var
  connection: TADOConnection;
const
  CONNECTION_STRING='Provider=SQLOLEDB.1;Password=123;User ID=sa;Initial Catalog=DB;Data Source=.\SQLR2';
begin
  connection := TADOConnection.Create(Application);
  connection.ConnectionString :=CONNECTION_STRING;
  connection.Open();
  Result := connection;
end;

function createDataset(sql: string): TDataSet;
var
  query: TADOQuery;
begin
  query := TADOQuery.Create(Application);
  query.connection := createConnection;
  query.sql.Text := sql;
  query.Open;
  Result := query;
end;

end.
