codeunit 62253 "Demo - FlameGraph WPT" implements "PerfToolCodeunit WPT"
{
    #region OpenSalesInvoicePage
    procedure OpenSalesInvoicePage()
    var
        SalesHeader: Record "Sales Header";
        PageManagement: Codeunit "Page Management";
    begin
        SalesHeader.SetRange("Document Type", SalesHeader."Document Type"::Invoice);
        SalesHeader.FindFirst();

        Sleep(100);

        PageManagement.PageRunModal(SalesHeader);
    end;
    #endregion

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

    //Slowing down
    [EventSubscriber(ObjectType::Codeunit, codeunit::"Page Management", 'OnAfterGetPageID', '', false, false)]
    local procedure OnAfterGetPageID(var PageID: Integer)
    begin
        if PageID = page::"Sales Invoice" then sleep(100);
    end;

    [EventSubscriber(ObjectType::Page, page::"Sales Invoice", 'OnOpenPageEvent', '', false, false)]
    local procedure OnOpenPageEvent()
    begin
        sleep(100);
    end;

    [EventSubscriber(ObjectType::Page, page::"Sales Invoice", 'OnAfterGetCurrRecordEvent', '', false, false)]
    local procedure OnAfterGetCurrRecordEvent()
    begin
        sleep(100);
    end;

    [EventSubscriber(ObjectType::Page, page::"Sales Invoice", 'OnAfterOnAfterGetRecord', '', false, false)]
    local procedure OnAfterOnAfterGetRecord()
    begin
        sleep(100);
    end;

    [EventSubscriber(ObjectType::Page, page::"Sales Invoice Subform", 'OnAfterGetRecordEvent', '', false, false)]
    local procedure OnAfterGetRecordEvent()
    begin
        sleep(100);
    end;

}