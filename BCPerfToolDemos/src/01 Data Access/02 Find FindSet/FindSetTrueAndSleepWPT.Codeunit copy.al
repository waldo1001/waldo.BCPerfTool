#pragma warning disable AA0181, AA0175
codeunit 62243 "FindSetTrueAndSleep WPT"
{
    trigger OnRun()
    var
        EmptyTableWPT: Record "EmptyTable WPT";
    begin
        EmptyTableWPT.Setrange(Code, 'NotExist');
        if EmptyTableWPT.FindSet(true) then;

        Sleep(10000); //keep the transaction locked for 10 seconds
    end;
}