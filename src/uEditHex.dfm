object FormEditHex: TFormEditHex
  Left = 198
  Top = 139
  Width = 648
  Height = 442
  Caption = 'Editor HEX'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter1: TSplitter
    Left = 0
    Top = 0
    Width = 640
    Height = 25
    Cursor = crVSplit
    Align = alTop
  end
  object CheckBox1: TCheckBox
    Left = 5
    Top = 3
    Width = 97
    Height = 17
    Caption = 'Modo INSERT'
    TabOrder = 0
    OnClick = CheckBox1Click
  end
  object CheckBox2: TCheckBox
    Left = 128
    Top = 3
    Width = 97
    Height = 17
    Caption = 'Somente leitura'
    TabOrder = 1
    OnClick = CheckBox2Click
  end
  object MainMenu1: TMainMenu
    Left = 280
    Top = 8
    object Arquivo1: TMenuItem
      Caption = 'Arquivo'
      object Abrir1: TMenuItem
        Caption = 'Abrir...'
        OnClick = Abrir1Click
      end
      object Salvar1: TMenuItem
        Caption = 'Salvar'
      end
      object Salvarcomo1: TMenuItem
        Caption = 'Salvar como...'
        OnClick = Salvarcomo1Click
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object Sair1: TMenuItem
        Caption = 'Sair'
        OnClick = Sair1Click
      end
    end
  end
  object OpenDialog1: TOpenDialog
    Left = 344
    Top = 8
  end
  object SaveDialog1: TSaveDialog
    Options = [ofOverwritePrompt, ofHideReadOnly, ofPathMustExist, ofEnableSizing]
    Left = 312
    Top = 8
  end
end
