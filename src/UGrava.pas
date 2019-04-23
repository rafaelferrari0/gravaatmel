unit UGrava;

//{$DEFINE EN-US}
{$DEFINE PT-BR}

{
Grava Atmel - (c) Rafael Ferrari - 2003 - 2016

Programa para gravar a série Atmel 89S com o protocolo SPI.

Este programa surgiu em 2003 para substituir o blast8252.
O blast8252 é um programador que utiliza a porta paralela, não funcionava em windows XP,
e era fornecido junto com os kits do site microcontrolador.com.br.
Criei o Grava Atmel para funcionar com o windows xp, e com interface em portugues.

Atualmente o Grava utiliza a porta serial para simular o protocolo SPI.
A intenção foi criar um gravador super barato e fácil de montar, pois todos os
componentes são fáceis de encontrar.

A migração foi feita utilizando o código existente, você vai encontrar
muita sujeira aqui!

Rotina principal:
SPI(dado: byte): byte;  >> Simula o protocolo SPI pulsando os pinos da porta.

Rotina de gravação:     >> Loop de leitura e gravação
BitBtn2Click(Sender: TObject);

Rotinas auxiliares:     >> Utilizam a SPI para ler ou gravar a memoria, dependendo do algoritmo de gravação (modelo)
LeByte(mem: integer): byte;
GravaByte(mem: integer; dado: byte);



}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, shellapi, Buttons, ExtCtrls,
  Spin, Menus, AppEvnts, jpeg, inifiles,hexfile, StdCtrls,
  ComCtrls, Gauges, synaser;


