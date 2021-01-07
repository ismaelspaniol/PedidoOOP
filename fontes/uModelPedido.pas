unit uModelPedido;

interface

uses
  uPedido, FireDAC.Comp.Client, udmDb, System.SysUtils, uControllerPedidoProdutos, uPedidoProdutos, System.Generics.Collections;

type
  TModelPedido = class
  private
    Fqry: TFDQuery;

  public
    function gravarPedido(pedido: TPedido): Integer;
    function proximoNumeroPedido : Integer;
    function getPedido(numero_pedido : integer):TPedido;
    procedure deletePedido(numero_pedido : string);
    constructor Create;
    destructor Destroy; override;
  end;

implementation

{ TModelPedido }

constructor TModelPedido.Create;
begin
  Fqry := TFDQuery.Create(nil);
  Fqry.Connection := dmdb.connectionMySql;
end;

procedure TModelPedido.deletePedido(numero_pedido: string);
begin
  Fqry.Close;
  Fqry.sql.text :=  ' delete from pedidos  '+
                    ' where numero_pedido = '+numero_pedido;
  Fqry.ExecSQL;

end;

destructor TModelPedido.Destroy;
begin
  Fqry.Free;
  inherited;
end;

function TModelPedido.getPedido(numero_pedido : integer): TPedido;
var
  pedido : TPedido;
  controllerPedidoProdutos : TControllerPedidoProdutos;
  pedidoProduto : TPedidoProduto;
  produtos : TObjectList<TPedidoProduto>;
begin
  Fqry.Close;
  Fqry.sql.text := ' SELECT numero_pedido, data_emissao, codigo_cliente, valor_total FROM pedidos '+
                    ' where numero_pedido =  '+intToStr(numero_pedido);
  Fqry.Open;
  pedido := Tpedido.Create;

  pedido.numero_pedido := Fqry.FieldByName('numero_pedido').AsInteger;
  pedido.data_emissao := Fqry.FieldByName('data_emissao').AsDateTime;
  pedido.codCliente := Fqry.FieldByName('codigo_cliente').AsInteger;


  try
    controllerPedidoProdutos := TControllerPedidoProdutos.Create;
    pedido.addListProdutos(controllerPedidoProdutos.getProdutosPedido(numero_pedido));
  finally
    controllerPedidoProdutos.Free ;

  end;

  result := pedido;

end;

function TModelPedido.gravarPedido(pedido: TPedido): Integer;
begin
  try
    Fqry.Close;
    Fqry.sql.text :='  INSERT INTO pedidos '+
                    ' (numero_pedido,data_emissao, codigo_cliente, valor_total) '+
                    ' VALUES('+intToStr(pedido.numero_pedido)+','+
                    quotedStr(FormatDateTime('yyyy.mm.dd',pedido.data_emissao ))+','+
                    intToStr(pedido.codCliente)+','+
                   StringReplace(floatToStr(pedido.valor_total), ',', '.',[rfReplaceAll, rfIgnoreCase])+') ' +
                   ' ON DUPLICATE KEY UPDATE ' +
                   ' data_emissao = '+quotedStr(FormatDateTime('yyyy.mm.dd',pedido.data_emissao ))+','+
                   ' codigo_cliente = '+ intToStr(pedido.codCliente)+','+
                   ' valor_total = '+StringReplace(floatToStr(pedido.valor_total), ',', '.',[rfReplaceAll, rfIgnoreCase]);

    Fqry.ExecSQL;
  except
    on e : exception do
    begin

      raise Exception.Create('Erro ao gravar pedido');
    end;

  end;

end;

function TModelPedido.proximoNumeroPedido: Integer;
begin
  fqry.close;
  fqry.sql.text := 'select coalesce(max(numero_pedido), 0)  + 1  as numero_pedido from pedidos';
  fqry.Open;

  result := fqry.FieldByName('numero_pedido').AsInteger;
end;

end.
