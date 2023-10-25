namespace waldo.BCPerftool.Analytics;

codeunit 62127 "DownloadProfile Meth WPT"
{
    internal procedure DownloadProfile(var Log: Record "PerfTool Log Entry WPT")
    var
        IsHandled: Boolean;
    begin
        OnBeforeDownloadProfile(Log, IsHandled);

        DoDownloadProfile(Log, IsHandled);

        OnAfterDownloadProfile(Log);
    end;

    local procedure DoDownloadProfile(var Log: Record "PerfTool Log Entry WPT"; IsHandled: Boolean);
    var
        ToFile: Text;
        InStr: InStream;
        PrivacyNoticeMsg: Label 'The file might contain sensitive data, so be sure to handle it securely and according to privacy requirements. Do you want to continue?';
        ProfileFileNameTxt: Label 'PerformanceProfile_%1', Locked = true;
        ProfileFileExtensionTxt: Label '.alcpuprofile', Locked = true;
    begin
        if IsHandled then
            exit;

        if not Confirm(PrivacyNoticeMsg) then
            exit;

        ToFile := StrSubstNo(ProfileFileNameTxt, Log.AppInsightsEventId) + ProfileFileExtensionTxt;
        Log.calcfields(ProfilingData);
        Log.ProfilingData.CreateInStream(InStr);
        DownloadFromStream(InStr, '', '', '', ToFile);
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeDownloadProfile(var Log: Record "PerfTool Log Entry WPT"; var IsHandled: Boolean);
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterDownloadProfile(var Log: Record "PerfTool Log Entry WPT");
    begin
    end;
}