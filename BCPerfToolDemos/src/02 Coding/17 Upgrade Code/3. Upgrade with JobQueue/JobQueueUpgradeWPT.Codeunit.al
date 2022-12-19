
codeunit 62298 "JobQueue Upgrade WPT"
{
    Subtype = Upgrade;

    trigger OnUpgradePerCompany()
    var
        JobQueueUpgradeWPT: Codeunit "JobQueue DoUpgrade WPT";
    begin
        JobQueueUpgradeWPT.ScheduleUpgrade();
    end;
}