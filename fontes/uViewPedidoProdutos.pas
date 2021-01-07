unit uViewPedidoProdutos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids, Vcl.ComCtrls, Vcl.StdCtrls, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, dxSkinsCore, dxSkins, dxSkinRoxo, dxSkinVerde, dxSkinsDefaultPainters, cxLabel, cxTextEdit, cxCurrencyEdit,
  udmPedidoProdutos, uPedido, uControllerPedidoProdutos, uPedidoProdutos, uControllerProdutos, uProdutos,
   System.Generics.Collections, Vcl.ExtCtrls, udmDb;

type
  TfrmPedidoProdutos = class(TForm)
    dsPedidoProdutos: TDataSource;
    Panel1: TPanel;
    btnGravar: TButton;
    cmpCodigoProduto: TEdit;
    cmpQuantidade: TcxCurrencyEdit;
    cmpValorUnitario: TcxCurrencyEdit;
    cxLabel1: TcxLabel;
    cxLabel2: TcxLabel;
    cxLabel3: TcxLabel;
    btnAddProduto: TButton;
    lblTotalPedido: TLabel;
    Panel2: TPanel;
    gridPedidosProdutos: TDBGrid;
    Panel3: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    cmpNumeroPedido: TEdit;
    cmpDataEmissao: TDateTimePicker;
    cmpCodCliente: TEdit;
    Label3: TLabel;
    btnBuscarPedido: TButton;
    btnRemoverPedido: TButton;
    procedure FormCreate(Sender: TObject);
    procedure btnAddProdutoClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnBuscarPedidoClick(Sender: TObject);
    procedure gridPedidosProdutosKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cmpCodClienteChange(Sender: TObject);
    procedure btnRemoverPedidoClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);

  private
    indice : integer;
    pedido : TPedido;
    controllerPedidoProdutos : TControllerPedidoProdutos;
    controllerProdutos : TControllerProdutos;
    procedure limpaCamposProduto();
    procedure addProdutoGrid(pedidoProduto : TPedidoProduto);
    procedure updateProdutoGrid(pedidoProduto : TPedidoProduto);
    function buscaProduto(indice : integer ):TPedidoProduto;
    function validarAdicionarProduto(): Boolean;
  public
    { Public declarations }
  end;

var
  frmPedidoProdutos: TfrmPedidoProdutos;

implementation
uses
  uControllerPedido;


{$R *.dfm}

procedure TfrmPedidoProdutos.addProdutoGrid(pedidoProduto: TPedidoProduto);
var
  produto : TProdutos;
begin

  dmPedidoProdutos.memPedidoProdutos.Active := true;
  dmPedidoProdutos.memPedidoProdutos.Append;
  dmPedidoProdutos.memPedidoProdutosquantidade.AsCurrency := pedidoProduto.quantidade;
  dmPedidoProdutos.memPedidoProdutosvalor_unitario.AsCurrency := pedidoProduto.valor_unitario;
  dmPedidoProdutos.memPedidoProdutosvalor_total.AsCurrency := pedidoProduto.valor_total;
  dmPedidoProdutos.memPedidoProdutoscod_produto.AsInteger := pedidoProduto.produto.codigo;
  dmPedidoProdutos.memPedidoProdutosdescricao.AsString := pedidoProduto.produto.descricao;
  dmPedidoProdutos.memPedidoProdutosindice.AsInteger :=  pedidoProduto.indice;
  dmPedidoProdutos.memPedidoProdutos.Post;
end;


procedure TfrmPedidoProdutos.updateProdutoGrid(pedidoProduto: TPedidoProduto);
begin

  dmPedidoProdutos.memPedidoProdutos.Active := true;
  dmPedidoProdutos.memPedidoProdutos.Edit;
  dmPedidoProdutos.memPedidoProdutosquantidade.AsCurrency := pedidoProduto.quantidade;
  dmPedidoProdutos.memPedidoProdutosvalor_unitario.AsCurrency := pedidoProduto.valor_unitario;
  dmPedidoProdutos.memPedidoProdutosvalor_total.AsCurrency := pedidoProduto.valor_total;
  dmPedidoProdutos.memPedidoProdutos.Post;
end;

function TfrmPedidoProdutos.validarAdicionarProduto: Boolean;
begin
  if ((cmpCodigoProduto.Text = '') or (cmpQuantidade.Text = '') or (cmpValorUnitario.text = '')) then
    result := false
  else
    result := true;

end;

procedure TfrmPedidoProdutos.btnAddProdutoClick(Sender: TObject);
var
  Pedidoproduto : TPedidoProduto;
begin
  try
    if validarAdicionarProduto then
    begin
      if cmpCodigoProduto.Enabled = false then
      begin
        Pedidoproduto := pedido.updateProduto(dmPedidoProdutos.memPedidoProdutosindice.AsInteger,cmpQuantidade.Value, cmpValorUnitario.value);
        updateProdutoGrid(Pedidoproduto);
        limpaCamposProduto();
        cmpCodigoProduto.Enabled := true;
      end
      else
      begin
        inc(indice);
        Pedidoproduto := TPedidoProduto.Create;
        Pedidoproduto.id_produto := controllerPedidoProdutos.codigoProdutoToIdProduto(strToInt(cmpCodigoProduto.Text));
        Pedidoproduto.quantidade := cmpQuantidade.Value;
        Pedidoproduto.indice := indice;
        Pedidoproduto.valor_unitario :=cmpValorUnitario.Value;



        pedido.addProduto(Pedidoproduto);
        addProdutoGrid(Pedidoproduto);

        limpaCamposProduto();
      end;

      lblTotalPedido.Caption := currToStr( pedido.valor_total);



    end
    else
      showMessage('Favor informar todos os campos para adicionar o produto');


  except
    on e : Exception do
    begin
      showMessage(E.message);
    end;

  end;

