codeunit 62216 "Demo - Codeunit Size WPT" implements "PerfToolCodeunit WPT"
{

    #region SmallCodeunit
    local procedure SmallCodeunit()
    begin
        for i := 0 to 100000 do begin
            //Do Something and raise event
            OnAfterDoingSomething();
        end;
    end;

    [BusinessEvent(true)]
    local procedure OnAfterDoingSomething()
    begin
    end;
    #endregion

    #region BigCodeunit
    local procedure BigCodeunit()
    begin
        for i := 0 to 100000 do begin
            //Do Something and raise event
            OnAfterDoingSomethingElse();
        end;
    end;

    [BusinessEvent(true)]
    local procedure OnAfterDoingSomethingElse()
    begin
    end;
    #endregion

    var
        i: integer;

    #region InterfaceImplementation
    procedure Run(ProcedureName: Text) Result: Boolean;
    begin
        case ProcedureName of
            GetProcedures().Get(1):
                SmallCodeunit();
            GetProcedures().Get(2):
                BigCodeunit();
        end;

        Result := true;
    end;

    procedure GetProcedures() Result: List of [Text[50]];
    begin
        Result.Add('Small Codeunit');
        Result.Add('Big Codeunit');
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Install Suites WPT", 'OnInstallAppPerCompanyFillSuite', '', false, false)]
    local procedure OnAfterInsertSuiteGroup();

    var
        PerfToolSuiteHeaderWPT: Record "PerfTool Suite Header WPT";
        WPTSuiteLine: Record "PerfTool Suite Line WPT";
        PerfToolGroupWPT: Record "PerfTool Group WPT";
        CreatePerfToolDataLibraryWPT: Codeunit "Create PerfToolDataLibrary WPT";
    begin
        CreatePerfToolDataLibraryWPT.CreateGroup('03.Events', 'Events', PerfToolGroupWPT);

        CreatePerfToolDataLibraryWPT.CreateSuite(PerfToolGroupWPT, '3. CU Size', 'Codeunit Size', PerfToolSuiteHeaderWPT);
        CreatePerfToolDataLibraryWPT.CreateSuiteLines(PerfToolSuiteHeaderWPT, WPTSuiteLine."Object Type"::Codeunit, enum::"PerfToolCodeunit WPT"::CodeunitSize, false, false, WPTSuiteLine);
    end;
    #endregion
}