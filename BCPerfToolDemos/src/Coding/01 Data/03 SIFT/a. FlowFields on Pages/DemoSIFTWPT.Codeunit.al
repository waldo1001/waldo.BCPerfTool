codeunit 62206 "Demo - SIFT WPT"
{
    #region SubscribersToStopTheTimer
    [EventSubscriber(ObjectType::Page, page::"Just Some Colors (Bad) WPT", 'OnAfterGetCurrRecordEvent', '', true, true)]
    local procedure StopPerfLogging1()
    var
        PerfToolWPT: Codeunit "PerfTool WPT";
    begin
        PerfToolWPT.Stop();
    end;

    [EventSubscriber(ObjectType::Page, page::"Just Some Colors (Good) WPT", 'OnAfterGetCurrRecordEvent', '', true, true)]
    local procedure StopPerfLogging2()
    var
        PerfToolWPT: Codeunit "PerfTool WPT";
    begin
        PerfToolWPT.Stop();
    end;

    [EventSubscriber(ObjectType::Page, page::"Just Some Countries BAD WPT", 'OnAfterGetCurrRecordEvent', '', true, true)]
    local procedure StopPerfLogging3()
    var
        PerfToolWPT: Codeunit "PerfTool WPT";
    begin
        PerfToolWPT.Stop();
    end;

    [EventSubscriber(ObjectType::Page, page::"Just Some Countries SIFT WPT", 'OnAfterGetCurrRecordEvent', '', true, true)]
    local procedure StopPerfLogging4()
    var
        PerfToolWPT: Codeunit "PerfTool WPT";
    begin
        PerfToolWPT.Stop();
    end;

    [EventSubscriber(ObjectType::Page, page::"Just Some Countries INCL WPT", 'OnAfterGetCurrRecordEvent', '', true, true)]
    local procedure StopPerfLogging5()
    var
        PerfToolWPT: Codeunit "PerfTool WPT";
    begin
        PerfToolWPT.Stop();
    end;
    #endregion

    #region InstallCode
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Install Suites WPT", 'OnInstallAppPerCompanyFillSuite', '', false, false)]
    local procedure OnAfterInsertSuiteGroup();

    var
        PerfToolSuiteHeaderWPT: Record "PerfTool Suite Header WPT";
        WPTSuiteLine: Record "PerfTool Suite Line WPT";
        PerfToolGroupWPT: Record "PerfTool Group WPT";
        CreatePerfToolDataLibraryWPT: Codeunit "Create PerfToolDataLibrary WPT";
    begin
        CreatePerfToolDataLibraryWPT.CreateGroup('01.DATA', 'Data Access', PerfToolGroupWPT);

        CreatePerfToolDataLibraryWPT.CreateSuite(PerfToolGroupWPT, '3.a Flowfields', 'FlowFields on Pages', PerfToolSuiteHeaderWPT);
        CreatePerfToolDataLibraryWPT.CreateSuiteLine(PerfToolSuiteHeaderWPT, WPTSuiteLine."Object Type"::Page, page::"Just Some Colors (Bad) WPT", true, false, WPTSuiteLine);
        CreatePerfToolDataLibraryWPT.CreateSuiteLine(PerfToolSuiteHeaderWPT, WPTSuiteLine."Object Type"::Page, page::"Just Some Colors (Good) WPT", true, false, WPTSuiteLine);
        CreatePerfToolDataLibraryWPT.CreateSuiteLine(PerfToolSuiteHeaderWPT, WPTSuiteLine."Object Type"::Page, page::"Just Some Countries BAD WPT", true, false, WPTSuiteLine);
        CreatePerfToolDataLibraryWPT.CreateSuiteLine(PerfToolSuiteHeaderWPT, WPTSuiteLine."Object Type"::Page, page::"Just Some Countries SIFT WPT", true, false, WPTSuiteLine);
        CreatePerfToolDataLibraryWPT.CreateSuiteLine(PerfToolSuiteHeaderWPT, WPTSuiteLine."Object Type"::Page, page::"Just Some Countries INCL WPT", true, false, WPTSuiteLine);
    end;
    #endregion
}