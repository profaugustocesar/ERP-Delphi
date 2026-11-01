unit unFrmConexao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TfrmConexao = class(TForm)
    lblTitulo: TLabel;
    lblInstrucao: TLabel;
    lblServidor: TLabel;
    lblPorta: TLabel;
    lblBanco: TLabel;
    lblUsuario: TLabel;
    lblSenha: TLabel;
    edtServidor: TEdit;
    edtPorta: TEdit;
    edtBanco: TEdit;
    edtUsuario: TEdit;
    edtSenha: TEdit;
    btnSalvar: TButton;
    btnEncerrar: TButton;
    procedure FormShow(Sender: TObject);
    procedure btnEncerrarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnSalvarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmConexao: TfrmConexao;

implementation

uses
  unDM;

{$R *.dfm}

procedure TfrmConexao.btnEncerrarClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmConexao.btnSalvarClick(Sender: TObject);
var
  vDados: TConfiguracoesBD;
begin

  vDados.Servidor := edtServidor.Text;
  vDados.Porta := StrToInt(edtPorta.Text);
  vDados.Banco := edtBanco.Text;
  vDados.Usuario := edtUsuario.Text;
  vDados.Senha := edtSenha.Text;

  try
    begin
      DM.SalvarArquivoIni(vDados);
      DM.AbrirConexao(DM.LerArquivoIni);
      Close;
    end;
  except
    on E: Exception do
      begin
        MessageDlg('Falha ao conectar o Banco de Dados' + sLineBreak + E.Message,
        mtError, [mbOK], 0);
      end;
  end;
end;

procedure TfrmConexao.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   if DM.ConexaoAtiva then
    Action := caFree
   else
    Application.Terminate;
end;

procedure TfrmConexao.FormShow(Sender: TObject);
var
  vConfiguracoesAtuais: TConfiguracoesBD;
begin

  vConfiguracoesAtuais := DM.LerArquivoIni;
  edtServidor.Text := vConfiguracoesAtuais.Servidor;
  edtPorta.Text := IntToStr(vConfiguracoesAtuais.Porta);
  edtBanco.Text := vConfiguracoesAtuais.Banco;
  edtUsuario.Text := vConfiguracoesAtuais.Usuario;

end;

end.
