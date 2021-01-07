object frmPedidoProdutos: TfrmPedidoProdutos
  Left = 0
  Top = 0
  Caption = 'frmPedidoProdutos'
  ClientHeight = 640
  ClientWidth = 691
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 504
    Width = 691
    Height = 136
    Align = alBottom
    TabOrder = 0
    object lblTotalPedido: TLabel
      Left = 643
      Top = 6
      Width = 11
      Height = 24
      Alignment = taRightJustify
      Caption = '0'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -20
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object btnGravar: TButton
      Left = 561
      Top = 51
      Width = 93
      Height = 42
      Caption = 'Gravar Pedido'
      TabOrder = 0
      OnClick = btnGravarClick
    end
    object cmpCodigoProduto: TEdit
      Left = 16
      Top = 68
      Width = 121
      Height = 21
      TabOrder = 1
    end
    object cmpQuantidade: TcxCurrencyEdit
      Left = 143
      Top = 68
      Properties.DisplayFormat = '0.00;-0.00'
      TabOrder = 2
      Width = 121
    end
    object cmpValorUnitario: TcxCurrencyEdit
      Left = 270
      Top = 68
      Properties.DisplayFormat = '0.00;-0.00'
      TabOrder = 3
      Width = 121
    end
    object cxLabel1: TcxLabel
      Left = 16
      Top = 45
      Caption = 'C'#243'digo Produto'
    end
    object cxLabel2: TcxLabel
      Left = 143
      Top = 45
      Caption = 'Quantidade'
    end
    object cxLabel3: TcxLabel
      Left = 270
      Top = 45
      Caption = 'Valor Unitario'
    end
    object btnAddProduto: TButton
      Left = 16
      Top = 16
      Width = 129
      Height = 25
      Caption = 'Adicionar Produto'
      TabOrder = 7
      OnClick = btnAddProdutoClick
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 73
    Width = 691
    Height = 431
    Align = alClient
    Caption = 'Panel2'
    TabOrder = 1
    object gridPedidosProdutos: TDBGrid
      Left = 1
      Top = 1
      Width = 689
      Height = 429
      Align = alClient
      DataSource = dsPedidoProdutos
      ReadOnly = True
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
      OnKeyDown = gridPedidosProdutosKeyDown
      Columns = <
        item
          Expanded = False
          FieldName = 'cod_produto'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'descricao'
          Width = 64
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'quantidade'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'valor_unitario'
          Width = 64
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'valor_total'
          Visible = True
        end>
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 0
    Width = 691
    Height = 73
    Align = alTop
    TabOrder = 2
    object Label1: TLabel
      Left = 8
      Top = 8
      Width = 72
      Height = 13
      Caption = 'N'#250'mero Pedido'
    end
    object Label2: TLabel
      Left = 144
      Top = 8
      Width = 64
      Height = 13
      Caption = 'Data Emiss'#227'o'
    end
    object Label3: TLabel
      Left = 296
      Top = 8
      Width = 55
      Height = 13
      Caption = 'C'#243'd Cliente'
    end
    object cmpNumeroPedido: TEdit
      Left = 8
      Top = 27
      Width = 121
      Height = 21
      Enabled = False
      NumbersOnly = True
      TabOrder = 0
    end
    object cmpDataEmissao: TDateTimePicker
      Left = 144
      Top = 27
      Width = 121
      Height = 21
      Date = 44201.600909618060000000
      Time = 44201.600909618060000000
      TabOrder = 1
    end
    object cmpCodCliente: TEdit
      Left = 296
      Top = 27
      Width = 121
      Height = 21
      NumbersOnly = True
      TabOrder = 2
      OnChange = cmpCodClienteChange
    end
    object btnBuscarPedido: TButton
      Left = 450
      Top = 25
      Width = 105
      Height = 25
      Caption = 'Buscar Pedido'
      TabOrder = 3
      OnClick = btnBuscarPedidoClick
    end
    object btnRemoverPedido: TButton
      Left = 561
      Top = 25
      Width = 104
      Height = 25
      Caption = 'Remover Pedido'
      TabOrder = 4
      OnClick = btnRemoverPedidoClick
    end
  end
  object dsPedidoProdutos: TDataSource
    DataSet = dmPedidoProdutos.memPedidoProdutos
    Left = 136
    Top = 184
  end
end
