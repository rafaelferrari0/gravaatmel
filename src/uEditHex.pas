unit uEditHex;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, MPHexEditor, Menus, StdCtrls, ExtCtrls;

type
  TFormEditHex = class(TForm)
    MainMenu1: TMainMenu;
    Arquivo1: TMenuItem;
    Abrir1: TMenuItem;
    Salvar1: TMenuItem;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    N1: TMenuItem;
    Sair1: TMenuItem;
    Salvarcomo1: TMenuItem;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    Splitter1: TSplitter;
    procedure Abrir1Click(Sender: TObject);
    procedure Sair1Click(Sender: TObject);
    procedure Salvarcomo1Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure CheckBox1Click(Sender: TObject);
    procedure CheckBox2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormEditHex: TFormEditHex;
//  arqaberto: string[255];
 MPHexEditor1: TMPHexEditor;

implementation

uses UGrava;

{$R *.dfm}





procedure TFormEditHex.Abrir1Click(Sender: TObject);
begin

    if OpenDialog1.Execute then
    begin

      if (form1.Get_File_Size(OpenDialog1.FileName) > (10000000)) then  // maior q 10M / protecao para nao acabar com a memoria
      begin
          MessageBox(FormEditHex.Handle,PAnsiChar(STR_MSG_FILETOOBIG),pansichar(STR_MSG_TYPE_ERROR),MB_OK + MB_ICONERROR + MB_APPLMODAL);
          exit;
      end;

      MPHexEditor1.LoadFromFile(OpenDialog1.FileName);
    end;

end;

procedure TFormEditHex.CheckBox1Click(Sender: TObject);
begin

  if CheckBox1.Checked then
    MPHexEditor1.InsertMode := true
  else
    MPHexEditor1.InsertMode := false;

end;

procedure TFormEditHex.CheckBox2Click(Sender: TObject);
begin

  if CheckBox2.Checked then
    MPHexEditor1.ReadOnlyView := true
  else
    MPHexEditor1.ReadOnlyView := false;

end;

procedure TFormEditHex.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
 var ret: integer;
  zero: tmemorystream;
begin

  if MPHexEditor1.Modified then
  begin

      ret := MessageBox(self.Handle,'O arquivo foi alterado. Deseja salvar alterações?','Atenção',MB_YESNOCANCEL + MB_ICONINFORMATION + MB_APPLMODAL);
      if ret = ID_OK then
      begin
        MPHexEditor1.SaveToFile(MPHexEditor1.Filename);
        CanClose := true;

      end
      else if ret = IDNO then
      begin
        CanClose := true;
      end
      else
        CanClose :=  false;

  end;


  zero := TMemoryStream.Create;
  try
    MPHexEditor1.LoadFromStream(zero);
  finally
    zero.free;
  end;

end;

procedure TFormEditHex.Sair1Click(Sender: TObject);
begin
  self.close;
end;

procedure TFormEditHex.Salvarcomo1Click(Sender: TObject);
begin
      if SaveDialog1.execute then
        MPHexEditor1.SaveToFile(SaveDialog1.FileName);

end;

procedure TFormEditHex.FormCreate(Sender: TObject);
begin

  MPHexEditor1:= TMPHexEditor.Create(FormEditHex);
  MPHexEditor1.Parent := FormEditHex;
  MPHexEditor1.Align := alClient;
  Arquivo1.Caption := STR_MENU_FILE;
  Abrir1.Caption := STR_SUBMENU_OPEN;

  salvar1.Caption := STR_SUBMENU_SAVE;
  Salvarcomo1.Caption := STR_SUBMENU_SAVEAS;
  sair1.Caption := STR_SUBMENU_EXIT;

  CheckBox1.Caption := STR_INSERTMODE;
  CheckBox2.Caption := STR_READONLY;

  FormEditHex.Caption := STR_EDITOR;



end;

procedure TFormEditHex.FormDestroy(Sender: TObject);
begin
 MPHexEditor1.free;
end;

end.
