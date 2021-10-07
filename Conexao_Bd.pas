unit CONEXAO_BD;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.FB,
  FireDAC.Phys.FBDef, FireDAC.VCLUI.Wait, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  TDM_CONEXAO = class(TDataModule)
    FDConnection1: TFDConnection;
    Qry_Usuarios: TFDQuery;
    Qry_UsuariosID: TIntegerField;
    Qry_UsuariosUSUARIO: TStringField;
    Qry_UsuariosID_PERFIL: TIntegerField;
    Qry_UsuariosSENHA: TStringField;
    Qry_UsuariosATIVO: TStringField;
    Qry_UsuariosVENDEDOR: TIntegerField;
    Qry_UsuariosCONTAS_PERMITIDAS: TStringField;
    Qry_UsuariosID_FORNECEDOR: TIntegerField;

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DM_CONEXAO: TDM_CONEXAO;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}



end.
