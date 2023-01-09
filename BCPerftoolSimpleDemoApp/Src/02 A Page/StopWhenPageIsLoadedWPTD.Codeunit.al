codeunit 62403 "StopWhenPageIsLoaded WPTD"
{
    [EventSubscriber(ObjectType::Page, page::"Customer List", 'OnAfterGetCurrRecordEvent', '', false, false)]
    local procedure StopSuite()
    var
        PerfToolWPT: Codeunit "PerfTool WPT";
    begin
        PerfToolWPT.Stop();
    end;
}