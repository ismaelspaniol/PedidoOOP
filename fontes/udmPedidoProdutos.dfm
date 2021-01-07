object dmPedidoProdutos: TdmPedidoProdutos
  OldCreateOrder = False
  Height = 150
  Width = 424
  object qryPedidoProdutos: TFDQuery
    CachedUpdates = True
    Connection = dmDb.connectionMySql
    SQL.Strings = (
      
        'select numero_pedido, quantidade, valor_unitario, valor_total, p' +
        'rodutos.codigo, produtos.descricao from pedidos_produtos'#10
      
        'join produtos on produtos.id_produto = pedidos_produtos.id_produ' +
        'to')
    Left = 88
    Top = 64
    object qryPedidoProdutosnumero_pedido: TIntegerField
      FieldName = 'numero_pedido'
      Origin = 'numero_pedido'
    end
    object qryPedidoProdutosquantidade: TBCDField
      AutoGenerateValue = arDefault
      FieldName = 'quantidade'
      Origin = 'quantidade'
      Precision = 15
      Size = 2
    end
    object qryPedidoProdutosvalor_unitario: TBCDField
      AutoGenerateValue = arDefault
      FieldName = 'valor_unitario'
      Origin = 'valor_unitario'
      Precision = 15
      Size = 2
    end
    object qryPedidoProdutosvalor_total: TBCDField
      AutoGenerateValue = arDefault
      FieldName = 'valor_total'
      Origin = 'valor_total'
      Precision = 15
      Size = 2
    end
    object qryPedidoProdutoscodigo: TIntegerField
      AutoGenerateValue = arDefault
      FieldName = 'codigo'
      Origin = 'codigo'
      ProviderFlags = []
      ReadOnly = True
    end
    object qryPedidoProdutosdescricao: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'descricao'
      Origin = 'descricao'
      ProviderFlags = []
      ReadOnly = True
      Size = 45
    end
  end
  object memPedidoProdutos: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 224
    Top = 64
    object memPedidoProdutoscod_produto: TIntegerField
      FieldName = 'cod_produto'
    end
    object memPedidoProdutosdescricao: TStringField
      FieldName = 'descricao'
    end
    object memPedidoProdutosquantidade: TCurrencyField
      FieldName = 'quantidade'
    end
    object memPedidoProdutosvalor_unitario: TCurrencyField
      FieldName = 'valor_unitario'
    end
    object memPedidoProdutosvalor_total: TCurrencyField
      FieldName = 'valor_total'
    end
    object memPedidoProdutosid_pedido_produto: TIntegerField
      FieldName = 'id_pedido_produto'
    end
    object memPedidoProdutosindice: TIntegerField
      FieldName = 'indice'
    end
  end
end
