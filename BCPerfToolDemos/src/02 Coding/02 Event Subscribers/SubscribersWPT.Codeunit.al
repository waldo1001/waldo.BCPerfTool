codeunit 62228 "Subscribers WPT"
{
    // SingleInstance = true;
    // EventSubscriberInstance = Manual;

    // [EventSubscriber(ObjectType::Table, Database::"Just Some Table WPT", 'OnAfterModifyEvent', '', false, false)]
    // local procedure OnAfterOnModify(var Rec: Record "Just Some Table WPT"; RunTrigger: Boolean);
    // begin
    //     if not RunTrigger then exit;

    //     // That's all - I'm not doing anything in fact...
    // end;


    // [EventSubscriber(ObjectType::Table, Database::"Just Some Table WPT", 'OnAfterValidateEvent', 'Message 2', false, false)]
    // local procedure JustDoSomthing(var Rec: Record "Just Some Table WPT"; var xRec: Record "Just Some Table WPT")
    // begin
    //     if Rec.color <> 'RED' then exit; //only execute when necessary

    //     // That's all - I'm not doing anything in fact...
    // end;
}