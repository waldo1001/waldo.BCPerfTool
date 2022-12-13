codeunit 62294 "Install - Obsolete Fields WPT"
{
    trigger OnRun()
    begin
        InsertBigTable();
    end;

    procedure InsertBigTable()
    var
        TableWithObsoleteFieldsWPT: Record "Table With Obsolete Fields WPT";
        InstallDemoDataWPT: Codeunit "Install Demo Data WPT";
        i: integer;
    begin
        if not TableWithObsoleteFieldsWPT.IsEmpty then exit;

        for i := 1 to 10000 do
            TableWithObsoleteFieldsWPT.Create(InstallDemoDataWPT.RandomText(random(50)), i);
    end;
}