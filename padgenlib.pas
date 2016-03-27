unit padgenlib;

{$mode objfpc}{$H+}

interface

uses
    Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs,Process;
type
  T5bytes = array of byte;

function CreatePad(pages:integer=10; linespage:integer=20):ansistring;

implementation

function getNums(b:T5bytes; n:integer=5 ):ansistring;
var
    i:integer;
    tmpi:integer;
    ns:string='';
begin
  for i:=0 to n-1 do
  begin
    tmpi:=b[i] mod 10;
    ns+=IntToStr(tmpi);
  end;
  getNums:=ns;
end;

function CreatePad(pages:integer=10; linespage:integer=20):ansistring;
var
    AProcess     : TProcess;
    Buffer       : array of byte; //array[1..BUF_SIZE]  of byte;
    sbuffer      : byte=0; //small buffer
    Counter      : integer;
    Exename      : string;
    padStr       : string;
    p:integer;
begin
  Exename:= FindDefaultExecutablePath('cat');
      if Exename='' then
      begin
        CreatePad:='' ;
        Exit
      end;

    //run
    AProcess := TProcess.Create(nil);
    AProcess.Executable := Exename;
    AProcess.Parameters.Add('/dev/random');
    AProcess.Options := [poUsePipes];
    AProcess.Execute;

    for  p:=1 to pages do
    begin
///////////////ONE PAGE//////////////////////
    padstr+='-----------------------------' + sLineBreak ;
    Counter:=0;
    repeat
      counter+=1;
    //read five bytes
      SetLength(Buffer,0);
      repeat
      AProcess.Output.Read(sBuffer, 1); //read one byte
      if sBuffer>250 then Continue;

      SetLength(Buffer, Length(Buffer)+1);
      Buffer[Length(Buffer)-1]:=sBuffer;
      until Length(buffer)=5;

      //write( '(' + IntToStr(counter) + ')');
      if (counter mod 5 = 0) then padStr+=getNums(Buffer, Length(Buffer) ) + sLineBreak
      else padStr+=getNums(Buffer, Length(Buffer) ) +' ';
    until counter = linespage*5;  // Stop

////////////PAGE READY///////////////////////
    end;
    padstr+='-----------------------------';
    AProcess.Terminate(0);
    AProcess.Free;
    CreatePad:=padStr;


end;

end.

