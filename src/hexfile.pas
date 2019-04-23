unit HexFile;

// modificado por RafaelBF. Suporte para o registro 2 do arquivo intel-hex // Strings movidas para constantes // Suporte 2 linguas

{===============================================================================

  THexFile

  Komponente f�r den Umgang mit Intel Hex Files

  Component for usage of Intel Hex Files

  (C) by Stephan Knupfer, EngineTronic Innovations B. V.


  Hilfe
  ==============================================================================
  Sorry, at the moment I don't have the time to translate this into english.

  Kurze Beschreibung des Aufbaus

    Ein Hex File enth�lt Daten und Adressen. Da diese nicht notwendigerweise
    linear geschrieben werden, k�nnen L�cken bzw. ungenutzte Speicherstellen
    im Hex File vorkommen. Daher erfolgt die Umsetzung in bin�re Daten einmal
    aus den eigentlichen Daten (DataBin) und zus�tzlich aus einem Array, der f�r
    jedes Datum angibt, ob es wirklich benutzt wird (DataUsed).

  Eigenschaften

  AutoUpdate
    property AutoUpdate: booleann;

    Dieses Flag bestimmt, ob sich eine �nderung der bin�ren Daten sofort auf das
    erzeugte Hex File auswirkt oder umgekehrt.
    Ist AutoUpdate false, muss zum Abgleich von bin�ren und hex file Daten
    die Prozedur Update aufgerufen werden. Dabei wird angenommen, dass die
    zuletzt modifizierten Daten die aktuellen sind.
    Wird eine �nderung zuerst an den hex file Daten vorgenommen, dann an den
    bin�ren Daten und danach Update aufgerufen, so geht die �nderung an den
    hex file Daten verloren.

> DataBin
    property DataBin[Index: integer]: integer;

    Diese nur zur Laufzeit verf�gbare Eigenschaft erlaubt den Zugriff auf
    die bin�ren Daten. Der Index kann zwischen 0 und DataSize-1 sein.
    Andernfalls wird eine Exception ausgel�st.
    Ist AutoUpdate true, so wird auch DataHex nach einer �nderung von DataBin
    angepa�t.

> DataHex
    property DataHex[Index: integer]: string;

    Die nur zur Laufzeit verf�gbare Eigenschaft DataHex repr�sentiert die
    Zeilen des Hex Files.
    Ist AutoUpdate true, so bewirkt eine �nderung von DataHex auch eine
    �nderung der betroffenen Speicherstellen in DataBin und DataUsed.
    Achtung: Die Zeilen in DataHex m�ssen g�ltige Intel Hex File Daten
    enthalten, andernfalls wird eine Exception ausgel�st.

> DataHexCount
    property DataHexCount: integer;

    Diese nur zur Laufzeit verf�gbare Eigenschaft gibt die Zeilen in
    DataHex an. Dies entspricht der Anzahl der Zeilen des Hex Files.

  DataSize
    property DataSize: integer;

    DataSize gibt die Gr��e des bin�ren Puffers DataBin sowie DataUsed an.
    Eine �nderung von DataSize erzeugt einen neuen Puffer, der mit UnusedBytes
    gef�llt wird.
    Ist AutoUpdate auf true gesetzt, so wird die Puffergr��e ge�ndert und danach
    eventuell vorhandene hex file Daten wieder in binary Daten konvertiert.

> DataUsed
    property DataUsed[Index: integer]: boolean;

    Diese nur zur Laufzeit verf�gbare Eigenschaft gibt an, ob das Datum in
    DataBin an der Stelle Index verwendet wird oder nicht.
    Index darf sich nur im Bereich von 0 bis DataSize-1 befinden, ansonsten
    wird eine Exception ausgel�st.

  HexfileVersion
    property HexfileVersion: THexfileVersion;

    Gibt die Codierung des hex file Daten an. zur Auswahl steht die 16 Bit
    Codierung, die nur Adressen im Bereich 0 bis 64k (65535 Bytes) erlaubt,
    sowie die 32 Bit Version mit 32 Bit Adressen.
    Die 32 Bit Version ist noch nicht implementiert. Wird dieses Format aus-
    gew�hlt, wird eine Warnung ausgegeben.

  HexLineLin
    property HexLineLen: integer;

    HexLineLen gibt die Anzahl der Datenbytes in einer Zeile der hex file Daten
    an.
    Wird HexLineLen ge�ndert und AutoUpdate ist auf true gesetzt, so werden
    die hex file Daten sofort angepa�t.
    Ist AutoUpdate false und es wurden keine Daten  oder die bin�ren Daten
    ge�ndert, so kann durch den Aufruf von Update die �Zeilenl�nge angepa�t
    werden.
    Wurden jedoch vor einer �nderung von HexLineLen DataHex ge�ndert, so wird
    die Zeilenl�ngen�nderung erst wirksam, wenn bin�re Daten ge�ndert werden
    und Update aufgerufen wird.

  UnusedBytes
    property UnusedBytes: byte;

    Unused Bytes gibt das F�llmuster f�r die nicht benutzten Bytes in DataBin
    an. Das F�llmuster wird verwendet um DataBin zu f�llen wenn sich DataSize
    �ndert oder aus den hex file Daten bin�re Daten erzeugt werden.
    Nur eine �nderung von UnusedBytes f�hrt noch zu keiner Modifikation in
    DataBin.


  Methoden

  BeginUpdate
    procedure BeginUpdate;

    BeginUpdate wird verwendet, um bei AutoUpdate gleich true die Aktualisierung
    w�hrend einer Datenmanipulation zu unterdr�cken um so eine h�here
    Ausf�hrungsgeschwindigkeit zu erzielen.
    Am Ende der Datenmanipulation muss EndUpdate aufgerufen werden, wodurch
    dann Update aufgerufen wird.

  BufferToDataBin
    procedure BufferToDataBin(var Buffer);

    Kopiert DataSize Bytes aus Buffer nach DataBin. Ist AutoUpdate true, wird
    anschlie�end Update aufgerufen.

  BufferToDataUsed
    procedure BufferToDataUsed(var Buffer);

    Kopiert DataSize Bytes aus Buffer nach DataUsed. Ist AutoUpdate true, wird
    anschlie�end Update aufgerufen.

  Create
    constructor Create(AOwner: TComponent); override;

    Create erstellt eine neue Instanz von THexFile. In der Regel muss Create
    nicht manuell aufgerufen werden.

  DataBinToBuffer
    procedure DataBinToBuffer(var Buffer);

    Kopiert den Inhalt von DataBin an einem St�ck in den �bergebenen Speicher-
    bereich Buffer. Es werden DataSize Bytes �bertragen. Es muss sichergestellt
    werden, dass Buffer mindestens so gro� ist.

  DataUsedToBuffer
    procedure DataUsedToBuffer(var Buffer);

    Kopiert den Inhalt von DataUsed an einem St�ck in den �bergebenen Speicher-
    bereich Buffer. Es werden DataSize Bytes �bertragen. Es muss sichergestellt
    werden, dass Buffer mindestens so gro� ist.

  Destroy
    destructor Destroy; override;

    Gibt die Instanz von THexFile frei. Muss normalerweise nicht aufgerufen
    werden sondern wird vom �bergeordneten Formular gemacht.

  EndUpdate
    procedure EndUpdate;

    EndUpdate schlie�t eine mit BeginUpdate eingeleitete Datenmanipulation ab.
    Der Aufruf von EndUpdate sorgt automatisch f�r einen Aufruf von Update
    um die Daten�nderung sowohl f�r hex file als auch f�r die bin�ren Daten
    wirksam zu machen.

  GetHexfileSize
    function GetHexfileSize: integer;

    Gibt die maximal benutzte Adresse der momentan in DataHex stehenden hex file
    Daten zur�ck was der ben�tigten Puffergr��e von DataBin und somit DataSize
    entspricht.
    Diese Funktion kann benutzt werden, um nach LoadHexFile die passende
    Gr��e von DataSize zu setzen.

  LoadHexFile
    procedure LoadHexFile(Filename: TFilename);

    L�d die Datei Filename in die Strings von DataHex. Ist AutoUpdate auf true
    gesetzt, wird anschlie�end Update aufgerufen und die bin�ren Daten ebenfalls
    aktualisiert.

  SaveHexFile
    procedure SaveHexFile(Filename: TFilename);

    Speichert die Strings aus DataHex in der Datei Filename.

  Update
    procedure Update;

    Update bringt bin�re und hex file Daten auf den gleichen Stand. Update
    pr�ft, ob �berhaupt eine Aktualisierung n�tig ist. Anhand der zuletzt
    ge�nderten Daten wird dann eine Umsetzung von hex file auf bin�r oder
    umgekehrt vorgenommen.

    Siehe auch AutoUpdate

 ===============================================================================
}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs;

