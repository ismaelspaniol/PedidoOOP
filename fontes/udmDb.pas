unit udmDb;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MySQL, FireDAC.Phys.MySQLDef, FireDAC.VCLUI.Wait, Data.DB, FireDAC.Comp.Client,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.DataSet;

type
  TdmDb = class(TDataModule)
    connectionMySql: TFDConnection;
    FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    procedure commit();
    procedure rollback();
  end;

var
  dmDb: TdmDb;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TdmDb.commit;
begin
  if connectionMySql.InTransaction then
    connectionMySql.Commit;
end;

procedure TdmDb.DataModuleCreate(Sender: TObject);
begin
  connectionMySql.Connected := True;
end;

procedure TdmDb.rollback;
begin
  if connectionMySql.InTransaction then
    connectionMySql.Rollback;
end;

end.
