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

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Create PerfToolDataLibrary WPT", 'OnAfterInsertSuiteGroup', '', false, false)]
    local procedure OnAfterInsertSuiteGroup(var Sender: Codeunit "Create PerfToolDataLibrary WPT"; var PerfToolGroupWPT: Record "PerfTool Group WPT");
    var
        PerfToolSuiteHeaderWPT: Record "PerfTool Suite Header WPT";
        WPTSuiteLine: Record "PerfTool Suite Line WPT";
    begin
        if PerfToolGroupWPT.Code <> '2.CODING' then exit;

        sender.CreateSuite(PerfToolGroupWPT, '1.QUERIES', 'Query Handling', PerfToolSuiteHeaderWPT);
        sender.CreateSuiteLines(PerfToolSuiteHeaderWPT, WPTSuiteLine."Object Type"::Codeunit, enum::"PerfToolCodeunit WPT"::LoopyLoop, false, WPTSuiteLine);
    end;

}