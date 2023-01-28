codeunit 62209 "Demo - PartialRecordsSS WPT" implements "PerfToolCodeunit WPT"
{
    #region EightExt_NoPartialrecordsLoopWithSubscrber
    //Eight table extensions on a table
    // A subscriber event in a loop
    local procedure EightExt_NoPRLoopWithSubscriber()
    var
        JustSomeTableWPT: Record "Just Some Extended Table 4 WPT";
        i: Integer;
    begin
        if JustSomeTableWPT.FindSet() then;
        repeat
            i += 1;
            DoLoopJITSubscriber(JustSomeTableWPT);
            if i > 7500 then exit;
        until JustSomeTableWPT.Next() < 1;
    end;
    #endregion


    #region EightExt_PartialrecordsLoopWithJITSubscrber
    //Eight table extensions on a table
    // A subscriber event in a loop, does JIT loading on a new table field (same extension)
    local procedure EightExt_PRLoopWithJITSubscriber()
    var
        JustSomeTableWPT: Record "Just Some Extended Table 4 WPT";
        i: Integer;
    begin
        JustSomeTableWPT.SetLoadFields(Message);
        if JustSomeTableWPT.FindSet() then;
        repeat
            i += 1;
            DoLoopJITSubscriber(JustSomeTableWPT);
            if i > 7500 then exit;
        until JustSomeTableWPT.Next() < 1;
    end;
    #endregion

    #region EightExt_PartialrecordsLoopWithAddFieldsSubscriber
    //Eight table extensions on a table
    // A subscriber event in a loop, check if new field is loaded, if not load it (same extension)
    local procedure EightExt_PRLoopWithAddFieldsSubscriber()
    var
        JustSomeTableWPT: Record "Just Some Extended Table 4 WPT";
        i: Integer;
    begin
        JustSomeTableWPT.SetLoadFields(Message);
        if JustSomeTableWPT.FindSet() then;
        repeat
            i += 1;
            DoLoopAddFieldsSubscriber(JustSomeTableWPT);
            if i > 7500 then exit;
        until JustSomeTableWPT.Next() < 1;
    end;
    #endregion

    #region EightExt_PartialrecordsLoopWithExtJITSubscrber
    //Eight table extensions on a table
    // A subscriber event in a loop, JIT load a new field from another table extension
    local procedure EightExt_PRLoopWithExtJITSubscriber()
    var
        JustSomeTableWPT: Record "Just Some Extended Table 4 WPT";
        i: Integer;
    begin
        JustSomeTableWPT.SetLoadFields(Message);
        if JustSomeTableWPT.FindSet() then;
        repeat
            i += 1;
            DoLoopAnotherExtJITSubscriber(JustSomeTableWPT);
            if i > 7500 then exit;
        until JustSomeTableWPT.Next() < 1;
    end;
    #endregion

    #region EightExt_PartialrecordsLoopWithExtAddFieldsSubscriber
    //Eight table extensions on a table
    // A subscriber event in a loop, check if new field is loaded, if not load it (another extension)
    local procedure EightExt_PRLoopWithExtAddFieldsSubscriber()
    var
        JustSomeTableWPT: Record "Just Some Extended Table 4 WPT";
        i: Integer;
    begin
        JustSomeTableWPT.SetLoadFields(Message);
        if JustSomeTableWPT.FindSet() then;
        repeat
            i += 1;
            DoLoopAnotherExtAddFieldsSubscriber(JustSomeTableWPT);
            if i > 7500 then exit;
        until JustSomeTableWPT.Next() < 1;
    end;
    #endregion



    [IntegrationEvent(false, false)]
    local procedure DoLoopJITSubscriber(var JustSomeTableWPT: Record "Just Some Extended Table 4 WPT")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure DoLoopAddFieldsSubscriber(var JustSomeTableWPT: Record "Just Some Extended Table 4 WPT")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure DoLoopAnotherExtJITSubscriber(var JustSomeTableWPT: Record "Just Some Extended Table 4 WPT")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure DoLoopAnotherExtAddFieldsSubscriber(var JustSomeTableWPT: Record "Just Some Extended Table 4 WPT")
    begin
    end;


    #region InterfaceImplementation
    procedure Run(ProcedureName: Text) Result: Boolean;
    var
    begin
        case ProcedureName of
            GetProcedures().Get(1):
                EightExt_NoPRLoopWithSubscriber();
            GetProcedures().Get(2):
                EightExt_PRLoopWithJITSubscriber();
            GetProcedures().Get(3):
                EightExt_PRLoopWithAddFieldsSubscriber();
            GetProcedures().Get(4):
                EightExt_PRLoopWithExtJITSubscriber();
            GetProcedures().Get(5):
                EightExt_PRLoopWithExtAddFieldsSubscriber();
        // GetProcedures().Get(6):
        //     Table2_FindSetWithPartialrecords();
        // GetProcedures().Get(7):
        //     Table3_FindSetNoPartialrecords();
        // GetProcedures().Get(8):
        //     Table3_FindSetWithPartialrecords();
        // GetProcedures().Get(9):
        //     Table4_FindSetNoPartialrecords();
        // GetProcedures().Get(10):
        //     Table4_FindSetWithPartialrecords();
        // GetProcedures().Get(11):
        //     FindSetWithPartialRecordsSubJIT();
        // GetProcedures().Get(12):
        //     FindSetWithPartialrecordsSubAddLoadFields();
        // GetProcedures().Get(13):
        //     DemoPRWithSubscriberWPT.FindSetWithPartialRecordsSubJIT();
        // GetProcedures().Get(14):
        //     DemoPRWithSubscriberWPT.FindSetWithPartialrecordsSubAddLoadFields();
        end;

        OnAfterRun(ProcedureName);

        Result := true;
    end;

    procedure GetProcedures() Result: List of [Text[50]];
    begin
        Result.Add('EightExt_NoPRLoopWithSubscriber');
        Result.Add('EightExt_PRLoopWithJITSubscriber');
        Result.Add('EightExt_PRLoopWithAddFieldsSubscriber');
        Result.add('EightExt_PRLoopWithExtJITSubscriber');
        Result.add('EightExt_PRLoopWithExtAddFieldsSubscriber');
        //Result.Add('Table1_FindSetWithPartialrecords');


        OnAfterGetProcedures(Result);
    end;

    [IntegrationEvent(true, false)]
    local procedure OnAfterGetProcedures(var Result: list of [Text[50]])
    begin
    end;

    [IntegrationEvent(true, false)]
    local procedure OnAfterRun(ProcedureName: Text)
    begin
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

        CreatePerfToolDataLibraryWPT.CreateSuite(PerfToolGroupWPT, '04b. PartialRecords', 'Partial Records With Subscriber', PerfToolSuiteHeaderWPT);
        CreatePerfToolDataLibraryWPT.CreateSuiteLines(PerfToolSuiteHeaderWPT, WPTSuiteLine."Object Type"::Codeunit, enum::"PerfToolCodeunit WPT"::PartialRecordsWithSubscriber, true, false, WPTSuiteLine);
    end;
    #endregion
}