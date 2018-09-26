//Statnosdfgsdgsdfg
unit Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, VaComm, VaSystem, Vcl.StdCtrls, VaClasses, Vcl.ExtCtrls, Vcl.ComCtrls;

type
  TForm7 = class(TForm)
    VaComm1: TVaComm;
    Memo1: TMemo;
    Edit1: TEdit;
    mmoRX: TMemo;
    VaCapture1: TVaCapture;
    Button1: TButton;
    Button2: TButton;
    Timer1: TTimer;
    Button3: TButton;
    OpenDialog1: TOpenDialog;
    Button4: TButton;
    Button5: TButton;
    ProgressBar1: TProgressBar;
    procedure VaCapture1Message(Sender: TObject; const Data: AnsiString);
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
  private
    { Private declarations }
  public
  n:integer;
    { Public declarations }

  end;

var
  Form7: TForm7;

implementation

{$R *.dfm}

procedure TForm7.Button1Click(Sender: TObject);
begin
VaComm1.WriteText(Edit1.Text+CHR(13));
end;

procedure TForm7.Button2Click(Sender: TObject);
begin
n:=0;
Timer1.Enabled := true;

end;


procedure TForm7.Button3Click(Sender: TObject);
begin
if OpenDialog1.Execute then
  Memo1.Lines.LoadFromFile(OpenDialog1.FileName);
  ProgressBar1.max := Memo1.Lines.Count;
end;

procedure TForm7.Button4Click(Sender: TObject);
begin
mmoRX.Lines.Clear;
end;

procedure Delay(dwMilliseconds: Longint);
var
  iStart, iStop: Longint;
begin
  iStart := System.Classes.TThread.GetTickCount;
  repeat
    iStop := System.Classes.TThread.GetTickCount;
    Application.ProcessMessages;
    Sleep(1);
  until (iStop - iStart) >= dwMilliseconds;
end;


procedure TForm7.Button5Click(Sender: TObject);
begin
VaComm1.WriteText('H'+CHR(13));
Delay(200);
VaComm1.WriteText('SOF'+CHR(13));
Delay(200);
VaComm1.WriteText('CF000000'+CHR(13));
Delay(200);
end;

//Troppo complicato
////////////////////////////345345345345345
///Un altra modifica
procedure TForm7.FormCreate(Sender: TObject);
begin
VaCapture1.DataFinish := CHR(13);
ProgressBar1.max := Memo1.Lines.Count;
end;

procedure TForm7.Timer1Timer(Sender: TObject);
begin
Timer1.Enabled := False;
VaComm1.WriteText(Memo1.Lines[n]+CHR(13));
inc(n);
ProgressBar1.Position:= n;
if n < memo1.Lines.Count then
Timer1.Enabled := true
else
begin
  Delay(50);
VaComm1.WriteText('H'+CHR(13));
end;

end;

procedure TForm7.VaCapture1Message(Sender: TObject; const Data: AnsiString);
begin
mmoRX.Lines.Add(Data);
end;

end.
