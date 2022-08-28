#pragma warning disable
codeunit 62235 "Demo - PartialRecords WPT" implements "PerfToolCodeunit WPT"
{
    #region Table0_FindSetNoPartialrecords
    local procedure Table0_FindSetNoPartialrecords()
    var
        JustSomeTableWPT: Record "Just Some Table WPT";
        NumberOfRecords: Integer;
        i: Integer;
    begin
        if JustSomeTableWPT.FindSet() then;
        repeat
            i += 1;
            if i > 10000 then exit;
        until JustSomeTableWPT.Next() < 1;
    end;
    #endregion

    #region Table1_FindSetNoPartialrecords
    local procedure Table1_FindSetNoPartialrecords()
    var
        JustSomeTableWPT: Record "Just Some Extended Table 1 WPT";
        NumberOfRecords: Integer;
        i: Integer;
    begin
        if JustSomeTableWPT.FindSet() then;
        repeat
            i += 1;
            if i > 10000 then exit;
        until JustSomeTableWPT.Next() < 1;
    end;
    #endregion

    #region Table2_FindSetNoPartialrecords
    local procedure Table2_FindSetNoPartialrecords()
    var
        JustSomeTableWPT: Record "Just Some Extended Table 2 WPT";
        NumberOfRecords: Integer;
        i: Integer;
    begin
        if JustSomeTableWPT.FindSet() then;
        repeat
            i += 1;
            if i > 10000 then exit;
        until JustSomeTableWPT.Next() < 1;
    end;
    #endregion

    #region Table3_FindSetNoPartialrecords
    local procedure Table3_FindSetNoPartialrecords()
    var
        JustSomeTableWPT: Record "Just Some Extended Table 3 WPT";
        NumberOfRecords: Integer;
        i: Integer;
    begin
        if JustSomeTableWPT.FindSet() then;
        repeat
            i += 1;
            if i > 10000 then exit;
        until JustSomeTableWPT.Next() < 1;
    end;
    #endregion

    #region Table4_FindSetNoPartialrecords
    local procedure Table4_FindSetNoPartialrecords()
    var
        JustSomeTableWPT: Record "Just Some Extended Table 4 WPT";
        NumberOfRecords: Integer;
        i: Integer;
    begin
        if JustSomeTableWPT.FindSet() then;
        repeat
            i += 1;
            if i > 10000 then exit;
        until JustSomeTableWPT.Next() < 1;
    end;
    #endregion

    #region FindSetWithPartialrecords
    local procedure FindSetWithPartialrecords()
    var
        JustSomeTableWPT: Record "Just Some Extended Table 4 WPT";
        i: Integer;
    begin
        JustSomeTableWPT.SetLoadFields(Message);
        if JustSomeTableWPT.FindSet() then;
        repeat
            i += 1;
            if i > 10000 then exit;
        until JustSomeTableWPT.Next() < 1;
    end;
    #endregion

    #region InterfaceImplementation
    procedure Run(ProcedureName: Text) Result: Boolean;
    begin
        case ProcedureName of
            GetProcedures().Get(1):
                Table0_FindSetNoPartialrecords();
            GetProcedures().Get(2):
                Table1_FindSetNoPartialrecords();
            GetProcedures().Get(3):
                Table2_FindSetNoPartialrecords();
            GetProcedures().Get(4):
                Table3_FindSetNoPartialrecords();
            GetProcedures().Get(5):
                Table4_FindSetNoPartialrecords();
            GetProcedures().Get(6):
                FindSetWithPartialrecords();
        end;

        OnAfterRun(ProcedureName);

        Result := true;
    end;

    procedure GetProcedures() Result: List of [Text[50]];
    begin
        Result.Add('Table0_FindSetNoPartialrecords');
        Result.Add('Table1_FindSetNoPartialrecords');
        Result.Add('Table2_FindSetNoPartialrecords');
        Result.Add('Table3_FindSetNoPartialrecords');
        Result.Add('Table4_FindSetNoPartialrecords');
        Result.Add('FindSetWithPartialrecords');

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


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Install Suites WPT", 'OnInstallAppPerCompanyFillSuite', '', false, false)]
    local procedure OnAfterInsertSuiteGroup();

    var
        PerfToolSuiteHeaderWPT: Record "PerfTool Suite Header WPT";
        WPTSuiteLine: Record "PerfTool Suite Line WPT";
        PerfToolGroupWPT: Record "PerfTool Group WPT";
        CreatePerfToolDataLibraryWPT: Codeunit "Create PerfToolDataLibrary WPT";
    begin
        CreatePerfToolDataLibraryWPT.CreateGroup('01.DATA', 'Data Access', PerfToolGroupWPT);

        CreatePerfToolDataLibraryWPT.CreateSuite(PerfToolGroupWPT, '4. PartialRecords', 'Partial Records', PerfToolSuiteHeaderWPT);
        CreatePerfToolDataLibraryWPT.CreateSuiteLines(PerfToolSuiteHeaderWPT, WPTSuiteLine."Object Type"::Codeunit, enum::"PerfToolCodeunit WPT"::PartialRecords, true, false, WPTSuiteLine);
    end;
    #endregion
}