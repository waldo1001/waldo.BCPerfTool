codeunit 62216 "Wrappers - No Subfunction2 WPT"
{
    trigger OnRun()
    var
        myGuid: Guid;
        Result: Text;
        i: Integer;
    begin
        myGuid := '{f4d9885c-8df6-401f-8a90-3286b814fe0a}';

        for i := 0 to 1000000 do
            Result := format(myGuid).TrimStart('{').TrimEnd('}');
    end;
}