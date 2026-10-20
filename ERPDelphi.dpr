program ERPDelphi;

uses
  Vcl.Forms,
  unPrincipal in 'principal\unPrincipal.pas' {frmPrincipal},
  unDM in 'dm\unDM.pas' {DM: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.CreateForm(TDM, DM);
  Application.Run;
end.
