codeunit 62222 "Demo - Retention WPT"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Create PerfToolDataLibrary WPT", 'OnAfterInsertSuiteGroup', '', false, false)]
    local procedure OnAfterInsertSuiteGroup(var Sender: Codeunit "Create PerfToolDataLibrary WPT"; var PerfToolGroupWPT: Record "PerfTool Group WPT");
    var
        PerfToolSuiteHeaderWPT: Record "PerfTool Suite Header WPT";
        WPTSuiteLine: Record "PerfTool Suite Line WPT";
    begin
        if PerfToolGroupWPT.Code <> '2.CODING' then exit;

        sender.CreateSuite(PerfToolGroupWPT, '99.RETENTION', 'Reetention Policies', PerfToolSuiteHeaderWPT);
        sender.CreateSuiteLine(PerfToolSuiteHeaderWPT, WPTSuiteLine."Object Type"::Page, page::"Retention Policy Setup List", false, WPTSuiteLine);
    end;

}