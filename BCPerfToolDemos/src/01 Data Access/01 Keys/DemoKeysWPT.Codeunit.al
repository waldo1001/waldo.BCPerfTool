#pragma warning disable AA0206
codeunit 62254 "Demo - Keys WPT" implements "PerfToolCodeunit WPT"
{
    #region CountWithoutKey
    procedure CountWithoutKey()
    var
        JustSomeTableWPT: Record "Just Some Table WPT";
        number: integer;
    begin
        JustSomeTableWPT.SetFilter(Color, 'BLACK|WHITE');
        number := JustSomeTableWPT.Count;
    end;
    #endregion

    #region CountWithKey
    procedure CountWithKey()
    var
        JustSomeTableWPT: Record "Just Some Table WPT";
        number: integer;
    begin
        JustSomeTableWPT.SetFilter("Color 2", 'BLACK|WHITE');
        number := JustSomeTableWPT.Count;
    end;
    #endregion

    #region InterfaceImplementation
    procedure Run(ProcedureName: Text) Result: Boolean;
    begin
        case ProcedureName of
            GetProcedures().Get(1):
                CountWithoutKey();
            GetProcedures().Get(2):
                CountWithKey();
        end;

        Result := true;
    end;

    procedure GetProcedures() Result: List of [Text[50]];
    begin
        Result.Add('CountWithoutKey');
        Result.Add('CountWithKey');
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"PerfTool Triggers WPT", 'OnGetSuiteData', '', false, false)]

    local procedure OnAfterInsertSuiteGroup()
    var
        PerfToolSuiteHeaderWPT: Record "PerfTool Suite Header WPT";
        WPTSuiteLine: Record "PerfTool Suite Line WPT";
        PerfToolGroupWPT: Record "PerfTool Group WPT";
        CreatePerfToolDataLibraryWPT: Codeunit "Create PerfToolDataLibrary WPT";
    begin
        CreatePerfToolDataLibraryWPT.CreateGroup('01.DATA', 'Data Access', PerfToolGroupWPT);

        CreatePerfToolDataLibraryWPT.CreateSuite(PerfToolGroupWPT, '01. Keys', 'Keys', PerfToolSuiteHeaderWPT);

        CreatePerfToolDataLibraryWPT.CreateSuiteLines(PerfToolSuiteHeaderWPT, WPTSuiteLine."Object Type"::Codeunit, enum::"PerfToolCodeunit WPT"::Keys, true, false, WPTSuiteLine);
    end;
    #endregion
}