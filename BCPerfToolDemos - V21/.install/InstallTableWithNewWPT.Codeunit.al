codeunit 62402 "Install - Table With New WPT"
{
    trigger OnRun()
    begin
        InsertBigTable();
    end;

    procedure InsertBigTable()
    var
        TableWithNewFieldsWPT: Record "Table With New Fields WPT";
        InstallDemoDataWPT: Codeunit "Install Demo Data WPT";
        i: integer;
    begin
        if not TableWithNewFieldsWPT.IsEmpty then exit;

        for i := 1 to 10000 do
            TableWithNewFieldsWPT.Create(InstallDemoDataWPT.RandomText(random(50)), i);
    end;
}