codeunit 62218 "Demo - Locking Find(Set) WPT" implements "PerfToolCodeunit WPT"
{
    #region FindSetTrueLocksTable_ExistingRecord
    procedure FindSetTrueLocksTable_ExistingRecord()
    var
        SessionId: Integer;
    begin
        //session 1
        StartSession(SessionId, Codeunit::"FindSetTrueAndSleep2 WPT");

        //session 2
        Sleep(2000); //Sleep to make sure the above transaction has started

        DeleteAllWaldosAndDoSomething();
    end;
    #endregion

    #region FindSetTrueLocksTable_NonExistingRecord
    procedure FindSetTrueLocksTable_NonExistingRecord()
    var
        SessionId: Integer;
    begin
        //session 1
        StartSession(SessionId, Codeunit::"FindSetTrueAndSleep WPT");

        //session 2
        Sleep(2000); //Sleep to make sure the above transaction has started

        DeleteAllWaldosAndDoSomething();
    end;
    #endregion

    local procedure DeleteAllWaldosAndDoSomething()
    var
        EmptyTableWPT: Record "EmptyTable WPT";
    begin
        EmptyTableWPT.Setrange(Code, 'WALDO');
        EmptyTableWPT.DeleteAll(true); //There is 1 "waldo"

        EmptyTableWPT.Init();
        EmptyTableWPT.Code := 'AJ';
        EmptyTableWPT.insert(true);
    end;

    #region PrepDemoData (unimportant)
    procedure PrepDemoData()
    var
        EmptyTableWPT: Record "EmptyTable WPT";
    begin
        EmptyTableWPT.InsertWaldoAndCommit(true, 'Msg1'); //DeletesAllFirst

        page.RunModal(page::"EmptyTable WPT");
    end;
    #endregion

    #region InterfaceImplementation
    procedure Run(ProcedureName: Text) Result: Boolean;
    begin
        case ProcedureName of
            GetProcedures().Get(1):
                PrepDemoData();
            GetProcedures().Get(2):
                FindSetTrueLocksTable_ExistingRecord();
            GetProcedures().Get(3):
                FindSetTrueLocksTable_NonExistingRecord();
        end;

        Result := true;
    end;

    procedure GetProcedures() Result: List of [Text[50]];
    begin
        Result.Add('PrepDemoData');
        Result.Add('FindSetTrueLocksTable_ExistingRecord');
        Result.Add('FindSetTrueLocksTable_NonExistingRecord');
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

        CreatePerfToolDataLibraryWPT.CreateSuite(PerfToolGroupWPT, '02.B FINDSET(LOCK)', 'Findset(True) Locking Behavior.', PerfToolSuiteHeaderWPT);

        CreatePerfToolDataLibraryWPT.CreateSuiteLines(PerfToolSuiteHeaderWPT, WPTSuiteLine."Object Type"::Codeunit, enum::"PerfToolCodeunit WPT"::FindSetLockingWPT, true, false, WPTSuiteLine);
    end;
    #endregion
}
