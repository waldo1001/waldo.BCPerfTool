namespace waldo.BCPerftool.Suites;

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
        Dlg: Dialog;
        i: Integer;
        DialogTxt: Label 'Suite: #1 \ Number #2 from #3', Comment = '#1 = Suite; #2 = current position; #3 = Total count.';
    begin
        if IsHandled then
            exit;

        Dlg.Open(DialogTxt, Header.Code, i, NumberOfTimes);

        for i := 1 to NumberOfTimes do begin
            dlg.Update();
            Header.RunAll();
            Commit();
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