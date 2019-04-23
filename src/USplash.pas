unit USplash;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls;

type
  TSplash = class(TForm)
    Panel1: TPanel;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }

  end;

var
  Splash: TSplash;


implementation

uses UGrava;

{$R *.dfm}



procedure TSplash.FormCreate(Sender: TObject);
begin

Panel1.Caption := STR_AGUARDE;
 
end;

end.
