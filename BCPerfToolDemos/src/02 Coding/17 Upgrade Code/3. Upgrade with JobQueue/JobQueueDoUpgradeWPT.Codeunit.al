codeunit 62297 "JobQueue DoUpgrade WPT"
{
    trigger OnRun()
    var
        UpgradeTag: Codeunit "Upgrade Tag";
    begin
        if UpgradeTag.HasUpgradeTag(JobQueueUpgradeLbl) then exit;

        PerformUpgrade();

        UpgradeTag.SetUpgradeTag(JobQueueUpgradeLbl);
    end;

    procedure ScheduleUpgrade() // can be local
    var
        JobQueueEntry: Record "Job Queue Entry";
        UpgradeTag: Codeunit "Upgrade Tag";
        RecId: RecordId;
    begin
        if UpgradeTag.HasUpgradeTag(JobQueueUpgradeLbl) then exit;

        JobQueueEntry.ScheduleJobQueueEntry(Codeunit::"JobQueue DoUpgrade WPT", RecId);
    end;

    local procedure PerformUpgrade()
    begin
        ClassicCopyFields();
        ClassicCopyRows();
    end;

    procedure ClassicCopyFields()
    var
        Source: Record "Table With Obsolete Fields WPT";
        Target: Record "Table With New Fields WPT";
    begin
        if Source.FindSet() then
            repeat
                if not Target.get(Source."Entry No.") then exit;

                Target.Message := Source.Message;
                Target."Message 2" := Source."Message 2";
                Target.Modify();
            until Source.Next() < 1;
    end;

    procedure ClassicCopyRows()
    var
        Source: Record "Obsolete Table WPT";
        Target: Record "New Table WPT";
    begin
        Target.DeleteAll(); // Obviously - don't do this in realy upgrade code ;-)

        if Source.FindSet() then
            repeat
                Target."Entry No." := Source."Entry No.";
                Target.Message := Source.Message;
                Target."Message 2" := Source."Message 2";
                //...
                Target.Insert();
            until Source.Next() < 1;
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Upgrade Tag", 'OnGetPerCompanyUpgradeTags', '', false, false)]
    local procedure OnGetPerCompanyUpgradeTags(var PerCompanyUpgradeTags: List of [Code[250]]);
    begin
        PerCompanyUpgradeTags.Add(JobQueueUpgradeLbl);
    end;


    var
        JobQueueUpgradeLbl: Label 'waldo-JobQueueUpgrade-20221213', Locked = true;
}