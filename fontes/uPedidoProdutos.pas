unit uPedidoProdutos;

interface

uses
  uProdutos, uControllerProdutos;

type
  TPedidoProduto = class
  private
    Fvalor_unitario: currency;
    Fproduto: TProdutos;
    Fid_produto: integer;
    Fvalor_total: currency;
    Fnumero_pedido: integer;
    Fid: integer;
    Fquantidade: currency;
    controllerProdutos : TControllerProdutos;
    Findice: integer;

    procedure Setid(const Value: integer);
    procedure Setnumero_pedido(const Value: integer);
    procedure Setproduto(const Value: TProdutos);
    procedure Setquantidade(const Value: currency);
    procedure Setvalor_unitario(const Value: currency);
    procedure AtualizaValorTotal();
    procedure getProduto();
    procedure Setid_produto(const Value: integer);
    procedure Setindice(const Value: integer);
  public
    property id: integer read Fid write Setid;
    property numero_pedido: integer read Fnumero_pedido write Setnumero_pedido;
    property produto: TProdutos read Fproduto;
    property id_produto : integer read Fid_produto write Setid_produto;
    property quantidade: currency read Fquantidade write Setquantidade;
    property valor_unitario: currency read Fvalor_unitario write Setvalor_unitario;
    property valor_total: currency read Fvalor_total;
    property indice : integer read Findice write Setindice;

    constructor Create;
    destructor Destroy; override;

  end;

implementation


{ TPedidoProduto }

procedure TPedidoProduto.AtualizaValorTotal;
begin
  if ((Fquantidade > 0) and (Fvalor_unitario > 0)) then
  begin
    Fvalor_total := Fquantidade * Fvalor_unitario;
  end;
end;

constructor TPedidoProduto.Create;
begin
  controllerProdutos := TControllerProdutos.Create;
end;

destructor TPedidoProduto.Destroy;
begin
  controllerProdutos.free;
  if Assigned(Fproduto) then
    Fproduto.Free;
  inherited;
end;

procedure TPedidoProduto.getProduto;
begin
  Fproduto := controllerProdutos.getProduto(Fid_produto);
end;

procedure TPedidoProduto.Setid(const Value: integer);
begin
  Fid := Value;
end;

procedure TPedidoProduto.Setid_produto(const Value: integer);
begin
  Fid_produto := Value;
  if Fid_produto > 0 then
  begin
    getProduto();
  end;
end;

procedure TPedidoProduto.Setindice(const Value: integer);
begin
  Findice := Value;
end;

procedure TPedidoProduto.Setnumero_pedido(const Value: integer);
begin
  Fnumero_pedido := Value;
end;

procedure TPedidoProduto.Setproduto(const Value: TProdutos);
begin
  Fproduto := Value;
end;

procedure TPedidoProduto.Setquantidade(const Value: currency);
begin
  Fquantidade := Value;
  AtualizaValorTotal();
end;



procedure TPedidoProduto.Setvalor_unitario(const Value: currency);
begin
  Fvalor_unitario := Value;
  AtualizaValorTotal();
end;

end.
