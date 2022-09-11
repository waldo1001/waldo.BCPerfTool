codeunit 62239 "DeleteAllWaldosAndSleep WPT"
{
    trigger OnRun()
    var
        EmptyTableWPT: Record "EmptyTable WPT";
    begin
        EmptyTableWPT.Setrange(Code, 'WALDO');
        EmptyTableWPT.DeleteAll(true);

        Sleep(10000); //keep the transaction locked for 10 seconds
    end;
}