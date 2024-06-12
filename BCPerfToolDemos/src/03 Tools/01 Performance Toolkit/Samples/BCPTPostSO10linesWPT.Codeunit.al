codeunit 62292 "BCPT Post SO - 10 lines WPT" implements "BCPT Test Param. Provider"
{
    SingleInstance = true;

    trigger OnRun();
    var
        SalesHeader: Record "Sales Header";
        SalesPost: Codeunit "Sales-Post";
        SalesHeaderId: Guid;
    begin
        If not IsInitialized then begin
            InitTest();
            IsInitialized := true;
        end;
        SalesHeaderId := CreateSalesOrder(BCPTTestContext);
        SalesHeader.GetBySystemId(SalesHeaderId);
        SalesHeader.Validate(Ship, true);
        SalesHeader.Validate(Invoice, not ShipOnly);
        SalesPost.Run(SalesHeader);
    end;

    var
        BCPTTestContext: Codeunit "BCPT Test Context";
        IsInitialized: Boolean;
        ShipOnly: Boolean;
        ShipOnlyLbl: Label 'ShipOnly';
        ParamValidationErr: Label 'Parameter is not defined in the correct format. The expected format is "%1"';


    local procedure InitTest();
    var
        SalesSetup: Record "Sales & Receivables Setup";
        NoSeriesLine: Record "No. Series Line";
    begin
        SalesSetup.Get();
        SalesSetup.TestField("Order Nos.");
        NoSeriesLine.SetRange("Series Code", SalesSetup."Order Nos.");
        NoSeriesLine.findset(true);
        repeat
            if NoSeriesLine."Ending No." <> '' then begin
                NoSeriesLine."Ending No." := '';
                NoSeriesLine.Validate("Allow Gaps in Nos.", true);
                NoSeriesLine.Modify(true);
            end;
        until NoSeriesLine.Next() = 0;
        commit();

        if Evaluate(ShipOnly, BCPTTestContext.GetParameter(ShipOnlyLbl)) then;
    end;

    local procedure CreateSalesOrder(Var BCPTTestContext: Codeunit "BCPT Test Context"): Guid
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
        for i := 1 to 10 do begin
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
                    Item.FindSet();
        end;

        exit(SalesHeader.SystemId);
    end;

    procedure GetDefaultParameters(): Text[1000]
    begin
        exit(copystr(ShipOnlyLbl + '=' + Format(true), 1, 1000));
    end;

    procedure ValidateParameters(Parameters: Text[1000])
    begin
        if StrPos(Parameters, ShipOnlyLbl) > 0 then begin
            Parameters := DelStr(Parameters, 1, StrLen(ShipOnlyLbl + '='));
            if Evaluate(ShipOnly, Parameters) then
                exit;
        end;
        Error(ParamValidationErr, GetDefaultParameters());
    end;
}