namespace waldo.BCPerftool.Analytics;

codeunit 62105 "PerfTool Start Log WPT"
{
    internal procedure Start(Identifier: Guid; var Log: Record "PerfTool Log Entry WPT"; AppInsightsEventId: Text[50]; Tag: Text[249]; AlternativeKey: Text[250])
    var
        IsHandled: Boolean;
    begin
        OnBeforeStart(Identifier, Log, AppInsightsEventId, Tag, AlternativeKey, IsHandled);

        DoStart(Identifier, Log, AppInsightsEventId, Tag, AlternativeKey, IsHandled);

        OnAfterStart(Identifier, Log, AppInsightsEventId, Tag, AlternativeKey);
    end;

    local procedure DoStart(Identifier: Guid; var Log: Record "PerfTool Log Entry WPT"; AppInsightsEventId: Text[50]; Tag: Text[249]; AlternativeKey: Text[250]; IsHandled: Boolean);
    begin
        if IsHandled then
            exit;

        Clear(Log);

        Log.Identifier := Identifier;
        Log.SqlRowsRead := SessionInformation.SqlRowsRead;
        Log.SqlStatementsExecuted := SessionInformation.SqlStatementsExecuted;
        Log.StartTime := CurrentDateTime;
        Log.AppInsightsEventId := AppInsightsEventId;
        log.AlternativeKey := AlternativeKey;
        Log.Tag := Tag;
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeStart(Identifier: Guid; var Log: Record "PerfTool Log Entry WPT"; var AppInsightsEventId: Text[50]; var Tag: Text[249]; AlternativeKey: Text[250]; var IsHandled: Boolean);
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterStart(Identifier: Guid; var Log: Record "PerfTool Log Entry WPT"; AppInsightsEventId: Text[50]; Tag: Text[249]; AlternativeKey: Text[250]);
    begin
    end;
}