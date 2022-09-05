codeunit 62202 "Demo - Bulk Inserts WPT" implements "PerfToolCodeunit WPT"
{
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

    #region NoBulkInserts
    procedure NoBulkInserts()
    var
        TableWithAutoIncrementWPT: Record "Table With AutoIncrement WPT";
        i: Integer;
    begin
        TableWithAutoIncrementWPT.DeleteAll();

        for i := 1 to 10000 do begin
            TableWithAutoIncrementWPT.Init();
            TableWithAutoIncrementWPT.Id := 0; //Initialize AutoIncrement
            TableWithAutoIncrementWPT.Description := 'NoBulkInserts';
            TableWithAutoIncrementWPT.Insert(true);
        end;
    end;
    #endregion

    #region BulkInsertsWithNumberSeq
    procedure BulkInsertsWithNumberSeq()
    var
        TableWithNoAutoIncrementWPT: Record "Table WithNo AutoIncrement WPT";
        i: Integer;
    begin
        TableWithNoAutoIncrementWPT.DeleteAll();

        for i := 1 to 10000 do begin
            TableWithNoAutoIncrementWPT.Init();
            TableWithNoAutoIncrementWPT.Id := NumberSequence.Next('BulkInsertsWithNumberSeq');
            TableWithNoAutoIncrementWPT.Description := 'BulkInsertsWithNumberSeq';
            TableWithNoAutoIncrementWPT.Insert(true);
        end;
    end;
    #endregion

    #region InterfaceImplementation
    procedure Run(ProcedureName: Text) Result: Boolean;
    begin
        case ProcedureName of
            GetProcedures().Get(1):
                BulkInserts();
            GetProcedures().Get(2):
                NoBulkInserts();
            GetProcedures().Get(3):
                BulkInsertsWithNumberSeq();
        end;

        Result := true;

    end;

    procedure GetProcedures() Result: List of [Text[50]];
    begin
        Result.Add('BulkInserts');
        Result.Add('NoBulkInserts');
        Result.Add('BulkInsertsWithNumberSeq');
    end;

    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Create PerfToolDataLibrary WPT", 'OnAfterInsertSuiteGroup', '', false, false)]
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Install Suites WPT", 'OnInstallAppPerCompanyFillSuite', '', false, false)]
    local procedure OnAfterInsertSuiteGroup();
    var
        PerfToolSuiteHeaderWPT: Record "PerfTool Suite Header WPT";
        WPTSuiteLine: Record "PerfTool Suite Line WPT";
        PerfToolGroupWPT: Record "PerfTool Group WPT";
        CreatePerfToolDataLibraryWPT: Codeunit "Create PerfToolDataLibrary WPT";
    begin
        CreatePerfToolDataLibraryWPT.CreateGroup('01.DATA', 'Data Access', PerfToolGroupWPT);

        CreatePerfToolDataLibraryWPT.CreateSuite(PerfToolGroupWPT, '07. Bulk Inserts', 'Bulk Inserts', PerfToolSuiteHeaderWPT);

        CreatePerfToolDataLibraryWPT.CreateSuiteLines(PerfToolSuiteHeaderWPT, WPTSuiteLine."Object Type"::Codeunit, enum::"PerfToolCodeunit WPT"::BulkInserts, true, true, WPTSuiteLine);
    end;
    #endregion
}