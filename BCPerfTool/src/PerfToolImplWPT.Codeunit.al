codeunit 62101 "PerfTool Impl. WPT"
{
    Access = Internal;
    SingleInstance = true;

    var
        PerfToolTriggersWPT: Codeunit "PerfTool Triggers WPT";


    procedure Start(Identifier: Text[2048])
    begin
        PerfToolTriggersWPT.OnBeforeStart(Identifier);
        //TODO: Finish coding
        PerfToolTriggersWPT.OnAfterStart(Identifier);
    end;

    procedure Stop()
    begin
        PerfToolTriggersWPT.OnBeforeStop();
        //TODO: Finish coding
        PerfToolTriggersWPT.OnAfterStop();
    end;


}