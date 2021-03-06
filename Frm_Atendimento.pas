unit Frm_Atendimento;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, IniFiles, Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.StdCtrls, Registry,
  System.Notification, Data.DB  ;

type
  TAtendimento = class(TForm)
    StatusBar1: TStatusBar;
    Timer1: TTimer;
    Btn_On_Off: TButton;
    Btn_Status: TButton;
    Label_Pc_1: TLabel;
    Label_Pc_2: TLabel;
    Label_Pc_3: TLabel;
    Label_Pc_4: TLabel;
    Label_Pc_5: TLabel;
    Label_Pc_6: TLabel;
    Label_Pc_7: TLabel;
    Label_Pc_1_Status: TLabel;
    Label_Pc_2_Status: TLabel;
    Label_Pc_3_Status: TLabel;
    Label_Pc_4_Status: TLabel;
    Label_Pc_5_Status: TLabel;
    Label_Pc_6_Status: TLabel;
    Label_Pc_7_Status: TLabel;
    Label_Pc_1_Quando: TLabel;
    Label_Pc_2_Quando: TLabel;
    Label_Pc_3_Quando: TLabel;
    Label_Pc_4_Quando: TLabel;
    Label_Pc_5_Quando: TLabel;
    Label_Pc_6_Quando: TLabel;
    Label_Pc_7_Quando: TLabel;
    NotificationCenter1: TNotificationCenter;
    DataSource1: TDataSource;

//  procedure GravaIni;
    procedure Timer1Timer(Sender: TObject);
    procedure Btn_On_OffClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Btn_StatusClick(Sender: TObject);
    procedure NotificationCenter1ReceiveLocalNotification(Sender: TObject;
      ANotification: TNotification);
    procedure Informacoes;
    procedure MinhaPosFila;
    procedure Att_Status;
    procedure Login_Ok;




  private
    { Private declarations }
  public
  var
    AtendimentoIni: TIniFile;

    Ultima_Atualizacao,
    Atualizado,
    Meu_Status,
    usuario,
    Pos_Fila,
    Pos_Fila_1,
    Pos_Fila_2,
    Pos_Fila_3,
    Pos_Fila_4,
    Pos_Fila_5,
    Pos_Fila_6,
    Pos_Fila_7,
    data_ini,
    data_ult_att,
    Label_Nome,
    Label_Status,
    Label_Quando,
    Linha
    : String;

    //Num_Label, Contagem
    Larg_Nome,
    Larg_Status,
    Alt_Nome
    : Integer;

    //data_ini : TDateTime;
    { Public declarations }
  end;

var
  Atendimento: TAtendimento;

implementation

{$R *.dfm}

uses CONEXAO_BD, Frm_Login;




{ TForm1 }


// NO FECHAMENTO DO PROGRAMA ELE IRA REGISTRAR A ATUALIZA??O


// NA ABERTURA DO PROGRAMA ELE IRA REGISTRAR A ATUALIZA??O
procedure TAtendimento.FormShow(Sender: TObject);

begin
  Label_Pc_1.Caption:= '';
  Label_Pc_2.Caption:= '';
  Label_Pc_3.Caption:= '';
  Label_Pc_4.Caption:= '';
  Label_Pc_5.Caption:= '';
  Label_Pc_6.Caption:= '';
  Label_Pc_7.Caption:= '';
  Label_Pc_1_Status.Caption:= '';
  Label_Pc_2_Status.Caption:= '';
  Label_Pc_3_Status.Caption:= '';
  Label_Pc_4_Status.Caption:= '';
  Label_Pc_5_Status.Caption:= '';
  Label_Pc_6_Status.Caption:= '';
  Label_Pc_7_Status.Caption:= '';
  Label_Pc_1_Quando.Caption:= '';
  Label_Pc_2_Quando.Caption:= '';
  Label_Pc_3_Quando.Caption:= '';
  Label_Pc_4_Quando.Caption:= '';
  Label_Pc_5_Quando.Caption:= '';
  Label_Pc_6_Quando.Caption:= '';
  Label_Pc_7_Quando.Caption:= '';
  Btn_Status.Visible := False;
//  Login.ShowModal;
  Meu_Status := 'CONECTADO';
  Login_Ok;
end;

// INFORMA??ES DOS COMPUTADORES
procedure TAtendimento.Informacoes;
 var
 Num_Label, Contagem : Integer;
