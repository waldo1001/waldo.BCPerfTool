codeunit 62201 "Install Suites WPT"
{
    Subtype = Install;

    trigger OnInstallAppPerCompany()
    begin
        // ResetAll();
        FillSuite();
    end;

    procedure FillSuite()
    // var
    //     WPTGroup: Record "PerfTool Group WPT";
    //     Library: Codeunit "Create PerfToolDataLibrary WPT";
    begin
        OnInstallAppPerCompanyFillSuite();

        // Library.CreateGroup('1.DATA', 'Data Access', WPTGroup);
        // Library.CreateGroup('2.CODING', 'Coding 4 Performance', WPTGroup);

        //The suites will be created in the demo-codeunits (by subscribing to "OnAfterInsertSuiteGroup")
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