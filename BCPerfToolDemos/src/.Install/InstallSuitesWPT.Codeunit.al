codeunit 62201 "Install Suites WPT"
{
    Subtype = Install;

    trigger OnInstallAppPerCompany()
    begin
        ResetAll();
        FillSuite();
    end;

    procedure FillSuite()
    var
        WPTGroup: Record "PerfTool Group WPT";
        WPTSuite: Record "PerfTool Suite Header WPT";
        WPTSuiteLine: Record "PerfTool Suite Line WPT";
        Library: Codeunit "Create PerfToolDataLibrary WPT";
    begin
        Library.CreateGroup('1.DATA', 'Data Access', WPTGroup);
        Library.CreateSuite(WPTGroup, '1. Looping', 'Find, Findset, ..', WPTSuite);
        Library.CreateSuiteLine(WPTSuite, WPTSuiteLine."Object Type"::Table, database::"Just Some Table WPT", true, WPTSuiteLine);
        Library.CreateSuite(WPTGroup, '2. Flowfields', 'FlowFields', WPTSuite);
        Library.CreateSuiteLine(WPTSuite, WPTSuiteLine."Object Type"::Page, page::"Just Some Colors WPT", true, WPTSuiteLine);
        Library.CreateSuiteLine(WPTSuite, WPTSuiteLine."Object Type"::Page, page::"Just Some Countries WPT", true, WPTSuiteLine);


        Library.CreateGroup('2.CODING', 'Coding 4 Performance', WPTGroup);
        Library.CreateSuite(WPTGroup, '1.QUERIES', 'Query Handling', WPTSuite);
        Library.CreateSuiteLine(WPTSuite, WPTSuiteLine."Object Type"::Codeunit, codeunit::"LoopyLoop Demo WPT", false, WPTSuiteLine);
        Library.CreateSuiteLine(WPTSuite, WPTSuiteLine."Object Type"::Codeunit, codeunit::"LoopWithQuery WPT", false, WPTSuiteLine);
        Library.CreateSuiteLine(WPTSuite, WPTSuiteLine."Object Type"::Query, query::"GroupingJustSomeTable WPT", false, WPTSuiteLine);
        Library.CreateSuiteLine(WPTSuite, WPTSuiteLine."Object Type"::Codeunit, Codeunit::"Grouping - Legacy WPT", true, WPTSuiteLine);
        Library.CreateSuiteLine(WPTSuite, WPTSuiteLine."Object Type"::Codeunit, Codeunit::"Grouping - Query WPT", false, WPTSuiteLine);
        Library.CreateSuiteLine(WPTSuite, WPTSuiteLine."Object Type"::Codeunit, Codeunit::"Grouping - Skip Method WPT", false, WPTSuiteLine);
        Library.CreateSuite(WPTGroup, '98.WRAPPERS', 'Wrapper functions', WPTSuite);
        Library.CreateSuiteLine(WPTSuite, WPTSuiteLine."Object Type"::PerfToolCodeunit, enum::"PerfToolCodeunit WPT"::Wrappers, 'Wrappers - Subfunction', false, WPTSuiteLine);
        Library.CreateSuiteLine(WPTSuite, WPTSuiteLine."Object Type"::PerfToolCodeunit, enum::"PerfToolCodeunit WPT"::Wrappers, 'Wrappers - No Subfunction', false, WPTSuiteLine);
        Library.CreateSuiteLine(WPTSuite, WPTSuiteLine."Object Type"::PerfToolCodeunit, enum::"PerfToolCodeunit WPT"::Wrappers, 'Wrappers - Single Instance', false, WPTSuiteLine);
        Library.CreateSuiteLine(WPTSuite, WPTSuiteLine."Object Type"::PerfToolCodeunit, enum::"PerfToolCodeunit WPT"::Wrappers, 'Wrappers - No Single Instance', false, WPTSuiteLine);


        Library.CreateSuite(WPTGroup, '99.RETENTION', 'Reetention Policies', WPTSuite);
        Library.CreateSuiteLine(WPTSuite, WPTSuiteLine."Object Type"::Page, page::"Retention Policy Setup List", false, WPTSuiteLine);


    end;

    procedure ResetAll()
    var
        PerfToolSuiteHeaderWPT: Record "PerfTool Suite Header WPT";
    begin
        PerfToolSuiteHeaderWPT.DeleteAll(true);
    end;

}