program prjExemploFtp;

uses
  Vcl.Forms,
  uMain in 'src\uMain.pas' {frmMain},
  Vcl.Themes,
  Vcl.Styles,
  uFtp in 'src\uFtp.pas',
  uConfiguracao in 'src\uConfiguracao.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'Exemplo - FTP';
  TStyleManager.TrySetStyle('Aqua Light Slate');
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
