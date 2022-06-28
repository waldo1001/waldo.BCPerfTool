codeunit 62201 "Install Demos WPT"
{
    Subtype = Install;

    trigger OnInstallAppPerCompany()
    begin
        FillSuite();
        FillData();
    end;

    local procedure FillSuite()
    begin
        //TODO: Implement Code
    end;

    local procedure FillData()
    begin
        //TODO: Implement Code
    end;
}