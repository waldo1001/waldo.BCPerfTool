codeunit 62228 "Subs OnModify WPT"
{
    SingleInstance = true;
    EventSubscriberInstance = Manual;

    [EventSubscriber(ObjectType::Table, Database::"Just Some Extended Table 1 WPT", 'OnAfterModifyEvent', '', false, false)]
    local procedure OnAfterOnModify(var Rec: Record "Just Some Extended Table 1 WPT"; RunTrigger: Boolean);
    begin
        if not RunTrigger then exit;

        // That's all - I'm not doing anything in fact...
    end;
}