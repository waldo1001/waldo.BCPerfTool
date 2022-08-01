#pragma warning disable
codeunit 62235 "Demo - PartialRecords WPT" implements "PerfToolCodeunit WPT"
{
    //#region FindSetNoPartialrecords
    local procedure FindSetNoPartialrecords()
    var
        JustSomeTableWPT: Record "Just Some Table WPT";
        NumberOfRecords: Integer;
        i: Integer;
    begin
        if JustSomeTableWPT.FindSet() then;
        repeat
            i += 1;
            if i > 10000 then exit;
        until JustSomeTableWPT.Next() < 1;
    end;
    //#endregion FindSetNoPartialrecords

    //#region FindSetWithPartialrecords
    local procedure FindSetWithPartialrecords()
    var
        JustSomeTableWPT: Record "Just Some Table WPT";
        NumberOfRecords: Integer;
        i: Integer;
    begin
        JustSomeTableWPT.SetLoadFields(Message);
        if JustSomeTableWPT.FindSet() then;
        repeat
            i += 1;
            if i > 10000 then exit;
        until JustSomeTableWPT.Next() < 1;
    end;
    //#endregion FindSetWithPartialrecords

    procedure Run(ProcedureName: Text) Result: Boolean;
    begin
        case ProcedureName of
            GetProcedures().Get(1):
                FindSetNoPartialrecords();
            GetProcedures().Get(2):
                FindSetWithPartialrecords();
        end;
    end;

    procedure GetProcedures() Result: List of [Text[30]];
    begin
        Result.Add('FindSetNoPartialrecords');
        Result.Add('FindSetWithPartialrecords');
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Create PerfToolDataLibrary WPT", 'OnAfterInsertSuiteGroup', '', false, false)]
    local procedure OnAfterInsertSuiteGroup(var Sender: Codeunit "Create PerfToolDataLibrary WPT"; var PerfToolGroupWPT: Record "PerfTool Group WPT");
    var
        PerfToolSuiteHeaderWPT: Record "PerfTool Suite Header WPT";
        WPTSuiteLine: Record "PerfTool Suite Line WPT";
    begin
        if PerfToolGroupWPT.Code <> '1.DATA' then exit;

        Sender.CreateSuite(PerfToolGroupWPT, '2. PartialRecords', 'Partial Records', PerfToolSuiteHeaderWPT);
        Sender.CreateSuiteLines(PerfToolSuiteHeaderWPT, WPTSuiteLine."Object Type"::Codeunit, enum::"PerfToolCodeunit WPT"::PartialRecords, true, false, WPTSuiteLine);
    end;
}