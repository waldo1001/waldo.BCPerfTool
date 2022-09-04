codeunit 62404 "Install - Obsolete Table WPT"
{
    trigger OnRun()
    begin
        InsertBigTable();
    end;

    procedure InsertBigTable()
    var
        ObsoleteTableWPT: Record "Obsolete Table WPT";
        InstallDemoDataWPT: Codeunit "Install Demo Data WPT";
        i: integer;
    begin
        if not ObsoleteTableWPT.IsEmpty then exit;

        for i := 1 to 10000 do
            ObsoleteTableWPT.Create(InstallDemoDataWPT.RandomText(random(50)), i);
    end;
}