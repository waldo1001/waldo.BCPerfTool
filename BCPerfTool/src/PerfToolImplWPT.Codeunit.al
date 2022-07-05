codeunit 62101 "PerfTool Impl. WPT"
{
    Access = Internal;
    SingleInstance = true;

    var
        PerfToolLogEntryWPT: Record "PerfTool Log Entry WPT";
        PerfToolTriggersWPT: Codeunit "PerfTool Triggers WPT";

    procedure Start(Identifier: Guid)
    begin
        Start(Identifier, '', '', '');
    end;

    procedure Start(Identifier: Guid; AppInsightsEventId: Text[50]; Tag: Text[249]; AlternativeKey: Text[250])
    var
        PerfToolStartLogWPT: Codeunit "PerfTool Start Log WPT";
    begin
        PerfToolTriggersWPT.OnBeforeStart(Identifier, Tag, AlternativeKey);

        PerfToolStartLogWPT.Start(Identifier, PerfToolLogEntryWPT, AppInsightsEventId, Tag, AlternativeKey);

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

    procedure RunObject(Identifier: Guid; ObjType: enum "Perftool Object Types WPT"; ObjId: Integer; Tag: Text[249]; AlternativeKey: Text[250]) Success: Boolean
    var
        RunObjectWPT: Codeunit "RunObject WPT";
    begin
        PerfToolTriggersWPT.OnBeforeRunObject(Identifier, ObjType, ObjId);

        Start(Identifier, '', Tag, AlternativeKey);

        Success := RunObjectWPT.RunObject(ObjType, ObjId);
        If Success then
            SetMessage('Success')
        else
            SetMessage(GetLastErrorText().Substring(1, 2040));

        Stop();

        PerfToolTriggersWPT.OnAfterRunObject(Identifier, ObjType, ObjId);
    end;
}