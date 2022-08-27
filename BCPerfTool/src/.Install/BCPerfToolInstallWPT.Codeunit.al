codeunit 62130 "BCPerfTool Install WPT"
{
    Subtype = Install;

    trigger OnInstallAppPerCompany()
    var
        PerfToolSetupWPT: Record "PerfTool Setup WPT";
    begin
        PerfToolSetupWPT.InsertIfNotExists();

        if PerfToolSetupWPT.FlameGraphServer <> '' then exit;

        PerfToolSetupWPT.FlameGraphServer := '192.168.1.220';
        PerfToolSetupWPT.Modify();
    end;
}