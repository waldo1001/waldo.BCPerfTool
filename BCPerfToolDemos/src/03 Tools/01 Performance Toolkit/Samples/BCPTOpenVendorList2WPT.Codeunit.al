codeunit 62241 "BCPT Open Vendor List 2 WPT"
{
    // Test codeunits can only run in foreground (UI)
    Subtype = Test;

    var
        BCPTTestContext: Codeunit "BCPT Test Context";

    [Test]
    procedure OpenVendorList()
    var
        VendorList: testpage "Vendor List";
        Number: Integer;
    begin
        VendorList.OpenView();

        while true do begin
            number := Random(10);
            case number of
                1:
                    NextRecord(VendorList);
                2:
                    PreviousRecord(VendorList);
                3:
                    LastRecord(VendorList);
                4:
                    ActivateBalanceLCY(VendorList);
                5:
                    ActivateBalanceDueLCY(VendorList);
                6:
                    ActivateName(VendorList);
                7:
                    ActivateNumber(VendorList);
                8:
                    FirstRecord(VendorList);
                else
                    NextRecord(VendorList);
            end;
        end;
    end;

    local procedure NextRecord(var VendorList: testpage "Vendor List")
    begin
        BCPTTestContext.StartScenario('NextRecord');
        if VendorList.Next() then;
        BCPTTestContext.EndScenario('NextRecord');
        BCPTTestContext.UserWait();
    end;

    local procedure PreviousRecord(var VendorList: testpage "Vendor List")
    begin
        BCPTTestContext.StartScenario('PreviousRecord');
        if VendorList.Previous() then;
        BCPTTestContext.EndScenario('PreviousRecord');
        BCPTTestContext.UserWait();
    end;

    local procedure LastRecord(var VendorList: testpage "Vendor List")
    begin
        BCPTTestContext.StartScenario('LastRecord');
        if VendorList.Last() then;
        BCPTTestContext.EndScenario('LastRecord');
        BCPTTestContext.UserWait();
    end;

    local procedure FirstRecord(var VendorList: testpage "Vendor List")
    begin
        BCPTTestContext.StartScenario('FirstRecord');
        if VendorList.First() then;
        BCPTTestContext.EndScenario('FirstRecord');
        BCPTTestContext.UserWait();
    end;

    local procedure ActivateBalanceLCY(var VendorList: testpage "Vendor List")
    begin
        BCPTTestContext.StartScenario('ActivateBalanceLCY');
        VendorList."Balance (LCY)".Activate();
        BCPTTestContext.EndScenario('ActivateBalanceLCY');
        BCPTTestContext.UserWait();
    end;

    local procedure ActivateNumber(var VendorList: testpage "Vendor List")
    begin
        BCPTTestContext.StartScenario('ActivateNumber');
        VendorList."No.".Activate();
        BCPTTestContext.EndScenario('ActivateNumber');
        BCPTTestContext.UserWait();
    end;

    local procedure ActivateName(var VendorList: testpage "Vendor List")
    begin
        BCPTTestContext.StartScenario('ActivateName');
        VendorList.Name.Activate();
        BCPTTestContext.EndScenario('ActivateName');
        BCPTTestContext.UserWait();
    end;

    local procedure ActivateBalanceDueLCY(var VendorList: testpage "Vendor List")
    begin
        BCPTTestContext.StartScenario('ActivateBalanceDueLCY');
        VendorList."Balance Due (LCY)".Activate();
        BCPTTestContext.EndScenario('ActivateBalanceDueLCY');
        BCPTTestContext.UserWait();
    end;

}