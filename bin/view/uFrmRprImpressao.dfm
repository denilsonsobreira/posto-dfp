object FrmRprImpressao: TFrmRprImpressao
  Left = 0
  Top = 0
  Caption = 'FrmRprImpressao'
  ClientHeight = 683
  ClientWidth = 1081
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object RLReport: TRLReport
    Left = 112
    Top = 0
    Width = 794
    Height = 1123
    DataSource = DsAbastecimento
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = []
    object RlBandTitle: TRLBand
      Left = 38
      Top = 38
      Width = 718
      Height = 91
      BandType = btHeader
      object RLDrawTitle: TRLDraw
        Left = 3
        Top = 3
        Width = 712
        Height = 85
      end
      object RlLblPosto: TRLLabel
        Left = 14
        Top = 24
        Width = 556
        Height = 37
        Caption = 'Relat'#243'rio Abastecimento Posto DFP'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -32
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RlLblTitleData: TRLLabel
        Left = 584
        Top = 16
        Width = 37
        Height = 16
        Caption = 'Data:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLLabel1: TRLLabel
        Left = 584
        Top = 48
        Width = 53
        Height = 16
        Caption = 'P'#225'gina:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLSystemInfo1: TRLSystemInfo
        Left = 627
        Top = 16
        Width = 39
        Height = 16
        Text = ''
      end
      object RLSystemInfo2: TRLSystemInfo
        Left = 643
        Top = 48
        Width = 87
        Height = 16
        Info = itPageNumber
        Text = ''
      end
    end
    object RLBandHeader: TRLBand
      Left = 38
      Top = 129
      Width = 718
      Height = 48
      AutoSize = True
      BandType = btColumnHeader
      Borders.Sides = sdCustom
      Borders.DrawLeft = False
      Borders.DrawTop = False
      Borders.DrawRight = False
      Borders.DrawBottom = True
      object RlLblValor: TRLLabel
        Left = 676
        Top = 31
        Width = 42
        Height = 16
        Align = faRightBottom
        Caption = 'Valor:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RlLblTanque: TRLLabel
        Left = 0
        Top = 31
        Width = 56
        Height = 16
        Align = faLeftBottom
        Caption = 'Tanque:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RlLblBomba: TRLLabel
        Left = 168
        Top = 31
        Width = 53
        Height = 16
        Caption = 'Bomba:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RlLblData: TRLLabel
        Left = 291
        Top = 31
        Width = 135
        Height = 16
        Caption = 'Data Abastecimento:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RlLblInfoData: TRLLabel
        Left = 14
        Top = 3
        Width = 39
        Height = 16
        Caption = 'Datas'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
    end
    object RLBandDetail: TRLBand
      Left = 38
      Top = 177
      Width = 718
      Height = 32
      Borders.Sides = sdCustom
      Borders.DrawLeft = False
      Borders.DrawTop = False
      Borders.DrawRight = False
      Borders.DrawBottom = True
      BeforePrint = RLBandDetailBeforePrint
      object RLDBNomeTanque: TRLDBText
        Left = 0
        Top = 0
        Width = 96
        Height = 31
        Align = faLeft
        DataField = 'NOMETANQUE'
        DataSource = DsAbastecimento
        Text = ''
      end
      object RLDBNomeBomba: TRLDBText
        Left = 168
        Top = 5
        Width = 91
        Height = 16
        DataField = 'NOMEBOMBA'
        DataSource = DsAbastecimento
        Text = ''
      end
      object RLDBDataAbastecimento: TRLDBText
        Left = 307
        Top = 6
        Width = 148
        Height = 16
        DataField = 'DATAABASTECIMENTO'
        DataSource = DsAbastecimento
        Text = ''
      end
      object RLDBValor_Total: TRLDBText
        Left = 623
        Top = 0
        Width = 95
        Height = 31
        Align = faRight
        DataField = 'VALOR_TOTAL'
        DataSource = DsAbastecimento
        Text = ''
      end
    end
    object RLBandFooter: TRLBand
      Left = 38
      Top = 209
      Width = 718
      Height = 40
      BandType = btColumnFooter
      BeforePrint = RLBandFooterBeforePrint
      object RLDraw1: TRLDraw
        Left = 0
        Top = 0
        Width = 718
        Height = 40
        Align = faClient
      end
      object RlLblValor_Total: TRLLabel
        Left = 698
        Top = 6
        Width = 20
        Height = 16
        Align = faRightOnly
        Caption = 'R$'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RlLblTotal: TRLLabel
        Left = 0
        Top = 6
        Width = 40
        Height = 16
        Align = faLeftOnly
        Caption = 'Total:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
    end
  end
  object QryAbastecimento: TFDQuery
    Active = True
    Connection = DmConexao.Conexao
    SQL.Strings = (
      
        'select A.data as DataAbastecimento, B.NOME as NomeBomba, T.NOME ' +
        'as NomeTanque, A.VALOR_TOTAL'
      'from abastecimento A'
      'INNER JOIN Bomba B ON A.bomba_id = B.Id'
      'INNER JOIN TANQUE T ON B.TANQUE_ID = T.ID'
      'ORDER BY A.DATA')
    Left = 32
    Top = 48
    object QryAbastecimentoDATAABASTECIMENTO: TDateField
      FieldName = 'DATAABASTECIMENTO'
      Origin = '"DATA"'
      Required = True
    end
    object QryAbastecimentoNOMEBOMBA: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'NOMEBOMBA'
      Origin = 'NOME'
      ProviderFlags = []
      ReadOnly = True
      Size = 40
    end
    object QryAbastecimentoNOMETANQUE: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'NOMETANQUE'
      Origin = 'NOME'
      ProviderFlags = []
      ReadOnly = True
      Size = 40
    end
    object QryAbastecimentoVALOR_TOTAL: TBCDField
      FieldName = 'VALOR_TOTAL'
      Origin = 'VALOR_TOTAL'
      Required = True
      currency = True
      Precision = 18
      Size = 2
    end
  end
  object DsAbastecimento: TDataSource
    DataSet = QryAbastecimento
    Left = 80
    Top = 48
  end
end
