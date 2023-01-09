#pragma warning disable AA0005
codeunit 62227 "Demo - Subs OnModify WPT" implements "PerfToolCodeunit WPT"
{
    #region ModifyAllNoEvents
    procedure ModifyAllNoEvents();
    var
        JustSomeTable: Record "Just Some Table WPT";
    begin
        JustSomeTable.SetFilter("Entry No.", '<%1', 50000); //Just to limit the amount of records we would change
        JustSomeTable.SetRange(Color, 'BROWN');
        JustSomeTable.ModifyAll("Message 2", format(random(1000)), false);
    end;
    #endregion

    #region ModifyAllFullEvents
    procedure ModifyAllFullEvents();
    var
        JustSomeTable: Record "Just Some Extended Table 1 WPT";
        DemoSubs: codeunit "Subs OnModify WPT";
    begin
        BindSubscription(DemoSubs);
        JustSomeTable.SetFilter("Entry No.", '<%1', 50000); //Just to limit the amount of records we would change
        JustSomeTable.SetRange(Color, 'BROWN');
        JustSomeTable.ModifyAll("Message 2", format(random(1000)), false);
        UnbindSubscription(DemoSubs);
    end;
    #endregion

    #region ModifyAllEventsNotBound
    procedure ModifyAllEventsNotBound();
    var
        JustSomeTable: Record "Just Some Extended Table 1 WPT";
    // DemoSubs: codeunit "Subs OnModify WPT";
    begin
        // BindSubscription(DemoSubs);
        JustSomeTable.SetFilter("Entry No.", '<%1', 50000); //Just to limit the amount of records we would change
        JustSomeTable.SetRange(Color, 'BROWN');
        JustSomeTable.ModifyAll("Message 2", format(random(1000)), false);
        // UnbindSubscription(DemoSubs);
    end;
    #endregion

    #region InterfaceImplementation
    procedure Run(ProcedureName: Text) Result: Boolean;
    begin
        case ProcedureName of
            GetProcedures().Get(1):
                ModifyAllNoEvents();
            GetProcedures().Get(2):
                ModifyAllFullEvents();
            GetProcedures().Get(3):
                ModifyAllEventsNotBound();
        end;

        Result := true;
    end;

    procedure GetProcedures() Result: List of [Text[50]];
    begin
        Result.Add('ModifyAll - NoEvents');
        Result.Add('ModifyAll - FullEvents');
        Result.Add('ModifyAll - Events Not Bound');
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"PerfTool Triggers WPT", 'OnGetSuiteData', '', false, false)]
    local procedure OnAfterInsertSuiteGroup();

    var
        PerfToolSuiteHeaderWPT: Record "PerfTool Suite Header WPT";
        WPTSuiteLine: Record "PerfTool Suite Line WPT";
        PerfToolGroupWPT: Record "PerfTool Group WPT";
        CreatePerfToolDataLibraryWPT: Codeunit "Create PerfToolDataLibrary WPT";
    begin
        CreatePerfToolDataLibraryWPT.CreateGroup('03.Events', 'Events', PerfToolGroupWPT);

        CreatePerfToolDataLibraryWPT.CreateSuite(PerfToolGroupWPT, '3. OnModify', 'OnModify(All)', PerfToolSuiteHeaderWPT);

        CreatePerfToolDataLibraryWPT.CreateSuiteLines(PerfToolSuiteHeaderWPT, WPTSuiteLine."Object Type"::Codeunit, enum::"PerfToolCodeunit WPT"::OnModifySubs, true, false, WPTSuiteLine);
    end;
    #endregion
}