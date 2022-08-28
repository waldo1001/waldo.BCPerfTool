codeunit 62258 "Install - Big Ext. Table 3 WPT"
{
    trigger OnRun()
    begin
        InsertBigTable();
    end;

    procedure InsertBigTable()
    var
        JustSomeTable: Record "Just Some Extended Table 3 WPT";
        InstallDemoDataWPT: Codeunit "Install Demo Data WPT";
        i: integer;
    begin
        if not JustSomeTable.IsEmpty then exit;

        for i := 1 to 500000 do
            JustSomeTable.Create(InstallDemoDataWPT.RandomText(random(50)), i);
    end;
}