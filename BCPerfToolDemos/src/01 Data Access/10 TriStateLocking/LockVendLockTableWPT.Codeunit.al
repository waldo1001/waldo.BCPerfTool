#pragma warning disable AA0181, AA0175
codeunit 62245 "Lock Vend LockTable WPT"
{
    trigger OnRun()
    var
        JustSomeTable, JustSomeTable2, JustSomeTable3 : Record "Vendor";
        fkey: Record "Feature Key";
    begin
        SelectLatestVersion();

        fkey.Get('TriStateLocking'); // bugfix - get tristatelocking in background session
        JustSomeTable.LockTable();
        JustSomeTable.FindLast();

        // lots of code

        JustSomeTable2.Init();
        // JustSomeTable2.id := JustSomeTable.id + 1;
        if (JustSomeTable2.Insert(true)) then; //This

        // lots of code

        JustSomeTable3.FindSet(); //The entire set is locked!

        Sleep(10000); // Hold Lock
    end;
}