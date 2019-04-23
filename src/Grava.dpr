program Grava;

uses
  Forms,
  UGrava in 'UGrava.pas' {Form1},
  UAjuda in 'UAjuda.pas' {FormAjuda},
  USplash in 'USplash.pas' {Splash},
  uEsquema in 'uEsquema.pas' {Form3},
  uEditHex in 'uEditHex.pas' {FormEditHex},
  UEndIO in 'UEndIO.pas' {EndIO};

{$R *.res}


begin



      Splash := TSplash.Create(Application);
      Splash.Show;
      Application.Initialize;
      Splash.Update;
      Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TFormAjuda, FormAjuda);
  Application.CreateForm(TForm3, Form3);
  Application.CreateForm(TFormEditHex, FormEditHex);
  Application.CreateForm(TEndIO, EndIO);
  Splash.Hide;
//      Splash.Free;
      Application.Run;

      Form1.SetFocus;






end.
