codeunit 62214 "Demo - RecRef vs Record WPT" implements "PerfToolCodeunit WPT"
{
    //#region NormalRecordRead
    local procedure NormalRecordRead()
    var
        JustSomeTableWPT: Record "Just Some Table WPT";
    begin
        JustSomeTableWPT.SetRange("Entry No.", 1, 10000);
        JustSomeTableWPT.FindSet();
        repeat
        until JustSomeTableWPT.Next() < 1;
    end;
    //#endregion

    //#region RecRefRecordRead
    local procedure RecRefRecordRead()
    var
        RecRef: RecordRef;
        FldRef: FieldRef;
    begin
        RecRef.Open(database::"Just Some Table WPT");
        FldRef := RecRef.Field(1);
        FldRef.SetRange(1, 10000);
        RecRef.FindSet();
        repeat
        until RecRef.Next() < 1;
        RecRef.Close();
    end;
    //#endregion

    //#region NormalRecordWrite
    local procedure NormalRecordWrite()
    var
        JustSomeTableWPT: Record "Just Some Table WPT";
    begin
        JustSomeTableWPT.SetRange("Entry No.", 1, 1000);
        JustSomeTableWPT.FindSet();
        repeat
            JustSomeTableWPT.Message := JustSomeTableWPT."Message 2";
            JustSomeTableWPT.Modify();
        until JustSomeTableWPT.Next() < 1;
    end;
    //#endregion

    //#region RecRefRecordWrite
    local procedure RecRefRecordWrite()
    var
        JustSomeTableWPT: Record "Just Some Table WPT";
        RecRef: RecordRef;
        FldRef: FieldRef;
        FldRef2: FieldRef;
    begin
        RecRef.Open(database::"Just Some Table WPT");
        FldRef := RecRef.Field(JustSomeTableWPT.FieldNo("Entry No."));
        FldRef.SetRange(1, 1000);
        RecRef.FindSet();
        repeat
            FldRef := RecRef.Field(JustSomeTableWPT.FieldNo(Message));
            FldRef2 := RecRef.Field(JustSomeTableWPT.FieldNo("Message 2"));
            FldRef.Value := FldRef2.Value;
            RecRef.Modify();
        until RecRef.Next() < 1;
        RecRef.Close();
    end;
    //#endregion

    procedure Run(ProcedureName: Text) Result: Boolean;
    begin
        case ProcedureName of
            GetProcedures().Get(1):
                NormalRecordRead();
            GetProcedures().Get(2):
                RecRefRecordRead();
            GetProcedures().Get(3):
                NormalRecordWrite();
            GetProcedures().Get(4):
                RecRefRecordWrite();

        end;
    end;

    procedure GetProcedures() Result: List of [Text[30]];
    begin
        Result.Add('NormalRecordRead');
        Result.Add('RecRefRecordRead');
        Result.Add('NormalRecordWrite');
        Result.Add('RecRefRecordWrite');
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Install Suites WPT", 'OnInstallAppPerCompanyFillSuite', '', false, false)]
    local procedure OnAfterInsertSuiteGroup();
    var
        PerfToolSuiteHeaderWPT: Record "PerfTool Suite Header WPT";
        WPTSuiteLine: Record "PerfTool Suite Line WPT";
        PerfToolGroupWPT: Record "PerfTool Group WPT";
        CreatePerfToolDataLibraryWPT: Codeunit "Create PerfToolDataLibrary WPT";
    begin
        CreatePerfToolDataLibraryWPT.CreateGroup('1.DATA', 'Data Access', PerfToolGroupWPT);

        CreatePerfToolDataLibraryWPT.CreateSuite(PerfToolGroupWPT, '5. RecRef', 'RecRef vs Record', PerfToolSuiteHeaderWPT);

        CreatePerfToolDataLibraryWPT.CreateSuiteLines(PerfToolSuiteHeaderWPT, WPTSuiteLine."Object Type"::Codeunit, enum::"PerfToolCodeunit WPT"::RecRef, true, false, WPTSuiteLine);
    end;
}