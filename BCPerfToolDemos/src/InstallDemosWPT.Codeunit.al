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
        PerfToolGroupWPT: Record "PerfTool Group WPT";
        PerfToolSuiteHeaderWPT: Record "PerfTool Suite Header WPT";
        PerfToolSuiteLineWPT: Record "PerfTool Suite Line WPT";
        CreatePerfToolDataLibraryWPT: Codeunit "Create PerfToolDataLibrary WPT";
    begin
        CreatePerfToolDataLibraryWPT.CreateGroup('1.DATA', 'Data Access', PerfToolGroupWPT);

        CreatePerfToolDataLibraryWPT.CreateGroup('2.CODING', 'Coding 4 Performance', PerfToolGroupWPT);
        CreatePerfToolDataLibraryWPT.CreateSuite('1.QUERIES', 'Query Handling', PerfToolGroupWPT, PerfToolSuiteHeaderWPT);
        CreatePerfToolDataLibraryWPT.CreateSuiteLine(PerfToolSuiteHeaderWPT, codeunit::"LoopyLoop Demo WLD WPT", PerfToolSuiteLineWPT);
    end;

    local procedure FillData()
    begin
        //TODO: Create Demo Data: Tables with many records
    end;
}