type
  THexfileVersion = (hv16Bit, hv32Bit);
  TLastUpdate = (luNone, luHex, luBin);

type
  THexFile = class(TComponent)
  private
    { Private-Deklarationen }
    FHexfileVersion: THexfileVersion;
    FDataSize: integer;
    FDataBin: pointer;
    FDataUsed: pointer;
    FDataHex: TStringList;
    FLastUpdate: TLastUpdate;
    FAutoUpdate: boolean;
    FHexLineLen: integer;
    FUnusedBytes: byte;
    FUpdating: boolean;
    function GetDataHexCount: integer;
    procedure SetHexfileVersion(hv: THexfileVersion);
    procedure SetDataSize(ds: integer);
    function GetDataBin(i: integer): integer;
    procedure SetDataBin(i, data: integer);
    function GetDataUsed(i: integer): boolean;
    procedure SetDataUsed(i: integer; used: boolean);
    function GetDataHex(i: integer): string;
    procedure SetDataHex(i: integer; s: string);
    procedure SetAutoUpdate(au: boolean);
    procedure SetHexLineLen(ll: integer);
  protected
    { Protected-Deklarationen }
  public
    { Public-Deklarationen }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Update;
    procedure SaveHexFile(Filename: TFilename);
    procedure LoadHexFile(Filename: TFilename);
    procedure DataBinToBuffer(var Buffer);
    procedure BufferToDataBin(var Buffer);
    procedure DataUsedToBuffer(var Buffer);
    procedure BufferToDataUsed(var Buffer);
    procedure BeginUpdate;
    procedure EndUpdate;
    function GetHexfileSize: integer;
    property DataHexCount: integer read GetDataHexCount;
    property DataBin[Index: integer]: integer read GetDataBin write SetDataBin;
    property DataUsed[Index: integer]: boolean read GetDataUsed write SetDataUsed;
    property DataHex[Index: integer]: string read GetDataHex write SetDataHex;
  published
    { Published-Deklarationen }
    property HexfileVersion: THexfileVersion read FHexfileVersion write SetHexfileVersion;
    property DataSize: integer read FDataSize write SetDataSize;
    property AutoUpdate: boolean read FAutoUpdate write SetAutoUpdate;
    property HexLineLen: integer read FHexLineLen write SetHexLineLen;
    property UnusedBytes: byte read FUnusedBytes write FUnusedBytes;
  end;

