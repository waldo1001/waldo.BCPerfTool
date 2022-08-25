codeunit 62242 "BCPTScen - Customer List WPT"
{
    Subtype = Test;

    [Test]
    procedure SimulateCustomerListActivity()
    var
        BCPTTestContext: Codeunit "BCPT Test Context";
        CustList: TestPage "Customer List";
    begin

        BCPTTestContext.StartScenario('OpenView');
        CustList.OpenView();
        BCPTTestContext.EndScenario('OpenView');
        BCPTTestContext.UserWait();
        BCPTTestContext.StartScenario('Next');
        CustList.Next();
        BCPTTestContext.EndScenario('Next');
        BCPTTestContext.UserWait();
        BCPTTestContext.StartScenario('Next');
        CustList.Next();
        BCPTTestContext.EndScenario('Next');
        BCPTTestContext.UserWait();
        BCPTTestContext.StartScenario('Next');
        CustList.Next();
        BCPTTestContext.EndScenario('Next');
        BCPTTestContext.UserWait();
        BCPTTestContext.StartScenario('Next');
        CustList.Next();
        BCPTTestContext.EndScenario('Next');
        BCPTTestContext.UserWait();
        BCPTTestContext.StartScenario('Next');
        CustList.Next();
        BCPTTestContext.EndScenario('Next');

        BCPTTestContext.UserWait();

        CustList.Close();
    end;
}