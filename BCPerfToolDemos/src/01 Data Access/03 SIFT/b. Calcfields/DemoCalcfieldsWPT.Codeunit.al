codeunit 62215 "Demo - Calcfields WPT" implements "PerfToolCodeunit WPT"
{
    #region CalcFieldsInLoop
    local procedure CalcFieldsInLoop()
    var
        JustSomeCountryWPT: Record "Just Some Country WPT";
        i: Integer;
    begin
        i := 0;
        JustSomeCountryWPT.FindSet();
        repeat
            JustSomeCountryWPT.CalcFields(TotalQuantity);
            i += 1;
            if i > 100 then exit;
        until JustSomeCountryWPT.Next() < 1;
    end;
    #endregion CalcFieldsInLoop

    #region AutoCalcFields
    local procedure AutoCalcFields()
    var
        JustSomeCountryWPT: Record "Just Some Country WPT";
        i: Integer;
    begin
        i := 0;
        JustSomeCountryWPT.SetAutoCalcFields(TotalQuantity);
        JustSomeCountryWPT.FindSet();
        repeat
            i += 1;
            if i > 100 then exit;
        until JustSomeCountryWPT.Next() < 1;
    end;
    #endregion AutoCalcFields

    #region InterfaceImplementation
    procedure Run(ProcedureName: Text) Result: Boolean;
    begin
        case ProcedureName of
            GetProcedures().Get(1):
                CalcFieldsInLoop();
            GetProcedures().Get(2):
                AutoCalcFields();
        end;

        Result := true;
    end;

    procedure GetProcedures() Result: List of [Text[50]];
    begin
        Result.Add('CalcFieldsInLoop');
        Result.Add('AutoCalcFields');
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"PerfTool Triggers WPT", 'OnGetSuiteData', '', false, false)]
    local procedure OnAfterInsertSuiteGroup();

    var
        PerfToolSuiteHeaderWPT: Record "PerfTool Suite Header WPT";
        WPTSuiteLine: Record "PerfTool Suite Line WPT";
        PerfToolGroupWPT: Record "PerfTool Group WPT";
        CreatePerfToolDataLibraryWPT: Codeunit "Create PerfToolDataLibrary WPT";
    begin
        CreatePerfToolDataLibraryWPT.CreateGroup('01.DATA', 'Data Access', PerfToolGroupWPT);

        CreatePerfToolDataLibraryWPT.CreateSuite(PerfToolGroupWPT, '03.b Calcfields', '(Auto)Calcfields', PerfToolSuiteHeaderWPT);

        CreatePerfToolDataLibraryWPT.CreateSuiteLines(PerfToolSuiteHeaderWPT, WPTSuiteLine."Object Type"::Codeunit, enum::"PerfToolCodeunit WPT"::CalcFields, true, false, WPTSuiteLine);
    end;
    #endregion
}