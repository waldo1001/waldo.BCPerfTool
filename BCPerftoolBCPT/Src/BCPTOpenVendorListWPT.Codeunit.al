codeunit 75014 "BCPT Open Vendor List WPT"
{
    // Test codeunits can only run in foreground (UI)
    Subtype = Test;

    trigger OnRun();
    begin
    end;

    [Test]
    procedure OpenVendorList()
    var
        VendorList: testpage "Vendor List";
    begin
        VendorList.OpenView();
        VendorList.Next();
        VendorList.Last();
        VendorList.Close();
    end;
}