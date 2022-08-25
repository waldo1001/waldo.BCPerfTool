codeunit 62247 "UselessOnAfterGetRecord WPT"
{
    [EventSubscriber(ObjectType::page, page::"Customer List", 'OnAfterGetCurrRecordEvent', '', false, false)]
    local procedure DoSomethingHeavy()
    begin
        Sleep(100);
    end;
}