object dtmPrincipal: TdtmPrincipal
  OldCreateOrder = False
  Height = 410
  Width = 731
  object ConexaoDB: TZConnection
    ControlsCodePage = cCP_UTF16
    AutoEncodeStrings = True
    Catalog = ''
    Properties.Strings = (
      'controls_cp=CP_UTF16'
      'AutoEncodeStrings=True')
    Connected = True
    HostName = '.\SERVERBUSS'
    Port = 0
    Database = 'VENDAS'
    User = 'sa'
    Password = '59912020'
    Protocol = 'mssql'
    LibraryLocation = 'C:\ProjetoDelphi\ntwdblib.dll'
    Left = 40
    Top = 40
  end
end