procedure Register;

implementation

var
usba:integer;


const
{$IFDEF PT-BR}
STR_ERR_CHECKSUM = 'Erro de checksum no arquivo HEX';
STR_ERR_NOEND = 'Erro no fim do arquivo HEX';
STR_ERR_UNKBLOCK = 'Encontrado bloco inv�lido no arquivo HEX';
STR_ERR_NODOTS = 'Arquivo HEX inv�lido! ":" n�o encontrado';
STR_ERR_MAXDATAUSED = 'Indice do DataUsed excedeu o limite';
STR_ERR_MAXDATABIN = 'Indice do DataBin excedeu o limite';
{$ELSE}
STR_ERR_CHECKSUM = 'Checksum error in .HEX file';
STR_ERR_NOEND = 'Invalid end of file in .HEX';
STR_ERR_UNKBLOCK = 'Invalid/unsupported block in.HEX file';
STR_ERR_NODOTS = 'Invalid .HEX file';
STR_ERR_MAXDATAUSED = '"DataUsed" index out of space';
STR_ERR_MAXDATABIN = '"DataBin" index out of space';
{$ENDIF}


function HexDigitToInt(c: char): integer;
begin
  HexDigitToInt:= -1;
  if ((c>='0') and (c<='9')) then HexDigitToInt:= byte(c)-byte('0');
  if ((c>='A') and (c<='F')) then HexDigitToInt:= byte(c)+10-byte('A');
