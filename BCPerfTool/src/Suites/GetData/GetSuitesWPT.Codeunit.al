namespace waldo.BCPerftool.Suites;

using waldo.BCPerftool;
using waldo.BCPerftool.Analytics;

codeunit 62136 "Get Suites WPT"
{
    var
        PerfToolTriggers: Codeunit "PerfTool Triggers WPT";

    procedure GetSuiteData(DeleteAllHistory: Boolean)
    begin
        ResetData(true, DeleteAllHistory, DeleteAllHistory);
        PerfToolTriggers.OnGetSuiteData();
    end;

    procedure ResetData(Suite: Boolean; Groups: Boolean; Logs: Boolean)
    var
        PerfToolLogEntryWPT: Record "PerfTool Log Entry WPT";
        PerfToolGroupWPT: Record "PerfTool Group WPT";
        PerfToolSuiteHeaderWPT: Record "PerfTool Suite Header WPT";
    begin
        if Suite then
            PerfToolSuiteHeaderWPT.DeleteAll(true);

        if Groups then
            PerfToolGroupWPT.DeleteAll(true);

        if Logs then
            PerfToolLogEntryWPT.DeleteAll(true);
    end;

}