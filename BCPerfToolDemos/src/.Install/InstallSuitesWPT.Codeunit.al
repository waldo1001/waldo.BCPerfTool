codeunit 62201 "Install Suites WPT"
{
    Subtype = Install;

    trigger OnInstallAppPerCompany()
    begin
        FillSuite();
    end;

    procedure FillSuite()
    var
        PerfToolTriggersWPT: Codeunit "PerfTool Triggers WPT";
    begin
        PerfToolTriggersWPT.OnGetSuiteData();
    end;
}