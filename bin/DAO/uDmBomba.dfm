object DmBomba: TDmBomba
  OldCreateOrder = False
  Height = 175
  Width = 223
  object QryBomba: TFDQuery
    Active = True
    Connection = DmConexao.Conexao
    SQL.Strings = (
      'SELECT * FROM BOMBA;')
    Left = 32
    Top = 24
    object QryBombaID: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'ID'
      Origin = 'ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object QryBombaNOME: TStringField
      FieldName = 'NOME'
      Origin = 'NOME'
      Required = True
      Size = 40
    end
    object QryBombaTANQUE_ID: TIntegerField
      FieldName = 'TANQUE_ID'
      Origin = 'TANQUE_ID'
      Required = True
    end
  end
  object DsBomba: TDataSource
    DataSet = QryBomba
    Left = 32
    Top = 104
  end
end
