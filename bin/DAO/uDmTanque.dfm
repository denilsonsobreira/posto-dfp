object DmTanque: TDmTanque
  OldCreateOrder = False
  Height = 179
  Width = 266
  object QryTanque: TFDQuery
    Active = True
    Connection = DmConexao.Conexao
    SQL.Strings = (
      'SELECT * FROM TANQUE;')
    Left = 16
    Top = 8
    object QryTanqueID: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'ID'
      Origin = 'ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object QryTanqueNOME: TStringField
      FieldName = 'NOME'
      Origin = 'NOME'
      Required = True
      Size = 40
    end
    object QryTanqueTIPO_COMBUSTIVEL: TIntegerField
      FieldName = 'TIPO_COMBUSTIVEL'
      Origin = 'TIPO_COMBUSTIVEL'
      Required = True
      OnGetText = QryTanqueTIPO_COMBUSTIVELGetText
    end
  end
  object DsTanque: TDataSource
    DataSet = QryTanque
    Left = 16
    Top = 64
  end
end
