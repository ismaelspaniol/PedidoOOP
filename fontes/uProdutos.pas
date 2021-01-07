unit uProdutos;

interface

type
  TProdutos = class

    private
    Fpreco_venda: Currency;
    Fid_produto: Integer;
    Fdescricao: String;
    Fcodigo: Integer;
    procedure Setcodigo(const Value: Integer);
    procedure Setdescricao(const Value: String);
    procedure Setid_produto(const Value: Integer);
    procedure Setpreco_venda(const Value: Currency);


    public
      property id_produto : Integer read Fid_produto write Setid_produto;
      property codigo : Integer read Fcodigo write Setcodigo;
      property descricao : String read Fdescricao write Setdescricao;
      property preco_venda : Currency read Fpreco_venda write Setpreco_venda;
  end;

implementation

{ TProdutos }

procedure TProdutos.Setcodigo(const Value: Integer);
begin
  Fcodigo := Value;
end;

procedure TProdutos.Setdescricao(const Value: String);
begin
  Fdescricao := Value;
end;

procedure TProdutos.Setid_produto(const Value: Integer);
begin
  Fid_produto := Value;
end;

procedure TProdutos.Setpreco_venda(const Value: Currency);
begin
  Fpreco_venda := Value;
end;

end.
