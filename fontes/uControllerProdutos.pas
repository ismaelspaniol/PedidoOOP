unit uControllerProdutos;

interface
  uses
    uModelProdutos, uProdutos;


  type
    TControllerProdutos = class
      private
      public
        function getProduto(id_produto : integer):TProdutos;
    end;

implementation

{ TModelProdutos }

function TControllerProdutos.getProduto(id_produto: integer): TProdutos;
var
  model : TModelProdutos;
begin
  try
    model := TmodelProdutos.Create;
    result :=  model.getProduto(id_produto);


  finally
    model.free;
  end;

end;

end.
