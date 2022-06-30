codeunit 62201 "Install Demos WPT"
{
    Subtype = Install;

    trigger OnInstallAppPerCompany()
    begin
        FillSuite();
        FillData();
    end;

    local procedure FillSuite()
    var
        CreatePerfToolDataLibraryWPT: Codeunit "Create PerfToolDataLibrary WPT";
    begin
        CreatePerfToolDataLibraryWPT.CreateSuite()
    end;

    local procedure FillData()
    begin
        //TODO: Implement Code
    end;
}