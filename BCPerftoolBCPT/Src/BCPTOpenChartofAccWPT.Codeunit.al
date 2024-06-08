codeunit 75008 "BCPT Open Chart of Acc. WPT"
{
    // Test codeunits can only run in foreground (UI)
    Subtype = Test;

    trigger OnRun();
    begin
    end;

    [Test]
    procedure OpenChartAccount()
    var
        ChartAccount: testpage "Chart of Accounts";
    begin
        ChartAccount.OpenView();
        ChartAccount.Next();
        ChartAccount.Last();
        ChartAccount.Close();
    end;
}