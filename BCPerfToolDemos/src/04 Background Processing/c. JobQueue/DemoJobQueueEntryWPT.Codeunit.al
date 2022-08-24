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


    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Create PerfToolDataLibrary WPT", 'OnAfterInsertSuiteGroup', '', false, false)]
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Install Suites WPT", 'OnInstallAppPerCompanyFillSuite', '', false, false)]
    local procedure OnAfterInsertSuiteGroup();

    var
        PerfToolSuiteHeaderWPT: Record "PerfTool Suite Header WPT";
        WPTSuiteLine: Record "PerfTool Suite Line WPT";
        PerfToolGroupWPT: Record "PerfTool Group WPT";
        CreatePerfToolDataLibraryWPT: Codeunit "Create PerfToolDataLibrary WPT";
    begin
        CreatePerfToolDataLibraryWPT.CreateGroup('4. Background', 'Background Processing', PerfToolGroupWPT);

        CreatePerfToolDataLibraryWPT.CreateSuite(PerfToolGroupWPT, '3. BG-JobQueue', 'Background - JobQueue', PerfToolSuiteHeaderWPT);

        CreatePerfToolDataLibraryWPT.CreateSuiteLines(PerfToolSuiteHeaderWPT, WPTSuiteLine."Object Type"::Codeunit, enum::"PerfToolCodeunit WPT"::JobQueueEntry, false, true, WPTSuiteLine);
    end;

}