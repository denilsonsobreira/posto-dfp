object DmAbastecimento: TDmAbastecimento
  OldCreateOrder = False
  Height = 216
  Width = 188
  object QryAbastecimento: TFDQuery
    Active = True
    Connection = DmConexao.Conexao
    SQL.Strings = (
      'SELECT * FROM ABASTECIMENTO;')
    Left = 32
    Top = 40
    object QryAbastecimentoID: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'ID'
      Origin = 'ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object QryAbastecimentoLITROS: TBCDField
      FieldName = 'LITROS'
      Origin = 'LITROS'
      Required = True
      Precision = 18
      Size = 2
    end
    object QryAbastecimentoVALOR_TOTAL: TBCDField
      FieldName = 'VALOR_TOTAL'
      Origin = 'VALOR_TOTAL'
      Required = True
      Precision = 18
      Size = 2
    end
    object QryAbastecimentoIMPOSTO: TBCDField
      FieldName = 'IMPOSTO'
      Origin = 'IMPOSTO'
      Required = True
      Precision = 18
      Size = 2
    end
    object QryAbastecimentoDATA: TDateField
      FieldName = 'DATA'
      Origin = '"DATA"'
      Required = True
    end
    object QryAbastecimentoBOMBA_ID: TIntegerField
      FieldName = 'BOMBA_ID'
      Origin = 'BOMBA_ID'
      Required = True
    end
  end
  object DsAbastecimento: TDataSource
    DataSet = QryAbastecimento
    Left = 88
    Top = 40
  end
  object QryBombasTipos: TFDQuery
    Active = True
    Connection = DmConexao.Conexao
    SQL.Strings = (
      'SELECT B.ID, B.NOME, T.TIPO_COMBUSTIVEL FROM BOMBA B'
      'LEFT JOIN tanque T ON B.TANQUE_ID = T.ID;')
    Left = 24
    Top = 120
    object QryBombasTiposID: TIntegerField
      FieldName = 'ID'
      Origin = 'ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object QryBombasTiposNOME: TStringField
      FieldName = 'NOME'
      Origin = 'NOME'
      Required = True
      Size = 40
    end
    object QryBombasTiposTIPO_COMBUSTIVEL: TIntegerField
      AutoGenerateValue = arDefault
      FieldName = 'TIPO_COMBUSTIVEL'
      Origin = 'TIPO_COMBUSTIVEL'
      ProviderFlags = []
      ReadOnly = True
      OnGetText = QryBombasTiposTIPO_COMBUSTIVELGetText
    end
  end
  object DsBombasTipos: TDataSource
    DataSet = QryBombasTipos
    Left = 88
    Top = 120
  end
end
