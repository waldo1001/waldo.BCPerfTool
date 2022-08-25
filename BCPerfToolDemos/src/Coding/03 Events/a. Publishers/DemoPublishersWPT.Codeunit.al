#pragma warning disable AA0005
codeunit 62207 "Demo - Publishers WPT" implements "PerfToolCodeunit WPT"
{
    //#region NoPublishers
    local procedure NoPublishers()
    begin
        for i := 0 to 100000 do begin
            //Do Something        
        end;
    end;
    //#endregion

    //#region Publishers
    local procedure Publishers()
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
    //#endregion

    //#region PublishersWithSubscriber
    local procedure PublishersWithSubscriber()
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

    [EventSubscriber(ObjectType::Codeunit, codeunit::"Demo - Publishers WPT", 'OnAfterDoingSomethingElse', '', false, false)]
    local procedure EmptySubscriber()
    begin
    end;
    //#endregion

    //#region PublishersWithSubscrSingleInst
    local procedure PublishersWithSubscrSingleInst()
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
    //#endregion

    var
        i: integer;

    procedure Run(ProcedureName: Text) Result: Boolean;
    begin
        case ProcedureName of
            GetProcedures().Get(1):
                NoPublishers();
            GetProcedures().Get(2):
                Publishers();
            GetProcedures().Get(3):
                PublishersWithSubscriber();
            GetProcedures().Get(4):
                PublishersWithSubscrSingleInst();
        end;

        Result := true;
    end;

    procedure GetProcedures() Result: List of [Text[30]];
    begin
        Result.Add('No Publishers');
        Result.Add('Publishers');
        Result.Add('PublishersWithSubscriber');
        Result.Add('PublishersWithSubscrSingleInst');
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
        CreatePerfToolDataLibraryWPT.CreateGroup('3.Events', 'Events', PerfToolGroupWPT);

        CreatePerfToolDataLibraryWPT.CreateSuite(PerfToolGroupWPT, '1. Publishers', 'Publishers', PerfToolSuiteHeaderWPT);

        CreatePerfToolDataLibraryWPT.CreateSuiteLines(PerfToolSuiteHeaderWPT, WPTSuiteLine."Object Type"::Codeunit, enum::"PerfToolCodeunit WPT"::Publishers, true, false, WPTSuiteLine);
    end;
}