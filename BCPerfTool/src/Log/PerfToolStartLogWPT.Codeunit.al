codeunit 62105 "PerfTool Start Log WPT"
{
    internal procedure Start(Identifier: Guid; var Log: Record "PerfTool Log Entry WPT"; AppInsightsEventId: Text[50])
    var
        IsHandled: Boolean;
    begin
        OnBeforeStart(Identifier, Log, AppInsightsEventId, IsHandled);

        DoStart(Identifier, Log, AppInsightsEventId, IsHandled);

        OnAfterStart(Identifier, Log, AppInsightsEventId);
    end;

    local procedure DoStart(Identifier: Guid; var Log: Record "PerfTool Log Entry WPT"; AppInsightsEventId: Text[50]; IsHandled: Boolean);
    begin
        if IsHandled then
            exit;

        Clear(Log);

        Log.Identifier := Identifier;
        Log.SqlRowsRead := SessionInformation.SqlRowsRead;
        Log.SqlStatementsExecuted := SessionInformation.SqlStatementsExecuted;
        Log.StartTime := CurrentDateTime;
        log.AppInsightsEventId := AppInsightsEventId;
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeStart(Identifier: Guid; var Log: Record "PerfTool Log Entry WPT"; var AppInsightsEventId: Text[50]; var IsHandled: Boolean);
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterStart(Identifier: Guid; var Log: Record "PerfTool Log Entry WPT"; AppInsightsEventId: Text[50]);
    begin
    end;
}