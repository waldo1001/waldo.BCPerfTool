codeunit 62300 "Demo - TriState Locking WPT" implements "PerfToolCodeunit WPT"
{
    #region WithLockTable
    procedure WithLockTable()
    var
        JustSomeTable: Record "Vendor";
        sid: Integer;
    // fkey: Record "Feature Key";
    // tb: TextBuilder;
    begin
        // fkey.Get('TriStateLocking');
        StartSession(sid, Codeunit::"Lock Vend LockTable WPT");

        //Session2
        Sleep(2000); //Sleep to make sure the background (10s) transaction has started

        // Message(Format(fkey.Enabled));

        JustSomeTable.ReadIsolation := IsolationLevel::UpdLock;
        JustSomeTable.FindFirst();
    end;
    #endregion
    #region WithLockTable_ReadIsolationReadUncommitted
    procedure WithLockTable_ReadIsolationReadUncommitted()
    var
        JustSomeTable: Record "Vendor";
        sid: Integer;
    // fkey: Record "Feature Key";
    // tb: TextBuilder;
    begin
        // fkey.Get('TriStateLocking');
        StartSession(sid, Codeunit::"Lock Vend LockTable WPT");

        //Session2
        Sleep(2000); //Sleep to make sure the background (10s) transaction has started

        // Message(Format(fkey.Enabled));

        JustSomeTable.ReadIsolation := IsolationLevel::ReadUncommitted;
        if JustSomeTable.IsEmpty() then exit;


    end;
    #endregion
    #region WithoutLockTable
    procedure WithoutLockTable()
    var
        JustSomeTable: Record "Contact";
        sid: Integer;
    // fkey: Record "Feature Key";
    // tb: TextBuilder;
    begin
        // fkey.Get('TriStateLocking');
        StartSession(sid, Codeunit::"Lock Cont NOLockTable WPT");

        //Session2
        Sleep(1000); //Sleep to make sure the background (10s) transaction has started

        // Message(Format(fkey.Enabled));

        JustSomeTable.ReadIsolation := IsolationLevel::UpdLock;
        JustSomeTable.FindFirst();
    end;
    #endregion
    #region FindSetTrue
    procedure FindSetTrue()
    var
        JustSomeTable: Record "Customer";
        sid: Integer;
    // fkey: Record "Feature Key";
    // tb: TextBuilder;
    begin
        // fkey.Get('TriStateLocking');
        StartSession(sid, Codeunit::"Lock Cust FindSetTrue WPT");

        //Session2
        Sleep(1000); //Sleep to make sure the background (10s) transaction has started

        // Message(Format(fkey.Enabled));

        JustSomeTable.ReadIsolation := IsolationLevel::UpdLock;
        JustSomeTable.FindFirst();
    end;
    #endregion

    #region Debug_LockWithLockTable
    procedure Debug_LockWithLockTable()
    begin
        Codeunit.Run(codeunit::"Lock Vend LockTable WPT");
    end;
    #endregion
    #region Debug_LockWithoutLockTable
    procedure Debug_LockWithoutLockTable()
    begin
        Codeunit.Run(codeunit::"Lock Cont NOLockTable WPT");
    end;
    #endregion
    #region Debug_LockWithFindSetTrue
    procedure Debug_LockWithFindSetTrue()
    begin
        Codeunit.Run(codeunit::"Lock Cust FindSetTrue WPT");
    end;
    #endregion

    #region InterfaceImplementation
    procedure Run(ProcedureName: Text) Result: Boolean;
    begin
        case ProcedureName of
            GetProcedures().Get(1):
                WithLockTable();
            GetProcedures().Get(2):
                WithLockTable_ReadIsolationReadUncommitted();
            GetProcedures().Get(3):
                WithoutLockTable();
            GetProcedures().Get(4):
                FindSetTrue();
            GetProcedures().Get(5):
                Debug_LockWithLockTable();
            GetProcedures().Get(6):
                Debug_LockWithoutLockTable();
            GetProcedures().Get(7):
                Debug_LockWithFindSetTrue();

        end;

        Result := true;
    end;

    procedure GetProcedures() Result: List of [Text[50]];
    begin
        Result.Add('WithLockTable');
        Result.Add('WithLockTable_ReadIsolationReadUncommitted');
        Result.Add('WithoutLockTable');
        Result.Add('FindSetTrue');
        Result.Add('Debug_LockWithLockTable');
        Result.Add('Debug_LockWithoutLockTable');
        Result.Add('Debug_LockWithFindSetTrue');
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

        CreatePerfToolDataLibraryWPT.CreateSuite(PerfToolGroupWPT, '10. TriStateLocking', 'TriState Locking', PerfToolSuiteHeaderWPT);

        CreatePerfToolDataLibraryWPT.CreateSuiteLines(PerfToolSuiteHeaderWPT, WPTSuiteLine."Object Type"::Codeunit, enum::"PerfToolCodeunit WPT"::TriStateLocking, true, false, WPTSuiteLine);

    end;
    #endregion
}