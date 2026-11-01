object frmConexao: TfrmConexao
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Conex'#227'o ao Banco de Dados'
  ClientHeight = 362
  ClientWidth = 542
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnClose = FormClose
  OnShow = FormShow
  TextHeight = 15
  object lblTitulo: TLabel
    Left = 24
    Top = 20
    Width = 496
    Height = 24
    AutoSize = False
    Caption = 'Configura'#231#227'o do banco de dados'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblInstrucao: TLabel
    Left = 24
    Top = 52
    Width = 496
    Height = 36
    AutoSize = False
    Caption = 
      'Revise os dados de acesso e clique em Salvar para tentar conecta' +
      'r novamente.'
    WordWrap = True
  end
  object lblServidor: TLabel
    Left = 24
    Top = 100
    Width = 43
    Height = 15
    Caption = 'Servidor'
    FocusControl = edtServidor
  end
  object lblPorta: TLabel
    Left = 432
    Top = 100
    Width = 28
    Height = 15
    Caption = 'Porta'
    FocusControl = edtPorta
  end
  object lblBanco: TLabel
    Left = 24
    Top = 160
    Width = 84
    Height = 15
    Caption = 'Banco de dados'
    FocusControl = edtBanco
  end
  object lblUsuario: TLabel
    Left = 24
    Top = 220
    Width = 40
    Height = 15
    Caption = 'Usu'#225'rio'
    FocusControl = edtUsuario
  end
  object lblSenha: TLabel
    Left = 284
    Top = 220
    Width = 32
    Height = 15
    Caption = 'Senha'
    FocusControl = edtSenha
  end
  object edtServidor: TEdit
    Left = 24
    Top = 120
    Width = 384
    Height = 23
    TabOrder = 0
  end
  object edtPorta: TEdit
    Left = 432
    Top = 120
    Width = 88
    Height = 23
    MaxLength = 5
    NumbersOnly = True
    TabOrder = 1
    Text = '3306'
  end
  object edtBanco: TEdit
    Left = 24
    Top = 180
    Width = 496
    Height = 23
    TabOrder = 2
  end
  object edtUsuario: TEdit
    Left = 24
    Top = 240
    Width = 236
    Height = 23
    TabOrder = 3
  end
  object edtSenha: TEdit
    Left = 284
    Top = 240
    Width = 236
    Height = 23
    PasswordChar = '*'
    TabOrder = 4
  end
  object btnSalvar: TButton
    Left = 236
    Top = 306
    Width = 133
    Height = 32
    Caption = 'Salvar e Conectar'
    Default = True
    TabOrder = 5
    OnClick = btnSalvarClick
  end
  object btnEncerrar: TButton
    Left = 384
    Top = 306
    Width = 136
    Height = 32
    Cancel = True
    Caption = 'Encerrar Aplica'#231#227'o'
    ModalResult = 2
    TabOrder = 6
    OnClick = btnEncerrarClick
  end
end
