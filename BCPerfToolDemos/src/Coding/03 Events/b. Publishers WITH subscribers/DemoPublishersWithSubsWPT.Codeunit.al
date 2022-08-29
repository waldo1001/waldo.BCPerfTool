#pragma warning disable AA0005
codeunit 62260 "Demo - PublishersWithSubs WPT" implements "PerfToolCodeunit WPT"
{

    #region PublishersWithSubscriber
    local procedure PublishersWithSubscriber()
    var
        i: integer;
    begin
        for i := 0 to 100000 do begin
            //Do Something and raise event
            OnAfterDoingSomethingElse();
        end;
    end;

    [BusinessEvent(true)]
    local procedure OnAfterDoingSomethingElse()
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
            OnAfterDoingSomethingElse2();
        end;
    end;

    [BusinessEvent(true)]
    local procedure OnAfterDoingSomethingElse2()
    begin
    end;
    #endregion

    #region InterfaceImplementation
    procedure Run(ProcedureName: Text) Result: Boolean;
    begin
        case ProcedureName of
            GetProcedures().Get(1):
                PublishersWithSubscriber();
            GetProcedures().Get(2):
                PublishersWithSubscrSingleInst();
        end;

        Result := true;
    end;

    procedure GetProcedures() Result: List of [Text[50]];
    begin
        Result.Add('PublishersWithSubscriber');
        Result.Add('PublishersWithSubscrSingleInst');
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