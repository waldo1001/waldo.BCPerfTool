codeunit 62253 "Demo - FlameGraph WPT" implements "PerfToolCodeunit WPT"
{
    #region OpenSalesInvoicePage
    procedure OpenSalesInvoicePage()
    var
        SalesHeader: Record "Sales Header";
        PageManagement: Codeunit "Page Management";
        FlameGraphSubsWPT: Codeunit "FlameGraph Subs WPT";
    begin
        BindSubscription(FlameGraphSubsWPT);

        SalesHeader.SetRange("Document Type", SalesHeader."Document Type"::Invoice);
        SalesHeader.FindFirst();

        PageManagement.PageRunModal(SalesHeader);

        UnbindSubscription(FlameGraphSubsWPT);
    end;
    #endregion

    #region InterfaceImplementation
    procedure Run(ProcedureName: Text) Result: Boolean;
    begin
        case ProcedureName of
            GetProcedures().Get(1):
                OpenSalesInvoicePage();
        end;

        Result := true;
    end;

    procedure GetProcedures() Result: List of [Text[50]];
    begin
        Result.Add('Open Sales Invoice Page');
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Install Suites WPT", 'OnInstallAppPerCompanyFillSuite', '', false, false)]
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