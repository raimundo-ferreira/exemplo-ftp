unit uMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.FileCtrl;

type
  TfrmMain = class(TForm)
    pnlConfiguracao: TPanel;
    edtHospedagem: TLabeledEdit;
    edtUsuario: TLabeledEdit;
    edtSenha: TLabeledEdit;
    edtPorta: TLabeledEdit;
    btnConectar: TButton;
    pnlBotoes: TPanel;
    btnDownload: TButton;
    btnUpload: TButton;
    pnlArquivoDownload: TPanel;
    edtDiretorioDownload: TLabeledEdit;
    btnDiretorioDownload: TButton;
    pnlArquivoUpload: TPanel;
    edtDiretorioUpload: TLabeledEdit;
    btnDiretorioUpload: TButton;
    flbArquivoUpload: TFileListBox;
    flbArquivoDownload: TFileListBox;
    procedure btnDiretorioDownloadClick(Sender: TObject);
    procedure btnDiretorioUploadClick(Sender: TObject);
    procedure btnUploadClick(Sender: TObject);
    procedure btnConectarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnDownloadClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    procedure AtualizaFileListBox(aFileListBox: TFileListBox; aDiretorio: string);
    function SelecionaDiretorio(aTitilo: string): string;
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.dfm}

uses uFtp, uConfiguracao;

procedure TfrmMain.AtualizaFileListBox(aFileListBox: TFileListBox; aDiretorio: string);
begin
  if aDiretorio <> EmptyStr then
    aFileListBox.ApplyFilePath(aDiretorio);
  aFileListBox.Update;
end;

procedure TfrmMain.btnConectarClick(Sender: TObject);
begin
  TFtp.GetInstance(edtHospedagem.Text, edtUsuario.Text, edtSenha.Text)
    .TestarConexao;
end;

procedure TfrmMain.btnDiretorioDownloadClick(Sender: TObject);
begin
  edtDiretorioDownload.Text := SelecionaDiretorio(edtDiretorioDownload.EditLabel.Caption);
  AtualizaFileListBox(flbArquivoDownload, edtDiretorioDownload.Text);
end;

procedure TfrmMain.btnDiretorioUploadClick(Sender: TObject);
begin
  edtDiretorioUpload.Text := SelecionaDiretorio(edtDiretorioUpload.EditLabel.Caption);
  AtualizaFileListBox(flbArquivoUpload, edtDiretorioUpload.Text);
end;

procedure TfrmMain.btnDownloadClick(Sender: TObject);
begin
  TFtp.GetInstance(edtHospedagem.Text, edtUsuario.Text, edtSenha.Text)
    .Download(edtDiretorioDownload.Text, True);
  AtualizaFileListBox(flbArquivoDownload, edtDiretorioDownload.Text);
  ShowMessage('Download concluído com sucesso!');
end;

procedure TfrmMain.btnUploadClick(Sender: TObject);
begin
  TFtp.GetInstance(edtHospedagem.Text, edtUsuario.Text, edtSenha.Text)
    .Upload(edtDiretorioUpload.Text, True);
  AtualizaFileListBox(flbArquivoUpload, edtDiretorioUpload.Text);
  ShowMessage('Upload concluído com sucesso!');
end;

procedure TfrmMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  TConfiguracao.Escrever(edtHospedagem);
  TConfiguracao.Escrever(edtUsuario);
  TConfiguracao.Escrever(edtSenha);
  TConfiguracao.Escrever(edtPorta);
  TConfiguracao.Escrever(edtDiretorioDownload);
  TConfiguracao.Escrever(edtDiretorioUpload);
end;

procedure TfrmMain.FormShow(Sender: TObject);
begin
  TConfiguracao.Ler(edtHospedagem);
  TConfiguracao.Ler(edtUsuario);
  TConfiguracao.Ler(edtSenha);
  TConfiguracao.Ler(edtPorta);
  TConfiguracao.Ler(edtDiretorioDownload);
  TConfiguracao.Ler(edtDiretorioUpload);
  flbArquivoUpload.ApplyFilePath(edtDiretorioUpload.Text);
  flbArquivoDownload.ApplyFilePath(edtDiretorioDownload.Text);
end;

function TfrmMain.SelecionaDiretorio(aTitilo: string): string;
var
  Pasta: string;
begin
  SelectDirectory(aTitilo, EmptyStr, Pasta);
  if (trim(Pasta) <> EmptyStr) and (Pasta[Length(Pasta)] <> '\') then
    Pasta := Pasta + '\';
  Result := Pasta;
end;

end.
