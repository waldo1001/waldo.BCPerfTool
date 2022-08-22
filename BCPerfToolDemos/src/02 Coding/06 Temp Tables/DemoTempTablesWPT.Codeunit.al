#pragma warning disable AA0073
codeunit 62203 "Demo - Temp Tables WPT" implements "PerfToolCodeunit WPT"
{
    #region NormalTable
    procedure NormalTable()
    var
        MyTable: Record "NormalTable WPT";
    begin
        for i := 0 to 2000 do begin
            MyTable."Entry No." := i;
            MyTable.Insert(false);
        end;

        if MyTable.FindSet() then
            repeat
            //Do something
            until MyTable.Next() < 1;

        MyTable.DeleteAll();
    end;
    #endregion

    #region NormalTableAsTemp
    procedure NormalTableAsTemp()
    var
        MyTable: Record "NormalTable WPT" temporary;
    begin
        for i := 0 to 2000 do begin
            MyTable."Entry No." := i;
            MyTable.Insert(false);
        end;

        if MyTable.FindSet() then
            repeat
            //Do something
            until MyTable.Next() < 1;

        MyTable.DeleteAll();
    end;
    #endregion 

    #region TempTable
    procedure TempTable()
    var
        MyTable: Record "TempTable WPT";
    begin
        for i := 0 to 2000 do begin
            MyTable."Entry No." := i;
            MyTable.Insert(false);
        end;

        if MyTable.FindSet() then
            repeat
            //Do something
            until MyTable.Next() < 1;

        MyTable.DeleteAll();
    end;
    #endregion

    var
        i: integer;

    procedure Run(ProcedureName: Text) Result: Boolean;
    begin
        case ProcedureName of
            GetProcedures().Get(1):
                NormalTable();
            GetProcedures().Get(2):
                NormalTableAsTemp();
            GetProcedures().Get(3):
                TempTable();
        end;
    end;

    procedure GetProcedures() Result: List of [Text[30]];
    begin
        Result.Add('NormalTable');
        Result.Add('NormalTableAsTemp');
        Result.Add('TempTable');
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Create PerfToolDataLibrary WPT", 'OnAfterInsertSuiteGroup', '', false, false)]
    local procedure OnAfterInsertSuiteGroup(var Sender: Codeunit "Create PerfToolDataLibrary WPT"; var PerfToolGroupWPT: Record "PerfTool Group WPT");
    var
        PerfToolSuiteHeaderWPT: Record "PerfTool Suite Header WPT";
        WPTSuiteLine: Record "PerfTool Suite Line WPT";
    begin
        if PerfToolGroupWPT.Code <> '2.CODING' then exit;

        sender.CreateSuite(PerfToolGroupWPT, '6. Temp Tables', 'Temp Tables', PerfToolSuiteHeaderWPT);

        sender.CreateSuiteLines(PerfToolSuiteHeaderWPT, WPTSuiteLine."Object Type"::Codeunit, enum::"PerfToolCodeunit WPT"::TempTables, true, false, WPTSuiteLine);
    end;
}