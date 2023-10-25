codeunit 62235 "Demo - PartialRecRead WPT" implements "PerfToolCodeunit WPT"
{
    #region FindSetNoPartialrecords
    local procedure FindSetNoPartialrecords()
    var
        JustSomeTableWPT: Record "Just Some Table WPT";
        i: Integer;
    begin
        if JustSomeTableWPT.FindSet() then;
        repeat
            i += 1;
            if i > 7500 then exit;
        until JustSomeTableWPT.Next() < 1;
    end;
    #endregion

    #region FindSetWithPartialrecords
    local procedure FindSetWithPartialrecords()
    var
        JustSomeTableWPT: Record "Just Some Table WPT";
        i: Integer;
    begin
        JustSomeTableWPT.SetLoadFields(Message);
        if JustSomeTableWPT.FindSet() then;
        repeat
            i += 1;
            if i > 7500 then exit;
        until JustSomeTableWPT.Next() < 1;
    end;
    #endregion

    #region Table1_FindSetNoPartialrecords
    local procedure Table1_FindSetNoPartialrecords()
    var
        JustSomeTableWPT: Record "Just Some Extended Table 1 WPT";
        i: Integer;
    begin
        if JustSomeTableWPT.FindSet() then;
        repeat
            i += 1;
            if i > 7500 then exit;
        until JustSomeTableWPT.Next() < 1;
    end;
    #endregion

    #region Table1_FindSetWithPartialrecords
    local procedure Table1_FindSetWithPartialrecords()
    var
        JustSomeTableWPT: Record "Just Some Extended Table 1 WPT";
        i: Integer;
    begin
        JustSomeTableWPT.SetLoadFields(Message);
        if JustSomeTableWPT.FindSet() then;
        repeat
            i += 1;
            if i > 7500 then exit;
        until JustSomeTableWPT.Next() < 1;
    end;
    #endregion

    #region Table2_FindSetNoPartialrecords
    local procedure Table2_FindSetNoPartialrecords()
    var
        JustSomeTableWPT: Record "Just Some Extended Table 2 WPT";
        i: Integer;
    begin
        if JustSomeTableWPT.FindSet() then;
        repeat
            i += 1;
            if i > 7500 then exit;
        until JustSomeTableWPT.Next() < 1;
    end;
    #endregion

    #region Table2_FindSetWithPartialrecords
    local procedure Table2_FindSetWithPartialrecords()
    var
        JustSomeTableWPT: Record "Just Some Extended Table 2 WPT";
        i: Integer;
    begin
        JustSomeTableWPT.SetLoadFields(Message);
        if JustSomeTableWPT.FindSet() then;
        repeat
            i += 1;
            if i > 7500 then exit;
        until JustSomeTableWPT.Next() < 1;
    end;
    #endregion

    #region Table3_FindSetNoPartialrecords
    local procedure Table3_FindSetNoPartialrecords()
    var
        JustSomeTableWPT: Record "Just Some Extended Table 3 WPT";
        i: Integer;
    begin
        if JustSomeTableWPT.FindSet() then;
        repeat
            i += 1;
            if i > 7500 then exit;
        until JustSomeTableWPT.Next() < 1;
    end;
    #endregion

    #region Table3_FindSetWithPartialrecords
    local procedure Table3_FindSetWithPartialrecords()
    var
        JustSomeTableWPT: Record "Just Some Extended Table 3 WPT";
        i: Integer;
    begin
        JustSomeTableWPT.SetLoadFields(Message);
        if JustSomeTableWPT.FindSet() then;
        repeat
            i += 1;
            if i > 7500 then exit;
        until JustSomeTableWPT.Next() < 1;
    end;
    #endregion

    #region Table4_FindSetNoPartialrecords
    local procedure Table4_FindSetNoPartialrecords()
    var
        JustSomeTableWPT: Record "Just Some Extended Table 4 WPT";
        i: Integer;
    begin
        if JustSomeTableWPT.FindSet() then;
        repeat
            i += 1;
            if i > 7500 then exit;
        until JustSomeTableWPT.Next() < 1;
    end;
    #endregion

    #region Table4_FindSetWithPartialrecords
    local procedure Table4_FindSetWithPartialrecords()
    var
        JustSomeTableWPT: Record "Just Some Extended Table 4 WPT";
        i: Integer;
    begin
        JustSomeTableWPT.SetLoadFields(Message);
        if JustSomeTableWPT.FindSet() then;
        repeat
            i += 1;
            if i > 7500 then exit;
        until JustSomeTableWPT.Next() < 1;
    end;
    #endregion

    #region InterfaceImplementation
    procedure Run(ProcedureName: Text) Result: Boolean;
    begin
        case ProcedureName of
            GetProcedures().Get(1):
                FindSetNoPartialrecords();
            GetProcedures().Get(2):
                FindSetWithPartialrecords();
            GetProcedures().Get(3):
                Table1_FindSetNoPartialrecords();
            GetProcedures().Get(4):
                Table1_FindSetWithPartialrecords();
            GetProcedures().Get(5):
                Table2_FindSetNoPartialrecords();
            GetProcedures().Get(6):
                Table2_FindSetWithPartialrecords();
            GetProcedures().Get(7):
                Table3_FindSetNoPartialrecords();
            GetProcedures().Get(8):
                Table3_FindSetWithPartialrecords();
            GetProcedures().Get(9):
                Table4_FindSetNoPartialrecords();
            GetProcedures().Get(10):
                Table4_FindSetWithPartialrecords();
        end;

        OnAfterRun(ProcedureName);

        Result := true;
    end;

    procedure GetProcedures() Result: List of [Text[50]];
    begin
        Result.Add('FindSetNoPartialrecords');
        Result.Add('FindSetWithPartialrecords');
        Result.Add('Table1_FindSetNoPartialrecords');
        Result.Add('Table1_FindSetWithPartialrecords');
        Result.Add('Table2_FindSetNoPartialrecords');
        Result.Add('Table2_FindSetWithPartialrecords');
        Result.Add('Table3_FindSetNoPartialrecords');
        Result.Add('Table3_FindSetWithPartialrecords');
        Result.Add('Table4_FindSetNoPartialrecords');
        Result.Add('Table4_FindSetWithPartialrecords');

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
    local procedure OnAfterInsertSuiteGroup();

    var
        PerfToolSuiteHeaderWPT: Record "PerfTool Suite Header WPT";
        WPTSuiteLine: Record "PerfTool Suite Line WPT";
        PerfToolGroupWPT: Record "PerfTool Group WPT";
        CreatePerfToolDataLibraryWPT: Codeunit "Create PerfToolDataLibrary WPT";
    begin
        CreatePerfToolDataLibraryWPT.CreateGroup('01.DATA', 'Data Access', PerfToolGroupWPT);

        CreatePerfToolDataLibraryWPT.CreateSuite(PerfToolGroupWPT, '04.a PartialRecRead', 'Partial Records - Read', PerfToolSuiteHeaderWPT);
        CreatePerfToolDataLibraryWPT.CreateSuiteLines(PerfToolSuiteHeaderWPT, WPTSuiteLine."Object Type"::Codeunit, enum::"PerfToolCodeunit WPT"::PartialRecords, true, false, WPTSuiteLine);
    end;
    #endregion
}