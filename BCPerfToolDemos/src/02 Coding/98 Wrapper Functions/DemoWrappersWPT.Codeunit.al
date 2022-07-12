codeunit 62219 "Demo - Wrappers WPT" implements "PerfToolCodeunit WPT"
{

    //#region SubFunction
    local procedure SubFunction()
    var
        myGuid: Guid;
        Result: Text;
        i: Integer;
    begin
        myGuid := '{f4d9885c-8df6-401f-8a90-3286b814fe0a}';

        for i := 0 to NumberOfInvocations() do
            Result := TrimBrackets(myGuid);
    end;

    local procedure TrimBrackets(var myGuid: guid): Text
    begin
        exit(format(myGuid, 0, 4));
    end;
    //#endregion SubFunction

    //#region NoSubFunction
    local procedure NoSubfunction()
    var
        myGuid: Guid;
        Result: Text;
        i: Integer;
    begin
        myGuid := '{f4d9885c-8df6-401f-8a90-3286b814fe0a}';

        for i := 0 to NumberOfInvocations() do
            Result := format(myGuid, 0, 4);
    end;
    //#endregion NoSubFunction

    //#region SingleInstance
    local procedure SingleInstance()
    var
        TrimBracketsSingleInstWPT: Codeunit "TrimBrackets - SingleInst WPT";
        myGuid: Guid;
        Result: Text;
        i: Integer;
    begin
        myGuid := '{f4d9885c-8df6-401f-8a90-3286b814fe0a}';

        for i := 0 to NumberOfInvocations() do
            Result := TrimBracketsSingleInstWPT.TrimBrackets(myGuid);
    end;
    //#endregion SingleInstance

    //#region NoSingleInstance
    local procedure NoSingleInstance()
    var
        TrimBracketsNoSingleInsWPT: Codeunit "TrimBrackets - NoSingleIns WPT";
        myGuid: Guid;
        Result: Text;
        i: Integer;
    begin
        myGuid := '{f4d9885c-8df6-401f-8a90-3286b814fe0a}';

        for i := 0 to NumberOfInvocations() do
            Result := TrimBracketsNoSingleInsWPT.TrimBrackets(myGuid);
    end;

    //#endregion NoSingleInstance

    local procedure NumberOfInvocations(): Integer
    begin
        exit(1000000);
    end;

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

    procedure GetProcedures() Result: List of [Text[30]];
    begin
        Result.Add('Wrappers - Subfunction');
        Result.Add('Wrappers - No Subfunction');
        Result.Add('Wrappers - Single Instance');
        Result.Add('Wrappers - No Single Instance');
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Create PerfToolDataLibrary WPT", 'OnAfterInsertSuiteGroup', '', false, false)]
    local procedure OnAfterInsertSuiteGroup(var Sender: Codeunit "Create PerfToolDataLibrary WPT"; var PerfToolGroupWPT: Record "PerfTool Group WPT");
    var
        PerfToolSuiteHeaderWPT: Record "PerfTool Suite Header WPT";
        WPTSuiteLine: Record "PerfTool Suite Line WPT";
    begin
        if PerfToolGroupWPT.Code <> '2.CODING' then exit;

        sender.CreateSuite(PerfToolGroupWPT, '98.WRAPPERS', 'Wrapper functions', PerfToolSuiteHeaderWPT);
        sender.CreateSuiteLines(PerfToolSuiteHeaderWPT, WPTSuiteLine."Object Type"::Codeunit, enum::"PerfToolCodeunit WPT"::Wrappers, false, WPTSuiteLine);
    end;
}