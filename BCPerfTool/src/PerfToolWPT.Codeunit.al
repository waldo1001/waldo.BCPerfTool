namespace waldo.BCPerftool.Run;

using waldo.BCPerftool;

codeunit 62100 "PerfTool WPT"
{
    Access = Public;
    SingleInstance = true;

    var
        PerfToolImplWPT: Codeunit "PerfTool Impl. WPT";

    procedure Start(pIdentifier: Text[2048])
    begin
        PerfToolImplWPT.Start(pIdentifier);
    end;

    procedure Stop()
    begin
        PerfToolImplWPT.Stop();
    end;

    [Obsolete('No used anymore', '')]
    procedure Run(ObjType: enum "Perftool Object Types WPT"; ObjId: Integer)
    begin
        PerfToolImplWPT.Run();
    end;

    procedure RunObject(Identifier: Guid; ObjType: enum "Perftool Object Types WPT"; ObjId: Integer; ProcedureName: Text; Tag: Text[249]; AlternativeKey: Text[250]) Success: Boolean
    begin
        exit(PerfToolImplWPT.RunObject(Identifier, ObjType, ObjId, ProcedureName, Tag, AlternativeKey));
    end;

    procedure IsStarted(): Boolean
    begin
        exit(PerfToolImplWPT.IsStarted());
    end;
}