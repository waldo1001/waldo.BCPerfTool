codeunit 62230 "Some Business Logic WPT"
{
    trigger OnRun()
    var
        EmptyTableWPT: Record "EmptyTable WPT";
        EnvironmentInformation: Codeunit "Environment Information";
        i: integer;
        cnt: Integer;
    begin
        cnt := 5000;

        if EnvironmentInformation.IsSaaS() then
            cnt := 500;

        for i := 1 to cnt do
            EmptyTableWPT.InsertWaldo(false, format(i));
    end;
}