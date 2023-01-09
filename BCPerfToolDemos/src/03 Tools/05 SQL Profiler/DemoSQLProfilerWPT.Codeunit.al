codeunit 62252 "Demo SQLProfiler WPT" implements "PerfToolCodeunit WPT"
{
    #region FindSetAndLoop100
    local procedure FindSetAndLoop100()
    var
        JustSomeTableWPT: Record "Just Some Table WPT";
        i: integer;
    begin
        if JustSomeTableWPT.FindSet() then
            for i := 1 to 100 do
                JustSomeTableWPT.Next();
    end;
    #endregion

    #region FindMinAndLoop100
    local procedure FindMinAndLoop100()
    var
        JustSomeTableWPT: Record "Just Some Table WPT";
        i: integer;
    begin
        if JustSomeTableWPT.Find('-') then
            for i := 1 to 100 do
                JustSomeTableWPT.Next();
    end;
    #endregion

    #region SetLoadFieldsAndModifySameField
    procedure SetLoadFieldsAndModifySameField()
    var
        JustSomeTableWPT: Record "Just Some Table WPT";
    begin
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

    #region InterfaceImplementation
    procedure Run(ProcedureName: Text) Result: Boolean;
    begin
        case ProcedureName of
            GetProcedures().Get(1):
                FindSetAndLoop100();
            GetProcedures().Get(2):
                FindMinAndLoop100();
            GetProcedures().Get(3):
                SetLoadFieldsAndModifySameField();
            GetProcedures().Get(4):
                SetLoadFieldsAndModifyDifferentField();
            GetProcedures().Get(5):
                BulkInserts();
            GetProcedures().Get(6):
                BulkInsertsWithNumberSequence();
        end;

        Result := true;
    end;

    procedure GetProcedures() Result: List of [Text[50]];
    begin
        Result.Add('FindSet + Repeat');
        Result.Add('Find(''-'') + Repeat');
        Result.Add('SetLoadFields & ModifySameField');
        Result.Add('SetLoadFields & ModifyDifferentField');
        Result.Add('BulkInserts');
        Result.Add('BulkInserts With NumberSequence');
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"PerfTool Triggers WPT", 'OnGetSuiteData', '', false, false)]
    local procedure OnAfterInsertSuiteGroup();

    var
        PerfToolSuiteHeaderWPT: Record "PerfTool Suite Header WPT";
        WPTSuiteLine: Record "PerfTool Suite Line WPT";
        PerfToolGroupWPT: Record "PerfTool Group WPT";
        CreatePerfToolDataLibraryWPT: Codeunit "Create PerfToolDataLibrary WPT";
    begin
        CreatePerfToolDataLibraryWPT.CreateGroup('20.Tools', 'Tools', PerfToolGroupWPT);

        CreatePerfToolDataLibraryWPT.CreateSuite(PerfToolGroupWPT, '5. SQL Profiler', 'SQL Profiler', PerfToolSuiteHeaderWPT);

        CreatePerfToolDataLibraryWPT.CreateSuiteLines(PerfToolSuiteHeaderWPT, WPTSuiteLine."Object Type"::Codeunit, enum::"PerfToolCodeunit WPT"::SQLProfiler, true, false, WPTSuiteLine);
    end;
    #endregion
}