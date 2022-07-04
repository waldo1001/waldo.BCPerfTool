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

    procedure Run(ObjType: enum "Perftool Object Types WPT"; ObjId: Integer)
    begin
        PerfToolImplWPT.Run();
    end;
}