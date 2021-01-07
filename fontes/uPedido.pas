unit uPedido;

interface

uses
  uClientes, System.Generics.Collections,System.SysUtils, uPedidoProdutos;

type
  TPedido = class
  private
    Fvalor_total: currency;
    Fdata_emissao: TDateTime;
    Fcliente: TCliente;
    FcodCliente: Integer;
    Fnumero_pedido: integer;
    Fprodutos : TObjectList<TPedidoProduto>;

    procedure Setcliente(const Value: TCliente);
    procedure Setdata_emissao(const Value: TDateTime);
    procedure Setnumero_pedido(const Value: integer);
    procedure Setvalor_total(const Value: currency);
    procedure SetcodCliente(const Value: Integer);
    function buscaProduto(indice: integer): TPedidoProduto;
    procedure atualizaValorTotal();
  public
    constructor Create;
    destructor Destroy; override;
    procedure addProduto(pedido_produto : TPedidoProduto);

    procedure addListProdutos(produtos : TObjectList<TPedidoProduto>);

    function getProdutos():TObjectList<TPedidoProduto>;
    function updateProduto(indice: integer; quantidade, valor: Currency ):TPedidoProduto;
    procedure deleteProduto(indice: integer);
    function totalProdutos: integer;
    property numero_pedido: integer read Fnumero_pedido write Setnumero_pedido;
    property data_emissao: TDateTime read Fdata_emissao write Setdata_emissao;
    property cliente: TCliente read Fcliente;
    property codCliente : Integer read FcodCliente write SetcodCliente;
    property valor_total: currency read Fvalor_total;


  end;

implementation
uses
  uControllerPedidoProdutos, uControllerPedido;

{ TPedido }

procedure TPedido.addListProdutos(produtos: TObjectList<TPedidoProduto>);
begin
  Fprodutos.free;
  Fprodutos := produtos;
  atualizaValorTotal();
end;

procedure TPedido.addProduto(pedido_produto: TPedidoProduto);
begin
  Fprodutos.Add(pedido_produto);
  Fvalor_total := Fvalor_total + pedido_produto.valor_total;
end;

procedure TPedido.atualizaValorTotal;
var
  PedidoProduto : TPedidoProduto;
begin
  Fvalor_total := 0;
  for pedidoProduto in Fprodutos do
  begin
    Fvalor_total := Fvalor_total + pedidoProduto.valor_total;
  end;


end;

function TPedido.buscaProduto(indice: integer): TPedidoProduto;
var
  pedidoProduto : TPedidoProduto;
begin
  for pedidoProduto in Fprodutos do
  begin
    if pedidoProduto.indice = indice then
    begin
      result := pedidoProduto;
    end;
  end;
end;

constructor TPedido.Create;
begin
  Fprodutos := TObjectList<TPedidoProduto>.Create;
end;

procedure TPedido.deleteProduto(indice: integer);
var
  pedidoProduto : TPedidoProduto;
  i : integer;
  controllerPedidoProdutos : TControllerPedidoProdutos;
  ControllerPedido : TControllerPedido;
begin

  try
    controllerPedidoProdutos := TControllerPedidoProdutos.Create;
    ControllerPedido := TControllerPedido.Create;
    for i := 0 to pred(Fprodutos.Count) do
    begin
      if Fprodutos[i].indice = indice then
      begin
        Fvalor_total := Fvalor_total - Fprodutos[i].valor_total;

        if Fprodutos[i].id > 0 then
        begin
          controllerPedidoProdutos.deleteProdutoPedido(Fprodutos[i].id);
          ControllerPedido.gravarPedido(self);
        end;
        Fprodutos.Delete(i);
        exit
      end;
    end;
    finally
    controllerPedidoProdutos.free;
    ControllerPedido.free;
  end;

end;

destructor TPedido.Destroy;
begin
  if Assigned(Fprodutos) then
    Fprodutos.free;
  inherited;
end;

function TPedido.getProdutos(): TObjectList<TPedidoProduto>;
begin
  result :=Fprodutos;
end;

procedure TPedido.Setcliente(const Value: TCliente);
begin
  Fcliente := Value;
end;

procedure TPedido.SetcodCliente(const Value: Integer);
begin
  FcodCliente := Value;
end;

procedure TPedido.Setdata_emissao(const Value: TDateTime);
begin
  Fdata_emissao := Value;
end;

procedure TPedido.Setnumero_pedido(const Value: integer);
begin
  Fnumero_pedido := Value;
end;

procedure TPedido.Setvalor_total(const Value: currency);
begin
  Fvalor_total := Value;
end;

function TPedido.totalProdutos: integer;
begin
  result := Fprodutos.Count;
end;

function TPedido.updateProduto(indice: integer; quantidade, valor: Currency): TPedidoProduto;
var
  Pedidoproduto : TPedidoProduto;
begin
  Pedidoproduto := buscaProduto(indice);
  Fvalor_total := Fvalor_total -  (Pedidoproduto.quantidade * Pedidoproduto.valor_unitario);
  Pedidoproduto.quantidade := quantidade;
  Pedidoproduto.valor_unitario := valor;
  Fvalor_total := Fvalor_total + Pedidoproduto.quantidade * Pedidoproduto.valor_unitario;

  result := Pedidoproduto;
end;

end.
