object DM_CONEXAO: TDM_CONEXAO
  OldCreateOrder = False
  Height = 242
  Width = 322
  object FDConnection1: TFDConnection
    Params.Strings = (
      'Database=192.168.25.200:d:\ettica\exec\dados\dados.fdb'
      'User_Name=sysdba'
      'Password=masterkey'
      'DriverID=FB')
    Connected = True
    LoginPrompt = False
    Left = 72
    Top = 112
  end
  object Qry_Usuarios: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'select * from usuarios')
    Left = 224
    Top = 136
    object Qry_UsuariosID: TIntegerField
      FieldName = 'ID'
      Origin = 'ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object Qry_UsuariosUSUARIO: TStringField
      FieldName = 'USUARIO'
      Origin = 'USUARIO'
      Required = True
      Size = 40
    end
    object Qry_UsuariosID_PERFIL: TIntegerField
      FieldName = 'ID_PERFIL'
      Origin = 'ID_PERFIL'
      Required = True
    end
    object Qry_UsuariosSENHA: TStringField
      FieldName = 'SENHA'
      Origin = 'SENHA'
    end
    object Qry_UsuariosATIVO: TStringField
      FieldName = 'ATIVO'
      Origin = 'ATIVO'
      Required = True
      FixedChar = True
      Size = 1
    end
    object Qry_UsuariosVENDEDOR: TIntegerField
      FieldName = 'VENDEDOR'
      Origin = 'VENDEDOR'
    end
    object Qry_UsuariosCONTAS_PERMITIDAS: TStringField
      FieldName = 'CONTAS_PERMITIDAS'
      Origin = 'CONTAS_PERMITIDAS'
      Size = 15
    end
    object Qry_UsuariosID_FORNECEDOR: TIntegerField
      FieldName = 'ID_FORNECEDOR'
      Origin = 'ID_FORNECEDOR'
    end
  end
end
