#pragma warning disable PTE0007,AA0161
codeunit 62253 "Demo - FlameGraph WPT" implements "PerfToolCodeunit WPT"
{
    #region OpenSalesInvoicePage
    procedure OpenSalesInvoicePage()
    var
        SalesHeader: Record "Sales Header";
        PageManagement: Codeunit "Page Management";
        FlameGraphSubsFastWPT: Codeunit "FlameGraph Subs (Fast) WPT";
    begin
        BindSubscription(FlameGraphSubsFastWPT);

        SalesHeader.SetRange("Document Type", SalesHeader."Document Type"::Invoice);
        SalesHeader.FindFirst();

        PageManagement.PageRunModal(SalesHeader);

        UnbindSubscription(FlameGraphSubsFastWPT);
    end;
    #endregion

    #region PostSalesInvoice
    procedure PostSalesInvoice()
    var
        FlameGraphSubsFastWPT: Codeunit "FlameGraph Subs (Fast) WPT";
        FlameGraphSubsSlowWPT: Codeunit "FlameGraph Subs (Slow) WPT";
        PyroscopeDemoGlobalsWPT: Codeunit "PyroscopeDemoGlobals WPT";
    begin
        if PyroscopeDemoGlobalsWPT.GetMakeSlow() then
            BindSubscription(FlameGraphSubsSlowWPT)
        else
            BindSubscription(FlameGraphSubsFastWPT);


        PostFirstSalesInvoice();


        if PyroscopeDemoGlobalsWPT.GetMakeSlow() then
            UnbindSubscription(FlameGraphSubsSlowWPT)
        else
            UnbindSubscription(FlameGraphSubsFastWPT);
    end;

    local procedure PostFirstSalesInvoice()
    var
        SalesHeader: Record "Sales Header";
        SalesPost: Codeunit "Sales-Post";
    begin
        SalesHeader.SetRange("Document Type", SalesHeader."Document Type"::Invoice);
        SalesHeader.FindFirst();

        SalesPost.SetSuppressCommit(true);
        SalesPost.run(SalesHeader);

        asserterror Error(''); //silently roll back
    end;
    #endregion

    #region ToggleMakeSlow
    local procedure ToggleMakeSlow()
    var
        PyroscopeDemoGlobalsWPT: Codeunit "PyroscopeDemoGlobals WPT";
    begin
        PyroscopeDemoGlobalsWPT.ToggleMakeSlow();

        Message('MakeSlow:' + format(PyroscopeDemoGlobalsWPT.GetMakeSlow()));
    end;
    #endregion

    #region InterfaceImplementation
    procedure Run(ProcedureName: Text) Result: Boolean;
    begin
        case ProcedureName of
            GetProcedures().Get(1):
                OpenSalesInvoicePage();
            GetProcedures().Get(2):
                PostSalesInvoice();
            GetProcedures().Get(3):
                ToggleMakeSlow();
        end;

        Result := true;
    end;

    procedure GetProcedures() Result: List of [Text[50]];
    begin
        Result.Add('Open Sales Invoice Page');
        Result.Add('Post Sales Invoice');
        Result.Add('Toggle "MakeSlow"');
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"PerfTool Triggers WPT", 'OnGetSuiteData', '', false, false)]
    local procedure OnAfterInsertSuiteGroup();

    var
        PerfToolSuiteHeaderWPT: Record "PerfTool Suite Header WPT";
        WPTSuiteLine: Record "PerfTool Suite Line WPT";
        PerfToolGroupWPT: Record "PerfTool Group WPT";
        CreatePerfToolDataLibraryWPT: Codeunit "Create PerfToolDataLibrary WPT";
    begin
        CreatePerfToolDataLibraryWPT.CreateGroup('20.TOOLS', '', PerfToolGroupWPT);

        CreatePerfToolDataLibraryWPT.CreateSuite(PerfToolGroupWPT, '7. FlameGraph', 'FlameGraph', PerfToolSuiteHeaderWPT);

        CreatePerfToolDataLibraryWPT.CreateSuiteLines(PerfToolSuiteHeaderWPT, WPTSuiteLine."Object Type"::Codeunit, enum::"PerfToolCodeunit WPT"::FlameGraph, true, true, WPTSuiteLine);
    end;
    #endregion

}