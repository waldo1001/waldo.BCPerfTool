codeunit 62284 "Demo - PartialRecWrite WPT" implements "PerfToolCodeunit WPT"
{
    #region Do100Inserts_2TableExtensions
    procedure Do100Inserts_2TableExtensions()
    var
        JustSomeTableWPT: Record "Just Some Extended Table 1 WPT";
        i, LastId : integer;
    begin
        JustSomeTableWPT.FindLast();
        LastId := JustSomeTableWPT."Entry No.";

        for i := 1 to 100 do begin
            JustSomeTableWPT."Entry No." := LastId + i;
            JustSomeTableWPT.Insert(false);
        end;
    end;
    #endregion

    #region Do100Inserts_4TableExtensions
    procedure Do100Inserts_4TableExtensions()
    var
        JustSomeTableWPT: Record "Just Some Extended Table 2 WPT";
        i, LastId : integer;
    begin
        JustSomeTableWPT.FindLast();
        LastId := JustSomeTableWPT."Entry No.";

        for i := 1 to 100 do begin
            JustSomeTableWPT."Entry No." := LastId + i;
            JustSomeTableWPT.Insert(false);
        end;
    end;
    #endregion

    #region Do100Inserts_6TableExtensions
    procedure Do100Inserts_6TableExtensions()
    var
        JustSomeTableWPT: Record "Just Some Extended Table 3 WPT";
        i, LastId : integer;
    begin
        JustSomeTableWPT.FindLast();
        LastId := JustSomeTableWPT."Entry No.";

        for i := 1 to 100 do begin
            JustSomeTableWPT."Entry No." := LastId + i;
            JustSomeTableWPT.Insert(false);
        end;
    end;
    #endregion

    #region Do100Inserts_8TableExtensions
    procedure Do100Inserts_8TableExtensions()
    var
        JustSomeTableWPT: Record "Just Some Extended Table 4 WPT";
        i, LastId : integer;
    begin
        JustSomeTableWPT.FindLast();
        LastId := JustSomeTableWPT."Entry No.";

        for i := 1 to 100 do begin
            JustSomeTableWPT."Entry No." := LastId + i;
            JustSomeTableWPT.Insert(false);
        end;
    end;
    #endregion

    #region InterfaceImplementation
    procedure Run(ProcedureName: Text) Result: Boolean;
    begin
        case ProcedureName of
            GetProcedures().Get(1):
                Do100Inserts_2TableExtensions();
            GetProcedures().Get(2):
                Do100Inserts_4TableExtensions();
            GetProcedures().Get(3):
                Do100Inserts_6TableExtensions();
            GetProcedures().Get(4):
                Do100Inserts_8TableExtensions();

        end;

        OnAfterRun(ProcedureName);

        Result := true;
    end;

    procedure GetProcedures() Result: List of [Text[50]];
    begin
        Result.Add('Do100Inserts_2TableExtensions');
        Result.Add('Do100Inserts_4TableExtensions');
        Result.Add('Do100Inserts_6TableExtensions');
        Result.Add('Do100Inserts_8TableExtensions');

        OnAfterGetProcedures(Result);
    end;

    [IntegrationEvent(true, false)]
    local procedure OnAfterGetProcedures(var Result: list of [Text[50]])
    begin
    end;

    [IntegrationEvent(true, false)]
    local procedure OnAfterRun(ProcedureName: Text)
    begin
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

        CreatePerfToolDataLibraryWPT.CreateSuite(PerfToolGroupWPT, '04.b PartialRecWrite', 'Partial Records - Insert', PerfToolSuiteHeaderWPT);

        CreatePerfToolDataLibraryWPT.CreateSuiteLines(PerfToolSuiteHeaderWPT, WPTSuiteLine."Object Type"::Codeunit, enum::"PerfToolCodeunit WPT"::PartialRecordInsert, true, false, WPTSuiteLine);
    end;
    #endregion
}
