program ERPDelphi;

uses
  System.SysUtils,
  Vcl.Dialogs,
  Vcl.Forms,
  unPrincipal in 'principal\unPrincipal.pas' {frmPrincipal},
  unDM in 'dm\unDM.pas' {DM: TDataModule},
  unFrmConexao in 'dm\unFrmConexao.pas' {frmConexao};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TDM, DM);
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.CreateForm(TfrmConexao, frmConexao);

  try
    begin
      DM.AbrirConexao(DM.LerArquivoIni);
      frmPrincipal.Show;
    end;
  except
    on E: Exception do
      begin
        MessageDlg('Falha ao conectar ao Banco de Dados.' + sLineBreak + E.Message,
        mtError, [mbOK], 0);
        frmConexao.ShowModal;
      end;
  end;

  Application.Run;
end.
