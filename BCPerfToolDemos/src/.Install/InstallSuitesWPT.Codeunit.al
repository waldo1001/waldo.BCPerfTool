codeunit 62201 "Install Suites WPT"
{
    Subtype = Install;

    trigger OnInstallAppPerCompany()
    begin
        FillSuite();
    end;

    procedure FillSuite()
    begin
        OnInstallAppPerCompanyFillSuite();
    end;

    procedure ResetAll()
    var
        PerfToolLogEntryWPT: Record "PerfTool Log Entry WPT";
        PerfToolGroupWPT: Record "PerfTool Group WPT";
        PerfToolSuiteHeaderWPT: Record "PerfTool Suite Header WPT";
    begin
        PerfToolSuiteHeaderWPT.DeleteAll(true);
        PerfToolGroupWPT.DeleteAll(true);
        PerfToolLogEntryWPT.DeleteAll(true);
    end;

    [BusinessEvent(false)]
    local procedure OnInstallAppPerCompanyFillSuite()
    begin
    end;
}