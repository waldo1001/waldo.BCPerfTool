namespace waldo.BCPerftool.Profiler;

using waldo.BCPerftool.Analytics;

codeunit 62124 "PerfTool Profiler Subs WPT"
{
    SingleInstance = true;

    var
        SamplingPerformanceProfiler: Codeunit "Sampling Performance Profiler";
        RunPerformanceProfiler: Boolean;

    procedure SetRunPerformanceProfilerActive(SetActive: Boolean)
    begin
        RunPerformanceProfiler := SetActive;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"PerfTool Start Log WPT", 'OnAfterStart', '', false, false)]
    local procedure StartProfiling(Identifier: Guid; var Log: Record "PerfTool Log Entry WPT"; AppInsightsEventId: Text[50]; Tag: Text[249]; AlternativeKey: Text[250]);
    begin
        if Session.CurrentExecutionMode = ExecutionMode::Debug then exit;

        if SamplingPerformanceProfiler.IsRecordingInProgress() then SamplingPerformanceProfiler.Stop();

        if not RunPerformanceProfiler then exit;

        SamplingPerformanceProfiler.Start();
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"PerfTool Stop Log WPT", 'OnAfterStop', '', false, false)]
    local procedure SaveProfilingDataToLog(var Log: Record "PerfTool Log Entry WPT");
    var
        OutStr: OutStream;
    begin
        if Session.CurrentExecutionMode = ExecutionMode::Debug then exit;

        if not SamplingPerformanceProfiler.IsRecordingInProgress() then exit;

        SamplingPerformanceProfiler.Stop();

        if not RunPerformanceProfiler then exit;

        Log.ProfilingData.CreateOutStream(OutStr);
        CopyStream(OutStr, SamplingPerformanceProfiler.GetData());
        Log.Modify();

        Log.UploadToPyroscope();
    end;

}