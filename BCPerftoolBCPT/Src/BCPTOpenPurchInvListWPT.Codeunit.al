codeunit 75011 "BCPT Open Purch. Inv. List WPT"
{
    // Test codeunits can only run in foreground (UI)
    Subtype = Test;

    trigger OnRun();
    begin
    end;

    [Test]
    procedure OpenPurchaseInvoices()
    var
        PurchaseInvoices: testpage "Purchase Invoices";
    begin
        PurchaseInvoices.OpenView();
        PurchaseInvoices.Next();
        PurchaseInvoices.Last();
        PurchaseInvoices.Close();
    end;
}