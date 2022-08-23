codeunit 62236 "Subs SingleInst WPT"
{
    SingleInstance = true;
    EventSubscriberInstance = Manual;

    [EventSubscriber(ObjectType::Table, Database::"Just Some Table WPT", 'OnAfterValidateEvent', 'Message 2', false, false)]
    local procedure JustDoSomthing(var Rec: Record "Just Some Table WPT"; var xRec: Record "Just Some Table WPT")
    begin
        if Rec.color <> 'RED' then exit; //only execute when necessary

        // That's all - I'm not doing anything in fact...
    end;
}