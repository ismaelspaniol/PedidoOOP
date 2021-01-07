unit uControllerPedidoProdutos;

interface
uses
   uModelPedidoProdutos, uPedidoProdutos,System.Generics.Collections;

type
  TControllerPedidoProdutos = Class
  private

  public
    function codigoProdutoToIdProduto(codigo: Integer): Integer;
    function gravarPedidoProduto(pedidoProduto : TPedidoProduto) : Integer;
    function getProdutosPedido(numero_pedido : integer) : TObjectList<TPedidoProduto>;
    procedure deleteProdutoPedido(id : integer);
  End;

implementation

{ TControllerPedidoProdutos }

function TControllerPedidoProdutos.codigoProdutoToIdProduto(codigo: Integer): Integer;
var
  model: TModelPedidoProdutos;
begin
  try
    model := TModelPedidoProdutos.Create();

   result := model.codigoProdutoToIdProduto(codigo);

  finally
    model.free;
  end;

end;


procedure TControllerPedidoProdutos.deleteProdutoPedido(id: integer);
var
  modelPedidoProduto : TModelPedidoProdutos;
begin
  try
    modelPedidoProduto := TModelPedidoProdutos.Create;

    modelPedidoProduto.deleteProdutoPedido(id);
  finally
    modelPedidoProduto.free;
  end
end;

function TControllerPedidoProdutos.getProdutosPedido(numero_pedido: integer): TObjectList<TPedidoProduto>;
var
  modelPedidoProduto : TModelPedidoProdutos;
begin
  try
    modelPedidoProduto := TModelPedidoProdutos.Create;

    result := modelPedidoProduto.getProdutosPedido(numero_pedido);
  finally
    modelPedidoProduto.free;
  end;

end;

function TControllerPedidoProdutos.gravarPedidoProduto(pedidoProduto: TPedidoProduto): Integer;
var
  modelPedidoProduto : TModelPedidoProdutos;
begin
  try
    modelPedidoProduto := TModelPedidoProdutos.Create;

    modelPedidoProduto.gravarPedidoProduto(pedidoProduto);
  finally
    modelPedidoProduto.free;
  end;


end;

end.
