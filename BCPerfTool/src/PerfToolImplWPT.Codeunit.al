codeunit 62101 "PerfTool Impl. WPT"
{
    Access = Internal;
    SingleInstance = true;

    var
        PerfToolLogEntryWPT: Record "PerfTool Log Entry WPT";
        PerfToolTriggersWPT: Codeunit "PerfTool Triggers WPT";

    procedure Start(Identifier: Guid)
    begin
        Start(Identifier, '');
    end;

    procedure Start(Identifier: Guid; AppInsightsEventId: Text[50])
    var
        PerfToolStartLogWPT: Codeunit "PerfTool Start Log WPT";
    begin
        PerfToolTriggersWPT.OnBeforeStart(Identifier);

        PerfToolStartLogWPT.Start(Identifier, PerfToolLogEntryWPT, AppInsightsEventId);

        PerfToolTriggersWPT.OnAfterStart(Identifier);
    end;

    procedure Stop()
    var
        PerfToolStopLogWPT: Codeunit "PerfTool Stop Log WPT";
    begin
        PerfToolTriggersWPT.OnBeforeStop();

        PerfToolStopLogWPT.Stop(PerfToolLogEntryWPT);

        PerfToolTriggersWPT.OnAfterStop();
    end;

    procedure SetMessage(Message: Text[2048])
    begin
        PerfToolLogEntryWPT.Message := Message;
    end;


}