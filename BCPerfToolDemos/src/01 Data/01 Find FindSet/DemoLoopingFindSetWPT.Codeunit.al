#pragma warning disable
codeunit 62226 "Demo - Looping Find(Set) WPT" implements "PerfToolCodeunit WPT"
{
    //#region FindSetAndLoop40
    local procedure FindSetAndLoop40()
    var
        JustSomeTableWPT: Record "Just Some Table WPT";
    begin
        if JustSomeTableWPT.FindSet() then
            for i := 1 to 40 do
                JustSomeTableWPT.Next();
    end;
    //#endregion FindSetAndLoop40

    //#region FindMinAndLoop40
    local procedure FindMinAndLoop40()
    var
        JustSomeTableWPT: Record "Just Some Table WPT";
    begin
        if JustSomeTableWPT.Find('-') then
            for i := 1 to 40 do
                JustSomeTableWPT.Next();
    end;
    //#endregion FindMinAndLoop40

    //#region FindSetAndLoop100
    local procedure FindSetAndLoop100()
    var
        JustSomeTableWPT: Record "Just Some Table WPT";
    begin
        if JustSomeTableWPT.FindSet() then
            for i := 1 to 100 do
                JustSomeTableWPT.Next();
    end;
    //#endregion FindSetAndLoop100

    //#region FindMinAndLoop100
    local procedure FindMinAndLoop100()
    var
        JustSomeTableWPT: Record "Just Some Table WPT";
    begin
        if JustSomeTableWPT.Find('-') then
            for i := 1 to 100 do
                JustSomeTableWPT.Next();
    end;
    //#endregion FindMinAndLoop100

    var
        i: integer;

    procedure Run(ProcedureName: Text) Result: Boolean;
    begin
        case ProcedureName of
            GetProcedures().Get(1):
                FindSetAndLoop40();
            GetProcedures().Get(2):
                FindMinAndLoop40();
            GetProcedures().Get(3):
                FindSetAndLoop100();
            GetProcedures().Get(4):
                FindMinAndLoop100();
        end;
    end;

    procedure GetProcedures() Result: List of [Text[30]];
    begin
        Result.Add('FindSetAndLoop40');
        Result.Add('FindMinAndLoop40');
        Result.Add('FindSetAndLoop100');
        Result.Add('FindMinAndLoop100');
    end;


    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Create PerfToolDataLibrary WPT", 'OnAfterInsertSuiteGroup', '', false, false)]
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Install Suites WPT", 'OnInstallAppPerCompanyFillSuite', '', false, false)]
    local procedure OnAfterInsertSuiteGroup()
    var
        PerfToolSuiteHeaderWPT: Record "PerfTool Suite Header WPT";
        WPTSuiteLine: Record "PerfTool Suite Line WPT";
        PerfToolGroupWPT: Record "PerfTool Group WPT";
        CreatePerfToolDataLibraryWPT: Codeunit "Create PerfToolDataLibrary WPT";
    begin
        CreatePerfToolDataLibraryWPT.CreateGroup('1.DATA', 'Data Access', PerfToolGroupWPT);

        CreatePerfToolDataLibraryWPT.CreateSuite(PerfToolGroupWPT, '1. FINDSET', 'Find, Findset, ..', PerfToolSuiteHeaderWPT);
        CreatePerfToolDataLibraryWPT.CreateSuiteLine(PerfToolSuiteHeaderWPT, WPTSuiteLine."Object Type"::Table, database::"Just Some Table WPT", true, false, WPTSuiteLine);
        CreatePerfToolDataLibraryWPT.CreateSuiteLines(PerfToolSuiteHeaderWPT, WPTSuiteLine."Object Type"::Codeunit, enum::"PerfToolCodeunit WPT"::FindSet, true, false, WPTSuiteLine);
    end;
}
