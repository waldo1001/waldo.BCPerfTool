codeunit 62225 "Demo - Lazy Evaluation WPT" implements "PerfToolCodeunit WPT"
{
    #region LazyEvaluationAND 
    procedure NoLazyEvaluationAND()
    begin
        if ShouldBeTrueButReturnsFalse() and HeavyFunction() then
            Message('This message should not show.');
    end;

    procedure ManualLazyEvaluationAND()
    begin
        if ShouldBeTrueButReturnsFalse() then
            if HeavyFunction() then
                Message('This message should not show.');
    end;
    #endregion

    #region LazyEvaluationOR

    procedure NoLazyEvaluationOR()
    begin
        if SomethingThatReturnedTrue() or HeavyFunction() then exit;
    end;

    procedure ManualLazyEvaluationOR()
    begin
        if SomethingThatReturnedTrue() then exit;
        if HeavyFunction() then exit;
    end;
    #endregion

    local procedure ShouldBeTrueButReturnsFalse(): Boolean
    begin
        Exit(false);
    end;

    local procedure SomethingThatReturnedTrue(): Boolean
    begin
        Exit(true);
    end;

    local procedure HeavyFunction(): Boolean
    begin
        Sleep(2000);
    end;

    procedure Run(ProcedureName: Text) Result: Boolean;
    begin
        case ProcedureName of
            GetProcedures().Get(1):
                NoLazyEvaluationAND();
            GetProcedures().Get(2):
                ManualLazyEvaluationAND();
            GetProcedures().Get(3):
                NoLazyEvaluationOR();
            GetProcedures().Get(4):
                ManualLazyEvaluationOR();
        end;

        Result := true;
    end;

    procedure GetProcedures() Result: List of [Text[50]];
    begin
        Result.Add('NoLazyEvaluationAND');
        Result.Add('ManualLazyEvaluationAND');
        Result.Add('NoLazyEvaluationOR');
        Result.Add('ManualLazyEvaluationOR');
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Install Suites WPT", 'OnInstallAppPerCompanyFillSuite', '', false, false)]
    local procedure OnAfterInsertSuiteGroup();

    var
        PerfToolSuiteHeaderWPT: Record "PerfTool Suite Header WPT";
        WPTSuiteLine: Record "PerfTool Suite Line WPT";
        PerfToolGroupWPT: Record "PerfTool Group WPT";
        CreatePerfToolDataLibraryWPT: Codeunit "Create PerfToolDataLibrary WPT";
    begin
        CreatePerfToolDataLibraryWPT.CreateGroup('09.LazyEvaluation', 'Lazy Evaluation', PerfToolGroupWPT);

        CreatePerfToolDataLibraryWPT.CreateSuite(PerfToolGroupWPT, '1. Lazy Evaluation', 'Lazy Evaluation', PerfToolSuiteHeaderWPT);

        CreatePerfToolDataLibraryWPT.CreateSuiteLines(PerfToolSuiteHeaderWPT, WPTSuiteLine."Object Type"::Codeunit, enum::"PerfToolCodeunit WPT"::LazyEvaluation, true, false, WPTSuiteLine);
    end;

}