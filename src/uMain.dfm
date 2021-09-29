object frmMain: TfrmMain
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Exemplo - FTP'
  ClientHeight = 474
  ClientWidth = 568
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pnlConfiguracao: TPanel
    Left = 0
    Top = 0
    Width = 568
    Height = 95
    Align = alTop
    TabOrder = 0
    object edtHospedagem: TLabeledEdit
      Left = 8
      Top = 24
      Width = 545
      Height = 21
      EditLabel.Width = 66
      EditLabel.Height = 13
      EditLabel.Caption = 'Hospedagem:'
      TabOrder = 0
    end
    object edtUsuario: TLabeledEdit
      Left = 8
      Top = 65
      Width = 215
      Height = 21
      EditLabel.Width = 40
      EditLabel.Height = 13
      EditLabel.Caption = 'Usuario:'
      TabOrder = 1
    end
    object edtSenha: TLabeledEdit
      Left = 231
      Top = 65
      Width = 163
      Height = 21
      EditLabel.Width = 34
      EditLabel.Height = 13
      EditLabel.Caption = 'Senha:'
      PasswordChar = '*'
      TabOrder = 2
    end
    object edtPorta: TLabeledEdit
      Left = 400
      Top = 65
      Width = 52
      Height = 21
      EditLabel.Width = 30
      EditLabel.Height = 13
      EditLabel.Caption = 'Porta:'
      NumbersOnly = True
      TabOrder = 3
      Text = '21'
    end
    object btnConectar: TButton
      Left = 458
      Top = 63
      Width = 95
      Height = 25
      Caption = 'Testar Conex'#227'o'
      TabOrder = 4
      OnClick = btnConectarClick
    end
  end
  object pnlBotoes: TPanel
    Left = 0
    Top = 433
    Width = 568
    Height = 41
    Align = alBottom
    TabOrder = 1
    object btnDownload: TButton
      Left = 101
      Top = 6
      Width = 75
      Height = 25
      Caption = 'Download'
      TabOrder = 0
      OnClick = btnDownloadClick
    end
    object btnUpload: TButton
      Left = 400
      Top = 6
      Width = 75
      Height = 25
      Caption = 'Upload'
      TabOrder = 1
      OnClick = btnUploadClick
    end
  end
  object pnlArquivoDownload: TPanel
    Left = 0
    Top = 95
    Width = 282
    Height = 338
    Align = alLeft
    TabOrder = 2
    object edtDiretorioDownload: TLabeledEdit
      Left = 8
      Top = 21
      Width = 247
      Height = 21
      TabStop = False
      EditLabel.Width = 174
      EditLabel.Height = 13
      EditLabel.Caption = 'Diret'#243'rio de aquivos para download:'
      ReadOnly = True
      TabOrder = 0
    end
    object btnDiretorioDownload: TButton
      Left = 255
      Top = 19
      Width = 21
      Height = 25
      Caption = '...'
      TabOrder = 1
      TabStop = False
      OnClick = btnDiretorioDownloadClick
    end
    object flbArquivoDownload: TFileListBox
      Left = 8
      Top = 48
      Width = 267
      Height = 284
      ItemHeight = 13
      TabOrder = 2
    end
  end
  object pnlArquivoUpload: TPanel
    Left = 286
    Top = 95
    Width = 282
    Height = 338
    Align = alRight
    TabOrder = 3
    object edtDiretorioUpload: TLabeledEdit
      Left = 8
      Top = 21
      Width = 247
      Height = 21
      TabStop = False
      EditLabel.Width = 160
      EditLabel.Height = 13
      EditLabel.Caption = 'Diret'#243'rio de aquivos para upload:'
      ReadOnly = True
      TabOrder = 0
    end
    object btnDiretorioUpload: TButton
      Left = 255
      Top = 19
      Width = 21
      Height = 25
      Caption = '...'
      TabOrder = 1
      TabStop = False
      OnClick = btnDiretorioUploadClick
    end
    object flbArquivoUpload: TFileListBox
      Left = 9
      Top = 48
      Width = 267
      Height = 284
      ItemHeight = 13
      TabOrder = 2
    end
  end
end
