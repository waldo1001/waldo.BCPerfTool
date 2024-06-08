codeunit 75006 "BCPT Create SQ with 20 Lns WPT"
{
    SingleInstance = true;

    trigger OnRun();
    begin
        If not IsInitialized then begin
            InitTest();
            IsInitialized := true;
        end;
        CreateSalesQuote();
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
        SalesSetup.TestField("Quote Nos.");
        NoSeriesLine.SetRange("Series Code", SalesSetup."Quote Nos.");
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

    local procedure CreateSalesQuote()
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
            Item.FindFirst();
        if NoOfLinesToCreate < 0 then
            NoOfLinesToCreate := 0;
        if NoOfLinesToCreate > 10000 then
            NoOfLinesToCreate := 10000;
        BCPTTestContext.StartScenario('Add Order');
        SalesHeader.init();
        SalesHeader."Document Type" := SalesHeader."Document Type"::Quote;
        SalesHeader.Insert(true);
        BCPTTestContext.EndScenario('Add Order');
        Commit();
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
            if i = 10 then
                BCPTTestContext.StartScenario('Enter Line Item No.');
            SalesLine.Validate("No.", Item."No.");
            if i = 10 then
                BCPTTestContext.EndScenario('Enter Line Item No.');
            BCPTTestContext.UserWait();
            if i = 10 then
                BCPTTestContext.StartScenario('Enter Line Quantity');
            SalesLine.Validate(Quantity, 1);
            SalesLine.Modify(true);
            Commit();
            if i = 10 then
                BCPTTestContext.EndScenario('Enter Line Quantity');
        end;
    end;

}