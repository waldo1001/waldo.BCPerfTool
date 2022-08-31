codeunit 62272 "Run Suiteline From Demo WPT"
{
    TableNo = "PerfTool Suite Line WPT";

    trigger OnRun()
    var
        PerfToolWPT: Codeunit "PerfTool WPT";
        PerfToolProfilerSubsWPT: Codeunit "PerfTool Profiler Subs WPT";
    begin
        if Rec."Run Performance Analyzer" then
            PerfToolProfilerSubsWPT.SetRunPerformanceProfilerActive(true);

        PerfToolWPT.RunObject(Rec.SystemId, enum::"Perftool Object Types WPT".FromInteger(Rec."Object Type"), Rec."Object ID", Rec."Procedure Name", Rec.CurrentTag(Format(SessionId())), Rec."PerfTool Code");

        PerfToolProfilerSubsWPT.SetRunPerformanceProfilerActive(false);
    end;
}