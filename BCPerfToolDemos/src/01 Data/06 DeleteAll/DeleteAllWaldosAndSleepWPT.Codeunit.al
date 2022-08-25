codeunit 62239 "DeleteAllWaldosAndSleep WPT"
{
    trigger OnRun()
    var
        EmptyTableWLD: Record "EmptyTable WPT";
    begin
        EmptyTableWLD.Setrange(Code, 'WALDO');
        EmptyTableWLD.DeleteAll(true);

        Sleep(10000); //keep the transaction locked for 10 seconds
    end;
}