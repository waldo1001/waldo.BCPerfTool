codeunit 62234 "Demo - PageBackGroundTasks WPT"
{
    var
        PerfToolWPT: Codeunit "PerfTool WPT";

    [EventSubscriber(ObjectType::Page, page::"Page With BackgroundTask WPT", 'OnAfterGetCurrRecordEvent', '', false, false)]
    local procedure StopLogging1()
    begin
        PerfToolWPT.Stop();
    end;

    [EventSubscriber(ObjectType::Page, page::"Page Without BackgroundTsk WPT", 'OnAfterGetCurrRecordEvent', '', false, false)]
    local procedure StopLogging2()
    begin
        PerfToolWPT.Stop();
    end;

    [EventSubscriber(ObjectType::Page, page::"ListPageWithBackgroundTask WPT", 'OnAfterGetCurrRecordEvent', '', false, false)]
    local procedure StopLogging3()
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
        CreatePerfToolDataLibraryWPT.CreateGroup('4. Background', 'Background Processing', PerfToolGroupWPT);

        CreatePerfToolDataLibraryWPT.CreateSuite(PerfToolGroupWPT, '4. BG-PageBGTasks', 'Background - Page Background Tasks', PerfToolSuiteHeaderWPT);

        CreatePerfToolDataLibraryWPT.CreateSuiteLine(PerfToolSuiteHeaderWPT, WPTSuiteLine."Object Type"::Page, page::"Page Without BackgroundTsk WPT", true, false, WPTSuiteLine);
        CreatePerfToolDataLibraryWPT.CreateSuiteLine(PerfToolSuiteHeaderWPT, WPTSuiteLine."Object Type"::Page, page::"Page With BackgroundTask WPT", true, false, WPTSuiteLine);
    end;
}