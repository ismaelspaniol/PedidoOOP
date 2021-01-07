unit uControllerPedido;

interface
uses
  uPedido, uModelPedido, uPedidoProdutos, ucontrollerPedidoProdutos, uDmDb;

  type
    TControllerPedido = class
     private
      modelPedido : TModelPedido;
     public
      function gravarPedido(pedido : TPedido) : integer;
      function getPedido(numero_pedido : integer):TPedido;
      procedure deletePedido(numero_pedido: string);
      constructor Create;
      destructor Destroy; override;
    end;

implementation

{ TControllerPedido }

constructor TControllerPedido.Create;
begin
  modelPedido := TModelPedido.Create();
end;

procedure TControllerPedido.deletePedido(numero_pedido: string);
begin
  modelPedido.deletePedido(numero_pedido);
end;

destructor TControllerPedido.Destroy;
begin
  modelPedido.free;
  inherited;
end;

function TControllerPedido.getPedido(numero_pedido: integer): TPedido;
begin
  result := modelPedido.getPedido(numero_pedido);
end;

function TControllerPedido.gravarPedido(pedido: TPedido): integer;
var
  pedidoProduto : TPedidoProduto;
  valorTotal : Currency;
  controllerPedidoProduto : TControllerPedidoProdutos;
begin

  try
    try
      if pedido.numero_pedido = 0 then
      begin
        pedido.numero_pedido := modelPedido.proximoNumeroPedido();


      end;
      valorTotal := 0;

      for pedidoProduto in pedido.getProdutos do
      begin
        pedidoProduto.numero_pedido := pedido.numero_pedido;
        valorTotal := valorTotal + pedidoProduto.valor_total;
      end;

      modelPedido.gravarPedido(pedido);



      controllerPedidoProduto := TControllerPedidoProdutos.Create;
      for pedidoProduto in pedido.getProdutos do
      begin
        controllerPedidoProduto.gravarPedidoProduto(pedidoProduto);
      end;



      dmDb.commit;
    except
      dmdb.rollback;


    end;



  finally
    controllerPedidoProduto.free;

  end;

end;

end.
