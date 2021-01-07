unit uModelPedidoProdutos;

interface

uses
  FireDAC.Comp.Client, udmDb, System.SysUtils, uPedidoProdutos,System.Generics.Collections;



type
  TModelPedidoProdutos = class
  private
    Fqry: TFDQuery;
  public
    function codigoProdutoToIdProduto(codigo: Integer): Integer;
    function gravarPedidoProduto(pedidoProduto : TPedidoProduto) : Integer;
    function getProdutosPedido(numero_pedido : integer) : TObjectList<TPedidoProduto>;
    procedure deleteProdutoPedido(id : integer);
    constructor Create;
    destructor Destroy; override;

  end;

implementation
  { TModelPedidoProdutos }

function TModelPedidoProdutos.codigoProdutoToIdProduto(codigo: Integer): Integer;
begin
  Fqry.Close;
  Fqry.SQL.text := ' select id_produto from produtos ' + ' where codigo =  '+intToStr(codigo);
  Fqry.Open;

  if Fqry.RecordCount > 0 then
  begin
    result := Fqry.FieldByName('id_produto').AsInteger;
  end
  else
    result := 0;
end;

constructor TModelPedidoProdutos.Create;
begin
  Fqry := TFDQuery.Create(nil);
  Fqry.Connection := dmdb.connectionMySql;
end;

procedure TModelPedidoProdutos.deleteProdutoPedido(id : integer);
begin
  Fqry.Close;
  Fqry.sql.text :=  ' delete from pedidos_produtos  '+
                    ' where id = '+intToStr(id);
  Fqry.ExecSQL;
  dmdb.commit;
end;

destructor TModelPedidoProdutos.Destroy;
begin
  Fqry.Free;
  inherited;
end;

function TModelPedidoProdutos.getProdutosPedido(numero_pedido: integer): TObjectList<TPedidoProduto>;
var
  pedidoProduto : TPedidoProduto;
  produtos :  TObjectList<TPedidoProduto>;
begin
  produtos := TObjectList<TPedidoProduto>.Create();

  Fqry.Close;
  Fqry.sql.text :=  ' select id, numero_pedido, id_produto, quantidade, valor_unitario, valor_total from pedidos_produtos '+
                    ' where numero_pedido = '+intToStr(numero_pedido);

  Fqry.Open;
  while not Fqry.eof do
  begin
    pedidoProduto := TPedidoProduto.Create;

    pedidoProduto.id := Fqry.FieldByName('id').AsInteger;
    pedidoProduto.id_produto := Fqry.FieldByName('id_produto').AsInteger;
    pedidoProduto.quantidade := Fqry.FieldByName('quantidade').AsCurrency;
    pedidoProduto.valor_unitario := Fqry.FieldByName('valor_unitario').AsCurrency;
    pedidoProduto.numero_pedido := Fqry.FieldByName('numero_pedido').AsInteger;

    produtos.Add(pedidoProduto);

    Fqry.Next;
  end;

  result := produtos;

end;

function TModelPedidoProdutos.gravarPedidoProduto(pedidoProduto: TPedidoProduto): Integer;
var
  id : String;
begin
  try
    if pedidoProduto.id > 0 then
    begin
      Fqry.Close;
      Fqry.sql.text := '  UPDATE pedidos_produtos set ' +
                       ' numero_pedido = '+intToStr(pedidoProduto.numero_pedido)+','+
                       ' id_produto = '+ intToStr(pedidoProduto.id_produto)+',' +
                       ' quantidade = '+StringReplace(floatToStr(pedidoProduto.quantidade), ',', '.',[rfReplaceAll, rfIgnoreCase])+',' +
                       ' valor_unitario = '+ StringReplace(floatToStr(pedidoProduto.valor_unitario), ',', '.',[rfReplaceAll, rfIgnoreCase])+',' +
                       ' valor_total = '+ StringReplace(floatToStr(pedidoProduto.valor_total), ',', '.',[rfReplaceAll, rfIgnoreCase])+
                       ' where id = '+intToStr(pedidoProduto.id);
      Fqry.ExecSql;

    end
    else
    begin
      Fqry.Close;
      Fqry.sql.text :=  '  INSERT INTO pedidos_produtos   '+
                       '             (id, numero_pedido, id_produto, quantidade, valor_unitario, valor_total)  '+
                       '          VALUES     '+
                       '             (0'+ ',' +intToStr(pedidoProduto.numero_pedido)+','+
                       intToStr(pedidoProduto.id_produto)+',' +
                       StringReplace(floatToStr(pedidoProduto.quantidade), ',', '.',[rfReplaceAll, rfIgnoreCase])+',' +
                       StringReplace(floatToStr(pedidoProduto.valor_unitario), ',', '.',[rfReplaceAll, rfIgnoreCase])+',' +
                       StringReplace(floatToStr(pedidoProduto.valor_total), ',', '.',[rfReplaceAll, rfIgnoreCase])+')';


      Fqry.ExecSql;

      Fqry.Close;
      Fqry.sql.text := 'SELECT LAST_INSERT_ID() as lastid';
      Fqry.Open;

      pedidoProduto.id := Fqry.FieldByName('lastid').AsInteger;

    end;

  except
    on e : exception do
    begin
      raise Exception.Create('Erro ao gravar pedido');
    end;

  end;
end;

end.
