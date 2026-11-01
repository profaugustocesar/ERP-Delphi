unit unDM;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait,
  Data.DB, FireDAC.Comp.Client, FireDAC.Phys.MySQL;

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
    function LerArquivoIni: TConfiguracoesBD;
    function AbrirConexao(const pDados: TConfiguracoesBD): Boolean;
  end;

var
  DM: TDM;

implementation

uses
  System.IniFiles;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TDM }

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

function TDM.LerArquivoIni: TConfiguracoesBD;
var
  vPasta: String;
  vArquivoIni: TIniFile;
begin
  vPasta := ExtractFileDir(ParamStr(0));
  vPasta := ExtractFileDir(vPasta);
  vPasta := ExtractFileDir(vPasta);

  vArquivoIni := TIniFile.Create( IncludeTrailingPathDelimiter(vPasta)+'Conexao.ini' );

  try
    Result.Servidor := vArquivoIni.ReadString('MariaDB','Servidor','localhost');
    Result.Porta := vArquivoIni.ReadInteger('MariaDB','Porta',3306);
    Result.Banco := vArquivoIni.ReadString('MariaDB','BancoDados','');
    Result.Usuario := vArquivoIni.ReadString('MariaDB','Usuario','');
    Result.Senha := vArquivoIni.ReadString('MariaDB','Senha','');
  finally
    vArquivoIni.Free;
  end;
end;

end.
