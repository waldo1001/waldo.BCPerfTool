codeunit 62215 "Demo - Calcfields WPT" implements "PerfToolCodeunit WPT"
{
    //#region CalcFieldsInLoop
    local procedure CalcFieldsInLoop()
    var
        JustSomeColorsWPT: Record "Just Some Country WPT";
    begin
        JustSomeColorsWPT.FindSet();
        repeat
            JustSomeColorsWPT.CalcFields(TotalQuantity);
        until JustSomeColorsWPT.Next() < 1;
    end;
    //#endregion CalcFieldsInLoop

    //#region AutoCalcFields
    local procedure AutoCalcFields()
    var
        JustSomeColorsWPT: Record "Just Some Country WPT";
    begin
        JustSomeColorsWPT.SetAutoCalcFields(TotalQuantity);
        JustSomeColorsWPT.FindSet();
        repeat
        until JustSomeColorsWPT.Next() < 1;
    end;
    //#endregion AutoCalcFields

    procedure Run(ProcedureName: Text) Result: Boolean;
    begin
        case ProcedureName of
            GetProcedures().Get(1):
                CalcFieldsInLoop();
            GetProcedures().Get(2):
                AutoCalcFields();
        end;
    end;

    procedure GetProcedures() Result: List of [Text[30]];
    begin
        Result.Add('CalcFieldsInLoop');
        Result.Add('AutoCalcFields');
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Install Suites WPT", 'OnInstallAppPerCompanyFillSuite', '', false, false)]
    local procedure OnAfterInsertSuiteGroup();

    var
        PerfToolSuiteHeaderWPT: Record "PerfTool Suite Header WPT";
        WPTSuiteLine: Record "PerfTool Suite Line WPT";
        PerfToolGroupWPT: Record "PerfTool Group WPT";
        CreatePerfToolDataLibraryWPT: Codeunit "Create PerfToolDataLibrary WPT";
    begin
        CreatePerfToolDataLibraryWPT.CreateGroup('1.DATA', 'Data Access', PerfToolGroupWPT);

        CreatePerfToolDataLibraryWPT.CreateSuite(PerfToolGroupWPT, '2.b Calcfields', '(Auto)Calcfields', PerfToolSuiteHeaderWPT);

        CreatePerfToolDataLibraryWPT.CreateSuiteLines(PerfToolSuiteHeaderWPT, WPTSuiteLine."Object Type"::Codeunit, enum::"PerfToolCodeunit WPT"::CalcFields, true, false, WPTSuiteLine);
    end;
}