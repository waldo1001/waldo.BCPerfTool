#pragma warning disable AA0181, AA0175
codeunit 62261 "Lock Cust FindSetTrue WPT"
{
    trigger OnRun()
    var
        JustSomeTable, JustSomeTable2, JustSomeTable3 : Record "Customer";
        fkey: Record "Feature Key";
    begin
        SelectLatestVersion();

        fkey.Get('TriStateLocking'); // bugfix - get tristatelocking in background session
        // JustSomeTable.LockTable();
        JustSomeTable.FindLast();

        // lots of code

        JustSomeTable2.Init();
        // JustSomeTable2.Id := JustSomeTable.Id + 1;
        if (JustSomeTable2.Insert(true)) then; //This

        // lots of code

        JustSomeTable3.FindSet(true); //The entire set is locked!

        Sleep(10000); // Hold Lock
    end;
}