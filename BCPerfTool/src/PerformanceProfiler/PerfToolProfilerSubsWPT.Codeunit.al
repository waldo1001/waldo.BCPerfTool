codeunit 62124 "PerfTool Profiler Subs WPT"
{
    SingleInstance = true;

    var
        SamplingPerformanceProfiler: Codeunit "Sampling Performance Profiler";

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"PerfTool Start Log WPT", 'OnAfterStart', '', false, false)]
    local procedure OnAfterStart(Identifier: Guid; var Log: Record "PerfTool Log Entry WPT"; AppInsightsEventId: Text[50]; Tag: Text[249]; AlternativeKey: Text[250]);
    begin
        if SamplingPerformanceProfiler.IsRecordingInProgress() then SamplingPerformanceProfiler.Stop();

        SamplingPerformanceProfiler.Start();
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"PerfTool Stop Log WPT", 'OnAfterStop', '', false, false)]
    local procedure OnAfterStop(var Log: Record "PerfTool Log Entry WPT");
    var
        OutStr: OutStream;
    begin
        if not SamplingPerformanceProfiler.IsRecordingInProgress() then exit;

        SamplingPerformanceProfiler.Stop();

        Log.ProfilingData.CreateOutStream(OutStr);
        CopyStream(OutStr, SamplingPerformanceProfiler.GetData());
        Log.Modify();
    end;

}