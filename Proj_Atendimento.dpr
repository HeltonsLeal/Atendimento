program Proj_Atendimento;

uses
  Vcl.Forms,
  SysUtils,
  Frm_Login in 'Frm_Login.pas' {Login},
  Conexao_Bd in 'Conexao_Bd.pas' {DM_CONEXAO: TDataModule},
  Frm_Atendimento in 'Frm_Atendimento.pas' {Atendimento};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TAtendimento, Atendimento);
  Application.CreateForm(TDM_CONEXAO, DM_CONEXAO);
  Application.CreateForm(TLogin, Login);
  Application.Run;



end.
