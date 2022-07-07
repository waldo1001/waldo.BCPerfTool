codeunit 62211 "OverruleRetentionPolicy WPT"
{
    [EventSubscriber(ObjectType::Table, database::"Reten. Pol. Deleting Param", 'OnAfterValidateEvent', 'Max. Number of Rec. to Delete', true, true)]
    local procedure SetNuwNumber(var Rec: Record "Reten. Pol. Deleting Param")
    begin
        rec."Max. Number of Rec. to Delete" := 999;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Apply Retention Policy", 'OnApplyRetentionPolicyRecordLimitExceeded', '', false, false)]
    local procedure OnApplyRetentionPolicyRecordLimitExceeded(CurrTableId: Integer; NumberOfRecordsRemainingToBeDeleted: Integer; ApplyAllRetentionPolicies: Boolean; UserInvokedRun: Boolean; var Handled: Boolean);
    begin
        Message('NumberOfRecordsRemainingToBeDeleted: %1', NumberOfRecordsRemainingToBeDeleted);
    end;

}