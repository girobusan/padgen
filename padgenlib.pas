unit padgenlib;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, Process;

type
  T5bytes = array of byte;

function CreatePad(pages: integer = 10; linespage: integer = 20;
  columns: integer = 6): ansistring;

implementation

function createLine(c: integer): string;
var
  dn: integer;
  i: integer;
  r: string = '';
begin
  dn := c * 5 + (c - 1);
  for i := 1 to dn do
    r += '-';
  Result := r
end;

function getNums(b: T5bytes): ansistring;
var
  i: integer;
  ns: string = '';
begin
  for i := 0 to (length(b) - 1) do
  begin
    ns += IntToStr(b[i] mod 10);
  end;
  Result := ns
end;

function CreatePad(pages: integer = 10; linespage: integer = 20;
  columns: integer = 6): ansistring;
var

  Buffer: array of byte; //array[1..BUF_SIZE]  of byte;
  sbuffer: byte = 0; //small buffer
  Counter: integer;
  devrnd: file;
  padStr: string = '';
  p: integer;
begin
  if pages*linespage*columns=0 then begin
    Result:='';
    Exit
  end;

  AssignFile(devrnd, '/dev/random');
  Reset(devrnd, sizeOf(byte));

  for  p := 1 to pages do
  begin
    ///////////////ONE PAGE//////////////////////
    padstr += createLine(columns) + sLineBreak;
    Counter := 0;
    repeat
      counter += 1;
      //read five bytes
      SetLength(Buffer, 0);
      repeat
        Blockread(devrnd, sBuffer, 1); //read one byte
        if sBuffer > 250 then
          Continue;

        SetLength(Buffer, Length(Buffer) + 1);
        Buffer[Length(Buffer) - 1] := sBuffer;
      until Length(buffer) = 5;

      if (counter mod columns = 0) then
        padStr += getNums(Buffer) + sLineBreak
      else
        padStr += getNums(Buffer) + ' ';
    until counter = linespage * columns;  // Stop

    ////////////PAGE READY///////////////////////
  end;
  padstr += createLine(columns);
  Result := padStr
end;

end.
