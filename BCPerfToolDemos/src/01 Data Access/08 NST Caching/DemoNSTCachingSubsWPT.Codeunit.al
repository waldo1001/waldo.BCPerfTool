codeunit 62271 "Demo - NST Caching Subs WPT"
{
    // SingleInstance = true;

    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Run SuiteLine Meth WPT", 'OnBeforeRun', '', false, false)]
    // local procedure OnBeforeRun(var SuiteLine: Record "PerfTool Suite Line WPT"; var ShowResults: Boolean; var IsHandled: Boolean);
    // var
    //     JobQueueEntry1: Record "Job Queue Entry";
    //     JobQueueEntry2: Record "Job Queue Entry";
    //     JobQueueEntry3: Record "Job Queue Entry";
    //     JobQueueEntry4: Record "Job Queue Entry";
    //     JobQueueEntry5: Record "Job Queue Entry";
    // // SessionId: Integer;
    // begin
    //     if not (SuiteLine."Procedure Name" in ['Run5Sessions_SameFiltering', 'Run5Sessions_RandomFiltering']) then exit;

    //     Case SuiteLine."Procedure Name" of
    //         'Run5Sessions_SameFiltering':
    //             SuiteLine."Procedure Name" := 'SameFiltering';
    //         'Run5Sessions_RandomFiltering':
    //             SuiteLine."Procedure Name" := 'RandomFiltering';
    //     end;

    //     // StartSession(SessionId, codeunit::"Run Suiteline From Demo WPT", CompanyName, SuiteLine);
    //     // StartSession(SessionId, codeunit::"Run Suiteline From Demo WPT", CompanyName, SuiteLine);
    //     // StartSession(SessionId, codeunit::"Run Suiteline From Demo WPT", CompanyName, SuiteLine);
    //     // StartSession(SessionId, codeunit::"Run Suiteline From Demo WPT", CompanyName, SuiteLine);
    //     // StartSession(SessionId, codeunit::"Run Suiteline From Demo WPT", CompanyName, SuiteLine);

    //     JobQueueEntry1.ScheduleJobQueueEntry(codeunit::"Run Suiteline From Demo WPT", SuiteLine.RecordId);
    //     JobQueueEntry2.ScheduleJobQueueEntry(codeunit::"Run Suiteline From Demo WPT", SuiteLine.RecordId);
    //     JobQueueEntry3.ScheduleJobQueueEntry(codeunit::"Run Suiteline From Demo WPT", SuiteLine.RecordId);
    //     JobQueueEntry4.ScheduleJobQueueEntry(codeunit::"Run Suiteline From Demo WPT", SuiteLine.RecordId);
    //     JobQueueEntry5.ScheduleJobQueueEntry(codeunit::"Run Suiteline From Demo WPT", SuiteLine.RecordId);

    //     IsHandled := true;
    // end;
}