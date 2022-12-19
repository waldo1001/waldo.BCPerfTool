codeunit 62288 "OnModifyHell Subs WPT"
{
    [EventSubscriber(ObjectType::Table, database::Customer, 'OnAfterModifyEvent', '', false, false)]
    local procedure ShowMessage()
    begin
        Message('OnAfterModifyEvent');
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Global Triggers", 'GetDatabaseTableTriggerSetup', '', false, false)]
    local procedure GetDatabaseTableTriggerSetup(TableId: Integer; var OnDatabaseModify: Boolean)
    begin
        if TableId = database::Customer then
            OnDatabaseModify := true;
    end;

    [EventSubscriber(ObjectType::Codeunit, codeunit::GlobalTriggerManagement, 'OnBeforeOnDatabaseModify', '', false, false)]
    local procedure OnBeforeOnDatabaseModify()
    begin
        // Message('OnBeforeOnDatabaseModify');
    end;

}