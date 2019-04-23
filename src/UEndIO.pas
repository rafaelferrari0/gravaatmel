unit UEndIO;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons;

type
  TEndIO = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    ComboBox1: TComboBox;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  EndIO: TEndIO;

implementation

uses UGrava;

{$R *.dfm}

procedure TEndIO.BitBtn1Click(Sender: TObject);
begin

  if (ComboBox1.Text) = '' then
  begin
    MessageBox(self.Handle,PAnsiChar(STR_MSG_CHOOSEPORT),PAnsiChar(STR_MSG_TYPE_ERROR),MB_OK + MB_ICONERROR + MB_APPLMODAL);
    exit;
  end;

  form1.arqinifile.WriteString('CONFIG','PORTA',combobox1.text);
//  MessageBox(form1.Handle,STR_ENDIO_RESTART,STR_MSG_INFORMATION,MB_OK + MB_ICONINFORMATION + MB_APPLMODAL);
  form1.InitSerial(combobox1.text);

//  showmessage(combobox1.text);

  self.close;

end;

procedure TEndIO.BitBtn2Click(Sender: TObject);
begin
  self.close;
end;

procedure TEndIO.Edit1KeyPress(Sender: TObject; var Key: Char);
begin

  key := UpCase(Key);
  if ((Key < '0') or (Key > '9')) and ((key < 'A') or (Key > 'F')) and (key > #32)  then
    key := #0;

end;

procedure TEndIO.FormCreate(Sender: TObject);
begin
  EndIO.Caption := STR_SUBMENU_CHOOSEPORT;

end;

end.
