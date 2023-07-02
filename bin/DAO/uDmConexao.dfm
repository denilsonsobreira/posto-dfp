object DmConexao: TDmConexao
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 238
  Width = 351
  object Conexao: TFDConnection
    Params.Strings = (
      'User_Name=sysdba'
      'Password=masterkey'
      'Database=D:\delphi\posto-dfp\db\POSTODFP.FDB'
      'DriverID=FB')
    LoginPrompt = False
    Left = 48
    Top = 56
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 48
    Top = 120
  end
end
