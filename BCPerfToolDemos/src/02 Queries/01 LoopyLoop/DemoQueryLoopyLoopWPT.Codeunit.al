codeunit 62223 "Demo - Query - LoopyLoop WPT" implements "PerfToolCodeunit WPT"
{
    //#region Classic LoopyLoop
    procedure ClassicLoopyLoop()
    var
        Customer: Record Customer;
        SalesInvoiceHeader: Record "Sales Invoice Header";
        SalesInvoiceLine: Record "Sales Invoice Line";
        Item: Record Item;
    begin

        if Customer.FindSet() then
            repeat
                SalesInvoiceHeader.SetRange("Bill-to Customer No.", customer."No.");
                if SalesInvoiceHeader.FindSet() then
                    repeat
                        SalesInvoiceLine.SetRange("Document No.", SalesInvoiceHeader."No.");
                        if SalesInvoiceLine.FindSet() then
                            repeat
                                item.SetAutoCalcFields(Inventory);
                                item.SetRange("No.", SalesInvoiceLine."No.");
                                if Item.FindSet() then
                                    repeat
                                    //do something
                                    until Item.Next() < 1;
                            until SalesInvoiceLine.Next() < 1;
                    until SalesInvoiceHeader.Next() < 1;
            until Customer.Next() < 1;
    end;

    //#endregion Classic LoopyLoop

    //#region LoopWithQuery
    procedure LoopWithQuery()
    var
        NestedLoopWPT: Query "NestedLoop WPT";
    begin
        NestedLoopWPT.Open();

        while NestedLoopWPT.Read() do;
        //do something

        NestedLoopWPT.Close();
    end;

    //#endregion LoopWithQuery

    procedure Run(ProcedureName: Text) Result: Boolean;
    begin
        case ProcedureName of
            GetProcedures().Get(1):
                ClassicLoopyLoop();
            GetProcedures().Get(2):
                LoopWithQuery();
        end;
    end;

    procedure GetProcedures() Result: List of [Text[30]];
    begin
        Result.Add('Classic LoopyLoop');
        Result.Add('Loop With Query');
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
        CreatePerfToolDataLibraryWPT.CreateGroup('2.QUERIES', 'Queries', PerfToolGroupWPT);

        CreatePerfToolDataLibraryWPT.CreateSuite(PerfToolGroupWPT, '1.Looping', 'Looping', PerfToolSuiteHeaderWPT);
        CreatePerfToolDataLibraryWPT.CreateSuiteLines(PerfToolSuiteHeaderWPT, WPTSuiteLine."Object Type"::Codeunit, enum::"PerfToolCodeunit WPT"::LoopyLoop, false, true, WPTSuiteLine);
    end;

}