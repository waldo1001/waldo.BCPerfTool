codeunit 62216 "Demo - Codeunit Size WPT" implements "PerfToolCodeunit WPT"
{

    #region SmallCodeunit
    local procedure SmallCodeunit()
    var
        i: integer;
    begin
        for i := 0 to 100000 do begin
            //Do Something and raise event
            OnAfterDoingSomething_SmallCodeunit();
        end;
    end;

    [BusinessEvent(true)]
    local procedure OnAfterDoingSomething_SmallCodeunit()
    begin
    end;
    #endregion

    #region BigCodeunit
    local procedure BigCodeunit()
    var
        i: integer;
    begin
        for i := 0 to 100000 do begin
            //Do Something and raise event
            OnAfterDoingSomething_BigCodeunit();
        end;
    end;

    [BusinessEvent(true)]
    local procedure OnAfterDoingSomething_BigCodeunit()
    begin
    end;
    #endregion

    #region SubsWithGlobalVars
    local procedure SubsWithGlobalVars()
    var
        i: integer;
    begin
        for i := 0 to 100000 do begin
            //Do Something and raise event
            OnAfterDoingSomething_SubsWithGlobalVars();
        end;
    end;

    [BusinessEvent(true)]
    local procedure OnAfterDoingSomething_SubsWithGlobalVars()
    begin
    end;
    #endregion

    #region SubsWithGlobalVarsSingleInst
    local procedure SubsWithGlobalVarsSingleInst()
    var
        i: integer;
    begin
        for i := 0 to 100000 do begin
            //Do Something and raise event
            OnAfterDoingSomething_SubsWithGlobalVarsSingleInst();
        end;
    end;

    [BusinessEvent(true)]
    local procedure OnAfterDoingSomething_SubsWithGlobalVarsSingleInst()
    begin
    end;
    #endregion

    #region InterfaceImplementation
    procedure Run(ProcedureName: Text) Result: Boolean;
    begin
        case ProcedureName of
            GetProcedures().Get(1):
                SmallCodeunit();
            GetProcedures().Get(2):
                BigCodeunit();
            GetProcedures().Get(3):
                SubsWithGlobalVars();
            GetProcedures().Get(4):
                SubsWithGlobalVarsSingleInst();
        end;

        Result := true;
    end;

    procedure GetProcedures() Result: List of [Text[50]];
    begin
        Result.Add('Small Codeunit');
        Result.Add('Big Codeunit');
        Result.Add('Global Vars');
        Result.Add('Global Vars Single Inst');
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

        CreatePerfToolDataLibraryWPT.CreateSuite(PerfToolGroupWPT, '5. CU Size', 'Codeunit Size', PerfToolSuiteHeaderWPT);
        CreatePerfToolDataLibraryWPT.CreateSuiteLines(PerfToolSuiteHeaderWPT, WPTSuiteLine."Object Type"::Codeunit, enum::"PerfToolCodeunit WPT"::CodeunitSize, false, false, WPTSuiteLine);
    end;
    #endregion
}