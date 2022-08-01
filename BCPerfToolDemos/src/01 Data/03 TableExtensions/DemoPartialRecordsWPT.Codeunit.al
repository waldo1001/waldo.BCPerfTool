codeunit 62235 "Demo - PartialRecords WPT" implements "PerfToolCodeunit WPT"
{
    //#region FindSetNoPartialrecords
    local procedure FindSetNoPartialrecords()
    begin

    end;

    //#endregion FindSetNoPartialrecords

    procedure Run(ProcedureName: Text) Result: Boolean;
    begin
        case ProcedureName of
            GetProcedures().Get(1):
                FindSetNoPartialrecords();
        end;
    end;

    procedure GetProcedures() Result: List of [Text[30]];
    begin
        Result.Add('FindSetNoPartialrecords');
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