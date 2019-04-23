unit uEsquema;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, jpeg, ExtCtrls, StdCtrls;

type
  TForm3 = class(TForm)
    Image1: TImage;
    Label1: TLabel;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;

implementation

uses UGrava;

{$R *.dfm}

procedure TForm3.FormCreate(Sender: TObject);
begin
  Form3.Caption := STR_SCHEMATIC;
  label1.Caption := STR_SCHTIP;
end;

end.
