codeunit 62123 "RunAllBatchesOnSuites Meth WPT"
{
    internal procedure RunAllBatchesOnSuites()
    var
        IsHandled: Boolean;
    begin
        OnBeforeRunAllBatchesOnSuites(IsHandled);

        DoRunAllBatchesOnSuites(IsHandled);

        OnAfterRunAllBatchesOnSuites();
    end;

    local procedure DoRunAllBatchesOnSuites(IsHandled: Boolean);
    var
        Suite: Record "PerfTool Suite Header WPT";
    begin
        if IsHandled then
            exit;

        if not suite.FindSet() then exit;

        repeat
            Suite.RunAll(suite.BatchCount);
        until suite.Next() < 1;
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeRunAllBatchesOnSuites(var IsHandled: Boolean);
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterRunAllBatchesOnSuites();
    begin
    end;
}