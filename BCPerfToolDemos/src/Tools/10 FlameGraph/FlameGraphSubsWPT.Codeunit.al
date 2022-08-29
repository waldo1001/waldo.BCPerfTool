codeunit 62265 "FlameGraph Subs WPT"
{
    EventSubscriberInstance = Manual;

    //Slowing down
    [EventSubscriber(ObjectType::Codeunit, codeunit::"Page Management", 'OnAfterGetPageID', '', false, false)]
    local procedure OnAfterGetPageID(var PageID: Integer)
    begin
        if PageID = page::"Sales Invoice" then sleep(100);
    end;

    [EventSubscriber(ObjectType::Page, page::"Sales Invoice", 'OnOpenPageEvent', '', false, false)]
    local procedure OnOpenPageEvent()
    begin
        sleep(100);
    end;

    [EventSubscriber(ObjectType::Page, page::"Sales Invoice", 'OnAfterGetCurrRecordEvent', '', false, false)]
    local procedure OnAfterGetCurrRecordEvent()
    begin
        sleep(100);
    end;

    [EventSubscriber(ObjectType::Page, page::"Sales Invoice", 'OnAfterOnAfterGetRecord', '', false, false)]
    local procedure OnAfterOnAfterGetRecord()
    begin
        sleep(100);
    end;

    [EventSubscriber(ObjectType::Page, page::"Sales Invoice Subform", 'OnAfterGetRecordEvent', '', false, false)]
    local procedure OnAfterGetRecordEvent()
    begin
        sleep(100);
    end;
}