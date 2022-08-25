codeunit 62252 "Demo SQLProfiler WPT" implements "PerfToolCodeunit WPT"
{
    #region SQLInfoFindMinRepeat
    procedure SQLInfoFindMinRepeat()
    var
        JustSomeTableWPT: Record "Just Some Table WPT";
    // ReadsBefore, StatementsBefore : biginteger;
    begin
        SelectLatestVersion();

        // ReadsBefore := SessionInformation.SqlRowsRead();
        // StatementsBefore := SessionInformation.SqlStatementsExecuted();

        JustSomeTableWPT.SetFilter("Entry No.", '<%1', 50000);
        if JustSomeTableWPT.Find('-') then
            repeat
            until JustSomeTableWPT.Next() < 1;
    end;

    #endregion SQLInfoFindMinRepeat

    #region SetLoadFieldsAndModifySameField
    procedure SetLoadFieldsAndModifySameField()
    var
        JustSomeTableWPT: Record "Just Some Table WPT";
    begin
        SelectLatestVersion();

        JustSomeTableWPT.SetLoadFields(Message);
        JustSomeTableWPT.LockTable();
        JustSomeTableWPT.FindFirst();
        JustSomeTableWPT.Message := Format(Random(1000));
        JustSomeTableWPT.Modify();
    end;
    #endregion SetLoadFieldsAndModifySameField

    #region SetLoadFieldsAndModifyDifferentField
    procedure SetLoadFieldsAndModifyDifferentField()
    var
        JustSomeTableWPT: Record "Just Some Table WPT";
    begin
        SelectLatestVersion();

        JustSomeTableWPT.SetLoadFields(Message);
        JustSomeTableWPT.LockTable();
        JustSomeTableWPT.FindFirst();
        JustSomeTableWPT."Message 2" := Format(Random(1000));
        JustSomeTableWPT.Modify();
    end;
    #endregion SetLoadFieldsAndModifyDifferentField

    #region BulkInserts
    procedure BulkInserts()
    var
        TableWithNoAutoIncrementWPT: Record "Table WithNo AutoIncrement WPT";
        i: Integer;
    begin
        TableWithNoAutoIncrementWPT.DeleteAll();

        for i := 1 to 10000 do begin
            TableWithNoAutoIncrementWPT.Init();
            TableWithNoAutoIncrementWPT.Id := i;
            TableWithNoAutoIncrementWPT.Description := 'Bulkinserts';
            TableWithNoAutoIncrementWPT.Insert(true);
        end;
    end;
    #endregion

    #region BulkInsertsWithNumberSequence
    procedure BulkInsertsWithNumberSequence()
    var
        TableWithNoAutoIncrementWPT: Record "Table WithNo AutoIncrement WPT";
        i: Integer;
    begin
        TableWithNoAutoIncrementWPT.DeleteAll();

        for i := 1 to 10000 do begin
            TableWithNoAutoIncrementWPT.Init();
            TableWithNoAutoIncrementWPT.Id := NumberSequence.Next('BulkInsertsWithNumberSequence');
            TableWithNoAutoIncrementWPT.Description := 'BulkInsertsWithNumberSequence';
            TableWithNoAutoIncrementWPT.Insert(true);
        end;
    end;
    #endregion

    procedure Run(ProcedureName: Text) Result: Boolean;
    begin
        case ProcedureName of
            GetProcedures().Get(1):
                SQLInfoFindMinRepeat();
            GetProcedures().Get(2):
                SetLoadFieldsAndModifySameField();
            GetProcedures().Get(3):
                SetLoadFieldsAndModifyDifferentField();
            GetProcedures().Get(4):
                BulkInserts();
            GetProcedures().Get(5):
                BulkInsertsWithNumberSequence();
        end;

        Result := true;
    end;

    procedure GetProcedures() Result: List of [Text[50]];
    begin
        Result.Add('Find(''-'') + Repeat');
        Result.Add('SetLoadFields & ModifySameField');
        Result.Add('SetLoadFields & ModifyDifferentField');
        Result.Add('BulkInserts');
        Result.Add('BulkInserts With NumberSequence');
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Install Suites WPT", 'OnInstallAppPerCompanyFillSuite', '', false, false)]
    local procedure OnAfterInsertSuiteGroup();

    var
        PerfToolSuiteHeaderWPT: Record "PerfTool Suite Header WPT";
        WPTSuiteLine: Record "PerfTool Suite Line WPT";
        PerfToolGroupWPT: Record "PerfTool Group WPT";
        CreatePerfToolDataLibraryWPT: Codeunit "Create PerfToolDataLibrary WPT";
    begin
        CreatePerfToolDataLibraryWPT.CreateGroup('09.LazyEvaluation', 'Lazy Evaluation', PerfToolGroupWPT);

        CreatePerfToolDataLibraryWPT.CreateSuite(PerfToolGroupWPT, '1. Lazy Evaluation', 'Lazy Evaluation', PerfToolSuiteHeaderWPT);

        CreatePerfToolDataLibraryWPT.CreateSuiteLines(PerfToolSuiteHeaderWPT, WPTSuiteLine."Object Type"::Codeunit, enum::"PerfToolCodeunit WPT"::LazyEvaluation, true, false, WPTSuiteLine);
    end;
}