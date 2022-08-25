codeunit 62210 "Demo - TextBuilder WPT" implements "PerfToolCodeunit WPT"
{
    //#region TextLoop
    procedure TextLoop()
    var
        i: integer;
        string: Text;
    begin
        for i := 1 to 10000 do
            string += 'AJ';
    end;
    //#endregion

    //#region TextBuilderLoop
    procedure TextBuilderLoop()
    var
        i: integer;
        string: TextBuilder;
    begin
        for i := 1 to 10000 do
            string.Append('waldo');
    end;
    //#endregion

    procedure Run(ProcedureName: Text) Result: Boolean;
    begin
        case ProcedureName of
            GetProcedures().Get(1):
                TextLoop();
            GetProcedures().Get(2):
                TextBuilderLoop();
        end;

        Result := true;
    end;

    procedure GetProcedures() Result: List of [Text[50]];
    begin
        Result.Add('TextLoop');
        Result.Add('TextBuilderLoop');
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
        CreatePerfToolDataLibraryWPT.CreateGroup('08.DATATYPES', 'Data Types', PerfToolGroupWPT);

        CreatePerfToolDataLibraryWPT.CreateSuite(PerfToolGroupWPT, '1. TEXT', 'Text vs Text Builder', PerfToolSuiteHeaderWPT);

        CreatePerfToolDataLibraryWPT.CreateSuiteLines(PerfToolSuiteHeaderWPT, WPTSuiteLine."Object Type"::Codeunit, enum::"PerfToolCodeunit WPT"::DTTextBuilder, true, false, WPTSuiteLine);
    end;
}