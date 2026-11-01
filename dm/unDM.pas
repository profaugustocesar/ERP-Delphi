unit unDM;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait,
  Data.DB, FireDAC.Comp.Client, FireDAC.Phys.MySQL, System.IniFiles;

type
  TConfiguracoesBD = record
    Servidor : string;
    Porta : integer;
    Banco : string;
    Usuario : string;
    Senha : string;
  end;

  TDM = class(TDataModule)
    Conexao: TFDConnection;
  private
    { Private declarations }
  public
    { Public declarations }
    function AbrirArquivoIni: TIniFile;
    function LerArquivoIni: TConfiguracoesBD;
    function AbrirConexao(const pDados: TConfiguracoesBD): Boolean;
    function ConexaoAtiva: Boolean;
    procedure SalvarArquivoIni(const pDados: TConfiguracoesBD);
  end;

var
  DM: TDM;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TDM }

function TDM.AbrirArquivoIni: TIniFile;
var
  vPasta: String;
  vArquivoIni: TIniFile;
begin
  vPasta := ExtractFileDir(ParamStr(0));
  vPasta := ExtractFileDir(vPasta);
  vPasta := ExtractFileDir(vPasta);

  vArquivoIni := TIniFile.Create( IncludeTrailingPathDelimiter(vPasta)+'Conexao.ini' );
  Result := vArquivoIni;
end;

function TDM.AbrirConexao(const pDados: TConfiguracoesBD): Boolean;
begin
  Conexao.Close;
  Conexao.Params.Clear;
  Conexao.Params.Values['DriverID'] := 'MySQL';
  Conexao.Params.Values['Server'] := pDados.Servidor;
  Conexao.Params.Values['Port'] := IntToStr(pDados.Porta);
  Conexao.Params.Values['Database'] := pDados.Banco;
  Conexao.Params.Values['User_Name'] := pDados.Usuario;
  Conexao.Params.Values['Password'] := pDados.Senha;
  Conexao.LoginPrompt := False;
  Conexao.Open;

  Result := Conexao.Connected;
end;

function TDM.ConexaoAtiva: Boolean;
begin
  Result := Conexao.Connected;
end;

function TDM.LerArquivoIni: TConfiguracoesBD;
var
  vArquivoIni: TIniFile;
begin

  vArquivoIni := AbrirArquivoIni;

  try
    begin
      Result.Servidor := vArquivoIni.ReadString('MariaDB','Servidor','localhost');
      Result.Porta := vArquivoIni.ReadInteger('MariaDB','Porta',3306);
      Result.Banco := vArquivoIni.ReadString('MariaDB','BancoDados','');
      Result.Usuario := vArquivoIni.ReadString('MariaDB','Usuario','');
      Result.Senha := vArquivoIni.ReadString('MariaDB','Senha','');
    end;
  finally
    vArquivoIni.Free;
  end;
end;

procedure TDM.SalvarArquivoIni(const pDados: TConfiguracoesBD);
var
  vArquivoIni: TIniFile;
begin

  if (Trim(pDados.Servidor) = '') then
    raise Exception.Create('Preencha o nome do Servidor');

  if (pDados.Porta < 1) or (pDados.Porta > 65535) then
    raise Exception.Create('Porta Inválida.');

  if (Trim(pDados.Banco) = '') then
    raise Exception.Create('Preencha o nome do Banco de Dados.');

  if (Trim(pDados.Usuario) = '') then
    raise Exception.Create('Preencha o nome de Usuário');

  vArquivoIni := AbrirArquivoIni;

  try
    begin
      vArquivoIni.WriteString('MariaDB','Servidor',pDados.Servidor);
      vArquivoIni.WriteInteger('MariaDB','Porta',pDados.Porta);
      vArquivoIni.WriteString('MariaDB','BancoDados',pDados.Banco);
      vArquivoIni.WriteString('MariaDB','Usuario',pDados.Usuario);

      if (Trim(pDados.Senha) <> '') then      
        vArquivoIni.WriteString('MariaDB','Senha',pDados.Senha);
    end;
  finally
    vArquivoIni.Free;
  end;

end;

end.