end;

function HexToInt(s: shortstring): integer;
begin
  HexToInt:= 16*HexDigitToInt(s[1])+HexDigitToInt(s[2]);
end;

function THexFile.GetDataHexCount: integer;
begin
  GetDataHexCount:= FDataHex.Count;
end;

procedure THexFile.SetHexfileVersion(hv: THexfileVersion);
begin
  if hv=hv32Bit then MessageDlg('Arquivos HEX no formato 32bits n�o s�o suportados!',mtError,[mbOK],0);
  FHexfileVersion:= hv;
end;

procedure THexFile.SetDataSize(ds: integer);
begin
  if ds<>FDataSize then
  begin
    if FDataBin<>nil then FreeMem(FDataBin,FDataSize*SizeOf(byte));
    if FDataUsed<>nil then FreeMem(FDataUsed,FDataSize*SizeOf(boolean));
    FDataBin:= nil;
    FDataUsed:= nil;
    FLastUpdate:= luHex;
    if ds<>0 then
    begin
      FDataSize:= ds;
      GetMem(FDataBin,FDataSize*SizeOf(byte));
      GetMem(FDataUsed,FDataSize*SizeOf(boolean));
      FillChar(FDataBin^,FDataSize*SizeOf(byte),UnusedBytes);
      FillChar(FDataUsed^,FDataSize*SizeOf(boolean),false);
    end;
  end;
  if FAutoUpdate and (not FUpdating) then Update;
end;

function THexFile.GetDataBin(i: integer): integer;
begin
  GetDataBin:= byte(ptr(integer(FDataBin)+i)^);
end;

procedure THexFile.SetDataBin(i, data: integer);
begin
  if (i>=0) and (i<FDataSize) then
  begin
    byte(ptr(integer(FDataBin)+i)^):= data;
    FLastUpdate:= luBin;
  end
  else
    raise Exception.Create(STR_ERR_MAXDATABIN);
  if DataUsed[i] and FAutoUpdate and (not FUpdating) then Update;
end;

function THexFile.GetDataUsed(i: integer): boolean;
begin
  GetDataUsed:= boolean(ptr(integer(FDataUsed)+i)^);
end;

procedure THexFile.SetDataUsed(i: integer; used: boolean);
begin
  if (i>=0) and (i<FDataSize) then
  begin
    boolean(ptr(integer(FDataUsed)+i)^):= used;
    FLastUpdate:= luBin;
  end
  else
    raise Exception.Create(STR_ERR_MAXDATAUSED);
  if FAutoUpdate and (not FUpdating) then Update;
end;

function THexFile.GetDataHex(i: integer): string;
begin
  if i<DataHexCount then
    GetDataHex:= FDataHex.Strings[i]
  else
    GetDataHex:= '';
end;

procedure THexFile.SetDataHex(i: integer; s: string);
begin
  while i>=DataHexCount do FDataHex.Add('');
  FDataHex.Strings[i]:= s;
  FLastUpdate:= luHex;
  if FAutoUpdate and (not FUpdating) then Update;
end;

procedure THexFile.SetAutoUpdate(au: boolean);
begin
  FAutoUpdate:= au;
  if FAutoUpdate and (not FUpdating) then Update;
end;

procedure THexFile.SetHexLineLen(ll: integer);
begin
  if ll=FHexLineLen then Exit;
  FHexLineLen:= ll;
  if FAutoUpdate and (not FUpdating) then
  begin
    if FLastUpdate=luHex then Update;
    FLastUpdate:= luBin;
    Update;
  end;
  if (not FAutoUpdate) and (FLastUpdate<>luHex) then
    FLastUpdate:= luBin;
