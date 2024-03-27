#pragma warning disable AA0181, AA0175
codeunit 62250 "Lock Cont NOLockTable WPT"
{
    trigger OnRun()
    var
        JustSomeTable, JustSomeTable2, JustSomeTable3 : Record "Contact";
        fkey: Record "Feature Key";
    begin
        SelectLatestVersion();

        fkey.Get('TriStateLocking'); // bugfix - get tristatelocking in background session
        JustSomeTable.FindLast();

        // lots of code
        sleep(500);

        JustSomeTable2.Init();
        // JustSomeTable2.Id := JustSomeTable.Id + 1;
        if (JustSomeTable2.Insert(true)) then; //This is a lock, of course

        // lots of code
        sleep(500);

        JustSomeTable3.FindSet(); //Shoud be "readcommitted"

        Sleep(10000); //Should not hold the lock (readcommitted)
    end;
}