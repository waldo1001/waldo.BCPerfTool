codeunit 62117 "RunPerfToolCodeunit WPT"
{
    internal procedure RunObject(PerfToolCodeunit: enum "PerfToolCodeunit WPT"; ProcedureName: Text) Result: Boolean
    var
        IsHandled: Boolean;
    begin
        OnBeforeRunObject(PerfToolCodeunit, ProcedureName, Result, IsHandled);

        DoRunObject(PerfToolCodeunit, ProcedureName, Result, IsHandled);

        OnAfterRunObject(PerfToolCodeunit, ProcedureName, Result);
    end;

    local procedure DoRunObject(PerfToolCodeunit: enum "PerfToolCodeunit WPT"; ProcedureName: Text; var Result: Boolean; IsHandled: Boolean)
    var
        PerfToolCodeunitWPT: interface "PerfToolCodeunit WPT";
    begin
        if IsHandled then
            exit;

        Result := true;

        PerfToolCodeunitWPT := PerfToolCodeunit;

        PerfToolCodeunitWPT.Run(ProcedureName);

    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeRunObject(PerfToolCodeunit: enum "PerfToolCodeunit WPT"; ProcedureName: Text; var Result: boolean; var IsHandled: Boolean);
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterRunObject(PerfToolCodeunit: enum "PerfToolCodeunit WPT"; ProcedureName: Text; var Result: boolean);
    begin
    end;
}