codeunit 62267 "Demo - Query - Index WPT" implements "PerfToolCodeunit WPT"
{
    #region NoDecentSumIndex
    local procedure NoDecentSumIndex()
    var
        NoDecentSumIndexWPT: Query "No Decent SumIndex WPT";
    begin
        NoDecentSumIndexWPT.Open();

        while NoDecentSumIndexWPT.Read() do;
        //do something

        NoDecentSumIndexWPT.Close();
    end;

    #endregion

    #region DecentSumIndex
    local procedure DecentSumIndex()
    var
        DecentSumIndexWPT: Query "Decent SumIndex WPT";
    begin
        DecentSumIndexWPT.Open();

        while DecentSumIndexWPT.Read() do;
        //do something

        DecentSumIndexWPT.Close();
    end;
    #endregion

    #region InterfaceImplementation
    procedure Run(ProcedureName: Text) Result: Boolean;
    begin
        case ProcedureName of
            GetProcedures().Get(1):
                NoDecentSumIndex();
            GetProcedures().Get(2):
                DecentSumIndex();
        end;

        Result := true;
    end;

    procedure GetProcedures() Result: List of [Text[50]];
    begin
        Result.Add('No Decent SumIndex');
        Result.Add('Decent SumIndex');
    end;

    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Create PerfToolDataLibrary WPT", 'OnAfterInsertSuiteGroup', '', false, false)]
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Install Suites WPT", 'OnInstallAppPerCompanyFillSuite', '', false, false)]
    local procedure OnAfterInsertSuiteGroup();

    var
        PerfToolSuiteHeaderWPT: Record "PerfTool Suite Header WPT";
        WPTSuiteLine: Record "PerfTool Suite Line WPT";
        PerfToolGroupWPT: Record "PerfTool Group WPT";
        CreatePerfToolDataLibraryWPT: Codeunit "Create PerfToolDataLibrary WPT";
    begin
        CreatePerfToolDataLibraryWPT.CreateGroup('02.QUERIES', 'Queries', PerfToolGroupWPT);

        CreatePerfToolDataLibraryWPT.CreateSuite(PerfToolGroupWPT, '3.Indexes', 'Handling Indexes', PerfToolSuiteHeaderWPT);

        CreatePerfToolDataLibraryWPT.CreateSuiteLines(PerfToolSuiteHeaderWPT, WPTSuiteLine."Object Type"::Codeunit, enum::"PerfToolCodeunit WPT"::QryIndexes, false, false, WPTSuiteLine);
    end;
    #endregion
}