object dmDb: TdmDb
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 325
  Width = 529
  object connectionMySql: TFDConnection
    Params.Strings = (
      'User_Name=root'
      'Password=masterkey'
      'Server=localhost'
      'DriverID=MySQL'
      'Database=teste')
    TxOptions.AutoStop = False
    Connected = True
    LoginPrompt = False
    Left = 176
    Top = 80
  end
  object FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink
    VendorLib = 'C:\Users\ismae\Desktop\teste\projeto\exe\libmysql.dll'
    Left = 384
    Top = 32
  end
end
