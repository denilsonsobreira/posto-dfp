object DmValores: TDmValores
  OldCreateOrder = False
  Height = 257
  Width = 249
  object QryValores: TFDQuery
    Active = True
    Connection = DmConexao.Conexao
    SQL.Strings = (
      'SELECT * FROM VALORES;')
    Left = 40
    Top = 64
    object QryValoresID: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'ID'
      Origin = 'ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object QryValoresVALOR_LITRO_GASOLINA: TBCDField
      FieldName = 'VALOR_LITRO_GASOLINA'
      Origin = 'VALOR_LITRO_GASOLINA'
      Required = True
      Precision = 18
      Size = 2
    end
    object QryValoresVALOR_LITRO_OLEO_DIESEL: TBCDField
      FieldName = 'VALOR_LITRO_OLEO_DIESEL'
      Origin = 'VALOR_LITRO_OLEO_DIESEL'
      Required = True
      Precision = 18
      Size = 2
    end
    object QryValoresVALOR_IMPOSTO: TBCDField
      FieldName = 'VALOR_IMPOSTO'
      Origin = 'VALOR_IMPOSTO'
      Required = True
      Precision = 18
      Size = 2
    end
  end
  object DsValores: TDataSource
    DataSet = QryValores
    Left = 40
    Top = 120
  end
end
