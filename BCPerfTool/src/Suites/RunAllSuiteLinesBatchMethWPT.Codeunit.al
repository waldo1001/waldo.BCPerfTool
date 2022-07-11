codeunit 62111 "RunAllSuiteLinesBatch Meth WPT"
{
    internal procedure RunAll(var Header: Record "PerfTool Suite Header WPT"; NumberOfTimes: Integer)
    var
        IsHandled: Boolean;
    begin
        OnBeforeRunAll(Header, NumberOfTimes, IsHandled);

        DoRunAll(Header, NumberOfTimes, IsHandled);

        OnAfterRunAll(Header);
    end;

    local procedure DoRunAll(var Header: Record "PerfTool Suite Header WPT"; NumberOfTimes: Integer; IsHandled: Boolean);
    var
        i: Integer;
        Dlg: Dialog;
    begin
        if IsHandled then
            exit;


        Dlg.Open('Number #1 from #2', i, NumberOfTimes);

        for i := 0 to NumberOfTimes do begin
            Header.RunAll();
            Commit();
            dlg.Update();
        end;

        dlg.Close();

    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeRunAll(var Header: Record "PerfTool Suite Header WPT"; NumberOfTimes: Integer; var IsHandled: Boolean);
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterRunAll(var Header: Record "PerfTool Suite Header WPT");
    begin
    end;
}