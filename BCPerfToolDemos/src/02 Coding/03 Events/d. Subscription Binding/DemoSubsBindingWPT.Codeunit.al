#pragma warning disable AA0005
codeunit 62262 "Demo - SubsBinding WPT" implements "PerfToolCodeunit WPT"
{
    #region LoopAllAlwaysBound
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
    #endregion LoopAllAlwaysBound

    #region LoopAllJITBinding
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
    #endregion LoopAllJITBinding


    #region InterfaceImplementation
    procedure Run(ProcedureName: Text) Result: Boolean;
    begin
        case ProcedureName of
            GetProcedures().Get(1):
                LoopAllAlwaysBound();
            GetProcedures().Get(2):
                LoopAllJITBinding();
        end;

        Result := true;
    end;

    procedure GetProcedures() Result: List of [Text[50]];
    begin
        Result.Add('LoopAll - Always Bound');
        Result.Add('LoopAll - JIT Binding');
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

        CreatePerfToolDataLibraryWPT.CreateSuite(PerfToolGroupWPT, '4. SubsBinding', 'Subscription Binding', PerfToolSuiteHeaderWPT);

        CreatePerfToolDataLibraryWPT.CreateSuiteLines(PerfToolSuiteHeaderWPT, WPTSuiteLine."Object Type"::Codeunit, enum::"PerfToolCodeunit WPT"::SubscriptionBinding, false, true, WPTSuiteLine);
    end;
    #endregion
}