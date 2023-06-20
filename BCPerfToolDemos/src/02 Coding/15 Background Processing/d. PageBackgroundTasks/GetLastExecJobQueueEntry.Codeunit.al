codeunit 62245 "Get Last Exec. Job Queue Entry"
{
    trigger OnRun()
    var
        Result: Dictionary of [Text, Text];
    begin
        Result.Add('LastExecutedJobQueueEntry', GetLastExecutedJobQueueEntry());

        page.SetBackgroundTaskResult(Result);
    end;

    procedure GetLastExecutedJobQueueEntry(): Text
    var
        JobQueueLogEntry: Record "Job Queue Log Entry";
    begin
        JobQueueLogEntry.SetAutoCalcFields("Object Caption to Run");
        If not JobQueueLogEntry.FindLast() then exit('');

        Exit(strsubstno('%1 %2 (%3)', format(JobQueueLogEntry."Object Type to Run"), format(JobQueueLogEntry."Object ID to Run"), JobQueueLogEntry."Object Caption to Run"));
    end;
}