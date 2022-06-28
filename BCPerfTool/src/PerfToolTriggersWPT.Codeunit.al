codeunit 62102 "PerfTool Triggers WPT"
{
    Access = public;

    [IntegrationEvent(true, false)]
    procedure OnBeforeStart(var Identifier: Text[2048])
    begin
    end;

    [IntegrationEvent(true, false)]
    procedure OnAfterStart(var Identifier: Text[2048])
    begin
    end;

    [IntegrationEvent(true, false)]
    procedure OnBeforeStop()
    begin
    end;

    [IntegrationEvent(true, false)]
    procedure OnAfterStop()
    begin
    end;
}