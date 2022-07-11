codeunit 62108 "Run SuiteLine Meth WPT"
{
    internal procedure Run(var SuiteLine: Record "PerfTool Suite Line WPT"; ShowResults: Boolean)
    var
        IsHandled: Boolean;
    begin
        OnBeforeStart(SuiteLine, ShowResults, IsHandled);

        DoRun(SuiteLine, ShowResults, IsHandled);

        OnAfterRun(SuiteLine);
    end;

    local procedure DoRun(var SuiteLine: Record "PerfTool Suite Line WPT"; ShowResults: Boolean; IsHandled: Boolean);
    var
        PerfToolImplWPT: Codeunit "PerfTool Impl. WPT";
    begin
        if IsHandled then
            exit;

        if SuiteLine.SelectLatestVersion then
            SelectLatestVersion();

        if SuiteLine."Object Type" = SuiteLine."Object Type"::PerfToolCodeunit then
            PerfToolImplWPT.RunObject(SuiteLine.SystemId, enum::"Perftool Object Types WPT".FromInteger(SuiteLine."Object Type"), SuiteLine.PerfToolCodeunit, SuiteLine."Procedure Name", SuiteLine.CurrentTag(), SuiteLine."PerfTool Code")
        else
            PerfToolImplWPT.RunObject(SuiteLine.SystemId, enum::"Perftool Object Types WPT".FromInteger(SuiteLine."Object Type"), SuiteLine."Object ID", SuiteLine.CurrentTag(), SuiteLine."PerfTool Code");

        if ShowResults then
            ShowEntries(SuiteLine);
    end;

    local procedure ShowEntries(var SuiteLine: Record "PerfTool Suite Line WPT")
    var
        PerfToolLogEntryWPT: Record "PerfTool Log Entry WPT";
    begin
        PerfToolLogEntryWPT.SetRange(Identifier, SuiteLine.SystemId);
        PerfToolLogEntryWPT.Ascending(false);

        page.Run(page::"PerfTool Log Entries WPT", PerfToolLogEntryWPT);
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeStart(var SuiteLine: Record "PerfTool Suite Line WPT"; var ShowResults: Boolean; var IsHandled: Boolean);
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterRun(var SuiteLine: Record "PerfTool Suite Line WPT");
    begin
    end;
}