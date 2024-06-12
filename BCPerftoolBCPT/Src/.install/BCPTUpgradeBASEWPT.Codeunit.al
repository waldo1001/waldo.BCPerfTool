codeunit 75001 "BCPT Upgrade BASE WPT"
{
    Subtype = Upgrade;

    trigger OnUpgradePerCompany()
    var
        BCPTInstall: Codeunit "BCPT Install BASE WPT";
    begin
        BCPTInstall.SetupSuites();
    end;
}