unit uDmPedido;

interface

uses
  System.SysUtils, System.Classes, udmDb, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TdmPedidos = class(TDataModule)
    qryPedidos: TFDQuery;
    qryPedidosdata_emissao: TDateTimeField;
    qryPedidosnumero_pedido: TIntegerField;
    qryPedidosnome: TStringField;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dmPedidos: TdmPedidos;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

end.
