codeunit 62405 "Demo - DataTransfer Upgrade"
{
    Subtype = Upgrade;

    trigger OnUpgradePerCompany()
    var
        DemoDataTransferTypeWPT: Codeunit "Demo - DataTransfer Type WPT";
    begin
        DemoDataTransferTypeWPT.PerformUpgrade();
    end;

}