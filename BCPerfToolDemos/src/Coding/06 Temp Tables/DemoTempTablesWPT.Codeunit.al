#pragma warning disable AA0073
codeunit 62203 "Demo - Temp Tables WPT" implements "PerfToolCodeunit WPT"
{
    #region NormalTable
    procedure NormalTable()
    var
        MyTable: Record "NormalTable WPT";
        i: integer;
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
        i: integer;
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
        i: integer;
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

    #region InterfaceImplementation
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

        Result := true;
    end;

    procedure GetProcedures() Result: List of [Text[50]];
    begin
        Result.Add('NormalTable');
        Result.Add('NormalTableAsTemp');
        Result.Add('TempTable');
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
        CreatePerfToolDataLibraryWPT.CreateGroup('06.TEMPTABLES', '', PerfToolGroupWPT);

        CreatePerfToolDataLibraryWPT.CreateSuite(PerfToolGroupWPT, '1. Temp Tables', 'Temp Tables', PerfToolSuiteHeaderWPT);

        CreatePerfToolDataLibraryWPT.CreateSuiteLines(PerfToolSuiteHeaderWPT, WPTSuiteLine."Object Type"::Codeunit, enum::"PerfToolCodeunit WPT"::TempTables, true, false, WPTSuiteLine);
    end;
    #endregion
}