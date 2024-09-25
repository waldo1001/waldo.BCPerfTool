#pragma warning disable AA0181
#pragma warning disable AA0175
codeunit 62281 "Demo - FindSetVsIsEmpty WPT" implements "PerfToolCodeunit WPT"
{
    #Region IsEmpty100Times
    procedure IsEmpty100Times()
    var
        JustSomeTableWPT: Record "Just Some Table WPT";
        i: integer;
    begin
        for i := 1 to 100 do begin
            SelectLatestVersion();
            JustSomeTableWPT.ReadIsolation := IsolationLevel::UpdLock;
            JustSomeTableWPT.SetFilter("Color 2", 'TEALISH');
            if JustSomeTableWPT.IsEmpty() then exit;
        end;
    end;
    #endregion

    #Region FindSet100Times
    procedure FindSet100Times()
    var
        JustSomeTableWPT: Record "Just Some Table WPT";
        i: integer;
    begin
        for i := 1 to 100 do begin
            SelectLatestVersion();
            JustSomeTableWPT.ReadIsolation := IsolationLevel::UpdLock;
            JustSomeTableWPT.SetFilter("Color 2", 'TEALISH');
            if not JustSomeTableWPT.FindSet() then exit;
        end;
    end;
    #endregion

    #Region IsEmpty1000Times
    procedure IsEmpty1000Times()
    var
        JustSomeTableWPT: Record "Just Some Table WPT";
        i: integer;
    begin
        for i := 1 to 1000 do begin
            SelectLatestVersion();
            JustSomeTableWPT.ReadIsolation := IsolationLevel::UpdLock;
            JustSomeTableWPT.SetFilter("Color 2", 'TEALISH');
            if JustSomeTableWPT.IsEmpty() then exit;
        end;
    end;
    #endregion

    #Region FindSet1000Times
    procedure FindSet1000Times()
    var
        JustSomeTableWPT: Record "Just Some Table WPT";
        i: integer;
    begin
        for i := 1 to 1000 do begin
            SelectLatestVersion();
            JustSomeTableWPT.ReadIsolation := IsolationLevel::UpdLock;
            JustSomeTableWPT.SetFilter("Color 2", 'TEALISH');
            if not JustSomeTableWPT.FindSet() then exit;
        end;
    end;
    #endregion

    #region InterfaceImplementation
    procedure Run(ProcedureName: Text) Result: Boolean;
    begin
        case ProcedureName of
            GetProcedures().Get(1):
                IsEmpty100Times();
            GetProcedures().Get(2):
                FindSet100Times();
            GetProcedures().Get(3):
                IsEmpty1000Times();
            GetProcedures().Get(4):
                FindSet1000Times();
        end;

        Result := true;
    end;

    procedure GetProcedures() Result: List of [Text[50]];
    begin
        Result.Add('IsEmpty100Times');
        Result.Add('FindSet100Times');
        Result.Add('IsEmpty1000Times');
        Result.Add('FindSet1000Times');
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

        CreatePerfToolDataLibraryWPT.CreateSuite(PerfToolGroupWPT, '02.DISEMPTYvsFINDSET', 'IsEmpty vs FindSet on Empty resultsets', PerfToolSuiteHeaderWPT);

        CreatePerfToolDataLibraryWPT.CreateSuiteLines(PerfToolSuiteHeaderWPT, WPTSuiteLine."Object Type"::Codeunit, enum::"PerfToolCodeunit WPT"::FindSetVsIsEmptyWPT, true, false, WPTSuiteLine);
    end;
    #endregion
}