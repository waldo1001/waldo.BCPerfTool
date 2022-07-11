codeunit 62220 "TrimBrackets - SingleInst WPT"
{
    SingleInstance = true;

    procedure TrimBrackets(var myGuid: guid): Text
    begin
        exit(format(myGuid, 0, 4));
    end;

}