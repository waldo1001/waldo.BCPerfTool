codeunit 62232 "Demo - JobQueueEntry WPT" implements "PerfToolCodeunit WPT"
{

    #region StartJobQueueEntry
    procedure StartJobQueueEntry()
    var
        JobQueueEntry: record "Job Queue Entry";
    begin
        JobQueueEntry.ScheduleJobQueueEntry(codeunit::"Some Business Logic WPT", JobQueueEntry.RecordId);

        page.run(page::"Job Queue Entries");
    end;
    #endregion StartJobQueueEntry

    procedure Run(ProcedureName: Text) Result: Boolean;
    begin
        case ProcedureName of
            GetProcedures().Get(1):
                StartJobQueueEntry();

        end;
    end;

    procedure GetProcedures() Result: List of [Text[30]];
    begin
        Result.Add('StartJobQueueEntry');
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Create PerfToolDataLibrary WPT", 'OnAfterInsertSuiteGroup', '', false, false)]
    local procedure OnAfterInsertSuiteGroup(var Sender: Codeunit "Create PerfToolDataLibrary WPT"; var PerfToolGroupWPT: Record "PerfTool Group WPT");
    var
        PerfToolSuiteHeaderWPT: Record "PerfTool Suite Header WPT";
        WPTSuiteLine: Record "PerfTool Suite Line WPT";
    begin
        if PerfToolGroupWPT.Code <> '2.CODING' then exit;

        sender.CreateSuite(PerfToolGroupWPT, '3.c BG-JobQueue', 'Background - JobQueue', PerfToolSuiteHeaderWPT);

        sender.CreateSuiteLines(PerfToolSuiteHeaderWPT, WPTSuiteLine."Object Type"::Codeunit, enum::"PerfToolCodeunit WPT"::JobQueueEntry, false, true, WPTSuiteLine);
    end;

}