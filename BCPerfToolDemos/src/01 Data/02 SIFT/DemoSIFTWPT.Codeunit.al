codeunit 62206 "Demo - SIFT WPT"
{
    [EventSubscriber(ObjectType::Page, page::"Just Some Colors WPT", 'OnAfterGetCurrRecordEvent', '', true, true)]
    local procedure StopPerfLogging1()
    var
        PerfToolWPT: Codeunit "PerfTool WPT";
    begin
        PerfToolWPT.Stop();
    end;

    [EventSubscriber(ObjectType::Page, page::"Just Some Countries WPT", 'OnAfterGetCurrRecordEvent', '', true, true)]
    local procedure StopPerfLogging2()
    var
        PerfToolWPT: Codeunit "PerfTool WPT";
    begin
        PerfToolWPT.Stop();
    end;






    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Create PerfToolDataLibrary WPT", 'OnAfterInsertSuiteGroup', '', false, false)]
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Install Suites WPT", 'OnInstallAppPerCompanyFillSuite', '', false, false)]
    local procedure OnAfterInsertSuiteGroup();

    var
        PerfToolSuiteHeaderWPT: Record "PerfTool Suite Header WPT";
        WPTSuiteLine: Record "PerfTool Suite Line WPT";
        PerfToolGroupWPT: Record "PerfTool Group WPT";
        CreatePerfToolDataLibraryWPT: Codeunit "Create PerfToolDataLibrary WPT";
    begin
        CreatePerfToolDataLibraryWPT.CreateGroup('1.DATA', 'Data Access', PerfToolGroupWPT);

        CreatePerfToolDataLibraryWPT.CreateSuite(PerfToolGroupWPT, '2. Flowfields', 'FlowFields', PerfToolSuiteHeaderWPT);
        CreatePerfToolDataLibraryWPT.CreateSuiteLine(PerfToolSuiteHeaderWPT, WPTSuiteLine."Object Type"::Page, page::"Just Some Colors WPT", true, true, WPTSuiteLine);
        CreatePerfToolDataLibraryWPT.CreateSuiteLine(PerfToolSuiteHeaderWPT, WPTSuiteLine."Object Type"::Page, page::"Just Some Countries WPT", true, true, WPTSuiteLine);
    end;
}