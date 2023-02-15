codeunit 62216 "Demo - SIFT visibility WPT"
{
    #region SubscribersToStopTheTimer
    [EventSubscriber(ObjectType::Page, page::"Just Some Colors DynHidden WPT", 'OnAfterGetCurrRecordEvent', '', true, true)]
    local procedure StopPerfLogging1()
    var
        PerfToolWPT: Codeunit "PerfTool WPT";
    begin
        PerfToolWPT.Stop();
    end;

    [EventSubscriber(ObjectType::Page, page::"Just Some Colors Hidden WPT", 'OnAfterGetCurrRecordEvent', '', true, true)]
    local procedure StopPerfLogging2()
    var
        PerfToolWPT: Codeunit "PerfTool WPT";
    begin
        PerfToolWPT.Stop();
    end;

    [EventSubscriber(ObjectType::Page, page::"Just Some Colors Removed WPT", 'OnAfterGetCurrRecordEvent', '', true, true)]
    local procedure StopPerfLogging3()
    var
        PerfToolWPT: Codeunit "PerfTool WPT";
    begin
        PerfToolWPT.Stop();
    end;

    [EventSubscriber(ObjectType::Page, page::"Just Some Colors (Good) WPT", 'OnAfterGetCurrRecordEvent', '', true, true)]
    local procedure StopPerfLogging4()
    var
        PerfToolWPT: Codeunit "PerfTool WPT";
    begin
        PerfToolWPT.Stop();
    end;
    #endregion
    #region InstallCode
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"PerfTool Triggers WPT", 'OnGetSuiteData', '', false, false)]
    local procedure OnAfterInsertSuiteGroup();
    var
        PerfToolSuiteHeaderWPT: Record "PerfTool Suite Header WPT";
        WPTSuiteLine: Record "PerfTool Suite Line WPT";
        PerfToolGroupWPT: Record "PerfTool Group WPT";
        CreatePerfToolDataLibraryWPT: Codeunit "Create PerfToolDataLibrary WPT";
    begin
        CreatePerfToolDataLibraryWPT.CreateGroup('01.DATA', 'Data Access', PerfToolGroupWPT);
        CreatePerfToolDataLibraryWPT.CreateSuite(PerfToolGroupWPT, '03.c Ff Visibility', 'FlowFields Visibility on Pages', PerfToolSuiteHeaderWPT);
        CreatePerfToolDataLibraryWPT.CreateSuiteLine(PerfToolSuiteHeaderWPT, WPTSuiteLine."Object Type"::Page, page::"Just Some Colors (Good) WPT", true, false, WPTSuiteLine);
        CreatePerfToolDataLibraryWPT.CreateSuiteLine(PerfToolSuiteHeaderWPT, WPTSuiteLine."Object Type"::Page, page::"Just Some Colors Removed WPT", true, false, WPTSuiteLine);
        CreatePerfToolDataLibraryWPT.CreateSuiteLine(PerfToolSuiteHeaderWPT, WPTSuiteLine."Object Type"::Page, page::"Just Some Colors DynHidden WPT", true, false, WPTSuiteLine);
        CreatePerfToolDataLibraryWPT.CreateSuiteLine(PerfToolSuiteHeaderWPT, WPTSuiteLine."Object Type"::Page, page::"Just Some Colors Hidden WPT", true, false, WPTSuiteLine);
    end;
    #endregion

}
