program Atendimento;

uses
  Vcl.Forms,
  Frm_Login in 'Frm_Login.pas' {Login},
  Conexao_Bd in 'Conexao_Bd.pas' {DM_CONEXAO: TDataModule},
  Frm_Atendimento in 'Frm_Atendimento.pas' {Atendimento};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TLogin, Login);
  Application.CreateForm(TDM_CONEXAO, DM_CONEXAO);
//  Application.CreateForm(TAtendimento, Atendimento);
  Application.Run;
end.
