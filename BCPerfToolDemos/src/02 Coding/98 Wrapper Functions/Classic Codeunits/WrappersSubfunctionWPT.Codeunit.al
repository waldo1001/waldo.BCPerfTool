codeunit 62214 "Wrappers - Subfunction WPT"
{
    trigger OnRun()
    var
        myGuid: Guid;
        Result: Text;
        i: Integer;
    begin
        myGuid := '{f4d9885c-8df6-401f-8a90-3286b814fe0a}';

        for i := 0 to 1000000 do
            Result := TrimBrackets(myGuid);
    end;

    local procedure TrimBrackets(var myGuid: guid): Text
    begin
        exit(format(myGuid, 0, 4));
    end;
}