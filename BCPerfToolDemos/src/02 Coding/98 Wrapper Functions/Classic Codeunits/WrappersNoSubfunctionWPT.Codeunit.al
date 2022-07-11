codeunit 62215 "Wrappers - No Subfunction WPT"
{
    trigger OnRun()
    var
        myGuid: Guid;
        Result: Text;
        i: Integer;
    begin
        myGuid := '{f4d9885c-8df6-401f-8a90-3286b814fe0a}';

        for i := 0 to 1000000 do
            Result := format(myGuid, 0, 4);
    end;
}