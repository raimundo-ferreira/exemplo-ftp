unit uFtp;

interface

uses
  IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient,
  IdExplicitTLSClientServerBase, IdFTP;

type

  IFtp = interface
    ['{D66CAC08-D2FA-402D-9D4F-40D7C52196CE}']
    procedure TestarConexao;
    procedure Download(const aDiretorioArquivos: string; aExcluirArquivo: Boolean = False);
    procedure Upload(const aDiretorioArquivos: string; aExcluirArquivo: Boolean = False);
  end;

  TFtp = class(TInterfacedObject, IFtp)
  private
    fIdFtp: TIdFTP;
    fHospedagem: string;
    fUsuario: string;
    fSenha: string;
    fPorta: Integer;
    procedure Conectar;
    procedure Desconectar;
  public
    constructor Create(const aHospedagem, aUsuario, aSenha: string; aPorta: Integer);
    destructor Destroy; override;
    class function GetInstance(const aHospedagem, aUsuario, aSenha: string; aPorta: Integer = 21): IFtp;
    procedure TestarConexao;
    procedure Download(const aDiretorioArquivos: string; aExcluirArquivo: Boolean = False);
    procedure Upload(const aDiretorioArquivos: string; aExcluirArquivo: Boolean = False );
  end;

implementation

uses
  System.SysUtils, System.Classes, Vcl.Dialogs;

{ TFtp }

procedure TFtp.Conectar;
begin
  if not(fIdFtp.Connected) then
  begin
    fIdFtp.Disconnect;
    fIdFtp.Host := fHospedagem;
    fIdFtp.Port := fPorta;
    fIdFtp.Username := fUsuario;
    fIdFtp.Password := fSenha;
    fIdFtp.Passive := False;
    try
      fIdFtp.Connect;
    except on E: Exception do
      raise Exception.Create('Erro ao se conecetar com o servidor FTP:' + sLineBreak + E.Message);
    end;
  end;
end;

constructor TFtp.Create(const aHospedagem, aUsuario, aSenha: string; aPorta: Integer);
begin
  fHospedagem := aHospedagem;
  fUsuario := aUsuario;
  fSenha := aSenha;
  fPorta := aPorta;
  fIdFtp := TIdFTP.Create(nil);
end;

procedure TFtp.Desconectar;
begin
  if (fIdFtp.Connected) then
    fIdFtp.Disconnect;
end;

destructor TFtp.Destroy;
begin
  Desconectar;
  FreeAndNil(fIdFtp);
  inherited;
end;

procedure TFtp.Download(const aDiretorioArquivos: string; aExcluirArquivo: Boolean = False);
var
  I: Integer;
begin
  Conectar;
  fIdFtp.List;
  for I := 0 to fIdFtp.DirectoryListing.Count - 1 do
  begin
    if ExtractFileExt(fIdFtp.DirectoryListing.Items[I].FileName) = '.txt' then
    begin
      fIdFtp.Get(fIdFtp.DirectoryListing.Items[I].FileName,
        aDiretorioArquivos + fIdFtp.DirectoryListing.Items[I].FileName, True, False);
      if aExcluirArquivo then
        fIdFtp.Delete(fIdFtp.DirectoryListing.Items[I].FileName);
    end;
  end;
end;

class function TFtp.GetInstance(const aHospedagem, aUsuario, aSenha: string; aPorta: Integer = 21): IFtp;
begin
  Result := TFtp.Create(aHospedagem, aUsuario, aSenha, aPorta);
end;

procedure TFtp.TestarConexao;
begin
  Conectar;
  ShowMessage('Conectado com sucesso!');
end;

procedure TFtp.Upload(const aDiretorioArquivos: string; aExcluirArquivo: Boolean = False);
var
  ListaArquivos: TStringList;
  SR: TSearchRec;
  I: Integer;
begin
  Conectar;
  ListaArquivos := TStringList.Create;
  try
    I := FindFirst(aDiretorioArquivos + '*.*', faAnyFile, SR);
    while I = 0 do
    begin
      if (SR.Name <> '.') and (SR.Name <> '..') then
        ListaArquivos.Add(SR.Name);
      I := FindNext(SR);
    end;
    for I := 0 to ListaArquivos.Count - 1 do
    begin
      fIdFtp.Put(aDiretorioArquivos + ListaArquivos[I], '', False);
      if aExcluirArquivo then
        DeleteFile(aDiretorioArquivos + ListaArquivos[I]);
    end;
  finally
    ListaArquivos.Free;
  end;
end;

end.