type
 vetorbyte= array of byte;

  TForm1 = class(TForm)
    StatusBar1: TStatusBar;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    GroupBox1: TGroupBox;
    BitBtn7: TBitBtn;
    BitBtn8: TBitBtn;
    GroupBox3: TGroupBox;
    BitBtn9: TBitBtn;
    GroupBox4: TGroupBox;
    MainMenu1: TMainMenu;
    Chip1: TMenuItem;
    menuAT89S8252: TMenuItem;
    menuAT89S53: TMenuItem;
    menuAT89S52: TMenuItem;
    menuAT89S51: TMenuItem;
    Gravao1: TMenuItem;
    menuNormal: TMenuItem;
    menuDiferencial: TMenuItem;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    Ajuda1: TMenuItem;
    Gravao2: TMenuItem;
    Sore1: TMenuItem;
    menuAT89S8253: TMenuItem;
    Esquema1: TMenuItem;
    N1: TMenuItem;
    Label1: TLabel;
    Ferramentas1: TMenuItem;
    HEXBIN1: TMenuItem;
    BINHEX1: TMenuItem;
    EditorHEX1: TMenuItem;
    Porta1: TMenuItem;
    EndereoIO1: TMenuItem;
    menuATMEGA8: TMenuItem;
    GroupBox2: TGroupBox;
    CheckboxFuse7h: TCheckBox;
    CheckboxFuse6h: TCheckBox;
    CheckboxFuse5h: TCheckBox;
    CheckboxFuse4h: TCheckBox;
    CheckboxFuse3h: TCheckBox;
    CheckboxFuse2h: TCheckBox;
    CheckboxFuse1h: TCheckBox;
    CheckboxFuse0h: TCheckBox;
    CheckboxFuse7l: TCheckBox;
    CheckboxFuse6l: TCheckBox;
    CheckboxFuse5l: TCheckBox;
    CheckboxFuse4l: TCheckBox;
    CheckboxFuse3l: TCheckBox;
    CheckboxFuse2l: TCheckBox;
    CheckboxFuse1l: TCheckBox;
    CheckboxFuse0l: TCheckBox;
    BitBtn1: TBitBtn;
    BitBtn4: TBitBtn;
    ComboBox1: TComboBox;
    Gauge1: TGauge;
    BitBtn10: TBitBtn;
    GroupBox5: TGroupBox;
    BitBtn5: TBitBtn;
    CheckBoxLock5: TCheckBox;
    CheckBoxLock4: TCheckBox;
    CheckBoxLock2: TCheckBox;
    CheckBoxLock3: TCheckBox;
    CheckBoxLock0: TCheckBox;
    CheckBoxLock1: TCheckBox;
    BitBtn6: TBitBtn;
    BitBtnCancela: TBitBtn;
    Timer1: TTimer;
    BotGrava: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    menuRapida: TMenuItem;
    BitBtn11: TBitBtn;
    GroupBox6: TGroupBox;
    BitBtn12: TBitBtn;
    BitBtn13: TBitBtn;
    CheckBoxFuse891: TCheckBox;
    CheckBoxFuse892: TCheckBox;
    CheckBoxFuse893: TCheckBox;
    CheckBoxFuse894: TCheckBox;
    Label2: TLabel;

    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BotGravaClick(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtn7Click(Sender: TObject);
    procedure BitBtn8Click(Sender: TObject);
    procedure BitBtn9Click(Sender: TObject);
    procedure menuAT89S8252Click(Sender: TObject);
    procedure menuAT89S53Click(Sender: TObject);
    procedure menuAT89S52Click(Sender: TObject);
    procedure menuAT89S51Click(Sender: TObject);
    procedure menuNormalClick(Sender: TObject);
    procedure menuDiferencialClick(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn10Click(Sender: TObject);
    procedure Gravao2Click(Sender: TObject);
    procedure Sore1Click(Sender: TObject);
    procedure menuAT89S8253Click(Sender: TObject);
    procedure RadioButtonClick(Sender: TObject);
    procedure Esquema1Click(Sender: TObject);
    procedure HEXBIN1Click(Sender: TObject);
    procedure BINHEX1Click(Sender: TObject);
    procedure EditorHEX1Click(Sender: TObject);
    procedure EndereoIO1Click(Sender: TObject);
    procedure menuATMEGA8Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn6Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure BitBtnCancelaClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure Timer1Timer(Sender: TObject);
    procedure menuRapidaClick(Sender: TObject);
    procedure BitBtn11Click(Sender: TObject);
    procedure BitBtn12Click(Sender: TObject);
    procedure BitBtn13Click(Sender: TObject);
  private
    { Private declarations }
    function LeHEXouBIN(arquivo: string; var pbuf: vetorbyte) : integer;
    function ReadSignature: boolean;
    function VerificaCom: boolean;
    function  Diminuivelo : boolean;
    procedure ClockDown;
    procedure ClockUp;
    function  SPI(dado: byte): byte;
    procedure ProgramEnable;
    procedure ProgramEnd;
    function  LeByte(mem: integer): byte;
    procedure GravaByte(mem: integer; dado: byte);
    procedure DesabilitaMenusAVR;
    procedure HabilitaMenusAVR;
    procedure HabilitaMenus89S;
    procedure HabilitaMenuFuse89S;
    procedure DesabilitaMenus89S;
    procedure DesabilitaMenuFuse89S;
    procedure TemEEprom;
    procedure NaoTemEEprom;
    procedure DesmarcaTodosChips;
    procedure SelecFlashEeprom;
  public
    { Public declarations }
    arqinifile: Tinifile;
    procedure InitSerial(port:string);
    function Get_File_Size(const S: string): int64;
  end;


var
  Form1: TForm1;
  tamflash: integer;
  tameeprom:integer;
  tampagina:integer;
  modograva: byte;
  delayqt : integer;
  delaygrava: integer;
  nomearquivo: string;
  algoritmo : integer;
  delaygravaalgo: integer;
//  salvaecr: byte;
//  salvacontrolp: byte;
  mosi, sck, miso, rst: byte;
//  portapar: word;
//  portaser:string[6];

    QuantumTimerExists:boolean;
    QuantumTimerMinMicrosec:extended;
    QuantumTimer:TLargeInteger;
    QuantumTimerResolution:Int64;

    serial:TBlockSerial;
    delaygravaee:integer;
    ultimapagina:word;
    bytehigh:byte;
    abortar:boolean;



resourcestring

{$IFDEF PT-BR}
STR_NAME_PROGRAM = 'Grava Atmel';
STR_COPYRIGHT = '"GRAVA ATMEL" (porta serial) v3.2, ©2016 Rafael B. Ferrari.' +#13 + #10 + 'rafaelbf@hotmail.com';
STR_NON_SERIAL = 'Não foi possível abrir a porta serial. Escolha uma outra no menu "Porta"';
STR_LOCKREAD_OK = 'L.B. lido';
STR_LOCKWRITE_OK = 'L.B. programado';
STR_FUSEREAD_OK = 'F.B. lido';
STR_FUSEWRITE_OK = 'F.B. programado';
STR_CONCLUIDO = 'Concluído';
STR_DADOS_IGUAIS =  'Os dados são idênticos';
STR_DADOS_DIF = 'O arquivo possui diferenças.';
STR_BYTES_DIF = 'bytes diferentes';
STR_COMPARANDO = 'Comparando';
STR_PRONTO = 'Pronto';
STR_TESTECON = 'Conexão OK';
STR_UTIL_PARAMETROS = 'Utilização dos parâmetros:';
STR_AGUARDE = 'aguarde...';
STR_ERRO_GRAVA = 'Erro de gravação';
STR_MAX_EEPROM = 'Tamanho do arquivo ultrapassa a capacidade da eeprom do chip.';
STR_GRAVANDO = 'Gravando';
STR_MAX_FLASH = 'Tamanho do arquivo ultrapassa a capacidade da flash do chip.';
STR_MEM_APAGADA = 'Memória apagada!';
STR_LENDO = 'Lendo';
STR_MEM_APAGANDO = 'Apagando memória...';
STR_VERIFIGRAVA = 'Gravando e Verificando';
STR_DE = 'de';
STR_FILTER_HEXBIN = 'Arquivos .BIN|*.bin|Arquivos .HEX|*.hex';
STR_FILTER_BIN = 'Arquivos .BIN|*.bin';
STR_FILTER_HEX = 'Arquivos .HEX|*.hex';
STR_CHIP = 'chip';
STR_ARQUIVO = 'arquivo';
STR_SCHEMATIC = 'esquema de ligação';
STR_SCHTIP = 'Alimentar o circuito com 5V'+#13+#10+'Usar capacitor de 100uF entre 5V e terra'+#13+#10+'Confira no datasheet os pinos correspondentes para o Atmega';
STR_CHIP_DESC = 'CHIP = s8252, s8253, s53, s52, s51 ou atmega8';
STR_ARQUIVO_DESC = 'ARQUIVO = Arquivo a ser gravado. (A gravação será iniciada automaticamente)';
STR_INSERTMODE = 'Modo INSERT';
STR_READONLY = 'Somente leitura';
STR_EDITOR = 'Editor HEX';
STR_BOT_GRAVA = 'Gravar';
STR_BOT_LER = 'Ler';
STR_BOT_COMPARAR = 'Comparar';
STR_BOT_APAGAR = 'Apagar';
STR_BOT_LOCK = 'Gravar';
STR_BOT_SAIR = 'Sair';
STR_BOT_RESET = 'Reset';
STR_BOT_AJUDA = 'Ajuda';
STR_BOT_CANCEL = 'Interromper gravação/verificação';
STR_BOT_TESTAR = 'Testar conexão';
STR_MENU_CHIP = 'Chip';
STR_MENU_GRAVACAO = 'Gravação';
STR_MENU_FERRAMENTAS = 'Ferramentas';
STR_MENU_AJUDA = 'Ajuda';
STR_MENU_PORTA = 'Porta';
STR_MENU_FILE = 'Arquivo';
STR_SUBMENU_OPEN = 'Abrir...';
STR_SUBMENU_SAVE = 'Salvar';
STR_SUBMENU_SAVEAS = 'Salvar como...';
STR_SUBMENU_EXIT = 'Sair';
STR_SUBMENU_NORMAL = 'Normal';
STR_SUBMENU_DIFERENCIAL = 'Diferencial';
STR_SUBMENU_FAST = 'Rápida';
STR_SUBMENU_CONVHEXBIN = 'Converter HEX -> BIN';
STR_SUBMENU_CONVBINHEX = 'Converter BIN -> HEX';
STR_SUBMENU_EDITHEX = 'Editor hexadecimal';
STR_SUBMENU_ESQUEMA = 'Esquema';
STR_SUBMENU_GRAVACAO = 'Gravação';
STR_SUBMENU_SOBRE = 'Sobre...';
STR_SUBMENU_CHOOSEPORT = 'Selecionar porta serial';
STR_MSG_INFORMATION = 'Informação';
STR_ERR_COM = 'Erro de comunicação';
STR_MSG_TYPE_EXCLAMATION = 'Aviso';
STR_MSG_TYPE_ERROR = 'Erro';
STR_MSG_FILETOOBIG = 'Arquivo muito grande para ser carregado';
STR_MSG_RESET = 'Pulse a chave RESET do microcontrolador e pressione OK';
STR_MSG_CHOOSEPORT = 'Escolha ou digite a porta serial conectada no gravador';

STR_TXT_HELP = ''+#13+#10
+'Gravador ISP para microcontroladores da família Atmel 89S e Atmega8, Atmega8515 e Atmega8535'+#13+#10
+''+#13+#10
+''+#13+#10
+'-GRAVAÇÃO-'+#13+#10
+'Modo Normal: O arquivo é byte a byte gravado e verificado no chip, se ocorre algum erro na gravação o programa tenta'+#13+#10
+'corrigir gravando o byte novamente com velocidade de comunicação mais baixa.'+#13+#10
+'Modo Diferencial: O arquivo é comprado com os dados gravados no chip, depois é feita a gravação apenas dos bytes'+#13+#10
+'diferentes. (OBS: Modo disponível apenas para AT89S8252/S53).'+#13+#10
+'Modo Rápido: Igual ao Modo Normal, mas somente os primeiros 15 bytes são verificados se foram gravados corretamente.'+#13+#10
+''+#13+#10
+'-LOCK BITS (89S)-'+#13+#10
+'1: Desabilita o uso de instruções MOVC executadas em memória externa para ler bytes da memória interna, e desabilita'+#13+#10
+'gravação da memória interna.'+#13+#10
+'2: Igual ao 1, e também desabilita a leitura da memória de programa interna.'+#13+#10
+'3: Igual ao 2, e também desabilita a execução de programas em memória externa.'+#13+#10
+'- Depois que algum Lock Bit foi ativado, o único modo de destravar é limpando a memória.'+#13+#10
+'- Em alguns microcontroladores é necessário desligar e ligar a alimentação após limpar os lock bits.'+#13+#10
+''+#13+#10
+'-LOCK BITS (AVR)-'+#13+#10
+'Quando um lockbit está selecionado, significa que ele está programado (está em zero).'+#13+#10
+'Cuidado para não ativar algum lockbit que desabilita a comunicação ISP.'+#13+#10
+''+#13+#10
+'-FUSE BITS (AVR)-'+#13+#10
+'Quando um fusebit está selecionado, significa que ele está programado (está em zero).'+#13+#10
+'Os fusebits não são limpos pelo botão de apagar memória.'+#13+#10
+''+#13+#10
+'-LIMPAR MEMÓRIA-'+#13+#10
+'Todas as memórias internas (flash, eeprom) e os Lock Bits serão apagados.'+#13+#10
+''+#13+#10
+'-PARÂMETROS-'+#13+#10
+'A utilização dos parâmetros possibilita chamar o Grava a partir de outros programas.'+#13+#10
+'O programa aceita dois parâmetros para gravar a memória de programa pela linha de comando:'+#13+#10
+'1: Informa o tipo do chip a ser gravado. Os valores podem ser: s8252, s8253, s51, s52, s53 ou atmega8.'+#13+#10
+'2: Informa o nome do arquivo a ser gravado. O programa iniciará a gravação do arquivo imediatamente.'+#13+#10
+'Ex: Grava.exe s53 arquivo.bin'+#13+#10
+''+#13+#10
+'-FERRAMENTAS-'+#13+#10
+'Conversor de arquivos entre os formatos HEX (Intel-HEX com endereçamento 16bits) e BIN (arquivo binário).'+#13+#10
+'Editor hexadecimal para arquivos. Permite fazer a edição de bytes nos arquivos, geralmente no formato .BIN.'+#13+#10
+''+#13+#10
+'** OBS **'+#13+#10
+'Deixe a chave de Reset aberta (1) para o microcontrolador ficar no modo de gravação, e fechada (0) para ele executar o programa gravado.'+#13+#10
+'No caso dos AVR é o contrário: Reset fechada (0) para o microcontrolador ficar no modo de gravação, e aberta (1) para ele executar o programa gravado.'+#13+#10
+'Pulsar a chave de Reset do microcontrolador se ele não iniciar a gravação/leitura e tentar novamente.'+#13+#10
+'Verifique se o cristal esta oscilando e se a alimentação está estável, com capacitores para filtrar os 5V.'+#13+#10
+'No caso do Atmega8/85X5 que vem de fábrica com o oscilador interno ligado, não é necessário cristal.'+#13+#10
+''+#13+#10
+'* AT89S8253 e ATMEGA8/85X5 *'+#13+#10
+'Na gravação da memória Flash, a memória EEprom também será apagada.'+#13+#10
+'';


{$ELSE}
STR_NAME_PROGRAM = 'Atmel Write';
STR_COPYRIGHT = '"GRAVA ATMEL" (Atmel Write) (serial port) v3.2, ©2016 Rafael B. Ferrari.' +#13 + #10 + 'rafaelbf@hotmail.com';
STR_NON_SERIAL = 'Cannot open serial port. Use the "port" menu to choose another';
STR_LOCKREAD_OK = 'L.B. read';
STR_LOCKWRITE_OK = 'L.B. programmed';
STR_FUSEREAD_OK = 'F.B. read';
STR_FUSEWRITE_OK = 'F.B. programmed';
STR_CONCLUIDO = 'Done';
STR_DADOS_IGUAIS =  'Identical data';
STR_DADOS_DIF = 'Devergence in data';
STR_BYTES_DIF = 'different bytes';
STR_COMPARANDO = 'Verifying';
STR_PRONTO = 'Ready';
STR_TESTECON = 'Connection OK';
STR_UTIL_PARAMETROS = 'Parameters utilization:';
STR_AGUARDE = 'wait...';
STR_ERRO_GRAVA = 'Write error';
STR_MAX_EEPROM = 'File size exceeds eeprom capacity';
STR_GRAVANDO = 'Writing';
STR_MAX_FLASH = 'File size exceeds Flash capacity';
STR_MEM_APAGADA = 'Erased';
STR_LENDO = 'Reading';
STR_MEM_APAGANDO = 'Erasing memory...';
STR_VERIFIGRAVA = 'Writing and verifying';
STR_DE = 'of';
STR_FILTER_HEXBIN = '.BIN files|*.bin|.HEX files|*.hex';
STR_FILTER_BIN = '.BIN files|*.bin';
STR_FILTER_HEX = '.HEX files|*.hex';
STR_CHIP = 'chip';
STR_ARQUIVO = 'file';
STR_SCHEMATIC = 'schematic';
STR_SCHTIP = 'Power the circuit with 5V regulated supply'+#13+#10+'Use 100uF capacitor between 5V and ground'+#13+#10+'Check the datasheet for corresponding pins of Atmega';
STR_CHIP_DESC = 'CHIP = s8252, s8253, s53, s52, s51 or atmega8';
STR_ARQUIVO_DESC = 'FILE = File to be written. (writting will auto-start)';
STR_INSERTMODE = 'INSERT mode';
STR_READONLY = 'Read-only mode';
STR_EDITOR = 'HEX Editor';
STR_BOT_GRAVA = 'Write';
STR_BOT_LER = 'Read';
STR_BOT_COMPARAR = 'Compare';
STR_BOT_APAGAR = 'Erase';
STR_BOT_LOCK = 'Program';
STR_BOT_SAIR = 'Exit';
STR_BOT_RESET = 'Reset';
STR_BOT_AJUDA = 'Help';
STR_BOT_CANCEL = 'Reding/Writing interrupt';
STR_BOT_TESTAR = 'Connection check';
STR_MENU_CHIP = 'Chip';
STR_MENU_GRAVACAO = 'Write Mode';
STR_MENU_FERRAMENTAS = 'Tools';
STR_MENU_AJUDA = 'Help';
STR_MENU_PORTA = 'Port';
STR_MENU_FILE = 'File';
STR_SUBMENU_OPEN = 'Open...';
STR_SUBMENU_SAVE = 'Save';
STR_SUBMENU_SAVEAS = 'Save as...';
STR_SUBMENU_EXIT = 'Exit';
STR_SUBMENU_NORMAL = 'Normal';
STR_SUBMENU_DIFERENCIAL = 'Diferential';
STR_SUBMENU_FAST = 'Fast';
STR_SUBMENU_CONVHEXBIN = 'HEX -> BIN converter';
STR_SUBMENU_CONVBINHEX = 'BIN -> HEX converter';
STR_SUBMENU_EDITHEX = 'Hex editor';
STR_SUBMENU_ESQUEMA = 'Schematic';
STR_SUBMENU_GRAVACAO = 'Help';
STR_SUBMENU_SOBRE = 'About...';
STR_SUBMENU_CHOOSEPORT = 'Choose serial port';
STR_MSG_INFORMATION = 'Information';
STR_ERR_COM = 'Communication error';
STR_MSG_TYPE_EXCLAMATION = 'Warning';
STR_MSG_TYPE_ERROR = 'Error';
STR_MSG_FILETOOBIG = 'File size too big';
STR_MSG_RESET = 'Pulse microcontroller reset swith and press OK';
STR_MSG_CHOOSEPORT = 'Choose the serial port connected to the programmer';

STR_TXT_HELP = ''+#13+#10
+'ISP programmer for Atmel microcontrollers: 89S, Atmega8, Atmega8515 and Atmega8535'+#13+#10
+''+#13+#10
+''+#13+#10
+'-WRITE MODE-'+#13+#10
+'Normal mode: The file is written and verified byte to byte, if one error occurs the program tries to'+#13+#10
+'write again in low speed.'+#13+#10
+'Differential mode: The file is compared with already programmed chip and only modified bytes are written'+#13+#10
+'(Only for AT89S8252/S53).'+#13+#10
+'Fast mode: Like Normal Node, but only first 15 bytes written are checked against errors.'+#13+#10
+''+#13+#10
+'-LOCK BITS (89S)-'+#13+#10
+'1: Disables MOVC instructions from external memory to read bytes from internal memory, and disables'+#13+#10
+'internal memory writing.'+#13+#10
+'2: Same as 1, and disables internal program memory read.'+#13+#10
+'3: Same as 2, and disables execution from external memory program.'+#13+#10
+'- After a Lock Bit activated, the only way to deactivate them is cleaning memory.'+#13+#10
+''+#13+#10
+'-LOCK BITS (AVR)-'+#13+#10
+'When a lockbit is selected, means activated (is zero).'+#13+#10
+'Caution; don''t activate an lockbit that disables ISP programming.'+#13+#10
+''+#13+#10
+'-FUSE BITS (AVR)-'+#13+#10
+'When a fusebit is selected, means activated (is zero).'+#13+#10
+'The fusebits are not affected by a memory erase.'+#13+#10
+''+#13+#10
+'-MEMORY ERASE-'+#13+#10
+'All internal memories (flash, eeprom) and Lockbits are erased.'+#13+#10
+''+#13+#10
+'-PARAMETERS-'+#13+#10
+'With Program Parameters you can "call" the programmer from another program.'+#13+#10
+'Use two parameters:'+#13+#10
+'1: Type of chip. The values can be: s8252, s8253, s51, s52, s53 or atmega8.'+#13+#10
+'2: File name to be written. The programming process will begin automatically.'+#13+#10
+'Ex: AtmelWrite.exe s53 file.bin'+#13+#10
+''+#13+#10
+'-TOOLS-'+#13+#10
+'File converter for .HEX (Intel-HEX with 16bits address) and .BIN (binary file) file types.'+#13+#10
+'Hexadecimal file editor. Edit .BIN files.'+#13+#10
+''+#13+#10
+'** PROGRAMMING **'+#13+#10
+'Leave reset switch open (1) to microcontroller enter in Programming Mode, and closed (0) for normal microcontroller operation (RUN).'+#13+#10
+'AVR microcontroller''s Reset is swapped: Reset key closed (0) for Programming Mode, and open (1) for normal operation.'+#13+#10
+'Pulse Reset Switch from microcontroller if failed programming/reading and try again.'+#13+#10
+'Verify if the oscillator crystal is working.'+#13+#10
+'The Atmega8/85X5 comes from factory with internal oscillator enabled. Crystal is not necessary.'+#13+#10
+''+#13+#10
+'* AT89S8253 and ATMEGA8/85X5 *'+#13+#10
+'In flash memory programming, the eeprom will also be erased.'+#13+#10
+'';

{$ENDIF}

const

// definicao dos algoritmos de programacao
      ALG_EE_8252 = 1;  // eeprom do 8252
      ALG_FL_8252 = 2;  // flash do 8252, 53
      ALG_FL_51 = 3;    // flash do 51, 52
      ALG_EE_8253 = 4;  // eeprom do 8253
      ALG_FL_8253 = 5;  // flash do 8253
      ALG_EE_ATMEGA8 = 6;  // eeprom do atmega8
      ALG_FL_ATMEGA8 = 7;  // flash do atmega8


      delayqtinitial = 5; // 1uS
      delayqtmax = 20000; // 20ms

//const DataP = $378;
//const DataP = portapar;
//      StatusP = DataP + 1;
//      ControlP = DataP + 2;
//      ECR = DataP + $402;

//const
//  portastatus = 1;
//  portacontrol = 2;
//  portaecr = $402;


{$R Vista.RES} 

implementation



uses UAjuda, uEsquema, uEditHex, UEndIO;

{$R *.dfm}


//procedure DelayQTinit;
//begin
//if QueryPerformanceFrequency(QuantumTimer) then
// begin
//     QuantumTimerResolution:=QuantumTimer;
//     QuantumTimerMinMicrosec:=1000000/QuantumTimer;
//     QuantumTimerExists:=true;
// end;
//
//end;


procedure DelayQTus(microsec:extended);
var
//Start,Actual:TLargeInteger;
//Elapsed:Extended;
//const DelayTooLow='Delay too low.'#13#10'Min allowed %s microsec';
timeDelta:int64;
timeStart:int64;
timeToWait:extended;
timeEllapsed:int64;
begin


//  if microsec<QuantumTimerMinMicrosec then
//     raise Exception.Create(Format(DelayTooLow,[FloatToStrF(1000000/QuantumTimerResolution,ffFixed,3,2)]));
//  QueryPerformanceCounter(Start);
//  microsec:=microsec/1000000;
//  repeat
//    QueryPerformanceCounter(Actual);
//    Elapsed:=(Actual-Start)/QuantumTimerResolution;
//  until Elapsed>microsec;


  QueryPerformanceFrequency( timeDelta );
  timeToWait := ((timeDelta * microsec) / 1000000);  // dividir 1000 fica em milisegundos, por 1 eh em segundos
  QueryPerformanceCounter ( timeStart );
  timeEllapsed := timeStart;

  while ( ( timeEllapsed - timeStart ) < timeToWait ) do
    QueryPerformanceCounter( timeEllapsed );


end;


procedure DelayQTms(microsec:extended);
var
timeDelta:int64;
timeStart:int64;
timeToWait:extended;
timeEllapsed:int64;
begin

  QueryPerformanceFrequency( timeDelta );
  timeToWait := ((timeDelta * microsec) / 1000);  // dividir 1000 fica em milisegundos, por 1 eh em segundos
  QueryPerformanceCounter ( timeStart );
  timeEllapsed := timeStart;

  while ( ( timeEllapsed - timeStart ) < timeToWait ) do
    QueryPerformanceCounter( timeEllapsed );

end;




procedure TForm1.InitSerial(port:string);
begin
  serial.free;
  serial:=TBlockserial.Create;
  try
    serial.Connect(port);
    serial.Config(115200,8,'N',0,false,false);
    serial.EnableRTSToggle(false);
//    serial.
    statusbar1.Panels[2].Text := port;
  except
    messagebox(application.DialogHandle,PansiChar(STR_NON_SERIAL),PansiChar(STR_NAME_PROGRAM),MB_OK + MB_ICONERROR);
    serial.free;
    serial := nil;
  end;
end;


// Le um arquivo binario. Se for hexadecimal faz a conversao antes de colocar no buffer
function TForm1.LeHEXouBIN(arquivo: string; var pbuf: vetorbyte) : integer;
 var arqhex : ThexFile;
 conta : integer;
 f: file;
 buf: byte;
 ultimoend: integer;
begin

      if (form1.Get_File_Size(OpenDialog1.FileName) > (10000000)) then  // maior q 10M // protecao para nao acabar com a memoria
      begin
          MessageBox(form1.Handle,PAnsiChar(STR_MSG_FILETOOBIG),PAnsiChar(STR_MSG_TYPE_ERROR),MB_OK + MB_ICONERROR + MB_APPLMODAL);
          result := 0;
          exit;
      end;


      if (LowerCase( extractfileext(arquivo) ) = '.hex') then
      begin
        arqhex := THexFile.Create(self);
        try
          arqhex.UnusedBytes := $FF;
          arqhex.LoadHexFile(arquivo);
          arqhex.DataSize := 65534;
          arqhex.Update;
          SetLength(pbuf,65534);
          ultimoend:=0;
          for conta:=  0 to arqhex.datasize - 1 do
          begin
            pbuf[conta] := arqhex.DataBin[conta];
            if (arqhex.DataUsed[conta]) then
              ultimoend := conta;
          end;
          inc(ultimoend);
          LeHEXouBIN := ultimoend;
        finally
          arqhex.Free;
        end;
      end
      else       // eh um arquivo BIN
      begin
        assignfile(f,arquivo);
        try
          Reset(f,1);
          LeHEXouBIN:=filesize(f);
          if (filesize(f) > 65536) then
          begin
            LeHEXouBIN := 65536;
            SetLength(pbuf,65536);
          end
          else
            SetLength(pbuf,filesize(f));
          conta :=0;
          while (not eof(f)) do
          begin
            blockread(f,buf,1);
            pbuf[conta] := buf;
            inc(conta);
          end;
          finally
            closefile(f);
          end;
      end;

end;


function TForm1.Get_File_Size(const S: string): int64;
var
  Find: THandle;
  Data: TWin32FindData;
begin
  Result := -1;
  Find := FindFirstFile(PChar(S), Data);
  if (Find <> INVALID_HANDLE_VALUE) then
  begin
//    result:=0;
    Result := Data.nFileSizeHigh;
    result := result shl 32;
    Result  := result or Data.nFileSizeLow;
    Windows.FindClose(Find);
  end;
end;


// Diminui a velocidade de gravacao.
function TForm1.Diminuivelo : boolean;
var ret: boolean;
// calculo: single;
begin
    ret := true;
    if (delayqt = delayqtinitial) then delayqt := ((delayqtmax div 10000) + delayqtinitial)
    else if (delayqt = ((delayqtmax div 10000) + delayqtinitial)) then delayqt := ((delayqtmax div 1000) + delayqtinitial)
    else if (delayqt = ((delayqtmax div 1000) + delayqtinitial)) then delayqt := ((delayqtmax div 100) + delayqtinitial)
    else if (delayqt = ((delayqtmax div 100) + delayqtinitial)) then delayqt := ((delayqtmax div 10) + delayqtinitial)
    else if (delayqt = ((delayqtmax div 10) + delayqtinitial)) then delayqt := delayqtmax;
    if (delayqt = delayqtmax) then ret := false;
//    calculo := (delayqt / delayqtmax);
//    calculo := calculo * 100;
//    ProgressBar1.Position := trunc(calculo);
//ProgressBar1.Position := ProgressBar1.Position - 20;
delaygrava := delaygrava + 3;
    Application.ProcessMessages;
//    else sleep(300);
    Diminuivelo := ret;
end;

// Pino CLK em nivel 0
procedure TForm1.ClockDown;
begin

//        DLPortIO1.Port[portapar + portacontrol] := DLPortIO1.Port[portapar + portacontrol] or 2;
      serial.RTS := true;
        DelayQTus(delayqt);
//sleep(50);
end;

// Pino CLK em nivel 1
procedure TForm1.ClockUp;
begin

//        DLPortIO1.Port[portapar + portacontrol] := DLPortIO1.Port[portapar + portacontrol]and $fd;
    serial.RTS := false;
        DelayQTus(delayqt);
//sleep(50);
end;

// Algoritmo de programacao serial sincrona, SPI. Le e escreve um byte serialmente
function TForm1.SPI(dado: byte): byte;
   var conta,bit,valor: byte;
begin
valor:=0;

//      temp := DLPortIO1.Port[portapar + portacontrol];
for conta := 7 downto 0 do begin
   if ((dado and $80) <> 0) then begin
//      temp := temp and $FE;
//      DLPortIO1.Port[portapar + portacontrol] := temp;
      serial.DTR := false;  // pino mosi
   end
   else begin
//      temp := temp or 1;
//      DLPortIO1.Port[portapar + portacontrol] := temp;
      serial.DTR := true;
   end;

      ClockUp;
//      bit := DLPortIO1.Port[portapar + portastatus] and $80;
//      if  not(serial.CTS) then bit:=1
//      else bit:=0;
//      if bit = 0 then bit:=1 else bit:=0;

//(algoritmo = ALG_EE_ATMEGA8) or (algoritmo = ALG_FL_ATMEGA8)

//      ClockDown;

      if  not(serial.CTS) then bit:=1  // le pino MISO
      else bit:=0;
      valor := valor shl 1;
      valor := valor or bit;

      ClockDown;

      dado := dado shl 1;

end; // for
SPI := valor;
end;


procedure TForm1.ProgramEnable;
// var temp: byte;
var  //    salvadelayqt : integer;
temp2: byte;
begin
//salvadelayqt := delayqt;
//delayqt := 180;
//   DLPortIO1.Port[ControlP] := 3;
//delayqt := 720;
//DLPortIO1.Port[portapar + portacontrol] := DLPortIO1.Port[portapar + portacontrol] or 3;      // sck/mosi em nivel baixo
//DLPortIO1.Port[portapar + portacontrol] := DLPortIO1.Port[portapar + portacontrol] and $f7;   // pino reset em nivel alto

serial.DTR := false; // mosi em alto
serial.RTS := true; // SCK em baixo

sleep(100);
//   showmessage(inttostr(SPI($ac)));
//   showmessage(inttostr(SPI($53)));
   SPI($ac);
   SPI($53);
   temp2:=SPI($0);
   if ((algoritmo = ALG_FL_51) or (algoritmo = ALG_EE_8253) or (algoritmo = ALG_FL_8253) or (algoritmo = ALG_EE_ATMEGA8) or (algoritmo = ALG_FL_ATMEGA8) ) then SPI($0);
sleep(70);

//showmessage('init:'+inttostr(temp2));

//delayqt := salvadelayqt;
end;

procedure TForm1.ProgramEnd;
// var temp: byte;
//var      salvadelayqt : integer;
begin
//salvadelayqt := delayqt;
//delayqt := 180;
//   sleep(50);
//   DLPortIO1.Port[ControlP] := 8;
//DLPortIO1.Port[portapar + portacontrol] := DLPortIO1.Port[portapar + portacontrol] or 8;      // pino reset em nivel baixo
//DLPortIO1.Port[portapar + portacontrol] := DLPortIO1.Port[portapar + portacontrol] and $fc;   // sck/mosi em nivel alto

//delayqt:=720;

//   SPI($ff);
//   SPI($ff);
//   SPI($ff);
//   SPI($ff);
//   SPI($0);
//   SPI($0);
//   SPI($0);
//   SPI($0);



serial.DTR := false; // mosi em alto
serial.RTS := true; // SCK em baixo

   sleep(70);
//delayqt := salvadelayqt;
end;



function TForm1.ReadSignature: boolean;
// var temp: byte;
var //     salvadelayqt : integer;
temp2: byte;
begin
//salvadelayqt := delayqt;


//sleep(50);

if ((algoritmo = ALG_FL_8252) or (algoritmo = ALG_EE_8252)) then // o s53 e s8252 nao tem funcao ReadSignature
begin
  ReadSignature:=true;
  exit;
end;


   if ((algoritmo = ALG_EE_ATMEGA8) or (algoritmo = ALG_FL_ATMEGA8)) then SPI($30)
   else
   SPI($28);

   if ((algoritmo = ALG_EE_8253) or (algoritmo = ALG_FL_8253)) then SPI($0);
   if ((algoritmo = ALG_EE_8253) or (algoritmo = ALG_FL_8253)) then SPI($30);
   if ((algoritmo = ALG_FL_51) or (algoritmo = ALG_EE_ATMEGA8) or (algoritmo = ALG_FL_ATMEGA8))  then SPI($0);
   if ((algoritmo = ALG_FL_51) or (algoritmo = ALG_EE_ATMEGA8) or (algoritmo = ALG_FL_ATMEGA8)) then SPI($0);

   temp2:=SPI($0);

   if (temp2=$1E) then ReadSignature:=true
   else ReadSignature:=false;

sleep(70);

//showmessage('signature:'+inttostr(temp2));

//delayqt := salvadelayqt;
end;


function TForm1.VerificaCom: boolean;
 var retorno: boolean;
begin

    retorno:=false;


            // verificacao da comunicacao, eu tento ler os signature bits
            if not (ReadSignature) then
            begin
              while(Diminuivelo) do
              begin
                if (ReadSignature) then
                begin
                  retorno:=true;
                  break;
                 end
              end;
            end
            else
              retorno:=true;

    if not (retorno) then
    begin
          statusbar1.Panels[0].Text := STR_ERR_COM;
          ProgramEnd;
          delayqt := delayqtinitial;
//          ProgressBar1.Position := ProgressBar1.Max;
    end;
VerificaCom:=retorno;
end;



function TForm1.LeByte(mem: integer): byte;
var alto,alto2,baixo : byte;
begin
LeByte := 0;

if (algoritmo = ALG_EE_8252) then
begin
    baixo:=mem mod 256;
    alto:=mem div 256;
    alto:=alto shl 3;
    alto:=alto and $38;
    alto:=alto or 5;
    SPI(alto);
    SPI(baixo);
    LeByte := SPI(0);
end
else if (algoritmo = ALG_FL_8252) then
begin
   baixo := mem mod 256;
   alto := mem div 256;
   alto2 := alto;
   alto := alto shl 3;
   alto2 := alto2 shr 3;
   alto := alto and $f8;        // zera os tres bits lsb
   alto := alto or 1;           // seta bit 1
   alto2 := alto2 and 4;           // isola bit 3, que corresponde ao A13 depois do 'shr'
   alto := alto or alto2;
   SPI(alto);
   SPI(baixo);
   LeByte := SPI(0);
end
else if ((algoritmo = ALG_FL_51) or (algoritmo = ALG_FL_8253)) then
begin
   baixo := mem mod 256;
   alto := mem div 256;
//   alto := alto and $1F;
   alto := alto and $3F; // para gravar tambem o 89S8253
   SPI($20);
   SPI(alto);
   SPI(baixo);
   LeByte := SPI(0);
end

else if (algoritmo = ALG_EE_8253) then
begin
   baixo := mem mod 256;
   alto := mem div 256;
   alto := alto and $07;
   SPI($A0);
   SPI(alto);
   SPI(baixo);
   LeByte := SPI(0);
end
else if (algoritmo = ALG_FL_ATMEGA8) then
begin

   baixo := mem mod 256;
   alto2 := baixo and 1;  // byte high ou byte low do word
   alto2:=alto2 shl 3;
   mem := mem div 2;

   baixo := mem mod 256;
   alto := mem div 256;
   SPI($20 or alto2);
   SPI(alto and $0F);
   SPI(baixo);
   LeByte := SPI(0);
end
else if (algoritmo = ALG_EE_ATMEGA8) then
begin
   baixo := mem mod 256;
   alto := mem div 256;
   SPI($A0);
   SPI(alto and 1);
   SPI(baixo);
   LeByte := SPI(0);
end;


end;

procedure TForm1.GravaByte(mem: integer; dado: byte);
var alto,alto2,baixo : byte;
 pagina: integer;
begin

if (algoritmo = ALG_EE_8252) then
begin
    baixo:=mem mod 256;
    alto:=mem div 256;
    alto:=alto shl 3;
    alto:=alto and $38;
    alto:=alto or 6;
    SPI(alto);
    SPI(baixo);
    SPI(dado);
//    sleep(delaygrava);
    delayqtms(delaygrava);
end
else if (algoritmo = ALG_FL_8252) then
begin
   baixo:=mem mod 256;
   alto:=mem div 256;
   alto2 := alto;
   alto:=alto shl 3;
   alto2 := alto2 shr 3;
   alto:=alto and $f8;
   alto:=alto or 2;
   alto2 := alto2 and 4;
   alto := alto or alto2;
   SPI(alto);
   SPI(baixo);
   SPI(dado);
//   sleep(delaygrava);
   delayqtms(delaygrava);
end
else if ((algoritmo = ALG_FL_51) or (algoritmo = ALG_FL_8253)) then
begin
   baixo := mem mod 256;
   alto := mem div 256;
   alto := alto and $3F;
   SPI($40);
   SPI(alto);
   SPI(baixo);
   SPI(dado);
//   sleep(delaygrava);
    delayqtms(delaygrava);
end
else if (algoritmo = ALG_EE_8253) then
begin
   baixo := mem mod 256;
   alto := mem div 256;
   alto := alto and $07;
   SPI($C0);
   SPI(alto);
   SPI(baixo);
   SPI(dado);
//   sleep(delaygrava);
  delayqtms(delaygrava);
end
else if (algoritmo = ALG_FL_ATMEGA8) then
begin

   baixo := mem mod 256;
   alto2 := baixo and 1;  // byte high ou byte low do word
   alto2:=alto2 shl 3;
   mem := mem div 2;

   pagina := mem and $FE0;
   if (pagina <> ultimapagina) then
   begin              // grava pagina, escreve o endereco da pagina
    baixo := ultimapagina mod 256;
    alto := ultimapagina div 256;
    SPI($4c);
    SPI(alto and $0F);
    SPI(baixo and $E0);
    SPI(0);
    delayqtms(delaygrava);
   end;
   // carrega dados na pagina

{
   if (alto2=0) then  // primeiro chega o bite high, eu guardo ele, pois vou gravar o low primeiro
   begin
    bytehigh:=dado;
   end
   else   // agora eu gravo os 2 bytes, o low primeiro
   begin

   baixo := mem mod 256;
   SPI($40);
   SPI(0);
   SPI(baixo and $1F);
   SPI(dado);
   baixo := mem mod 256;
   SPI($40 or alto2);
   SPI(0);
   SPI(baixo and $1F);
   SPI(bytehigh);
}
   baixo := mem mod 256;
   SPI($40 or alto2);
   SPI(0);
   SPI(baixo and $1F);
   SPI(dado);
//   end;

   ultimapagina := mem and $FE0;

end
else if (algoritmo = ALG_EE_ATMEGA8) then
begin
   baixo := mem mod 256;
   alto := mem div 256;
   SPI($C0);
   SPI(alto and 1);
   SPI(baixo);
   SPI(dado);
  delayqtms(delaygravaee);
end


end;


procedure TForm1.SelecFlashEeprom;
begin
      if (radiobutton2.Checked = true) then   // se a opcao eeprom estiver selecionada, muda para o algoritmo de eeprom
      begin
        if (algoritmo = ALG_FL_8253) then     // se o algoritmo for do 8253, altera para o algoritmo de eeprom
          algoritmo := ALG_EE_8253
        else if (algoritmo = ALG_FL_8252) then
          algoritmo := ALG_EE_8252
        else if (algoritmo = ALG_FL_ATMEGA8) then
          algoritmo := ALG_EE_ATMEGA8;
      end
      else                                   // senao muda para o algoritmo de flash
      begin
        if (algoritmo = ALG_EE_8253) then
          algoritmo := ALG_FL_8253
        else if (algoritmo = ALG_EE_8252) then
          algoritmo := ALG_FL_8252
        else if (algoritmo = ALG_EE_ATMEGA8) then
          algoritmo := ALG_FL_ATMEGA8;
      end;
end;



procedure TForm1.DesabilitaMenusAVR;
 var conta:integer;
begin
  for conta := 0 to GroupBox2.ControlCount-1 do // desliga todos checkbox
  begin
    if (GroupBox2.Controls[conta] is TCheckBox) then TCheckBox(GroupBox2.Controls[conta]).Checked := false;
    GroupBox2.Controls[conta].Enabled := false;
  end;
//    if (GroupBox2.Controls[conta] is TCheckBox) then
//    begin
//      TCheckBox(GroupBox2.Controls[conta]).Checked := false;
//      TCheckBox(GroupBox2.Controls[conta]).enabled := false;
//    end;

  for conta := 0 to GroupBox5.ControlCount-1 do // desliga todos checkbox
  begin
    if (GroupBox5.Controls[conta] is TCheckBox) then TCheckBox(GroupBox5.Controls[conta]).Checked := false;
    GroupBox5.Controls[conta].Enabled := false;
  end;

//    if (GroupBox5.Controls[conta] is TCheckBox) then
//    begin
//      TCheckBox(GroupBox5.Controls[conta]).Checked := false;
//      TCheckBox(GroupBox5.Controls[conta]).enabled := false;
//    end;




end;

procedure TForm1.HabilitaMenusAVR;
 var conta:integer;
begin
  for conta := 0 to GroupBox2.ControlCount-1 do // liga todos checkbox
    GroupBox2.Controls[conta].Enabled:=true;
//    if (GroupBox2.Controls[conta] is TCheckBox) then
//    begin
//      TCheckBox(GroupBox2.Controls[conta]).enabled := true;
//    end;
  for conta := 0 to GroupBox5.ControlCount-1 do // liga todos checkbox
    GroupBox5.Controls[conta].Enabled:=true;
//    if (GroupBox5.Controls[conta] is TCheckBox) then
//    begin
//      TCheckBox(GroupBox5.Controls[conta]).enabled := true;
//    end;



end;


procedure TForm1.DesabilitaMenus89S;
begin
  ComboBox1.Enabled := false;
  BitBtn10.Enabled := false;
end;

procedure TForm1.HabilitaMenus89S;
begin
  ComboBox1.Enabled := true;
  BitBtn10.Enabled := true;
end;




procedure TForm1.TemEEprom;
begin
  radiobutton1.enabled := true;
  radiobutton2.Enabled := true;
  radiobutton1.Checked := true;
  radiobutton2.Checked := false;
end;
procedure TForm1.NaoTemEEprom;
begin
  radiobutton1.Checked := true;
  radiobutton2.Checked := false;
  radiobutton1.Enabled := false;
  radiobutton2.Enabled := false;
end;

procedure TForm1.DesmarcaTodosChips;
 var conta:integer;
begin
for conta:=0 to chip1.Count-1 do
  chip1.Items[conta].Checked := false; // desmarca todos itens
end;

procedure TForm1.Button2Click(Sender: TObject);
begin

self.Close;

end;

procedure TForm1.Button3Click(Sender: TObject);
begin

formAjuda.show;

end;

procedure TForm1.FormCreate(Sender: TObject);
 var tipochip: integer;
begin

//DelayQTinit;

nomearquivo := '';


arqinifile := Tinifile.create(ChangeFileExt((ParamStr(0)),'.ini'));

SetPriorityClass(GetCurrentProcess, HIGH_PRIORITY_CLASS);

//showmessage(inttostr(getpriorityclass(getcurrentprocess)));

//portapar := arqinifile.ReadInteger('CONFIG','END',$378);
//if portapar < 100 then
//  portapar := $378;

delayqt := delayqtinitial;

modograva:=0;

tipochip := arqinifile.ReadInteger('CONFIG','CHIP',0);

case tipochip of
0: menuAT89S8252.Click;
1: menuAT89S8253.Click;
2: menuAT89S53.Click;
3: menuAT89S52.Click;
4: menuAT89S51.Click;
5: menuATMEGA8.Click;
end;



{
algoritmo := ALG_FL_8252;
tamflash := 8192;
modograva:=0;
menuAT89S8252.Checked := true;
menuAT89S53.Checked := false;
menuAT89S52.Checked := false;
menuAT89S51.Checked := false;
menuNormal.Checked := true;
menuDiferencial.Checked := false;
}

//portaser := arqinifile.ReadString('CONFIG','POTA','COM1');
InitSerial(arqinifile.ReadString('CONFIG','PORTA','COM1'));


//DLPortIO1.DriverPath := ExtractFileDir(ParamStr(0));
//DLPortIO1.DLLPath := ExtractFileDir(ParamStr(0));
//DLPortIO1.OpenDriver;
//if (not DLPortIO1.ActiveHW) then
//begin
//        messagebox(application.DialogHandle,STR_NAO_PARALELA,'Grava',MB_OK + MB_ICONERROR);
//        application.Terminate;
//end
//else
//begin

//showmessage('CPU: ' + floattostr(SanosTimer1.ExactCPUSpeed) + 'Mhz');
//if sanostimer1.QuantumTimerExists then showmessage('Quantum counter: ' + floattostr(sanostimer1.QuantumTimerMinmicrosec));
//if sanostimer1.TickTimerExists then showmessage('Time Stamp counter: ' + floattostr(sanostimer1.TimeStampTimerMinmicrosec));

//salvaecr := DLPortIO1.Port[ECR];
//if (portapar <> $378) and (portapar <> $278) then
//  salvaecr := DLPortIO1.Port[portapar + portaecr];
//salvacontrolp := DLPortIO1.Port[portapar + portacontrol];

//DLPortIO1.Port[ECR] := DLPortIO1.Port[ECR] and $1F;             // Se existir porta ECP, seta o modo de compatibilidade SPP no registrador ECR
//if (portapar <> $378) and (portapar <> $278) then
//  DLPortIO1.Port[portapar + portaecr] := DLPortIO1.Port[portapar + portaecr] and $1F;             // Se existir porta ECP, seta o modo de compatibilidade SPP no registrador ECR
//DLPortIO1.Port[portapar + portacontrol] := 8;                          // deixa em nivel alto os pinos sck/mosi e deixa em 0 o pino reset

serial.DTR := true; // mosi em baixo
serial.RTS := true; // SCK em baixo

//sleep(100);

//if  not (serial.CTS) then showmessagE('CTS em 1')
//else showmessagE('CTS em 0');

//sleep(100);

// LINGUAS
bitbtn1.caption := STR_BOT_GRAVA;
Bitbtn4.caption := STR_BOT_LER;
Bitbtn6.caption := STR_BOT_LER;
Bitbtn12.caption := STR_BOT_LER;
Bitbtn4.caption := STR_BOT_LER;
BotGrava.caption := STR_BOT_GRAVA;
Bitbtn2.caption := STR_BOT_LER;
Bitbtn3.caption := STR_BOT_COMPARAR;
Bitbtn9.caption := STR_BOT_APAGAR;
bitbtn10.caption := STR_BOT_LOCK;
bitbtn13.Caption := STR_BOT_LOCK;
bitbtn1.Caption:=STR_BOT_LOCK;
bitbtn5.Caption := STR_BOT_LOCK;
bitbtn7.caption := STR_BOT_SAIR;
bitbtn11.caption := STR_BOT_TESTAR;
//bitbtn1.caption := STR_BOT_RESET;
bitbtn8.caption := STR_BOT_AJUDA;
chip1.caption := STR_MENU_CHIP;
gravao1.caption := STR_MENU_GRAVACAO;
ferramentas1.caption := STR_MENU_FERRAMENTAS;
ajuda1.caption := STR_MENU_AJUDA;
menuNormal.caption := STR_SUBMENU_NORMAL;
menuRapida.Caption := STR_SUBMENU_FAST;
menuDiferencial.caption := STR_SUBMENU_DIFERENCIAL;
hexbin1.caption := STR_SUBMENU_CONVHEXBIN;
binhex1.caption := STR_SUBMENU_CONVBINHEX;
editorhex1.caption := STR_SUBMENU_EDITHEX;
esquema1.caption := STR_SUBMENU_ESQUEMA;
gravao2.caption := STR_SUBMENU_GRAVACAO;
sore1.caption := STR_SUBMENU_SOBRE;
//label2.Caption := STR_SPEED_PORT;
statusbar1.Panels[0].Text := STR_PRONTO;
porta1.Caption := STR_MENU_PORTA;
EndereoIO1.Caption := STR_SUBMENU_CHOOSEPORT;
label1.Caption := STR_NAME_PROGRAM;
Form1.Caption := STR_NAME_PROGRAM;
BitBtnCancela.Hint := STR_BOT_CANCEL;

sleep(800);

if (paramstr(1) <> '') then
begin
if (paramstr(1) = 's8252') then self.menuAT89S8252.Click
else if (paramstr(1) = 's8253') then self.menuAT89S8253.Click
else if (paramstr(1) = 's53') then self.menuAT89S53.Click
else if (paramstr(1) = 's52') then self.menuAT89S52.Click
else if (paramstr(1) = 's51') then self.menuAT89S51.Click
else if (paramstr(1) = 'atmega8') then self.menuATMEGA8.Click
else showmessage(STR_UTIL_PARAMETROS +#13+#10+#13+#10 +  ExtractFileName(paramstr(0)) + ' [' + STR_CHIP + '] [' + STR_ARQUIVO + ']' +#13+#10+#13+#10 + '-> ' + STR_CHIP_DESC +#13+#10 + '-> ' + STR_ARQUIVO_DESC +#13+#10);
end;

    if (paramstr(2) <> '') then
        if fileexists(paramstr(2)) then
        begin
            nomearquivo := paramstr(2);
            self.Show;
             MessageBox(form1.Handle,PAnsiChar(STR_MSG_RESET),PAnsiChar(STR_MSG_TYPE_EXCLAMATION),MB_OK + MB_ICONEXCLAMATION + MB_APPLMODAL);
            self.BotGrava.Click;
        end;

//end;

//    ProgressBar1.Max := delayqtmax;
//    ProgressBar1.Position := delayqtmax;





end;



procedure TForm1.BotGravaClick(Sender: TObject);
   var
      size: integer;
      conta: integer;
      arqbuf: vetorbyte;
      gravouultimo: boolean;
      contaModoRapido:integer;
begin

    form1.SetFocus;

    gravouultimo:=false;

    if (nomearquivo = '') then
    begin
        opendialog1.filter:= STR_FILTER_HEXBIN;
        if OpenDialog1.Execute then
        begin
            nomearquivo := OpenDialog1.FileName;
        end
        else
        exit;
    end;

    if not fileexists(nomearquivo) then
    begin
        nomearquivo := '';
        exit;
    end;

      SelecFlashEeprom;

      statusbar1.Panels[0].Text := STR_AGUARDE;

      size := LeHEXouBIN(nomearquivo, arqbuf);


        statusbar1.Panels[0].Text := '';

//        if ((algoritmo = ALG_EE_8252) or (algoritmo = ALG_EE_8253) or (algoritmo = ALG_EE_ATMEGA8)) then
        if radiobutton2.Checked then // se estiver gravando eeprom, confere o tamanho maximo
        begin
            if (size > tameeprom) then
            begin
//                showmessage(STR_MAX_EEPROM);
                MessageBox(form1.Handle,PAnsiChar(STR_MAX_EEPROM),PAnsiChar(STR_MSG_TYPE_ERROR),MB_OK + MB_ICONERROR + MB_APPLMODAL);
                nomearquivo := '';
                exit;
            end;
        end
        else // tamanho maximo flash
        begin
            if (size > tamflash) then
            begin
//                showmessage(STR_MAX_FLASH);
                MessageBox(form1.Handle,PAnsiChar(STR_MAX_FLASH),PAnsiChar(STR_MSG_TYPE_ERROR),MB_OK + MB_ICONERROR + MB_APPLMODAL);
                nomearquivo := '';
                exit;
            end;
        end;


        ProgramEnable;

        if not (VerificaCom) then
        begin
//          statusbar1.Panels[0].Text := STR_ERR_COM;
//          ProgramEnd;
          nomearquivo := '';
//          delayqt := delayqtinitial;
          delaygrava := delaygravaalgo;
          exit;
        end;

        abortar:=false;

        if (modograva = 0) or (modograva = 2) then  // normal ou rapido
        begin
            gauge1.Progress := 0;
            gauge1.MaxValue := size-1;

            // eh necessario apagar a memoria do S51/S52/S8253 antes de gravar
            if ((algoritmo = ALG_FL_51) or (algoritmo = ALG_FL_8253) or (algoritmo = ALG_FL_ATMEGA8)) then
            begin
              statusbar1.Panels[0].Text := STR_MEM_APAGANDO;
              application.ProcessMessages;
              BitBtn9.Tag := 1; // nao mostrar botao de confirmacao, nao usar programenable
              bitbtn9.Click;  // chama botao apagar memoria
            end;

            if (algoritmo = ALG_FL_ATMEGA8) then
            begin
              ultimapagina:=0;
              statusbar1.Panels[0].Text := STR_GRAVANDO;
              application.ProcessMessages;
              conta := 0;
              while ((conta < size)) do
              begin
                  statusbar1.Panels[1].Text := inttostr(conta+1) + ' '+ STR_DE + ' ' + inttostr(size) + ' bytes';
                  gauge1.Progress := conta;
                  application.ProcessMessages;
                  GravaByte(conta,arqbuf[conta]);
                  inc(conta);
                  if (abortar) then break;
              end; // while

              if ((size and 1) = 1) then   // se o final for impar
              begin
                GravaByte(size,$ff);  // grava um ff para ficar com tamanho par
              end;

              // manda gravar a ultima pagina
              if (ultimapagina=0) then
                GravaByte(tampagina*2,arqbuf[0])
              else
                GravaByte(0,arqbuf[0]);

              ProgramEnd;

              if (abortar) then
              begin
                abortar:=false;
                exit;
              end;

              ProgramEnable;
              statusbar1.Panels[0].Text := STR_COMPARANDO;
              application.ProcessMessages;
              conta := 0;
              contaModoRapido:=0;

              while (conta < size) do
              begin
                  statusbar1.Panels[1].Text := inttostr(conta+1) + ' ' + STR_DE + ' ' + inttostr(size) + ' bytes';
                  gauge1.Progress := conta;
                  application.ProcessMessages;
                  if (LeByte(conta) <> arqbuf[conta]) then
                  begin
                        statusbar1.Panels[0].Text := STR_ERRO_GRAVA;
                        ProgramEnd;
                        nomearquivo := '';
                        delayqt := delayqtinitial;
                        delaygrava := delaygravaalgo;
                        exit;
                  end;
                  inc(conta);
                  if (modograva=2) then inc(contaModoRapido);
                  if (abortar) then break;
                  if (contaModoRapido >= 15)  then break;
              end; // while
              ProgramEnd;

              if (abortar) then
              begin
                abortar:=false;
                exit;
              end;

            end
            else   // if (algoritmo = ALG_FL_ATMEGA8)
            begin

              statusbar1.Panels[0].Text := STR_VERIFIGRAVA;
              application.ProcessMessages;
              conta := 0;
              contaModoRapido:=0;
              while (conta < size) do
              begin
                  statusbar1.Panels[1].Text := inttostr(conta+1) + ' ' + STR_DE + ' ' + inttostr(size) + ' bytes';
                  gauge1.Progress := conta;
                  application.ProcessMessages;

                  GravaByte(conta,arqbuf[conta]);

                  if (contaModoRapido < 15) then
                  begin

                    if (LeByte(conta) <> arqbuf[conta]) then
                    begin
                        if ((Diminuivelo) or (gravouultimo)) then
                        begin
                            ProgramEnd;
                            ProgramEnable;
                            dec(conta);
                        end
                        else
                        begin
                            statusbar1.Panels[0].Text := STR_ERRO_GRAVA;
                            ProgramEnd;
                            nomearquivo := '';
                            delayqt := delayqtinitial;
                            delaygrava := delaygravaalgo;
                            exit;
                        end;
                        gravouultimo := false;
                    end // if gravabyte
                    else
                        gravouultimo := true;

                    if (modograva=2) then inc(contaModoRapido);
                  end // if (contaModoRapido)
                  else if (contaModoRapido = 15) then
                    statusbar1.Panels[0].Text := STR_GRAVANDO;

                  inc(conta);
                  if (abortar) then break;
              end; // while
              ProgramEnd;

              if (abortar) then
              begin
                abortar:=false;
                exit;
              end;

            end; // if algoritmo



        end  // if (modograva = 0)
        else if (modograva =1) then  // modo diferencial
        begin
            gauge1.Progress := 0;
            gauge1.MaxValue := size-1;
            statusbar1.Panels[0].Text := STR_GRAVANDO;
            application.ProcessMessages;
            ProgramEnable;
            conta:=0;
            while (conta < size) do
//            for conta := 0 to size-1 do
            begin
                statusbar1.Panels[1].Text := inttostr(conta+1) + ' ' + STR_DE + ' ' + inttostr(size) + ' bytes';
                gauge1.Progress := conta;
                application.ProcessMessages;

                if (arqbuf[conta] <> LeByte(conta)) then
                begin
                    GravaByte(conta,arqbuf[conta]);
                    if (arqbuf[conta] <> LeByte(conta)) then
                    begin
                        repeat
                            if ((Diminuivelo) or (gravouultimo)) then
                            begin
                                ProgramEnd;
                                ProgramEnable;
                                GravaByte(conta,arqbuf[conta]);
                                gravouultimo := false;
                            end
                            else
                            begin
                                statusbar1.Panels[0].Text := STR_ERRO_GRAVA;
                                ProgramEnd;
                                nomearquivo := '';
                                delayqt := delayqtinitial;
                                delaygrava := delaygravaalgo;
                                exit;
                            end;
                        until (arqbuf[conta] = LeByte(conta));
                        gravouultimo := true;
                    end
                    else
                        gravouultimo := true;

                end; // if arqbuf
                inc(conta);
                if (abortar) then break;
            end;  // while
            ProgramEnd;

            if (abortar) then
            begin
              abortar:=false;
              exit;
            end;

        end;  // modgrava 2

        arqbuf := nil;
        statusbar1.Panels[0].Text := STR_CONCLUIDO;

//    end;

nomearquivo := '';

end;

// botao de LER
procedure TForm1.BitBtn2Click(Sender: TObject);
  var f: file;
  conta: integer;
  dado: byte;
  tammemoria: integer;
begin

savedialog1.filter:= STR_FILTER_BIN;
SaveDialog1.DefaultExt := '.bin';
if savedialog1.Execute then
begin

  ProgramEnable;

  if not (VerificaCom) then
    exit;

  if (radiobutton2.checked) then tammemoria := tameeprom
  else tammemoria := tamflash;

  abortar:=false;

        assignfile(f,savedialog1.FileName);
        rewrite(f,1);
        gauge1.Progress :=0;
        gauge1.MaxValue := tammemoria-1;
        statusbar1.Panels[0].Text := STR_LENDO;
//        ProgramEnable;
        conta:=0;
        while (conta < tammemoria) do
//        for conta := 0 to tammemoria-1 do
        begin
           dado := LeByte(conta);
           blockwrite(f,dado,1);
           gauge1.Progress := conta;
           statusbar1.Panels[1].Text := inttostr(conta+1) + ' bytes';
           application.ProcessMessages;
           inc(conta);
           if (abortar) then break;
        end;
        ProgramEnd;
        closefile(f);
  statusbar1.Panels[0].Text := STR_CONCLUIDO;

end;

end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin

//DLPortIO1.Port[portapar + portacontrol] := salvacontrolp;

//if (portapar <> $378) and (portapar <> $278) then
//  DLPortIO1.Port[portapar + portaecr] := salvaecr;

arqinifile.Free;
arqinifile := nil;

serial.free;



end;

procedure TForm1.BitBtn7Click(Sender: TObject);
begin
self.Close;
end;

procedure TForm1.BitBtn8Click(Sender: TObject);
begin

formAjuda.Show;

end;

// botao APAGAR
procedure TForm1.BitBtn9Click(Sender: TObject);
begin


if not (BitBtn9.Tag=1) then ProgramEnable;

        if not (VerificaCom) then
          exit;

BitBtn9.Enabled := false;

SPI($ac);
if ((algoritmo = ALG_FL_51) or (algoritmo = ALG_EE_8253) or (algoritmo = ALG_FL_8253) or (algoritmo = ALG_EE_ATMEGA8) or (algoritmo = ALG_FL_ATMEGA8)) then
begin
  SPI($80);
  SPI($0);
  SPI($0);
end
else
begin
  SPI($4);
  SPI($0);
end;

sleep(500); // espera bastante...
ProgramEnd;

if (BitBtn9.Tag=1) then
 BitBtn9.Tag:=0
else
// showmessage(STR_MEM_APAGADA);
//MessageBox(form1.Handle,STR_MEM_APAGADA,STR_MSG_TYPE_EXCLAMATION,MB_OK + MB_ICONEXCLAMATION + MB_APPLMODAL);
statusbar1.Panels[0].Text := STR_MEM_APAGADA;

BitBtn9.Enabled := true;
end;

procedure TForm1.menuAT89S8252Click(Sender: TObject);
// var conta:integer;
begin
tamflash := 8192;
tameeprom:=2048;
DesmarcaTodosChips;
menuAT89S8252.Checked := true;
DesabilitaMenusAVR;
DesabilitaMenuFuse89S;
HabilitaMenus89S;
TemEEprom;
algoritmo := ALG_FL_8252;
delaygravaalgo := 3;
menuNormal.Enabled := true;
menuRapida.Enabled := true;
menuDiferencial.Enabled := true;
arqinifile.WriteInteger('CONFIG','CHIP',menuAT89S8252.tag);
end;

procedure TForm1.menuAT89S53Click(Sender: TObject);
// var conta:integer;
begin
tamflash := 12288;
DesmarcaTodosChips;
menuAT89S53.Checked := true;
DesabilitaMenusAVR;
DesabilitaMenuFuse89S;
HabilitaMenus89S;
NaoTemEEprom;
algoritmo := ALG_FL_8252;
delaygrava := 3;
menuNormal.Enabled := true;
menuRapida.Enabled := true;
menuDiferencial.Enabled := true;
arqinifile.WriteInteger('CONFIG','CHIP',menuAT89S53.tag);
end;

procedure TForm1.menuAT89S52Click(Sender: TObject);
// var conta:integer;
begin
tamflash := 8192;
DesmarcaTodosChips;
menuAT89S52.Checked := true;
DesabilitaMenusAVR;
DesabilitaMenuFuse89S;
HabilitaMenus89S;
NaoTemEEprom;
algoritmo := ALG_FL_51;
delaygrava := 1;
menuNormal.Click;
menuNormal.Enabled := true;
menuRapida.Enabled := true;
menuDiferencial.Enabled := false;
arqinifile.WriteInteger('CONFIG','CHIP',menuAT89S52.tag);
end;

procedure TForm1.menuAT89S51Click(Sender: TObject);
// var conta:integer;
begin
tamflash := 4196;
DesmarcaTodosChips;
menuAT89S51.Checked := true;
DesabilitaMenusAVR;
DesabilitaMenuFuse89S;
HabilitaMenus89S;
NaoTemEEprom;
algoritmo := ALG_FL_51;
delaygrava := 1;
menuNormal.Click;
menuNormal.Enabled := true;
menuRapida.Enabled := true;
menuDiferencial.Enabled := false;
arqinifile.WriteInteger('CONFIG','CHIP',menuAT89S51.tag);
end;

procedure TForm1.menuNormalClick(Sender: TObject);
begin
modograva:=0;
menuNormal.Checked := true;
menuDiferencial.Checked := false;
menuRapida.checked := false;
end;

procedure TForm1.menuDiferencialClick(Sender: TObject);
begin
modograva:=1;
menuNormal.Checked := false;
menuDiferencial.Checked := true;
menuRapida.checked := false;
end;

procedure TForm1.menuRapidaClick(Sender: TObject);
begin
modograva:=2;
menuNormal.Checked := false;
menuDiferencial.Checked := false;
menuRapida.checked := true;
end;


// Botao de COMPARAR
procedure TForm1.BitBtn3Click(Sender: TObject);
//    var f: file;
  var
      tamarq: integer;
      conta: integer;
      arqbuf: vetorbyte;
//      buf: byte;
      erros: integer;
//      salvadelayqt : integer;
//      leuultimo: boolean;
//      tammemoria:integer;
begin

//leuultimo := false;

opendialog1.filter:= STR_FILTER_HEXBIN;
if opendialog1.Execute then
begin


{
   assignfile(f,opendialog1.filename);
   Reset(f,1);
   tamarq:=filesize(f);
}



  statusbar1.Panels[0].Text := STR_AGUARDE;
  tamarq := LeHEXouBIN(opendialog1.filename, arqbuf);
  statusbar1.Panels[0].Text := '';


if (radiobutton2.checked) then
   if (tamarq > tameeprom) then begin
//      showmessage(STR_MAX_EEPROM);
      MessageBox(form1.Handle,PAnsiChar(STR_MAX_EEPROM),PAnsiChar(STR_MSG_TYPE_ERROR),MB_OK + MB_ICONERROR + MB_APPLMODAL);
      exit;
   end
else
   if (tamarq > tamflash) then begin
//      showmessage(STR_MAX_FLASH);
      MessageBox(form1.Handle,PAnsiChar(STR_MAX_FLASH),PAnsiChar(STR_MSG_TYPE_ERROR),MB_OK + MB_ICONERROR + MB_APPLMODAL);
      exit;
   end;

//salvadelayqt := delayqt;

{
   conta :=0;
   SetLength(arqbuf,tamarq);
   while (not eof(f)) do
   begin
      blockread(f,buf,1);
      arqbuf[conta] := buf;
      inc(conta);
   end;
   closefile(f);
}

ProgramEnable;

        if not (VerificaCom) then
          exit;

  abortar:=false;

   statusbar1.Panels[0].Text := STR_COMPARANDO;
      gauge1.Progress := 0;
      gauge1.MaxValue := tamarq-1;
      erros:=0;
//      ProgramEnable;
//      for conta := 0 to tamarq-1 do
conta := 0;
while (conta < tamarq) do
      begin
         if (LeByte(conta) <> arqbuf[conta]) then
         begin
//            if ((Diminuivelo) or (leuultimo)) then
//            begin
//               ProgramEnd;
//               ProgramEnable;
//               dec(conta);
//            end
//            else
            inc(erros);

//            leuultimo := false;
         end;
//         else
//         leuultimo := true;
         gauge1.Progress := conta;
         statusbar1.Panels[1].Text := inttostr(erros) + ' ' + STR_BYTES_DIF;
         application.ProcessMessages;
      inc(conta);
      if (abortar) then break;
      end;
      ProgramEnd;
//sleep(500);
   if (erros > 0) then showmessage(STR_DADOS_DIF)
   else statusbar1.Panels[1].Text := STR_DADOS_IGUAIS;

   arqbuf := nil;
   statusbar1.Panels[0].Text := STR_CONCLUIDO;
   abortar:=false;
//delayqt := salvadelayqt;

end;


end;

procedure TForm1.BINHEX1Click(Sender: TObject);
 var arqhex: thexfile;
  arqbin: tfilestream;
  conta: integer;
  buff: array of byte;
begin

  if OpenDialog1.Execute then
  begin
    arqbin := TFilestream.Create(opendialog1.FileName, fmOpenRead);
    try
      arqhex := THexFile.Create(self);
      try
        arqhex.UnusedBytes := $ff;
        arqhex.DataSize := arqbin.Size;
        SetLength(buff,arqbin.size);
        arqbin.Read(buff[0],arqbin.size);
        for conta := 0 to arqbin.Size - 1 do
        begin
          arqhex.DataBin[conta] := buff[conta];
          arqhex.DataUsed[conta] := true;
        end;
        if SaveDialog1.Execute then
        begin
          arqhex.Update;
          arqhex.SaveHexFile(SaveDialog1.FileName);
        end;

      finally
        arqhex.free;
      end;

    finally
      arqbin.Free;
    end;

  end;

end;

procedure TForm1.BitBtn10Click(Sender: TObject);
 var lockb : byte;
  contalock: byte;
begin

lockb:=0;

if (algoritmo = ALG_FL_51) then
begin
    lockb := StrToIntDef(combobox1.text,0);
end
else if ((algoritmo = ALG_FL_8253) or (algoritmo = ALG_EE_8253))
then
begin
    if (StrToIntDef(combobox1.text,0)=1) then lockb := $E6        // 1110 0110
    else if (StrToIntDef(combobox1.text,0) = 2) then lockb := $E5   // 1110 0101
    else if (StrToIntDef(combobox1.text,0) = 3) then lockb := $E3;  // 1110 0011
end
else
begin
    if (StrToIntDef(combobox1.text,0) = 1) then lockb := $67        // 0110 0111
    else if (StrToIntDef(combobox1.text,0) = 2) then lockb := $27   // 0010 0111
    else if (StrToIntDef(combobox1.text,0) = 3) then lockb := $07;  // 0000 0111
end;

if (lockb > 0) then
begin


    ProgramEnable;

    if not (VerificaCom) then
      exit;



    if (algoritmo = ALG_FL_51) then
    begin
        SPI($ac);       // ativa o lock Modo 1 (no lock protection)
        SPI($E0);
        SPI($0);
        SPI($0);
        sleep(50);
        for contalock := 1 to lockb do  // Ativa sequencialmente os os lockbits
        begin
            SPI($ac);
            SPI(contalock or $E0);
            SPI($0);
            SPI($0);
            sleep(50);
        end;
    end
    else if ((algoritmo = ALG_FL_8253) or (algoritmo = ALG_EE_8253))
    then
    begin
        SPI($ac);
        SPI(lockb);
        SPI($0);
        SPI($0);
        sleep(50);
    end
    else
    begin
        SPI($ac);
        SPI(lockb);
        SPI($0);
        sleep(50);
    end;

ProgramEnd;
//showmessage(STR_LOCK_OK);
//MessageBox(form1.Handle,STR_LOCK_OK,STR_MSG_TYPE_EXCLAMATION,MB_OK + MB_ICONEXCLAMATION + MB_APPLMODAL);
statusbar1.Panels[0].Text := STR_LOCKWRITE_OK;

end;

end;

procedure TForm1.Gravao2Click(Sender: TObject);
begin
formAjuda.Show;
end;

procedure TForm1.HEXBIN1Click(Sender: TObject);
 var arqhex : ThexFile;
   buff: array of byte;
  arqbin: TFileStream;
  conta: integer;
  ultimoend: integer;
begin

  opendialog1.Filter := STR_FILTER_HEX;

  if OpenDialog1.Execute then
  begin

  arqhex := THexFile.Create(self);
  try

    arqhex.UnusedBytes := $FF;
    arqhex.LoadHexFile(OpenDialog1.FileName);
    arqhex.DataSize := 65534;
    arqhex.Update;

    SetLength(buff,65534);

    if SaveDialog1.Execute then
    begin

      ultimoend:=0;
      for conta:=  0 to arqhex.datasize - 1 do
      begin
        buff[conta] := arqhex.DataBin[conta];
        if arqhex.DataUsed[conta] then
          ultimoend := conta;
      end;

      arqbin := TFileStream.Create(SaveDialog1.FileName,fmCreate or fmOpenWrite or fmShareDenyWrite);
      try
        arqbin.Writebuffer(buff[0],ultimoend+1);
      finally
        arqbin.free;
      end;

    end;  // savedialog

    finally
      arqhex.free;
    end;

  end;  // opendialog


end;

procedure TForm1.Sore1Click(Sender: TObject);
 var texto: string;
begin
  texto := STR_COPYRIGHT;
  texto := texto + #13+#10+#13+#10;
//  if QuantumTimerExists then texto := texto + 'Temporização mínima do Quantum counter: ' + floattostr(QuantumTimerMinmicrosec) + ' us' + #13+#10;
  MessageBox(form1.Handle,pchar(texto),PAnsiChar(STR_MSG_INFORMATION),MB_OK + MB_ICONINFORMATION + MB_APPLMODAL);
end;





procedure TForm1.menuAT89S8253Click(Sender: TObject);
// var conta:integer;
begin
tamflash := 12288;
tameeprom:=2048;
DesmarcaTodosChips;
menuAT89S8253.Checked := true;
DesabilitaMenusAVR;
HabilitaMenus89S;
HabilitaMenuFuse89S;
TemEEprom;
algoritmo := ALG_FL_8253;
delaygrava := 4;
menuNormal.Click;
menuNormal.Enabled := true;
menuRapida.Enabled := true;
menuDiferencial.Enabled := false;
arqinifile.WriteInteger('CONFIG','CHIP',menuAT89S8253.tag);
end;

// se mudou flash/eeprom
procedure TForm1.RadioButtonClick(Sender: TObject);
begin
  SelecFlashEeprom;
end;



procedure TForm1.EditorHEX1Click(Sender: TObject);
begin
  formedithex.show;
end;

procedure TForm1.EndereoIO1Click(Sender: TObject);
begin

//  EndIO.Label1.Caption := STR_ENDIO_LABEL;
//  EndIO.Label3.Caption := STR_ENDIO_WARN;
//  endio.combobox1.Text := portaser;

//showmessage(GetSerialPortNames);

endio.ComboBox1.Clear;
endio.ComboBox1.Items.CommaText := GetSerialPortNames;

  EndIO.Show;


end;

procedure TForm1.Esquema1Click(Sender: TObject);
begin
  form3.show;
end;



procedure TForm1.menuATMEGA8Click(Sender: TObject);
// var conta:integer;
begin
tamflash := 8192;
tameeprom:=512;
tampagina:=32; // 32words no manual
TemEEprom;
DesmarcaTodosChips;
menuATMEGA8.Checked := true;
HabilitaMenusAVR;
DesabilitaMenus89S;
DesabilitaMenuFuse89S;
algoritmo := ALG_FL_ATMEGA8;
delaygrava := 7; // tive q aumentar, tava falhando
delaygravaee := 12;
menuNormal.Click;
menuNormal.Enabled := true;
menuRapida.Enabled := true;
menuDiferencial.Enabled := false;
arqinifile.WriteInteger('CONFIG','CHIP',menuATMEGA8.tag);
end;

procedure TForm1.BitBtn4Click(Sender: TObject);
 var alto,baixo: byte;
//  umbit: boolean;
  conta: integer;
begin

  ProgramEnable;

        if not (VerificaCom) then
          exit;

// le low fuse bits
  SPI($50);
  SPI($0);
  SPI($0);
  baixo := SPI($0);

// le high fuse bits
  SPI($58);
  SPI($8);
  SPI($0);
  alto := SPI($0);

  ProgramEnd;

  for conta := 0 to GroupBox2.ControlCount-1 do // seta todos os checkbox
    if (GroupBox2.Controls[conta] is TCheckBox) then
      TCheckBox(GroupBox2.Controls[conta]).Checked := true;


    if ((baixo and 1)=1) then
      CheckboxFuse0l.Checked:=false;
    if ((baixo and 2)=2) then
      CheckboxFuse1l.Checked:=false;
    if ((baixo and 4)=4) then
      CheckboxFuse2l.Checked:=false;
    if ((baixo and 8)=8) then
      CheckboxFuse3l.Checked:=false;
    if ((baixo and 16)=16) then
      CheckboxFuse4l.Checked:=false;
    if ((baixo and 32)=32) then
      CheckboxFuse5l.Checked:=false;
    if ((baixo and 64)=64) then
      CheckboxFuse6l.Checked:=false;
    if ((baixo and 128)=128) then
      CheckboxFuse7l.Checked:=false;

    if ((alto and 1)=1) then
      CheckboxFuse0h.Checked:=false;
    if ((alto and 2)=2) then
      CheckboxFuse1h.Checked:=false;
    if ((alto and 4)=4) then
      CheckboxFuse2h.Checked:=false;
    if ((alto and 8)=8) then
      CheckboxFuse3h.Checked:=false;
    if ((alto and 16)=16) then
      CheckboxFuse4h.Checked:=false;
    if ((alto and 32)=32) then
      CheckboxFuse5h.Checked:=false;
    if ((alto and 64)=64) then
      CheckboxFuse6h.Checked:=false;
    if ((alto and 128)=128) then
      CheckboxFuse7h.Checked:=false;

statusbar1.Panels[0].Text := STR_FUSEREAD_OK;


end;


procedure TForm1.BitBtn1Click(Sender: TObject);
 var alto,baixo: byte;
//  umbit: boolean;
//  conta: integer;
begin

    baixo:=0;
    alto:=0;


    if (CheckboxFuse0l.Checked=false) then
      baixo := baixo or 1;
    if (CheckboxFuse1l.Checked=false) then
      baixo := baixo or 2;
    if (CheckboxFuse2l.Checked=false) then
      baixo := baixo or 4;
    if (CheckboxFuse3l.Checked=false) then
      baixo := baixo or 8;
    if (CheckboxFuse4l.Checked=false) then
      baixo := baixo or 16;
    if (CheckboxFuse5l.Checked=false) then
      baixo := baixo or 32;
    if (CheckboxFuse6l.Checked=false) then
      baixo := baixo or 64;
    if (CheckboxFuse7l.Checked=false) then
      baixo := baixo or 128;

    if (CheckboxFuse0h.Checked=false) then
      alto := alto or 1;
    if (CheckboxFuse1h.Checked=false) then
      alto := alto or 2;
    if (CheckboxFuse2h.Checked=false) then
      alto := alto or 4;
    if (CheckboxFuse3h.Checked=false) then
      alto := alto or 8;
    if (CheckboxFuse4h.Checked=false) then
      alto := alto or 16;
    if (CheckboxFuse5h.Checked=false) then
      alto := alto or 32;
    if (CheckboxFuse6h.Checked=false) then
      alto := alto or 64;
    if (CheckboxFuse7h.Checked=false) then
      alto := alto or 128;

  ProgramEnable;

  if not (VerificaCom) then
    exit;

// grava low fuse bits
  SPI($ac);
  SPI($a0);
  SPI($0);
  SPI(baixo);

// grava high fuse bits
  SPI($ac);
  SPI($a8);
  SPI($0);
  SPI(alto);

  ProgramEnd;

statusbar1.Panels[0].Text := STR_FUSEWRITE_OK;

end;

procedure TForm1.BitBtn6Click(Sender: TObject);
 var lockb: byte;
//  umbit: boolean;
  conta: integer;
begin

  ProgramEnable;

  if not (VerificaCom) then
    exit;

// le lock bits
  SPI($58);
  SPI($0);
  SPI($0);
  lockb := SPI($0);

  for conta := 0 to GroupBox5.ControlCount-1 do // seta todos os checkbox
    if (GroupBox5.Controls[conta] is TCheckBox) then
      TCheckBox(GroupBox5.Controls[conta]).Checked := true;


  ProgramEnd;

    if ((lockb and 1)=1) then
      CheckBoxLock0.Checked:=false;
    if ((lockb and 2)=2) then
      CheckBoxLock1.Checked:=false;
    if ((lockb and 4)=4) then
      CheckBoxLock2.Checked:=false;
    if ((lockb and 8)=8) then
      CheckBoxLock3.Checked:=false;
    if ((lockb and 16)=16) then
      CheckBoxLock4.Checked:=false;
    if ((lockb and 32)=32) then
      CheckBoxLock5.Checked:=false;

statusbar1.Panels[0].Text := STR_LOCKREAD_OK;

end;

procedure TForm1.BitBtn5Click(Sender: TObject);
 var lockb: byte;
//  umbit: boolean;
//  conta: integer;
begin

  lockb:=0;

    if (CheckBoxLock0.Checked=false) then
      lockb := lockb or 1;
    if (CheckBoxLock1.Checked=false) then
      lockb := lockb or 2;
    if (CheckBoxLock2.Checked=false) then
      lockb := lockb or 4;
    if (CheckBoxLock3.Checked=false) then
      lockb := lockb or 8;
    if (CheckBoxLock4.Checked=false) then
      lockb := lockb or 16;
    if (CheckBoxLock5.Checked=false) then
      lockb := lockb or 32;

  ProgramEnable;

  if not (VerificaCom) then
    exit;

// grava lockbits
  SPI($ac);
  SPI($e0);
  SPI($0);
  SPI(lockb or $c0);


  ProgramEnd;

statusbar1.Panels[0].Text := STR_LOCKWRITE_OK;

end;

procedure TForm1.BitBtnCancelaClick(Sender: TObject);
begin
  abortar:=true;
end;

procedure TForm1.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
 var conta:integer;
begin

// truque para sair abortanto as comunicacoes
// se eu estiver dentro de uma rotina de leitura/gravacao e acionar o abortar, ele vai voltar para false
// so vai ficar true se estiver fora das rotinas

  CanClose:=false;

  if (abortar) then
    CanClose := true;

  abortar:=true;

  timer1.Enabled := true;


end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  self.Close;
end;




procedure TForm1.BitBtn11Click(Sender: TObject);
begin

  statusbar1.Panels[0].Text := '';
  Application.ProcessMessages;

  ProgramEnable;

  if (VerificaCom) then
  begin
    statusbar1.Panels[0].Text := STR_TESTECON;
  end;

  ProgramEnd;


end;

procedure TForm1.BitBtn12Click(Sender: TObject);
 var lockb: byte;
  conta: integer;
begin

  ProgramEnable;

  if not (VerificaCom) then
    exit;

// le fuse bits do 89s8253
  SPI($21);
  SPI($0);
  SPI($0);
  lockb := SPI($0);

  
  for conta := 0 to GroupBox6.ControlCount-1 do // zera todos os checkbox
    if (GroupBox6.Controls[conta] is TCheckBox) then
      TCheckBox(GroupBox6.Controls[conta]).Checked := false;


  ProgramEnd;

    if ((lockb and 1)=1) then
      CheckBoxFuse891.Checked:=true;
    if ((lockb and 2)=2) then
      CheckBoxFuse892.Checked:=true;
    if ((lockb and 4)=4) then
      CheckBoxFuse893.Checked:=true;
    if ((lockb and 8)=8) then
      CheckBoxFuse894.Checked:=true;

//showmessage(IntToHex(lockb,2));

  statusbar1.Panels[0].Text := STR_FUSEREAD_OK;


end;



procedure TForm1.DesabilitaMenuFuse89S;
 var conta:integer;
begin
  for conta := 0 to GroupBox6.ControlCount-1 do // desliga todos checkbox
  begin
    if (GroupBox6.Controls[conta] is TCheckBox) then TCheckBox(GroupBox6.Controls[conta]).Checked := false;
    GroupBox6.Controls[conta].Enabled := false;
  end;
end;

procedure TForm1.HabilitaMenuFuse89S;
 var conta:integer;
begin
  for conta := 0 to GroupBox6.ControlCount-1 do // liga menu Fuse 89s8253
  begin
    GroupBox6.Controls[conta].Enabled := true;
  end;
end;

procedure TForm1.BitBtn13Click(Sender: TObject);
 var lockb:byte;
begin

  lockb:=$10; // 0001 0000 (byte dos fuse bits, rs)

    if (CheckBoxFuse891.Checked) then
      lockb := lockb or 1;
    if (CheckBoxFuse892.Checked) then
      lockb := lockb or 2;
    if (CheckBoxFuse893.Checked) then
      lockb := lockb or 4;
    if (CheckBoxFuse894.Checked) then
      lockb := lockb or 8;

  ProgramEnable;

  if not (VerificaCom) then
    exit;


// grava fusebits
  SPI($ac);
  SPI(lockb);
  SPI($0);
  SPI($0);
  sleep(50);

//showmessage(IntToHex(lockb,2));

  ProgramEnd;

  statusbar1.Panels[0].Text := STR_FUSEWRITE_OK;

end;

end.

