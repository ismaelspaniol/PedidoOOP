unit udmPedidoProdutos;

interface

uses
  System.SysUtils, System.Classes, udmDb, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TdmPedidoProdutos = class(TDataModule)
    qryPedidoProdutos: TFDQuery;
    qryPedidoProdutosnumero_pedido: TIntegerField;
    qryPedidoProdutosquantidade: TBCDField;
    qryPedidoProdutosvalor_unitario: TBCDField;
    qryPedidoProdutosvalor_total: TBCDField;
    qryPedidoProdutoscodigo: TIntegerField;
    qryPedidoProdutosdescricao: TStringField;
    memPedidoProdutos: TFDMemTable;
    memPedidoProdutoscod_produto: TIntegerField;
    memPedidoProdutosdescricao: TStringField;
    memPedidoProdutosquantidade: TCurrencyField;
    memPedidoProdutosvalor_unitario: TCurrencyField;
    memPedidoProdutosvalor_total: TCurrencyField;
    memPedidoProdutosid_pedido_produto: TIntegerField;
    memPedidoProdutosindice: TIntegerField;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dmPedidoProdutos: TdmPedidoProdutos;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

end.
