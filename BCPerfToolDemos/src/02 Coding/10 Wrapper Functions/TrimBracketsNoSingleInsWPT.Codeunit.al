codeunit 62221 "TrimBrackets - NoSingleIns WPT"
{
    procedure TrimBrackets(var myGuid: guid): Text
    begin
        exit(format(myGuid, 0, 4));
    end;
}