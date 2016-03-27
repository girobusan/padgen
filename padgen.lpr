program padgen;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, Classes, SysUtils,  CustApp,padgenlib
  { you can add units after this };

type

  { TPadGen }

  TPadGen = class(TCustomApplication)
  protected
    procedure DoRun; override;
  public
    constructor Create(TheOwner: TComponent); override;
    destructor Destroy; override;
    procedure WriteHelp; virtual;
  end;

{ TPadGen }

procedure TPadGen.DoRun;
var
  ErrorMsg: String;
  Pages:Integer=10;
  Lines:Integer=20;
  Pad:String;
begin
  // quick check parameters
  ErrorMsg:=CheckOptions('hlp', ['help', 'lines', 'pages'] );
  if ErrorMsg<>'' then begin
    Writeln('Error: '+ ErrorMsg);
    Terminate;
    Exit;
  end;

  // parse parameters
  if HasOption('h', 'help') then begin
    WriteHelp;
    Terminate;
    Exit;
  end;

  if HasOption('l', 'lines') then begin
    Lines:= StrToInt( GetOptionValue('l', 'lines'))
  end;

    if HasOption('p', 'pages') then begin
    Pages:= StrToInt(GetOptionValue('p', 'pages'))
  end;

  { add your program here }
  Pad:=CreatePad(Pages, Lines);
  if Pad='' then begin
  write('Something has gone wrong. Check, if your system has "cat" ');
  writeln('installed, and you have enough rights to acsess it and to read /dev/random')
  end
  else writeln(Pad);

  // stop program loop
  Terminate;
end;

constructor TPadGen.Create(TheOwner: TComponent);
begin
  inherited Create(TheOwner);
  StopOnException:=True;
end;

destructor TPadGen.Destroy;
begin
  inherited Destroy;
end;

procedure TPadGen.WriteHelp;
begin
  { add your help code here }
  writeln ('Simple one-time-pad generator.');
  writeln('Usage: ', 'padgen', ' -p <number of pages> -l <lines per page>');
  writeln ('Defaults are 10 pages, 20 lines (5000 digits total)')
end;

var
  Application: TPadGen;
begin
  Application:=TPadGen.Create(nil);
  Application.Title:='PadGen';
  Application.Run;
  Application.Free;
end.
