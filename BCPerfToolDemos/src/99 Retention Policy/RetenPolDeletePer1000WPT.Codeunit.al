codeunit 62213 "Reten. Pol. DeletePer1000 WPT" implements "Reten. Pol. Deleting"
{
    var
        TooManyRecordsToDeleteLbl: Label 'Reached the maximum number of records that can be deleted at the same time. The maximum number allowed is %1.', Comment = '%1 = integer';
    // LimitNumberOfRecordsLbl: Label 'Limited the number of records to delete for table %1, %2 to %3 records. The maximum number of records that can be deleted at the same time is %4, and %5 records were previously deleted in one or more tables.', Comment = '%1 = a id of a table (integer), %2 = the caption of the table, %3, %4, %5 = integer';
    // MissingReadPermissionLbl: Label 'Unable to check number of records to delete due to missing read permission for table %1, %2', Comment = '%1 = table number, %2 = table caption';

    procedure DeleteRecords(var RecordRef: RecordRef; var RetenPolDeletingParam: Record "Reten. Pol. Deleting Param" temporary);
    var
        RetentionPolicyLog: Codeunit "Retention Policy Log";
        Gone: Integer;
        ToGo: Integer;
    begin

        if RecordRef.IsEmpty then exit;

        if (RecordRef.Count() > (RetenPolDeletingParam."Max. Number of Rec. To Delete")) then begin
            RetentionPolicyLog.LogWarning(LogCategory(), StrSubstNo(TooManyRecordsToDeleteLbl, RetenPolDeletingParam."Total Max. Nr. of Rec. to Del."));
            ToGo := RetenPolDeletingParam."Total Max. Nr. of Rec. to Del.";
        end;

        Gone := 0;
        ToGo := RecordRef.Count;
        while (ToGo > NumberOfRecordsToDelete()) and (Gone < RetenPolDeletingParam."Total Max. Nr. of Rec. to Del.") do begin
            LimitRecordsToBeDeleted(RecordRef, NumberOfRecordsToDelete());
            RecordRef.DeleteAll(true);
            RecordRef.MarkedOnly(false);

            Commit();

            RetentionPolicyLog.LogInfo(LogCategory(), StrSubstNo('Deleted %1 records. %2 to go!', NumberOfRecordsToDelete(), ToGo));
            Sleep(100);

            ToGo := RecordRef.Count;
            Gone += NumberOfRecordsToDelete();
        end;

        RecordRef.DeleteAll();

        RecordRef.Close();
    end;

    local procedure LimitRecordsToBeDeleted(var RecordRef: RecordRef; MaxNumberOfRecordsToDelete: Integer)
    begin
        if RecordRef.MarkedOnly() then
            UnmarkRecordsToLimit(RecordRef, MaxNumberOfRecordsToDelete)
        else
            MarkRecordsToLimit(RecordRef, MaxNumberOfRecordsToDelete);

    end;

    local procedure UnmarkRecordsToLimit(var RecordRef: RecordRef; StartRecordIndex: Integer)
    begin
        RecordRef.FindSet();
        RecordRef.Next(StartRecordIndex);
        RecordRef.MarkedOnly(false);
        repeat
            RecordRef.Mark(false);
        until RecordRef.Next() = 0;
        RecordRef.MarkedOnly(true);
    end;

    local procedure MarkRecordsToLimit(var RecordRef: RecordRef; RecordCount: Integer)
    var
        i: integer;
    begin
        RecordRef.FindSet();
        repeat
            RecordRef.Mark(true);
            i += 1;
            if RecordRef.Next() = 0 then
                i := RecordCount;
        until i >= RecordCount;
        RecordRef.MarkedOnly(true);
    end;

    local procedure NumberOfRecordsToDelete(): Integer
    begin
        exit(1000)
    end;

    local procedure LogCategory(): Enum "Retention Policy Log Category"
    var
        RetentionPolicyLogCategory: Enum "Retention Policy Log Category";
    begin
        exit(RetentionPolicyLogCategory::"Retention Policy - Apply");
    end;
}