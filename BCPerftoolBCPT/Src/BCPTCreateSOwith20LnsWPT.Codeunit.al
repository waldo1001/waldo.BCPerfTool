codeunit 75002 "BCPT Create SO with 20 Lns WPT"
{
    SingleInstance = true;

    trigger OnRun();
    begin
        If not IsInitialized then begin
            InitTest();
            IsInitialized := true;
        end;
        CreateSalesOrder();
    end;

    var
        BCPTTestContext: Codeunit "BCPT Test Context";
        IsInitialized: Boolean;
        NoOfLinesToCreate: Integer;

    local procedure InitTest();
    var
        SalesSetup: Record "Sales & Receivables Setup";
        NoSeriesLine: Record "No. Series Line";
    begin
        SalesSetup.Get();
        SalesSetup.TestField("Order Nos.");
        NoSeriesLine.SetRange("Series Code", SalesSetup."Order Nos.");
        NoSeriesLine.findset(true, true);
        repeat
            if NoSeriesLine."Ending No." <> '' then begin
                NoSeriesLine."Ending No." := '';
                NoSeriesLine.Validate("Allow Gaps in Nos.", true);
                NoSeriesLine.Modify(true);
            end;
        until NoSeriesLine.Next() = 0;
        commit();

        NoOfLinesToCreate := 20;
    end;

    local procedure CreateSalesOrder()
    var
        Customer: Record Customer;
        Item: Record Item;
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        i: Integer;
    begin
        if not Customer.get('10000') then
            Customer.FindFirst();
        if not item.get('70000') then
            Item.FindSet();
        if NoOfLinesToCreate < 0 then
            NoOfLinesToCreate := 0;
        if NoOfLinesToCreate > 10000 then
            NoOfLinesToCreate := 10000;
        BCPTTestContext.StartScenario('Add Order');
        SalesHeader.Init();
        SalesHeader."Document Type" := SalesHeader."Document Type"::Order;
        SalesHeader.Insert(true);
        Commit();
        BCPTTestContext.EndScenario('Add Order');
        BCPTTestContext.UserWait();
        BCPTTestContext.StartScenario('Enter Account No.');
        SalesHeader.Validate("Sell-to Customer No.", Customer."No.");
        SalesHeader.Modify(true);
        Commit();
        BCPTTestContext.EndScenario('Enter Account No.');
        BCPTTestContext.UserWait();
        SalesLine."Document Type" := SalesHeader."Document Type";
        SalesLine."Document No." := SalesHeader."No.";
        for i := 1 to NoOfLinesToCreate do begin
            SalesLine."Line No." += 10000;
            SalesLine.Init();
            SalesLine.Validate(Type, SalesLine.Type::Item);
            SalesLine.Insert(true);
            BCPTTestContext.UserWait();
            if i = 1 then
                BCPTTestContext.StartScenario('Enter Line Item No.');
            SalesLine.Validate("No.", Item."No.");
            if i = 1 then
                BCPTTestContext.EndScenario('Enter Line Item No.');
            BCPTTestContext.UserWait();
            if i = 1 then
                BCPTTestContext.StartScenario('Enter Line Quantity');
            SalesLine.Validate(Quantity, 1);
            SalesLine.Modify(true);
            if i = 1 then
                BCPTTestContext.EndScenario('Enter Line Quantity');
            BCPTTestContext.UserWait();
            if i mod 2 = 0 then
                if Item.Next() = 0 then
#pragma warning disable AA0181, AA0175
                    Item.FindSet();
#pragma warning restore AA0181, AA0175
        end;
    end;

}