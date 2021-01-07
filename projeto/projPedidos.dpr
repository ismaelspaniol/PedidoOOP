program projPedidos;

uses
  Vcl.Forms,
  udmDb in '..\fontes\udmDb.pas' {dmDb: TDataModule},
  uProdutos in '..\fontes\uProdutos.pas',
  uClientes in '..\fontes\uClientes.pas',
  uDmPedido in '..\fontes\uDmPedido.pas' {dmPedidos: TDataModule},
  uViewPedidoProdutos in '..\fontes\uViewPedidoProdutos.pas' {frmPedidoProdutos},
  uPedidoProdutos in '..\fontes\uPedidoProdutos.pas',
  uPedido in '..\fontes\uPedido.pas',
  udmPedidoProdutos in '..\fontes\udmPedidoProdutos.pas' {dmPedidoProdutos: TDataModule},
  uControllerPedidoProdutos in '..\fontes\uControllerPedidoProdutos.pas',
  uModelPedidoProdutos in '..\fontes\uModelPedidoProdutos.pas',
  uModelProdutos in '..\fontes\uModelProdutos.pas',
  uControllerProdutos in '..\fontes\uControllerProdutos.pas',
  uControllerPedido in '..\fontes\uControllerPedido.pas',
  uModelPedido in '..\fontes\uModelPedido.pas';

{$R *.res}

begin
  Application.Initialize;
  ReportMemoryLeaksOnShutdown := true;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TdmDb, dmDb);
  Application.CreateForm(TdmPedidos, dmPedidos);
  Application.CreateForm(TdmPedidoProdutos, dmPedidoProdutos);
  Application.CreateForm(TfrmPedidoProdutos, frmPedidoProdutos);
  Application.Run;
end.
