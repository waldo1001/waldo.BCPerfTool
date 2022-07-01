codeunit 62108 "Run SuiteLine Meth WPT"
{
    internal procedure Run(var SuiteLine: Record "PerfTool Suite Line WPT")
    var
        IsHandled: Boolean;
    begin
        OnBeforeStar(SuiteLine, IsHandled);

        DoRun(SuiteLine, IsHandled);

        OnAfterRun(SuiteLine);
    end;

    local procedure DoRun(var SuiteLine: Record "PerfTool Suite Line WPT"; IsHandled: Boolean);
    var
        PerfToolImplWPT: Codeunit "PerfTool Impl. WPT";
    begin
        if IsHandled then
            exit;

        PerfToolImplWPT.Start(SuiteLine.SystemId);

        RunObject(SuiteLine, PerfToolImplWPT);

        PerfToolImplWPT.Stop();

        ShowEntries(SuiteLine);
    end;

    local procedure RunObject(var SuiteLine: Record "PerfTool Suite Line WPT"; var PerfToolImplWPT: Codeunit "PerfTool Impl. WPT")
    begin
        case SuiteLine."Object Type" of
            suiteline."Object Type"::Codeunit:
                if Codeunit.Run(SuiteLine."Object ID") then
                    PerfToolImplWPT.SetMessage('Success')
                else
                    PerfToolImplWPT.SetMessage(GetLastErrorText().Substring(1, 2040));
            else
                Error('TODO: Not implemented yet');
        end;
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
    local procedure OnBeforeStar(var SuiteLine: Record "PerfTool Suite Line WPT"; var IsHandled: Boolean);
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterRun(var SuiteLine: Record "PerfTool Suite Line WPT");
    begin
    end;
}