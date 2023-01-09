codeunit 62402 "SimpleDemo WPTD" implements "PerfToolCodeunit WPT"
{
    #region SimpleTest
    procedure SimpleTest()
    var
        i: integer;
        string: Text;
    begin
        for i := 1 to 25000 do
            string += 'Vjeko';
    end;
    #endregion

    #region AnotherSimpleTest
    procedure AnotherSimpleTest()
    var
        i: integer;
        string: TextBuilder;
    begin
        for i := 1 to 25000 do
            string.Append('waldo');
    end;
    #endregion

    #region InterfaceImplementation
    procedure Run(ProcedureName: Text) Result: Boolean;
    begin
        case ProcedureName of
            GetProcedures().Get(1):
                SimpleTest();
            GetProcedures().Get(2):
                AnotherSimpleTest();
        end;

        Result := true;
    end;

    procedure GetProcedures() Result: List of [Text[50]];
    begin
        Result.Add('SimpleTest');
        Result.Add('AnotherSimpleTest');
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"PerfTool Triggers WPT", 'OnGetSuiteData', '', false, false)]
    local procedure OnAfterInsertSuiteGroup()
    var
        PerfToolSuiteHeaderWPT: Record "PerfTool Suite Header WPT";
        WPTSuiteLine: Record "PerfTool Suite Line WPT";
        PerfToolGroupWPT: Record "PerfTool Group WPT";
        CreatePerfToolDataLibraryWPT: Codeunit "Create PerfToolDataLibrary WPT";
    begin
        CreatePerfToolDataLibraryWPT.CreateGroup('SimpleDemoApp', 'SimpleDemoApp', PerfToolGroupWPT);

        CreatePerfToolDataLibraryWPT.CreateSuite(PerfToolGroupWPT, 'SimpleCodeunit', 'Simple Codeunit', PerfToolSuiteHeaderWPT);

        CreatePerfToolDataLibraryWPT.CreateSuiteLines(PerfToolSuiteHeaderWPT, WPTSuiteLine."Object Type"::Codeunit, enum::"PerfToolCodeunit WPT"::SimpleCodeunit, true, false, WPTSuiteLine);
    end;
    #endregion
}