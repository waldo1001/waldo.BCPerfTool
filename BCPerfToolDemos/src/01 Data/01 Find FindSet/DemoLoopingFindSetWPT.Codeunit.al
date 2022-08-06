#pragma warning disable
codeunit 62226 "Demo - Looping Find(Set) WPT" implements "PerfToolCodeunit WPT"
{
    //#region FindSetAndLoop40
    local procedure FindSetAndLoop40()
    var
        JustSomeTableWPT: Record "Just Some Table WPT";
        i: Integer;
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
        i: Integer;
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
        i: Integer;
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
        i: Integer;
    begin
        if JustSomeTableWPT.Find('-') then
            for i := 1 to 100 do
                JustSomeTableWPT.Next();
    end;
    //#endregion FindMinAndLoop100



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

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Create PerfToolDataLibrary WPT", 'OnAfterInsertSuiteGroup', '', false, false)]
    local procedure OnAfterInsertSuiteGroup(var Sender: Codeunit "Create PerfToolDataLibrary WPT"; var PerfToolGroupWPT: Record "PerfTool Group WPT");
    var
        PerfToolSuiteHeaderWPT: Record "PerfTool Suite Header WPT";
        WPTSuiteLine: Record "PerfTool Suite Line WPT";
    begin
        if PerfToolGroupWPT.Code <> '1.DATA' then exit;

        Sender.CreateSuite(PerfToolGroupWPT, '1. Looping', 'Find, Findset, ..', PerfToolSuiteHeaderWPT);
        Sender.CreateSuiteLine(PerfToolSuiteHeaderWPT, WPTSuiteLine."Object Type"::Table, database::"Just Some Table WPT", true, false, WPTSuiteLine);
        Sender.CreateSuiteLines(PerfToolSuiteHeaderWPT, WPTSuiteLine."Object Type"::Codeunit, enum::"PerfToolCodeunit WPT"::FindSet, true, false, WPTSuiteLine);

    end;
}
