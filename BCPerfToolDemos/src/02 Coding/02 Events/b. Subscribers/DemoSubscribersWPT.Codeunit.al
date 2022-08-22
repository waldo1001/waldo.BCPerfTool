#pragma warning disable AA0005
codeunit 62227 "Demo - Subscribers WPT" implements "PerfToolCodeunit WPT"
{
    //#region ModifyAllNoEvents
    procedure ModifyAllNoEvents();
    var
        JustSomeTable: Record "Just Some Table WPT";
    begin
        JustSomeTable.SetFilter("Entry No.", '<%1', 50000); //Just to limit the amount of records we would change
        JustSomeTable.SetRange(Color, 'BROWN');
        JustSomeTable.ModifyAll("Message 2", format(random(1000)), false);
    end;
    //#endregion ModifyAllNoEvents

    //#region ModifyAllFullEvents
    procedure ModifyAllFullEvents();
    var
        JustSomeTable: Record "Just Some Table WPT";
        DemoSubs: codeunit "Subs OnModify WPT";
    begin
        // Enable events in subscriber-codeunit
        BindSubscription(DemoSubs);
        JustSomeTable.SetFilter("Entry No.", '<%1', 50000); //Just to limit the amount of records we would change
        JustSomeTable.SetRange(Color, 'BROWN');
        JustSomeTable.ModifyAll("Message 2", format(random(1000)), false);
        UnbindSubscription(DemoSubs);
    end;
    //#endregion ModifyAllFullEvents

    //#region LoopAllAlwaysBound
    procedure LoopAllAlwaysBound()
    var
        JustSomeTable: Record "Just Some Table WPT";
        DemoSubs: Codeunit "Subs SingleInst WPT";
    begin
        BindSubscription(DemoSubs);

        JustSomeTable.SetFilter("Entry No.", '<%1', 50000); //Just to limit the amount of records we would change
        if JustSomeTable.FindSet() then
            repeat
                JustSomeTable.Validate("Message 2", format(Random(1000)));

            until JustSomeTable.Next() < 1;

        UnbindSubscription(DemoSubs);
    end;
    //#endregion LoopAllAlwaysBound

    //#region LoopAllJITBinding
    procedure LoopAllJITBinding()
    var
        JustSomeTable: Record "Just Some Table WPT";
        DemoSubs: Codeunit "Subs SingleInst WPT";
    begin

        JustSomeTable.SetFilter("Entry No.", '<%1', 50000); //Just to limit the amount of records we would change
        if JustSomeTable.FindSet() then
            repeat
                if JustSomeTable.Color = 'RED' then  //only raise events when necessary
                    BindSubscription(DemoSubs);

                JustSomeTable.Validate("Message 2", format(Random(1000)));

                if JustSomeTable.Color = 'RED' then  //only raise events when necessary
                    UnbindSubscription(DemoSubs);

            until JustSomeTable.Next() < 1;
    end;
    //#endregion LoopAllJITBinding

    //#region NoSingleInstSubscribers
    local procedure NoSingleInstSubscribers()
    var
        JustSomeTable: Record "Just Some Table WPT";
        DemoSubs: Codeunit "Subs SingleInst WPT";
    begin
        BindSubscription(DemoSubs);

        JustSomeTable.SetFilter("Entry No.", '<%1', 5000); //Just to limit the amount of records we would change
        if JustSomeTable.FindSet() then
            repeat
                JustSomeTable.Validate("Message 2", format(Random(1000)));

            until JustSomeTable.Next() < 1;

        UnbindSubscription(DemoSubs);
    end;
    //#endregion NoSingleInstSubscribers

    //#region SingleInstSubscribers
    local procedure SingleInstSubscribers()
    var
        JustSomeTable: Record "Just Some Table WPT";
        DemoSubs: Codeunit "Subs NoSingleInst WPT";
    begin
        BindSubscription(DemoSubs);

        JustSomeTable.SetFilter("Entry No.", '<%1', 5000); //Just to limit the amount of records we would change
        if JustSomeTable.FindSet() then
            repeat
                JustSomeTable.Validate("Message 2", format(Random(1000)));

            until JustSomeTable.Next() < 1;

        UnbindSubscription(DemoSubs);
    end;
    //#endregion SingleInstSubscribers

    [BusinessEvent(true)]
    local procedure OnAfterDoingSomethingElse()
    begin
    end;

    [EventSubscriber(ObjectType::Codeunit, codeunit::"Demo - Subscribers WPT", 'OnAfterDoingSomethingElse', '', false, false)]
    local procedure EmptySubscriber()
    begin
    end;
    //#endregion

    var
        i: integer;

    procedure Run(ProcedureName: Text) Result: Boolean;
    begin
        case ProcedureName of
            GetProcedures().Get(1):
                ModifyAllNoEvents();
            GetProcedures().Get(2):
                ModifyAllFullEvents();
            GetProcedures().Get(3):
                LoopAllAlwaysBound();
            GetProcedures().Get(4):
                LoopAllJITBinding();
            GetProcedures().Get(5):
                NoSingleInstSubscribers();
            GetProcedures().Get(6):
                SingleInstSubscribers();
        end;
    end;

    procedure GetProcedures() Result: List of [Text[30]];
    begin
        Result.Add('ModifyAll - NoEvents');
        Result.Add('ModifyAll - FullEvents');
        Result.Add('LoopAll - Always Bound');
        Result.Add('LoopAll - JIT Binding');
        Result.Add('No Single Inst Subscribers');
        Result.Add('Single Inst Subscribers');
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Create PerfToolDataLibrary WPT", 'OnAfterInsertSuiteGroup', '', false, false)]
    local procedure OnAfterInsertSuiteGroup(var Sender: Codeunit "Create PerfToolDataLibrary WPT"; var PerfToolGroupWPT: Record "PerfTool Group WPT");
    var
        PerfToolSuiteHeaderWPT: Record "PerfTool Suite Header WPT";
        WPTSuiteLine: Record "PerfTool Suite Line WPT";
    begin
        if PerfToolGroupWPT.Code <> '2.CODING' then exit;

        sender.CreateSuite(PerfToolGroupWPT, '2.b Subscribers', 'Subscribers', PerfToolSuiteHeaderWPT);

        sender.CreateSuiteLines(PerfToolSuiteHeaderWPT, WPTSuiteLine."Object Type"::Codeunit, enum::"PerfToolCodeunit WPT"::Subscribers, false, true, WPTSuiteLine);
    end;
}