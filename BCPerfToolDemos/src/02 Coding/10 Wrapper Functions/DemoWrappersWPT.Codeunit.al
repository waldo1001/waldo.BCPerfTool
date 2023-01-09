codeunit 62219 "Demo - Wrappers WPT" implements "PerfToolCodeunit WPT"
{

    #region SubFunction
    local procedure SubFunction()
    var
        myGuid: Guid;
        Result: Text;
        i: Integer;
    begin
        myGuid := '{f4d9885c-8df6-401f-8a90-3286b814fe0a}';

        for i := 0 to 1000000 do
            Result := TrimBrackets(myGuid);
    end;

    local procedure TrimBrackets(var myGuid: guid): Text
    begin
        exit(format(myGuid, 0, 4));
    end;
    #endregion SubFunction

    #region NoSubFunction
    local procedure NoSubfunction()
    var
        myGuid: Guid;
        Result: Text;
        i: Integer;
    begin
        myGuid := '{f4d9885c-8df6-401f-8a90-3286b814fe0a}';

        for i := 0 to 1000000 do
            Result := format(myGuid, 0, 4);
    end;
    #endregion NoSubFunction

    #region SingleInstance
    local procedure SingleInstance()
    var
        TrimBracketsSingleInstWPT: Codeunit "TrimBrackets - SingleInst WPT";
        myGuid: Guid;
        Result: Text;
        i: Integer;
    begin
        myGuid := '{f4d9885c-8df6-401f-8a90-3286b814fe0a}';

        for i := 0 to 1000000 do
            Result := TrimBracketsSingleInstWPT.TrimBrackets(myGuid);
    end;
    #endregion SingleInstance

    #region NoSingleInstance
    local procedure NoSingleInstance()
    var
        TrimBracketsNoSingleInsWPT: Codeunit "TrimBrackets - NoSingleIns WPT";
        myGuid: Guid;
        Result: Text;
        i: Integer;
    begin
        myGuid := '{f4d9885c-8df6-401f-8a90-3286b814fe0a}';

        for i := 0 to 1000000 do
            Result := TrimBracketsNoSingleInsWPT.TrimBrackets(myGuid);
    end;

    #endregion NoSingleInstance

    #region InterfaceImplementation
    procedure Run(ProcedureName: Text) Result: Boolean;
    begin
        case ProcedureName of
            GetProcedures().Get(1):
                SubFunction();
            GetProcedures().Get(2):
                NoSubfunction();
            GetProcedures().Get(3):
                SingleInstance();
            GetProcedures().Get(4):
                NoSingleInstance();
        end;

        Result := true;
    end;

    procedure GetProcedures() Result: List of [Text[50]];
    begin
        Result.Add('Subfunction');
        Result.Add('No Subfunction');
        Result.Add('Single Instance');
        Result.Add('No Single Instance');
    end;

    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Create PerfToolDataLibrary WPT", 'OnAfterInsertSuiteGroup', '', false, false)]
    //     [EventSubscriber(ObjectType::Codeunit, Codeunit::"PerfTool Triggers WPT", 'OnGetSuiteData', '', false, false)]
    // local procedure OnAfterInsertSuiteGroup();

    // var
    //     PerfToolSuiteHeaderWPT: Record "PerfTool Suite Header WPT";
    //     WPTSuiteLine: Record "PerfTool Suite Line WPT";
    //     PerfToolGroupWPT: Record "PerfTool Group WPT";
    //     CreatePerfToolDataLibraryWPT: Codeunit "Create PerfToolDataLibrary WPT";
    // begin
    //     CreatePerfToolDataLibraryWPT.CreateGroup('10.WRAPPERS', 'Wrappers', PerfToolGroupWPT);

    //     CreatePerfToolDataLibraryWPT.CreateSuite(PerfToolGroupWPT, '1. WRAPPERS', 'Wrapper functions', PerfToolSuiteHeaderWPT);
    //     CreatePerfToolDataLibraryWPT.CreateSuiteLines(PerfToolSuiteHeaderWPT, WPTSuiteLine."Object Type"::Codeunit, enum::"PerfToolCodeunit WPT"::Wrappers, false, false, WPTSuiteLine);
    // end;
    #endregion
}