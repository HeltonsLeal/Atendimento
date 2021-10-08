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
    On_Off: TButton;
    Status: TButton;
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
    procedure On_OffClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure NomePc;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure StatusClick(Sender: TObject);
    procedure NotificationCenter1ReceiveLocalNotification(Sender: TObject;
      ANotification: TNotification);
    procedure Informacoes;
    procedure MinhaPosFila;
    procedure Att_Status;



  private
    { Private declarations }
  public
  var
    AtendimentoIni: TIniFile;
    Pega_Nome: array[0..255] of char;
    Nome_Pc,
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

uses CONEXAO_BD;




{ TForm1 }


// NO FECHAMENTO DO PROGRAMA ELE IRA REGISTRAR A ATUALIZA��O
procedure TAtendimento.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  
end;

// NA ABERTURA DO PROGRAMA ELE IRA REGISTRAR A ATUALIZA��O
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
  NomePc;
  Status.Visible := False;
  Meu_Status := 'CONECTADO';
  Att_Status;
//  Informacoes;
end;

// INFORMA��ES DOS COMPUTADORES
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

procedure TAtendimento.MinhaPosFila;
  var
  I : integer;
 begin
  for I := 1 to 7 do
  if True then





 end;

//PEGANDO O NOME DO PC
procedure TAtendimento.NomePc;
  var
  size: dword;
  begin
  size:=256;
  if GetComputerName(Pega_Nome, size) then
  Nome_Pc := Pega_Nome;
  end;

//teste de notifica��o
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

// BOT�O ON OFF PARA MOSTRAR SE ESTA ON LINE OU OFF LINE
procedure TAtendimento.On_OffClick(Sender: TObject);

 begin
  if On_Off.caption = 'ON LINE' then
  begin
    On_Off.caption := 'OFF LINE';
    Meu_Status := 'ON LINE';
    Status.Visible := True;

  end
  Else
  begin
    On_Off.caption := 'ON LINE';
    Meu_Status := 'OFF LINE';
    Status.Visible := False;
    Status.caption := 'INICIAR ATENDIMENTO';

  end;

 end;

procedure TAtendimento.Att_Status;
 begin
  DM_CONEXAO.Qry_Usuarios.Close;
  DM_CONEXAO.Qry_Usuarios.SQL.Clear;
  DM_CONEXAO.Qry_Usuarios.SQL.Add('UPDATE USUARIOS SET CONTAS_PERMITIDAS =');
  DM_CONEXAO.Qry_Usuarios.SQL.Add(''''+Meu_Status+'''');
  DM_CONEXAO.Qry_Usuarios.SQL.Add('WHERE USUARIO =');
  DM_CONEXAO.Qry_Usuarios.SQL.Add(''''+Usuario+'''');
  DM_CONEXAO.Qry_Usuarios.ExecSQL;
 end;



// BOT�O INIFICAR E FINALIZAR PARA MOSTRAR SE ESTA ON LINE OU OFF LINE
procedure TAtendimento.StatusClick(Sender: TObject);
 begin
  if Status.caption = 'INICIAR ATENDIMENTO' then
  begin
    Status.caption := 'FINALIZAR ATENDIMENTO';
    Meu_Status := 'EM ATENDIMENTO';
    Att_Status;
  end
  Else
  begin
    Status.caption := 'INICIAR ATENDIMENTO';
    Meu_Status := 'ON LINE';
    Att_Status;
  end;
 end;

// BARRA DE STATUS COM O CONTADO DE HORAS E SE ESTA LOGADO
procedure TAtendimento.Timer1Timer(Sender: TObject);

  var
  MyNotification: TNotification;
  begin

  StatusBar1.Panels[0].text := DateTimetoStr(Now);
  StatusBar1.Panels[1].text := Meu_Status;

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