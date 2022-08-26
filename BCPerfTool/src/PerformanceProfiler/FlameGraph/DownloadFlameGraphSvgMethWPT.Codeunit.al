codeunit 62129 "DownloadFlameGraphSvg Meth WPT"
{
    internal procedure Download(var Log: Record "PerfTool Log Entry WPT")
    var
        IsHandled: Boolean;
    begin
        OnBeforeDownload(Log, IsHandled);

        DoDownload(Log, IsHandled);

        OnAfterDownload(Log);
    end;

    local procedure DoDownload(var Log: Record "PerfTool Log Entry WPT"; IsHandled: Boolean);
    var
        TempBlob: Codeunit "Temp Blob";
        ToFile: Text;
        InStr: InStream;
        OutStr: OutStream;
        FlameGraphFileNameTxt: Label 'FlameGraph_%1', Locked = true;
        FlameGraphFileExtensionTxt: Label '.svg', Locked = true;
        Base64Encoded: Text;
    begin
        if IsHandled then
            exit;

        Base64Encoded := Log.GetFlameGraphSvg();

        ToFile := StrSubstNo(FlameGraphFileNameTxt, Log.AppInsightsEventId) + FlameGraphFileExtensionTxt;

        TempBlob.CreateOutStream(OutStr);
        OutStr.WriteText(Base64Encoded);
        TempBlob.CreateInStream(InStr);
        DownloadFromStream(InStr, '', '', '', ToFile);
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeDownload(var Log: Record "PerfTool Log Entry WPT"; var IsHandled: Boolean);
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterDownload(var Log: Record "PerfTool Log Entry WPT");
    begin
    end;
}