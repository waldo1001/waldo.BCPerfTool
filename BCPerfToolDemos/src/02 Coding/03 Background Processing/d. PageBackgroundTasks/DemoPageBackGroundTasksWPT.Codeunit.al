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


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Create PerfToolDataLibrary WPT", 'OnAfterInsertSuiteGroup', '', false, false)]
    local procedure OnAfterInsertSuiteGroup(var Sender: Codeunit "Create PerfToolDataLibrary WPT"; var PerfToolGroupWPT: Record "PerfTool Group WPT");
    var
        PerfToolSuiteHeaderWPT: Record "PerfTool Suite Header WPT";
        WPTSuiteLine: Record "PerfTool Suite Line WPT";
    begin
        if PerfToolGroupWPT.Code <> '2.CODING' then exit;

        sender.CreateSuite(PerfToolGroupWPT, '3.d BG-PageBGTasks', 'Background - Page Background Tasks', PerfToolSuiteHeaderWPT);

        sender.CreateSuiteLine(PerfToolSuiteHeaderWPT, WPTSuiteLine."Object Type"::Page, page::"Page Without BackgroundTsk WPT", true, false, WPTSuiteLine);
        sender.CreateSuiteLine(PerfToolSuiteHeaderWPT, WPTSuiteLine."Object Type"::Page, page::"Page With BackgroundTask WPT", true, false, WPTSuiteLine);
    end;
}