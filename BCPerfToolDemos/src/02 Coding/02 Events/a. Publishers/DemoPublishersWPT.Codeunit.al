#pragma warning disable AA0005
codeunit 62207 "Demo - Publishers WPT" implements "PerfToolCodeunit WPT"
{
    //#region NoPublishers
    local procedure NoPublishers()
    begin
        for i := 0 to 1000000 do begin
            //Do Something        
        end;
    end;
    //#endregion

    //#region Publishers
    local procedure Publishers()
    begin
        for i := 0 to 1000000 do begin
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
        for i := 0 to 1000000 do begin
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
        for i := 0 to 1000000 do begin
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
    end;

    procedure GetProcedures() Result: List of [Text[30]];
    begin
        Result.Add('No Publishers');
        Result.Add('Publishers');
        Result.Add('PublishersWithSubscriber');
        Result.Add('PublishersWithSubscrSingleInst');
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Create PerfToolDataLibrary WPT", 'OnAfterInsertSuiteGroup', '', false, false)]
    local procedure OnAfterInsertSuiteGroup(var Sender: Codeunit "Create PerfToolDataLibrary WPT"; var PerfToolGroupWPT: Record "PerfTool Group WPT");
    var
        PerfToolSuiteHeaderWPT: Record "PerfTool Suite Header WPT";
        WPTSuiteLine: Record "PerfTool Suite Line WPT";
    begin
        if PerfToolGroupWPT.Code <> '2.CODING' then exit;

        sender.CreateSuite(PerfToolGroupWPT, '2.a Publishers', 'Publishers', PerfToolSuiteHeaderWPT);

        sender.CreateSuiteLines(PerfToolSuiteHeaderWPT, WPTSuiteLine."Object Type"::Codeunit, enum::"PerfToolCodeunit WPT"::Publishers, true, false, WPTSuiteLine);
    end;
}