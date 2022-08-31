codeunit 62268 "Demo - NST Caching WPT" implements "PerfToolCodeunit WPT"
{
    #region RandomFiltering
    local procedure RandomFiltering()
    begin
        Codeunit.Run(Codeunit::"SomeSQLCallRandomFiltering WPT")
    end;
    #endregion

    #region SameFiltering
    local procedure SameFiltering()
    begin
        Codeunit.Run(Codeunit::"SomeSQLCallSameFiltering WPT")
    end;
    #endregion

    #region Run5Sessions_RandomFiltering
    local procedure Run5Sessions_RandomFiltering()
    begin
        //is executed by subscriber because we need to capturen the SuiteLine to be able to run it in another session.  I don't know the suiteline here;
    end;
    #endregion

    #region Run5Sessions_SameFiltering
    local procedure Run5Sessions_SameFiltering()
    begin
        //is executed by subscriber because we need to capturen the SuiteLine to be able to run it in another session.  I don't know the suiteline here;
    end;
    #endregion

    #region InterfaceImplementation
    procedure Run(ProcedureName: Text) Result: Boolean;
    begin
        case ProcedureName of
            GetProcedures().Get(1):
                RandomFiltering();
            GetProcedures().Get(2):
                SameFiltering();
            GetProcedures().Get(3):
                Run5Sessions_RandomFiltering();
            GetProcedures().Get(4):
                Run5Sessions_SameFiltering();
        end;

        Result := true;
    end;

    procedure GetProcedures() Result: List of [Text[50]];
    begin
        Result.Add('RandomFiltering');
        Result.Add('SameFiltering');
        Result.Add('Run5Sessions_RandomFiltering');
        Result.Add('Run5Sessions_SameFiltering');
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Install Suites WPT", 'OnInstallAppPerCompanyFillSuite', '', false, false)]
    local procedure OnAfterInsertSuiteGroup();
    var
        PerfToolSuiteHeaderWPT: Record "PerfTool Suite Header WPT";
        WPTSuiteLine: Record "PerfTool Suite Line WPT";
        PerfToolGroupWPT: Record "PerfTool Group WPT";
        CreatePerfToolDataLibraryWPT: Codeunit "Create PerfToolDataLibrary WPT";
    begin
        CreatePerfToolDataLibraryWPT.CreateGroup('01.DATA', 'Data Access', PerfToolGroupWPT);

        CreatePerfToolDataLibraryWPT.CreateSuite(PerfToolGroupWPT, '8. NST Caching', 'NST Caching', PerfToolSuiteHeaderWPT);

        CreatePerfToolDataLibraryWPT.CreateSuiteLines(PerfToolSuiteHeaderWPT, WPTSuiteLine."Object Type"::Codeunit, enum::"PerfToolCodeunit WPT"::NSTCaching, false, false, WPTSuiteLine);
    end;
    #endregion
}