unit uConfiguracao;

interface

uses
  Vcl.StdCtrls, IniFiles;

type
  TConfiguracao = class
  public
    class procedure Ler(aEdit: TCustomEdit);
    class procedure Escrever(aEdit: TCustomEdit);
  end;

implementation

uses
  Vcl.Forms, System.SysUtils;

{ TConfiguracao }

class procedure TConfiguracao.Escrever(aEdit: TCustomEdit);
var
  Ini: TIniFile;
begin
  Ini := TIniFile.Create(ExtractFilePath(Application.ExeName) + 'Config.ini');
  try
    Ini.WriteString('CONFIGURACOES', aEdit.Name, aEdit.Text);
  finally
    Ini.Free;
  end;
end;

class procedure TConfiguracao.Ler(aEdit: TCustomEdit);
var
  Ini: TIniFile;
begin
  Ini := TIniFile.Create(ExtractFilePath(Application.ExeName) + 'Config.ini');
  try
    aEdit.Text := Ini.ReadString('CONFIGURACOES', aEdit.Name, aEdit.Text);
  finally
    Ini.Free;
  end;
end;

end.
