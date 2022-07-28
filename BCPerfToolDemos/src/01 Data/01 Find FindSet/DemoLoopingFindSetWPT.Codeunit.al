codeunit 62226 "Demo - Looping Find(Set) WPT"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Create PerfToolDataLibrary WPT", 'OnAfterInsertSuiteGroup', '', false, false)]
    local procedure OnAfterInsertSuiteGroup(var Sender: Codeunit "Create PerfToolDataLibrary WPT"; var PerfToolGroupWPT: Record "PerfTool Group WPT");
    var
        PerfToolSuiteHeaderWPT: Record "PerfTool Suite Header WPT";
        WPTSuiteLine: Record "PerfTool Suite Line WPT";
    begin
        if PerfToolGroupWPT.Code <> '1.DATA' then exit;

        Sender.CreateSuite(PerfToolGroupWPT, '1. Looping', 'Find, Findset, ..', PerfToolSuiteHeaderWPT);
        Sender.CreateSuiteLine(PerfToolSuiteHeaderWPT, WPTSuiteLine."Object Type"::Table, database::"Just Some Table WPT", true, true, WPTSuiteLine);

    end;
}
