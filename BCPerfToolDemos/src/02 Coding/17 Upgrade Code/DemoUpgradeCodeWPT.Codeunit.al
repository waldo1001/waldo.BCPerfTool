codeunit 62290 "Demo - Upgrade Code WPT" implements "PerfToolCodeunit WPT"
{
    #region ObsoletedTable
    procedure ShowObsoletedTable()
    begin
        page.RunModal(page::"ObsoletedTable WPT");
    end;
    #endregion

    #region ClassicCopyFields
    procedure ClassicCopyFields()
    var
        Source: Record "Table With Obsolete Fields WPT";
        Target: Record "Table With New Fields WPT";
    begin
        if Source.FindSet() then
            repeat
                Target.get(Source."Entry No.");
                Target.Message := Source.Message;
                Target."Message 2" := Source."Message 2";
                Target.Modify();
            until Source.Next() < 1;
    end;
    #endregion

    #region DataTransferCopyFields
    procedure DataTransferCopyFields()
    var
        Source: Record "Table With Obsolete Fields WPT";
        Target: Record "Table With New Fields WPT";
        DataTranf: DataTransfer;
    begin
        DataTranf.SetTables(Database::"Table With Obsolete Fields WPT", Database::"Table With New Fields WPT");
        DataTranf.AddJoin(Source.FieldNo("Entry No."), Target.FieldNo("Entry No."));
        DataTranf.AddFieldValue(Source.Fieldno(Message), Target.FieldNo(Message));
        DataTranf.AddFieldValue(Source.FieldNo("Message 2"), Target.FieldNo("Message 2"));
        DataTranf.CopyFields();
    end;
    #endregion

    #region ClassicCopyRows
    procedure ClassicCopyRows()
    var
        Source: Record "Obsolete Table WPT";
        Target: Record "New Table WPT";
    begin
        Target.DeleteAll(); // Obviously - don't do this in realy upgrade code ;-)

        if Source.FindSet() then
            repeat
                Target."Entry No." := Source."Entry No.";
                Target.Message := Source.Message;
                Target."Message 2" := Source."Message 2";
                //...
                Target.Insert();
            until Source.Next() < 1;
    end;
    #endregion

    #region DataTransferCopyRows
    procedure DataTransferCopyRows()
    var
        Source: Record "Obsolete Table WPT";
        Target: Record "New Table WPT";
        DataTranf: DataTransfer;
    begin
        Target.DeleteAll(); // Obviously - don't do this in realy upgrade code ;-)

        DataTranf.SetTables(database::"Obsolete Table WPT", database::"New Table WPT");

        DataTranf.AddFieldValue(Source.FieldNo("Entry No."), Target.FieldNo("Entry No."));
        DataTranf.AddFieldValue(Source.Fieldno(Message), Target.FieldNo(Message));
        DataTranf.AddFieldValue(Source.FieldNo("Message 2"), Target.FieldNo("Message 2"));

        DataTranf.CopyRows();
    end;
    #endregion

    #region DataTransferUpgrade
    procedure PerformUpgrade_DataTransfer()
    var
        PerfToolSuiteLineWPT: Record "PerfTool Suite Line WPT";
        Target: Record "New Table WPT";
    begin
        Target.DeleteAll(); //Prep Table

        PerfToolSuiteLineWPT.SetRange("PerfTool Code", '1.UPGRADECODE');
        PerfToolSuiteLineWPT.SetFilter("Procedure Name", '*DataTransfer*');
        if PerfToolSuiteLineWPT.FindSet() then
            repeat
                PerfToolSuiteLineWPT.Run(False);
                Commit();
                Sleep(1000);
            // end
            until PerfToolSuiteLineWPT.Next() < 1;
    end;
    #endregion

    #region ScheduleUpgrade
    procedure ScheduleUpgrade()
    var
        JobQueueUpgradeWPT: Codeunit "JobQueue DoUpgrade WPT";
    begin
        JobQueueUpgradeWPT.ScheduleUpgrade();
    end;
    #endregion

    #region InterfaceImplementation
    procedure Run(ProcedureName: Text) Result: Boolean;
    begin
        case ProcedureName of
            GetProcedures().Get(1):
                ShowObsoletedTable();
            GetProcedures().Get(2):
                ClassicCopyFields();
            GetProcedures().Get(3):
                DataTransferCopyFields();
            GetProcedures().Get(4):
                ClassicCopyRows();
            GetProcedures().Get(5):
                DataTransferCopyRows();
            GetProcedures().Get(6):
                ScheduleUpgrade();
        end;

        Result := true;
    end;

    procedure GetProcedures() Result: List of [Text[50]];
    begin
        Result.Add('ShowObsoletedTable');
        Result.Add('Copy Fields Classic');
        Result.Add('Copy Fields with DataTransfer');
        Result.Add('Copy Rows Classic');
        Result.Add('Copy Rows with DataTransfer');
        Result.Add('ScheduleUpgrade');
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Install Suites WPT", 'OnInstallAppPerCompanyFillSuite', '', false, false)]
    local procedure OnAfterInsertSuiteGroup()
    var
        PerfToolSuiteHeaderWPT: Record "PerfTool Suite Header WPT";
        WPTSuiteLine: Record "PerfTool Suite Line WPT";
        PerfToolGroupWPT: Record "PerfTool Group WPT";
        CreatePerfToolDataLibraryWPT: Codeunit "Create PerfToolDataLibrary WPT";
    begin
        CreatePerfToolDataLibraryWPT.CreateGroup('17.UPGRADECODE', 'Upgrade Code', PerfToolGroupWPT);

        CreatePerfToolDataLibraryWPT.CreateSuite(PerfToolGroupWPT, '1.UPGRADECODE', 'Upgrade Code', PerfToolSuiteHeaderWPT);

        CreatePerfToolDataLibraryWPT.CreateSuiteLines(PerfToolSuiteHeaderWPT, WPTSuiteLine."Object Type"::Codeunit, enum::"PerfToolCodeunit WPT"::UpgradeCode, true, false, WPTSuiteLine);
    end;
    #endregion
}
