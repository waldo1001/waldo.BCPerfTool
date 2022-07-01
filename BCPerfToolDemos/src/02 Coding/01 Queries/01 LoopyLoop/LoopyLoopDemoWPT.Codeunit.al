#pragma warning disable
codeunit 62202 "LoopyLoop Demo WPT"
{
    trigger OnRun()
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
}
