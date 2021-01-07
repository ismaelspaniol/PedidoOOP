object dmPedidos: TdmPedidos
  OldCreateOrder = False
  Height = 273
  Width = 567
  object qryPedidos: TFDQuery
    Active = True
    Connection = dmDb.connectionMySql
    SQL.Strings = (
      
        'select p.data_emissao, p.numero_pedido, c.nome from pedidos p'#10'jo' +
        'in clientes c on p.codigo_cliente = c.codigo')
    Left = 48
    Top = 32
    object qryPedidosdata_emissao: TDateTimeField
      FieldName = 'data_emissao'
      Origin = 'data_emissao'
      Required = True
    end
    object qryPedidosnumero_pedido: TIntegerField
      FieldName = 'numero_pedido'
      Origin = 'numero_pedido'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object qryPedidosnome: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'nome'
      Origin = 'nome'
      ProviderFlags = []
      ReadOnly = True
      Size = 70
    end
  end
end
