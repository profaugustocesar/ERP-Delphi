program ERPDelphi;

uses
  Vcl.Forms,
  unPrincipal in 'principal\unPrincipal.pas' {frmPrincipal},
  unDM in 'dm\unDM.pas' {DM: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TDM, DM);

  if (DM.AbrirConexao(DM.LerArquivoIni)) then
    begin
      Application.CreateForm(TfrmPrincipal, frmPrincipal);
      Application.Run;
    end
  else
    begin
      Application.Terminate;
    end;
end.
