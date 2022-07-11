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
        if PerfToolSuiteLineWPT.FindSet() then
            repeat
                PerfToolSuiteLineWPT.Run(false);
                Commit();
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