end;

procedure TfrmPedidoProdutos.btnBuscarPedidoClick(Sender: TObject);
var
  controllerPedido : TControllerPedido;
  pedidoProduto : TPedidoProduto;
  numero_pedido : String;
begin
  numero_pedido := InputBox('Pergunta', 'Informe o número do Pedido', '0');

  try
    indice :=0;
    controllerPedido := TControllerPedido.Create;
    pedido.free;
    pedido := controllerPedido.getPedido(strToInt(numero_pedido));



    cmpNumeroPedido.text := intToStr(pedido.numero_Pedido);
    cmpDataEmissao.Date := pedido.data_emissao;
    cmpCodCliente.text := intToStr(pedido.codCliente);

    dmPedidoProdutos.memPedidoProdutos.Active := false;

    lblTotalPedido.caption := floatToStr(pedido.valor_total);
    for pedidoProduto in pedido.getProdutos do
    begin
      inc(indice);
      pedidoProduto.indice := indice;
      addProdutoGrid(pedidoProduto);
    end;

  finally
    controllerPedido.Free
  end;

end;

procedure TfrmPedidoProdutos.btnGravarClick(Sender: TObject);
var
  controllerPedido : TControllerPedido;

begin
  try
    try
      controllerPedido := TControllerPedido.Create;
      if not (cmpCodCliente.Text = '') then
      begin

        pedido.data_emissao := cmpDataEmissao.DateTime;
        pedido.codCliente := strtoInt(cmpCodCliente.Text);


        controllerPedido.gravarPedido(pedido);
        cmpNumeroPedido.Text := intToStr(pedido.numero_pedido);
        showMessage('Pedido salvo com sucesso');
      end
      else
        showMessage('Favor informa o código do cliente');



    finally
      controllerPedido.Free
    end;

  except
    showMessage('Erro ao gravar pedido');

  end;

end;

procedure TfrmPedidoProdutos.btnRemoverPedidoClick(Sender: TObject);
var
  numero_pedido : string;
  controllerPedido : TControllerPedido;
begin
  numero_pedido := InputBox('Pergunta', 'Informe o número do Pedido a ser removido', '0');
  if MessageDlg('Confirma exclusão ?', mtConfirmation, [mbYes, mbNo],0) = mrYes then
  begin
    try
      try
        controllerPedido := TControllerPedido.Create;
        controllerPedido.deletePedido(numero_pedido);
        dmdb.commit;
      finally
        controllerPedido.Free;

      end;

    except
      showMessage('Erro ao remover pedido');
      dmdb.rollback;

    end;
  end;

end;

function TfrmPedidoProdutos.buscaProduto(indice: integer): TPedidoProduto;
var
  pedidoProduto : TPedidoProduto;
begin
  for pedidoProduto in pedido.getProdutos do
  begin
    if pedidoProduto.indice = indice then
    begin
      result := pedidoProduto;
    end;
  end;


end;

procedure TfrmPedidoProdutos.cmpCodClienteChange(Sender: TObject);
begin
  if cmpCodCliente.Text = '' then
  begin
    btnBuscarPedido.Visible := true;
    btnRemoverPedido.Visible := true;
  end
  else
  begin
    btnBuscarPedido.Visible := false;
    btnRemoverPedido.Visible := false;
  end;
end;

procedure TfrmPedidoProdutos.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  pedido.Free;
  controllerPedidoProdutos.free;
  controllerProdutos.free;

end;

procedure TfrmPedidoProdutos.FormCreate(Sender: TObject);
begin
  indice := 0;
  dmPedidoProdutos.memPedidoProdutos.Active := false;

  pedido := TPedido.Create;
  controllerPedidoProdutos := TControllerPedidoProdutos.Create();
  controllerProdutos := TControllerProdutos.Create();

  cmpDataEmissao.DateTime := now;
end;

procedure TfrmPedidoProdutos.gridPedidosProdutosKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
 if key = VK_RETURN then //enter
  begin
    cmpCodigoProduto.Text := dmPedidoProdutos.memPedidoProdutoscod_produto.AsString;
    cmpCodigoProduto.Enabled := false;
    cmpValorUnitario.Value := dmPedidoProdutos.memPedidoProdutosvalor_unitario.value;
    cmpQuantidade.value := dmPedidoProdutos.memPedidoProdutosquantidade.value;
  end
  else
  if key = VK_DELETE then //delete
  begin
    if MessageDlg('Confirma exclusão ?', mtConfirmation, [mbYes, mbNo],0) = mrYes then
    begin
      try
        pedido.deleteProduto(dmPedidoProdutos.memPedidoProdutosindice.AsInteger);
        dmPedidoProdutos.memPedidoProdutos.Delete;
        lblTotalPedido.caption := currToStr(pedido.valor_total);




        showMessage('Removido com sucesso');
      except
        showMessage('Erro ao remover produto');

      end;

    end;
  end;

end;

procedure TfrmPedidoProdutos.limpaCamposProduto;
begin
  cmpCodigoProduto.Clear;
  cmpQuantidade.Clear;
  cmpValorUnitario.Clear;
end;



end.
