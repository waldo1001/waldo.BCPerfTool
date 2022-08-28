codeunit 62255 "Install - Big Table WPT"
{
    trigger OnRun()
    begin
        InsertBigTable();
    end;

    procedure InsertBigTable()
    var
        JustSomeTable: Record "Just Some Table WPT";
        InstallDemoDataWPT: Codeunit "Install Demo Data WPT";
        i: integer;
    begin
        if not JustSomeTable.IsEmpty then exit;

        for i := 1 to 500000 do
            JustSomeTable.Create(InstallDemoDataWPT.RandomText(random(50)), i);
    end;
}