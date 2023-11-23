namespace waldo.BCPerftool.Analytics;

codeunit 62106 "PerfTool Stop Log WPT"
{
    internal procedure Stop(var Log: Record "PerfTool Log Entry WPT")
    var
        IsHandled: Boolean;
    begin
        OnBeforeStop(Log, IsHandled);

        DoStop(Log, IsHandled);

        OnAfterStop(Log);
    end;

    local procedure DoStop(var Log: Record "PerfTool Log Entry WPT"; IsHandled: Boolean);
    begin
        if IsHandled then
            exit;

        Log.StopTime := CurrentDateTime;
        Log.TestDuration := Log.StopTime - Log.StartTime;
        Log.SqlRowsRead := SessionInformation.SqlRowsRead - Log.SqlRowsRead;
        Log.SqlStatementsExecuted := SessionInformation.SqlStatementsExecuted - Log.SqlStatementsExecuted;
        Log.Insert(true);

        Log.LogToAppInsights();
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeStop(var Log: Record "PerfTool Log Entry WPT"; var IsHandled: Boolean);
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterStop(var Log: Record "PerfTool Log Entry WPT");
    begin
    end;
}