end;

constructor THexFile.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FDataHex:= TStringList.Create;
  if FHexLineLen=0 then
    FHexLineLen:= 16;
  usba:=0;
end;

destructor THexFile.Destroy;
begin
  FDataHex.Destroy;
  inherited Destroy;
end;

procedure THexFile.Update;
var
  numbytes: integer;
  startaddr: integer;
  datastring: string;
  checksum: integer;
  blocktype: integer;
  i, j: integer;
  s: string;
begin
  if FLastUpdate=luNone then Exit;

  BeginUpdate;

  if FLastUpdate=luBin then
  begin
    FDataHex.Clear;
    numbytes:= 0;
    checksum:= 0;
    startaddr:= 0;
    for i:= 0 to FDataSize-1 do
    begin
      if DataUsed[i] then
      begin
        if numbytes=0 then
        begin
          startaddr:= i;
          datastring:= '';
          checksum:= 0;
        end;
         inc(numbytes);
        datastring:= datastring+IntToHex(DataBin[i],2);
        checksum:= checksum-DataBin[i];

        if numbytes=FHexLineLen then
        begin
          checksum:= checksum-numbytes;
          checksum:= checksum-(startaddr div 256);
          checksum:= checksum-(startaddr mod 256);
          datastring:= ':'+IntToHex(numbytes,2)+IntToHex(startaddr div 256,2)+
            IntToHex(startaddr mod 256,2)+'00'+datastring+
            IntToHex(byte(checksum),2);
          FDataHex.Add(datastring);
          numbytes:= 0;
        end;
      end
      else
      if numbytes>0 then
      begin
        checksum:= checksum-numbytes;
        checksum:= checksum-(startaddr div 256);
        checksum:= checksum-(startaddr mod 256);
        datastring:= ':'+IntToHex(numbytes,2)+IntToHex(startaddr div 256,2)+
          IntToHex(startaddr mod 256,2)+'00'+datastring+
          IntToHex(byte(checksum),2);
        FDataHex.Add(datastring);
        numbytes:= 0;
      end;
    end;
    if numbytes>0 then
    begin
      checksum:= checksum-numbytes;
      checksum:= checksum-(startaddr div 256);
      checksum:= checksum-(startaddr mod 256);
      datastring:= ':'+IntToHex(numbytes,2)+IntToHex(startaddr div 256,2)+
        IntToHex(startaddr mod 256,2)+'00'+datastring+
        IntToHex(byte(checksum),2);
      FDataHex.Add(datastring);
    end;
    FDataHex.Add(':00000001FF');
  end;

  if FLastUpdate=luHex then
    begin
    FillChar(FDataBin^,FDataSize*SizeOf(byte),UnusedBytes);
    FillChar(FDataUsed^,FDataSize*SizeOf(boolean),false);
    for i:= 0 to FDataHex.Count-1 do
    begin
      s:= FDataHex.Strings[i];
      if s[1]=':' then
      begin
        checksum:= 0;
        numbytes:= HexToInt(s[2]+s[3]);
        checksum:= checksum-numbytes;
        startaddr:= 256*HexToInt(s[4]+s[5])+HexToInt(s[6]+s[7]);
        checksum:= checksum-(startaddr div 256);
        checksum:= checksum-(startaddr mod 256);
        blocktype:= HexToInt(s[8]+s[9]);
        checksum:= checksum-blocktype;
        if blocktype=0 then
        begin
          for j:= 0 to numbytes-1 do
          begin
            try
              DataBin[usba+startaddr+j]:= HexToInt(s[10+j*2]+s[11+j*2]);
              DataUsed[usba+startaddr+j]:= true;
            except
              break;
            end;
            checksum:= checksum-DataBin[usba+startaddr+j];
          end;
          if byte(checksum)<>HexToInt(s[10+numbytes*2]+s[11+numbytes*2]) then
            raise Exception.Create(STR_ERR_CHECKSUM + #13+#13+' '+ IntToHex(byte(checksum),2) + ' <> ' + s[10+numbytes*2]+s[11+numbytes*2]);
        end
        else if blocktype=1 then
        begin
          if s<>':00000001FF' then
            raise Exception.Create(STR_ERR_NOEND);
          break;
        end
        else if blocktype=2 then
        begin
          usba:= 256*HexToInt(s[10]+s[11])+HexToInt(s[12]+s[13]);
        end
        else
          raise Exception.Create(STR_ERR_UNKBLOCK);
      end
      else
        raise Exception.Create(STR_ERR_NODOTS);
    end;
  end;

  FLastUpdate:= luNone;
  EndUpdate;
end;

procedure THexFile.SaveHexFile(Filename: TFilename);
begin
  FDataHex.SaveToFile(Filename);
end;

procedure THexFile.LoadHexFile(Filename: TFilename);
begin
  FDataHex.LoadFromFile(Filename);
  FLastUpdate:= luHex;
  if FAutoUpdate and (not FUpdating) then Update;
end;

procedure THexFile.DataBinToBuffer(var Buffer);
begin
  Move(FDataBin^,Buffer,FDataSize);
end;

procedure THexFile.BufferToDataBin(var Buffer);
begin
  Move(Buffer,FDataBin^,FDataSize);
  FLastUpdate:= luBin;
  if FAutoUpdate and (not FUpdating) then Update;
end;

procedure THexFile.DataUsedToBuffer(var Buffer);
begin
  Move(FDataUsed^,Buffer,FDataSize);
end;

procedure THexFile.BufferToDataUsed(var Buffer);
begin
  Move(Buffer,FDataUsed^,FDataSize);
  FLastUpdate:= luBin;
  if FAutoUpdate and (not FUpdating) then Update;
end;

procedure THexFile.BeginUpdate;
begin
  FUpdating:= true;
end;

procedure THexFile.EndUpdate;
begin
  FUpdating:= false;
  if FAutoUpdate and (FLastUpdate<>luNone) then Update;
end;

function THexFile.GetHexfileSize: integer;
var
  numbytes: integer;
  startaddr: integer;
  checksum: integer;
  blocktype: integer;
  i, j: integer;
  s: string;
  size: integer;
begin
  size:= 0;
  for i:= 0 to FDataHex.Count-1 do
  begin
    s:= FDataHex.Strings[i];
    if s[1]=':' then
    begin
      checksum:= 0;
      numbytes:= HexToInt(s[2]+s[3]);
      checksum:= checksum-numbytes;
      startaddr:= 256*HexToInt(s[4]+s[5])+HexToInt(s[6]+s[7]);
      checksum:= checksum-(startaddr div 256);
      checksum:= checksum-(startaddr mod 256);
      blocktype:= HexToInt(s[8]+s[9]);
      checksum:= checksum-blocktype;
      if blocktype=0 then
      begin
        size:= startaddr+numbytes;
        for j:= 0 to numbytes-1 do
          checksum:= checksum-DataBin[usba+startaddr+j];
        if byte(checksum)<>HexToInt(s[10+numbytes*2]+s[11+numbytes*2]) then
          raise Exception.Create(STR_ERR_CHECKSUM + #13+#13+' '+ IntToHex(byte(checksum),2) + ' <> ' + s[10+numbytes*2]+s[11+numbytes*2]);
      end
      else if blocktype=1 then
      begin
        if s<>':00000001FF' then
          raise Exception.Create(STR_ERR_NOEND);
        break;
      end
        else if blocktype=2 then
        begin
          usba:= 256*HexToInt(s[10]+s[11])+HexToInt(s[12]+s[13]);
        end      
      else
        raise Exception.Create(STR_ERR_UNKBLOCK);
    end
    else
      raise Exception.Create(STR_ERR_NODOTS);
  end; //for
  GetHexfileSize:= usba+size;
end;

procedure Register;
begin
  RegisterComponents('Extras', [THexFile]);
end;

end.
