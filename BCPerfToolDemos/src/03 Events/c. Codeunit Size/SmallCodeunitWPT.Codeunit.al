codeunit 62217 "SmallCodeunit WPT"
{
    [EventSubscriber(ObjectType::Codeunit, codeunit::"Demo - Codeunit Size WPT", 'OnAfterDoingSomething', '', false, false)]
    local procedure MyProcedure()
    begin
        // SomeFunction();
    end;

    local procedure SomeFunction()
    var
        i: Integer;
    begin
        for i := 1 to 1000 do;
    end;
}