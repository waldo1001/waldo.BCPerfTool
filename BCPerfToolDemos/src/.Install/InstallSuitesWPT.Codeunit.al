codeunit 62201 "Install Suites WPT"
{
    Subtype = Install;

    trigger OnInstallAppPerCompany()
    begin
        // ResetAll();
        FillSuite();
    end;

    procedure FillSuite()
    var
        WPTGroup: Record "PerfTool Group WPT";
        WPTSuite: Record "PerfTool Suite Header WPT";
        WPTSuiteLine: Record "PerfTool Suite Line WPT";
        Library: Codeunit "Create PerfToolDataLibrary WPT";
    begin
        Library.CreateGroup('1.DATA', 'Data Access', WPTGroup);
        Library.CreateSuite(WPTGroup, '1. Looping', 'Find, Findset, ..', WPTSuite);
        Library.CreateSuiteLine(WPTSuite, WPTSuiteLine."Object Type"::Table, database::"Just Some Table WPT", true, WPTSuiteLine);
        Library.CreateSuite(WPTGroup, '2. Flowfields', 'FlowFields', WPTSuite);
        Library.CreateSuiteLine(WPTSuite, WPTSuiteLine."Object Type"::Page, page::"Just Some Colors WPT", true, WPTSuiteLine);
        Library.CreateSuiteLine(WPTSuite, WPTSuiteLine."Object Type"::Page, page::"Just Some Countries WPT", true, WPTSuiteLine);

        Library.CreateGroup('2.CODING', 'Coding 4 Performance', WPTGroup);

    end;

    procedure ResetAll()
    var
        PerfToolGroupWPT: Record "PerfTool Group WPT";
        PerfToolSuiteHeaderWPT: Record "PerfTool Suite Header WPT";
    begin
        PerfToolSuiteHeaderWPT.DeleteAll(true);
        PerfToolGroupWPT.DeleteAll(true);
    end;
}