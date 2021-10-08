program Atendimento;

uses
  Vcl.Forms,
  Login in 'Login.pas' {Form1},
  Conexao_Bd in 'Conexao_Bd.pas' {DM_CONEXAO: TDataModule},
  Atendimento_bd in 'Atendimento_bd.pas' {Atendimento};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TDM_CONEXAO, DM_CONEXAO);
  Application.CreateForm(TAtendimento, Atendimento);
  Application.Run;
end.
