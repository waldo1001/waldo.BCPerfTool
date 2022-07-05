codeunit 62102 "PerfTool Triggers WPT"
{
    Access = public;

    [IntegrationEvent(true, false)]
    procedure OnBeforeStart(var Identifier: Guid; var Tag: Text[249]; AlternativeKey: Text[250])
    begin
    end;

    [IntegrationEvent(true, false)]
    procedure OnAfterStart(var Identifier: Guid)
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

    [IntegrationEvent(true, false)]
    procedure OnBeforeRunObject(var Identifier: Guid; ObjType: enum "Perftool Object Types WPT"; ObjId: Integer)
    begin
    end;

    [IntegrationEvent(true, false)]
    procedure OnAfterRunObject(Identifier: Guid; ObjType: enum "Perftool Object Types WPT"; ObjId: Integer)
    begin
    end;
}