begin
   For Contagem := 1 to 6 do
  begin
    Label_Nome := 'Label_Pc_' + IntToStr(Contagem);
    Label_Status := 'Label_Pc_' + IntToStr(Contagem)+'_Status';
    Label_Quando := 'Label_Pc_' + IntToStr(Contagem)+'_Quando';

  (*
      Pos_Fila_1 := AtendimentoIni.ReadString('POS','POS1','');
       Pos_Fila_2 := AtendimentoIni.ReadString('POS','POS2','');
       Pos_Fila_3 := AtendimentoIni.ReadString('POS','POS3','');
       Pos_Fila_4 := AtendimentoIni.ReadString('POS','POS4','');
       Pos_Fila_5 := AtendimentoIni.ReadString('POS','POS5','');
       Pos_Fila_6 := AtendimentoIni.ReadString('POS','POS6','');
       Pos_Fila_7 := AtendimentoIni.ReadString('POS','POS7','');

 *)


    for Num_Label := 0 to ComponentCount -1 do
    if (Components[Num_Label] is TLabel) and
    (Components[Num_Label].Name = Label_Nome) then
    begin
      TLabel(Components[Num_Label]).Caption := AtendimentoIni.ReadString('POS','POS'+inttostr(Contagem),'');
      Linha := TLabel(Components[Num_Label]).Caption;
      Larg_Nome := TLabel(Components[Num_Label]).Width+20;
      Alt_Nome := TLabel(Components[Num_Label]).Top;
    end;

    for Num_Label := 0 to ComponentCount -1 do
    if (Components[Num_Label] is TLabel) and
    (Components[Num_Label].Name = Label_Status) then
     begin
      TLabel(Components[Num_Label]).Caption := AtendimentoIni.ReadString('DISPONIBLIDADE',Linha,'');
      TLabel(Components[Num_Label]).Left := Larg_Nome;
      TLabel(Components[Num_Label]).Top := Alt_Nome;
      Larg_Status := TLabel(Components[Num_Label]).Width+Larg_Nome+20;

      if TLabel(Components[Num_Label]).Caption = 'ON LINE' then
      begin
         TLabel(Components[Num_Label]).Font.Color := clGreen;
      end
       else if TLabel(Components[Num_Label]).Caption = 'EM ATENDIMENTO' then
      begin
         TLabel(Components[Num_Label]).Font.Color := clBlue;
      end
       else
      begin
         TLabel(Components[Num_Label]).Font.Color := clRed;
      end;
     end;

    for Num_Label := 0 to ComponentCount -1 do
    if (Components[Num_Label] is TLabel) and
    (Components[Num_Label].Name = Label_Quando) then
    begin
      TLabel(Components[Num_Label]).Caption := AtendimentoIni.ReadString('QUANDO',Linha,'');
      TLabel(Components[Num_Label]).Left := Larg_Status;
      TLabel(Components[Num_Label]).Top := Alt_Nome;
    end;

  end;

end;

// VERIFICANDO SE O LOGIN EST? OK
procedure TAtendimento.Login_Ok;
begin
  if Meu_Status = '' then
  begin
    Self.Close
  end
  Else
    Begin
      FreeAndNil(Login);
      Att_Status;
    End;
end;

procedure TAtendimento.MinhaPosFila;
 var
 I : integer;
begin
 for I := 1 to 7 do
 if True then
end;

//PEGANDO O NOME DO PC

//teste de notifica??o
procedure TAtendimento.NotificationCenter1ReceiveLocalNotification(Sender: TObject;
  ANotification: TNotification);
 var
 MyNotification: TNotification;
begin
  MyNotification := NotificationCenter1.CreateNotification;
  try
  MyNotification.Name := 'Windows10Notification';
  MyNotification.Title := 'ATENDIMENTO INICIADO';
  MyNotification.AlertBody := usuario+' INICIOU UM ANTENDIMENTO';

  NotificationCenter1.PresentNotification(MyNotification);
  finally
  MyNotification.Free;
  end;
end;

// BOT?O ON OFF PARA MOSTRAR SE ESTA ON LINE OU OFF LINE
procedure TAtendimento.Btn_On_OffClick(Sender: TObject);

 begin
  if Btn_On_Off.caption = 'ON LINE' then
  begin
    Btn_On_Off.caption := 'OFF LINE';
    Meu_Status := 'ON LINE';
    Btn_Status.Visible := True;

  end
  Else
  begin
    Btn_On_Off.caption := 'ON LINE';
    Meu_Status := 'OFF LINE';
    Btn_Status.Visible := False;
    Btn_Status.caption := 'INICIAR ATENDIMENTO';

  end;

 end;

//ATUALIZA??O DE STATUS
procedure TAtendimento.Att_Status;
begin
  with DM_CONEXAO.Qry_Usuarios do
  begin
    Close;
    SQL.Clear;
    SQL.Add('UPDATE USUARIOS SET CONTAS_PERMITIDAS =');
    SQL.Add(''''+Meu_Status+'''');
    SQL.Add('WHERE USUARIO =');
    SQL.Add(''''+Usuario+'''');
    ExecSQL;
  end;
end;

// BOT?O INIFICAR E FINALIZAR PARA MOSTRAR SE ESTA ON LINE OU OFF LINE
procedure TAtendimento.Btn_StatusClick(Sender: TObject);
 begin
  if Btn_Status.caption = 'INICIAR ATENDIMENTO' then
  begin
    Btn_Status.caption := 'FINALIZAR ATENDIMENTO';
    Meu_Status := 'EM ATENDIMENTO';
    Att_Status;
  end
  Else
  begin
    Btn_Status.caption := 'INICIAR ATENDIMENTO';
    Meu_Status := 'ON LINE';
    Att_Status;
  end;
 end;

// BARRA DE STATUS COM O CONTADO DE HORAS E SE ESTA LOGADO
procedure TAtendimento.Timer1Timer(Sender: TObject);
begin
StatusBar1.Panels[0].text := DateTimetoStr(Now);
StatusBar1.Panels[1].text := Meu_Status;
//StatusBar1.Panels[2].text := Meu_Status;

//  Informacoes;
 (*
if data_ult_att < Data_ini then
begin
Informacoes;
data_ult_att := DateTimeToStr(now)
end;
   *)





end;
end.
