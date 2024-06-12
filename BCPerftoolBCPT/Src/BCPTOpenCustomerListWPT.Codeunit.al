codeunit 75009 "BCPT Open Customer List WPT"
{
    // Test codeunits can only run in foreground (UI)
    Subtype = Test;

    trigger OnRun();
    begin
    end;

    [Test]
    procedure OpenCustomerList()
    var
        CustomerList: testpage "Customer List";
    begin
        CustomerList.OpenView();
        CustomerList.Next();
        CustomerList.Last();
        CustomerList.Close();
    end;
}