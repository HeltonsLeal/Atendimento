unit Frm_Login;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Data.DB;

type
  TLogin = class(TForm)
    Edit_Cod: TEdit;
    Edit_Nome: TEdit;
    Edit_Senha: TEdit;
    Button_Login: TButton;
    Ds_Sql_Usuarios: TDataSource;
    procedure Edit_CodKeyPress(Sender: TObject; var Key: Char);
    procedure Edit_NomeKeyPress(Sender: TObject; var Key: Char);
    procedure Edit_SenhaKeyPress(Sender: TObject; var Key: Char);



  private
    { Private declarations }
  public
    { Public declarations }
    Cod,
    Nome,
    Senha
    : String
  end;

var
  Login: TLogin;

implementation

{$R *.dfm}

uses Conexao_Bd, Frm_Atendimento;






procedure TLogin.Edit_CodKeyPress(Sender: TObject; var Key: Char);
 begin
  if key = #13 then
  begin
    SelectNext(Sender as tWinControl, True, True);
    Key := #0;
    Cod := Edit_Cod.Text;
    if Edit_Cod.Text = '' then
    begin
      Edit_Cod.Text := 'C?digo'
    end;
    if (Edit_cod.Text <>'')
    And (Edit_cod.Text <> 'C?digo') then
    begin
     Try
      With DM_CONEXAO.Qry_Usuarios do
        begin
        Close;
        SQL.Clear;
        SQL.Add('SELECT * FROM USUARIOS WHERE VENDEDOR =');
        SQL.Add(Cod);
        Open();
        Edit_Nome.Text := FieldByName('USUARIO').Value;
        Nome := FieldByName('USUARIO').Value;
        Senha := FieldByName('SENHA').Value;
        Edit_Senha.SetFocus;
        Edit_Senha.Text := '';
        Edit_Senha.PasswordChar :='*';
        end;
     Except

      ShowMessage('USU?RIO N?O CADASTRADO');

     End;
    end;
  end;


 end;

procedure TLogin.Edit_NomeKeyPress(Sender: TObject; var Key: Char);
 begin
  if key = #13 then
  begin
    SelectNext(Sender as tWinControl, True, True);
    Key := #0;
    if Edit_Nome.Text = '' then
    begin
      Edit_Nome.Text := 'NOME'
    end
    Else if Edit_Nome.Text <>'NOME' then
      begin
       Nome := Edit_Nome.Text;
       Try
        With DM_CONEXAO.Qry_Usuarios do
          begin
          Close;
          SQL.Clear;
          SQL.Add('SELECT * FROM USUARIOS WHERE USUARIO =');
          SQL.Add(''''+Nome+'''');
          Open();
          Edit_Cod.Text := IntToStr(FieldByName('VENDEDOR').Value);
          Senha := FieldByName('SENHA').Value;
          Edit_Senha.SetFocus;
          Edit_Senha.Text := '';
          Edit_Senha.PasswordChar :='*';
          end;
       Except

        ShowMessage('USU?RIO N?O CADASTRADO');

       End;

      end;
  end;
 end;

procedure TLogin.Edit_SenhaKeyPress(Sender: TObject; var Key: Char);
 begin
  if key = #13 then
  begin
    SelectNext(Sender as tWinControl, True, True);
    Key := #0;
    if (Edit_Senha.Text = '')
    Or (Edit_Senha.Text = 'Senha')
    Or (Edit_Cod.Text = 'C?digo')
    Or (Edit_Cod.Text = 'C?digo')
    Or (Edit_Nome.Text = 'NOME')
    Or (Edit_Nome.Text = 'NOME')
    then
    begin
      Edit_Senha.Text := 'Senha';
      Edit_Cod.SetFocus;
    end
    Else  If (Senha = Edit_Senha.Text)
      then
      Begin

        Atendimento.Meu_Status := 'CONECTADO';
        ModalResult := 1;

      End
      Else
        Begin
          ShowMessage('SENHA INVALIDA');
          Edit_Senha.SetFocus;
        End;
  end;
 end;





end.


