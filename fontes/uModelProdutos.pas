unit uModelProdutos;

interface
uses
  uProdutos, uDmDb,FireDAC.Comp.Client,System.SysUtils;

  type
    TModelProdutos = class
      private
       Fqry: TFDQuery;
      public
        constructor Create;
        destructor Destroy; override;
        function getProduto(id_produto : integer) : TProdutos;
    end;

implementation

{ TModelProdutos }

constructor TModelProdutos.Create;
begin
  Fqry := TFDQuery.Create(nil);
  Fqry.Connection := dmdb.connectionMySql;
end;

destructor TModelProdutos.Destroy;
begin
  Fqry.Free;
  inherited;
end;

function TModelProdutos.getProduto(id_produto : integer): TProdutos;
var
  produto : TProdutos;
begin
  try
    produto := TProdutos.Create;

    Fqry.Close;
    Fqry.sql.text := ' SELECT id_produto, codigo, descricao, preco_venda FROM produtos where id_produto = '+intToStr(id_produto);
    Fqry.Open;
    if Fqry.recordCount > 0 then
    begin
      produto.id_produto := Fqry.fieldByName('id_produto').asInteger;
      produto.codigo := Fqry.fieldByName('codigo').asInteger;
      produto.descricao := Fqry.fieldByName('descricao').asString;
      produto.preco_venda := Fqry.fieldByName('preco_venda').asFloat;
    end;

    result := produto;

  finally


  end;

end;

end.
