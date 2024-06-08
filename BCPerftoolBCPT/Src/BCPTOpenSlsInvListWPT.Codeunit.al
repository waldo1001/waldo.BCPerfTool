codeunit 75013 "BCPT Open Sls Inv List WPT"
{
    // Test codeunits can only run in foreground (UI)
    Subtype = Test;

    trigger OnRun();
    begin
    end;

    [Test]
    procedure OpenSalesInvoiceList()
    var
        SalesInvoiceList: testpage "Sales Invoice List";
    begin
        SalesInvoiceList.OpenView();
        SalesInvoiceList.Next();
        SalesInvoiceList.Last();
        SalesInvoiceList.Close();
    end;
}