codeunit 62279 "Demo - The Demo App WPT"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Install Suites WPT", 'OnInstallAppPerCompanyFillSuite', '', false, false)]
    local procedure OnAfterInsertSuiteGroup();
    var
        PerfToolSuiteHeaderWPT: Record "PerfTool Suite Header WPT";
        WPTSuiteLine: Record "PerfTool Suite Line WPT";
        PerfToolGroupWPT: Record "PerfTool Group WPT";
        CreatePerfToolDataLibraryWPT: Codeunit "Create PerfToolDataLibrary WPT";
    begin
        CreatePerfToolDataLibraryWPT.CreateGroup('0.Demo', 'The Demo App', PerfToolGroupWPT);

        CreatePerfToolDataLibraryWPT.CreateSuite(PerfToolGroupWPT, '2. Demo App', 'What''s in the demo app?', PerfToolSuiteHeaderWPT);

        CreatePerfToolDataLibraryWPT.CreateSuiteLine(PerfToolSuiteHeaderWPT, WPTSuiteLine."Object Type"::Table, database::"Just Some Table WPT", false, false, WPTSuiteLine);
        CreatePerfToolDataLibraryWPT.CreateSuiteLine(PerfToolSuiteHeaderWPT, WPTSuiteLine."Object Type"::Table, database::"Just Some Extended Table 1 WPT", false, false, WPTSuiteLine);
        CreatePerfToolDataLibraryWPT.CreateSuiteLine(PerfToolSuiteHeaderWPT, WPTSuiteLine."Object Type"::Table, database::"Just Some Extended Table 2 WPT", false, false, WPTSuiteLine);
        CreatePerfToolDataLibraryWPT.CreateSuiteLine(PerfToolSuiteHeaderWPT, WPTSuiteLine."Object Type"::Table, database::"Just Some Extended Table 3 WPT", false, false, WPTSuiteLine);
        CreatePerfToolDataLibraryWPT.CreateSuiteLine(PerfToolSuiteHeaderWPT, WPTSuiteLine."Object Type"::Table, database::"Just Some Extended Table 4 WPT", false, false, WPTSuiteLine);

    end;
}