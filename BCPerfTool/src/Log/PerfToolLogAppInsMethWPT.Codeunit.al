namespace waldo.BCPerftool.Analytics;

using waldo.BCPerftool.Suites;

codeunit 62103 "PerfTool LogAppIns Meth WPT"
{
    internal procedure LogAppInsights(var Log: Record "PerfTool Log Entry WPT")
    var
        IsHandled: Boolean;
    begin
        OnBeforeLogAppInsights(Log, IsHandled);

        DoLogAppInsights(Log, IsHandled);

        OnAfterLogAppInsights(Log);
    end;

    local procedure DoLogAppInsights(var Log: Record "PerfTool Log Entry WPT"; IsHandled: Boolean);
    var
        Dimensions: Dictionary of [Text, Text];
        TelemetryLogLbl: Label 'waldo - %1', Locked = true;
    begin
        if IsHandled then
            exit;

        Dimensions.Add('code', Log.Message);
        Dimensions.Add('noOfSqlStatements', Format(Log.SqlStatementsExecuted));
        Dimensions.Add('noOfSqlRowsRead', Format(Log.SqlRowsRead));
        Dimensions.Add('startTime', Format(Log.StartTime));
        Dimensions.Add('endTime', Format(Log.StopTime));
        Dimensions.Add('duration', Format(Log.TestDuration));

        AddInsightsFromPerfToolSuite(Log, Dimensions);

        HandleAppInsightsEventId(Log, Dimensions);

        Session.LogMessage(
            Log.AppInsightsEventId,
            StrSubstNo(TelemetryLogLbl, Log.Message),
            Verbosity::Normal,
            DataClassification::SystemMetadata,
            TelemetryScope::All,
            Dimensions)
    end;

    local procedure AddInsightsFromPerfToolSuite(var Log: Record "PerfTool Log Entry WPT"; var Dimensions: Dictionary of [Text, Text])
    var
        PerfToolSuiteLineWPT: Record "PerfTool Suite Line WPT";
        PerfToolSuiteHeaderWPT: Record "PerfTool Suite Header WPT";
    begin
        PerfToolSuiteLineWPT.SetAutoCalcFields("Object Name");
        if not PerfToolSuiteLineWPT.GetBySystemId(log.Identifier) then exit;

        Dimensions.Add('ObjectType', format(PerfToolSuiteLineWPT."Object Type"));
        Dimensions.Add('ObjectId', format(PerfToolSuiteLineWPT."Object ID"));
        Dimensions.Add('ObjectName', PerfToolSuiteLineWPT."Object Name");

        if not PerfToolSuiteHeaderWPT.Get() then exit;

        Dimensions.Add('SuiteCode', PerfToolSuiteHeaderWPT.Code);
        Dimensions.Add('SuiteGroup', PerfToolSuiteHeaderWPT."Group Code");

    end;

    local procedure HandleAppInsightsEventId(var Log: Record "PerfTool Log Entry WPT"; Dimensions: Dictionary of [Text, Text])
    var
        EventId: Text[50];
        Value: Text;
    begin
        If Log.AppInsightsEventId <> '' then exit;

        EventId := 'WPT';

        if Dimensions.get('ObjectType', Value) then
            EventId += '_' + Value;
        if Dimensions.Get('ObjectId', Value) then
            EventId += '_' + Value;

        Log.AppInsightsEventId := EventId;
        Log.Modify(true);
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeLogAppInsights(var Log: Record "PerfTool Log Entry WPT"; var IsHandled: Boolean);
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterLogAppInsights(var Log: Record "PerfTool Log Entry WPT");
    begin
    end;
}