#pragma warning disable AA0005
codeunit 62260 "Demo - PublishersWithSubs WPT" implements "PerfToolCodeunit WPT"
{
    #region PublishersWithoutSubscriber
    local procedure PublishersWithoutSubscriber()
    var
        i: integer;
    begin
        for i := 0 to 100000 do begin
            //Do Something and raise event
            OnAfterDoingSomething();
        end;
    end;

    [BusinessEvent(true)]
    local procedure OnAfterDoingSomething()
    begin
    end;
    #endregion

    #region PublishersWithSmallSubscriber
    local procedure PublishersWithSmallSubscriber()
    var
        i: integer;
    begin
        for i := 0 to 100000 do begin
            //Do Something and raise event
            OnAfterDoingSomethingSmall();
        end;
    end;

    [BusinessEvent(true)]
    local procedure OnAfterDoingSomethingSmall()
    begin
    end;
    #endregion

    #region PublishersWithBigSubscriber
    local procedure PublishersWithBigSubscriber()
    var
        i: integer;
    begin
        for i := 0 to 100000 do begin
            //Do Something and raise event
            OnAfterDoingSomethingBig();
        end;
    end;

    [BusinessEvent(true)]
    local procedure OnAfterDoingSomethingBig()
    begin
    end;
    #endregion

    #region PublishersWithGlobalVar
    local procedure PublishersWithGlobalVar()
    var
        i: integer;
    begin
        for i := 0 to 100000 do begin
            //Do Something and raise event
            OnAfterDoingSomethingGlobalVar();
        end;
    end;

    [BusinessEvent(true)]
    local procedure OnAfterDoingSomethingGlobalVar()
    begin
    end;
    #endregion

    #region PublishersWithSubscrSingleInst
    local procedure PublishersWithSubscrSingleInst()
    var
        i: integer;
    begin
        for i := 0 to 100000 do begin
            //Do Something and raise event
            OnAfterDoingSomethingBigSingleInst();
        end;
    end;

    [BusinessEvent(true)]
    local procedure OnAfterDoingSomethingBigSingleInst()
    begin
    end;
    #endregion

    #region InterfaceImplementation
    procedure Run(ProcedureName: Text) Result: Boolean;
    begin
        case ProcedureName of
            GetProcedures().Get(1):
                PublishersWithoutSubscriber();
            GetProcedures().Get(2):
                PublishersWithSmallSubscriber();
            GetProcedures().Get(3):
                PublishersWithBigSubscriber();
            GetProcedures().Get(4):
                PublishersWithGlobalVar();
            GetProcedures().Get(5):
                PublishersWithSubscrSingleInst();
        end;

        Result := true;
    end;

    procedure GetProcedures() Result: List of [Text[50]];
    begin
        Result.Add('No Subscriber');
        Result.Add('Small Subscriber');
        Result.Add('Big Subscriber');
        Result.Add('Subscriber with Global Vars');
        Result.Add('Subscriber with Global Vars (Single Instance)');
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Install Suites WPT", 'OnInstallAppPerCompanyFillSuite', '', false, false)]
    local procedure OnAfterInsertSuiteGroup();

    var
        PerfToolSuiteHeaderWPT: Record "PerfTool Suite Header WPT";
        WPTSuiteLine: Record "PerfTool Suite Line WPT";
        PerfToolGroupWPT: Record "PerfTool Group WPT";
        CreatePerfToolDataLibraryWPT: Codeunit "Create PerfToolDataLibrary WPT";
    begin
        CreatePerfToolDataLibraryWPT.CreateGroup('03.Events', 'Events', PerfToolGroupWPT);

        CreatePerfToolDataLibraryWPT.CreateSuite(PerfToolGroupWPT, '2. PubsWithSubs', 'Publishers With Subscribers', PerfToolSuiteHeaderWPT);

        CreatePerfToolDataLibraryWPT.CreateSuiteLines(PerfToolSuiteHeaderWPT, WPTSuiteLine."Object Type"::Codeunit, enum::"PerfToolCodeunit WPT"::PublishersWithSubscribers, true, false, WPTSuiteLine);
    end;
    #endregion
}