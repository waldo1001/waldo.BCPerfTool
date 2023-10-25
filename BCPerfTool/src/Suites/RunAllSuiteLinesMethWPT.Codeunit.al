namespace waldo.BCPerftool.Suites;

codeunit 62110 "RunAllSuiteLines Meth WPT"
{
    internal procedure RunAll(var Header: Record "PerfTool Suite Header WPT")
    var
        IsHandled: Boolean;
    begin
        OnBeforeRunAll(Header, IsHandled);

        DoRunAll(Header, IsHandled);

        OnAfterRunAll(Header);
    end;

    local procedure DoRunAll(var Header: Record "PerfTool Suite Header WPT"; IsHandled: Boolean);
    var
        PerfToolSuiteLineWPT: Record "PerfTool Suite Line WPT";
    begin
        if IsHandled then
            exit;

        PerfToolSuiteLineWPT.SetRange("PerfTool Code", Header.Code);
        PerfToolSuiteLineWPT.SetFilter("Object Type", '<>%1', PerfToolSuiteLineWPT."Object Type"::Page); //Pages should not be run in Batch (because of the RunModal)
        PerfToolSuiteLineWPT.SetRange(DisableFromBatch, false);

        if PerfToolSuiteLineWPT.FindSet() then
            repeat
                PerfToolSuiteLineWPT.Run(false);
                Commit();
                sleep(1); //needed for very fast tasks, where I got instable execution of "SelectLatestVersion"
            until PerfToolSuiteLineWPT.Next() < 1;
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeRunAll(var Header: Record "PerfTool Suite Header WPT"; var IsHandled: Boolean);
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterRunAll(var Header: Record "PerfTool Suite Header WPT");
    begin
    end;
}