codeunit 62202 "Demo - Bulk Inserts WPT" implements "PerfToolCodeunit WPT"
{
    #region BulkInserts
    procedure BulkInserts()
    var
        TableWithNoAutoIncrementWLD: Record "Table WithNo AutoIncrement WPT";
        i: Integer;
    begin
        TableWithNoAutoIncrementWLD.DeleteAll();

        for i := 1 to 10000 do begin
            TableWithNoAutoIncrementWLD.Init();
            TableWithNoAutoIncrementWLD.Id := i;
            TableWithNoAutoIncrementWLD.Description := 'Bulkinserts';
            TableWithNoAutoIncrementWLD.Insert(true);
        end;
    end;
    #endregion

    #region NoBulkInserts
    procedure NoBulkInserts()
    var
        TableWithAutoIncrementWLD: Record "Table With AutoIncrement WPT";
        i: Integer;
    begin
        TableWithAutoIncrementWLD.DeleteAll();

        for i := 1 to 10000 do begin
            TableWithAutoIncrementWLD.Init();
            TableWithAutoIncrementWLD.Id := 0; //Initialize AutoIncrement
            TableWithAutoIncrementWLD.Description := 'NoBulkInserts';
            TableWithAutoIncrementWLD.Insert(true);
        end;
    end;
    #endregion

    #region NoBulkInsertsWithNumberSeq
    procedure NoBulkInsertsWithNumberSeq()
    var
        TableWithNoAutoIncrementWLD: Record "Table WithNo AutoIncrement WPT";
        i: Integer;
    begin
        TableWithNoAutoIncrementWLD.DeleteAll();

        for i := 1 to 10000 do begin
            TableWithNoAutoIncrementWLD.Init();
            TableWithNoAutoIncrementWLD.Id := NumberSequence.Next('NoBulkInsertsWithNumberSeq');
            TableWithNoAutoIncrementWLD.Description := 'NoBulkInsertsWithNumberSeq';
            TableWithNoAutoIncrementWLD.Insert(true);
        end;
    end;
    #endregion

    procedure Run(ProcedureName: Text) Result: Boolean;
    begin
        case ProcedureName of
            GetProcedures().Get(1):
                BulkInserts();
            GetProcedures().Get(2):
                NoBulkInserts();
            GetProcedures().Get(3):
                NoBulkInsertsWithNumberSeq();
        end;

    end;

    procedure GetProcedures() Result: List of [Text[30]];
    begin
        Result.Add('BulkInserts');
        Result.Add('NoBulkInserts');
        Result.Add('NoBulkInsertsWithNumberSeq');
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Create PerfToolDataLibrary WPT", 'OnAfterInsertSuiteGroup', '', false, false)]
    local procedure OnAfterInsertSuiteGroup(var Sender: Codeunit "Create PerfToolDataLibrary WPT"; var PerfToolGroupWPT: Record "PerfTool Group WPT");
    var
        PerfToolSuiteHeaderWPT: Record "PerfTool Suite Header WPT";
        WPTSuiteLine: Record "PerfTool Suite Line WPT";
    begin
        if PerfToolGroupWPT.Code <> '2.CODING' then exit;

        sender.CreateSuite(PerfToolGroupWPT, '5. Bulk Inserts', 'Bulk Inserts', PerfToolSuiteHeaderWPT);

        sender.CreateSuiteLines(PerfToolSuiteHeaderWPT, WPTSuiteLine."Object Type"::Codeunit, enum::"PerfToolCodeunit WPT"::BulkInserts, true, true, WPTSuiteLine);
    end;
}