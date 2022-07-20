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






    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Create PerfToolDataLibrary WPT", 'OnAfterInsertSuiteGroup', '', false, false)]
    local procedure OnAfterInsertSuiteGroup(var Sender: Codeunit "Create PerfToolDataLibrary WPT"; var PerfToolGroupWPT: Record "PerfTool Group WPT");
    var
        PerfToolSuiteHeaderWPT: Record "PerfTool Suite Header WPT";
        WPTSuiteLine: Record "PerfTool Suite Line WPT";
    begin
        if PerfToolGroupWPT.Code <> '1.DATA' then exit;

        Sender.CreateSuite(PerfToolGroupWPT, '2. Flowfields', 'FlowFields', PerfToolSuiteHeaderWPT);
        Sender.CreateSuiteLine(PerfToolSuiteHeaderWPT, WPTSuiteLine."Object Type"::Page, page::"Just Some Colors WPT", true, WPTSuiteLine);
        Sender.CreateSuiteLine(PerfToolSuiteHeaderWPT, WPTSuiteLine."Object Type"::Page, page::"Just Some Countries WPT", true, WPTSuiteLine);

    end;
}