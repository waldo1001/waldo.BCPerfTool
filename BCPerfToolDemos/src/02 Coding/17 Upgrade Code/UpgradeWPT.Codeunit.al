codeunit 62291 "Upgrade WPT"
{
    Subtype = Upgrade;

    trigger OnUpgradePerCompany()
    var
        DemoDataTransferTypeWPT: Codeunit "Demo - Upgrade Code WPT";
    begin
        DemoDataTransferTypeWPT.PerformUpgrade_DataTransfer();
    end;

}