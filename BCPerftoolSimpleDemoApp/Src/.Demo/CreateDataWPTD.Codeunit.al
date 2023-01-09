codeunit 62401 "Create Data WPTD"
{
    Subtype = Install;

    trigger OnInstallAppPerCompany()
    begin
        CreateDemoData();
        InstallSuites();
    end;

    procedure CreateDemoData()
    var
        DemoTableWPTD: Record "Demo Table WPTD";
        i: integer;
    begin
        if not DemoTableWPTD.IsEmpty then exit;

        for i := 1 to 5000 do
            DemoTableWPTD.Create(RandomText(random(50)), i);
    end;

    local procedure InstallSuites()
    var
        PerfToolTriggersWPT: Codeunit "PerfTool Triggers WPT";
    begin
        PerfToolTriggersWPT.OnGetSuiteData();
    end;

    local procedure RandomText(Length: Integer): Text[2048]
    var
        GuidTxt: Text;
    begin
        while StrLen(GuidTxt) < Length do
            GuidTxt += LowerCase(DelChr(Format(CreateGuid()), '=', '{}-'));
        exit(CopyStr(GuidTxt, 1, 2048));
    end;
}