codeunit 62401 "Install Demo Data v21 WPT"
{
    Subtype = Install;

    trigger OnInstallAppPerCompany()
    begin
        FillData();
    end;

    procedure FillData()
    begin
        InsertBigTables();
    end;

    local procedure InsertBigTables()
    var
        TableWithObsoleteFieldsWPT: Record "Table With Obsolete Fields WPT";
        TableWithNewFieldsWPT: Record "Table With New Fields WPT";
        ObsoleteTableWPT: Record "Obsolete Table WPT";
        JobQueueEntry1: Record "Job Queue Entry";
        JobQueueEntry2: Record "Job Queue Entry";
        JobQueueEntry3: Record "Job Queue Entry";

        RecId: Recordid;
    begin
        if TableWithObsoleteFieldsWPT.IsEmpty then
            JobQueueEntry1.ScheduleJobQueueEntry(codeunit::"Install - Table With Obs WPT", RecId);
        if TableWithNewFieldsWPT.IsEmpty then
            JobQueueEntry2.ScheduleJobQueueEntry(codeunit::"Install - Table With New WPT", RecId);
        if ObsoleteTableWPT.IsEmpty then
            JobQueueEntry3.ScheduleJobQueueEntry(Codeunit::"Install - Obsolete Table WPT", RecId);

    end;

}