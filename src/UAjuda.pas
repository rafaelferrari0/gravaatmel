unit UAjuda;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TFormAjuda = class(TForm)
    Memo1: TMemo;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormAjuda: TFormAjuda;

implementation

uses UGrava;

{$R *.dfm}

procedure TFormAjuda.FormCreate(Sender: TObject);
begin

FormAjuda.Caption := STR_BOT_AJUDA;

memo1.text := STR_TXT_HELP;

end;

end.
