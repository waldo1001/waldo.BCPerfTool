#pragma warning disable AA0231
codeunit 62128 "UploadToPyroscope Meth WPT"
{
    internal procedure UploadToPyroscope(var Log: Record "PerfTool Log Entry WPT")
    var
        IsHandled: Boolean;
    begin
        OnBeforeUploadToPyroscope(Log, IsHandled);

        DoUploadToPyroscope(Log, IsHandled);

        OnAfterUploadToPyroscope(Log);
    end;

    local procedure DoUploadToPyroscope(var Log: Record "PerfTool Log Entry WPT"; IsHandled: Boolean)
    var
        Response: HttpResponseMessage;
        Base64EncodedResult: Text;
    begin
        if IsHandled then
            exit;

        Base64EncodedResult := GetFoldedFile(Log, Response);
        UploadToPyroscopeServer(Log, Base64EncodedResult, Response);
    end;

    local procedure GetFoldedFile(var Log: Record "PerfTool Log Entry WPT"; var Response: HttpResponseMessage) Base64EncodedResult: Text
    var
        HTTP: HTTPClient;
        Content: HttpContent;
        Headers: HttpHeaders;
        InStr: InStream;
        AllContent: Text;
        PartOfContent: Text;
        URL: Text;
    begin
        Log.CalcFields(ProfilingData);

        Log.ProfilingData.CreateInStream(InStr);

        while not InStr.EOS do begin
            InStr.ReadText(PartOfContent);
            AllContent += PartOfContent;
        end;

        URL := 'http://blogapi.sshadows.dk/upload';

        Content.WriteFrom(AllContent);
        Content.GetHeaders(Headers);
        Headers.Add('onlyfolded', 'true');
        Headers.Add('filter', 'BCPerfTool');
        Headers.Add('fromunix', Format(log.StartTime, 0, 9));
        Headers.Add('tounix', Format(log.StopTime, 0, 9));

        if Http.Post(URL, Content, Response) then
            case Response.HttpStatusCode of
                200:
                    Response.Content.ReadAs(Base64EncodedResult);
                else
                    NotifyFailure('An error occurred while trying to get the flamegraph. Url: ' + Url);
            end
        else
            NotifyFailure('Failed to post to flamegraph server.  Url:' + Url);

    end;

    local procedure UploadToPyroscopeServer(var Log: Record "PerfTool Log Entry WPT"; payload: Text; Response: HttpResponseMessage)
    var
        PerfToolSetupWPT: Record "PerfTool Setup WPT";
        Content: HttpContent;
        HTTP: HTTPClient;
        Name: Text;
        FromUnix: Text;
        UntilUnix: Text;
        Url: Text;
    begin
        PerfToolSetupWPT.GetRecordOnce();
        PerfToolSetupWPT.TestField(FlameGraphServer);

        Content.WriteFrom(payload);

        Name := GetName(Log);
        FromUnix := format(log.StartTime, 0, 9);
        UntilUnix := format(log.StopTime, 0, 9);

        url := CreateRequestUrl(PerfToolSetupWPT.FlameGraphServer, 4040, Name, FromUnix, UntilUnix);

        if not HTTP.Post(Url, Content, Response) then
            NotifyFailure('An error occurred while uploading to pyroscope. Url:' + Url)
        else
            case Response.HttpStatusCode of
                200:
                    exit;
                else
                    NotifyFailure('An error occured uploading to pyroscope: ' + Response.ReasonPhrase);
            end;
    end;

    local procedure GetName(var Log: Record "PerfTool Log Entry WPT") name: Text
    var
        Header: Record "PerfTool Suite Header WPT";
        Line: Record "PerfTool Suite Line WPT";
        Grp: Record "PerfTool Group WPT";
        Part1: Text;
        Part2: Text;
        Tags: Text;
    begin
        if Line.GetBySystemId(log.Identifier) then begin
            Header.get(line."PerfTool Code");
            Grp.Get(Header."Group Code");

            Part1 := GetDecentText(Grp.Description);
            Part2 := GetDecentText(Header.Description);
            Tags := GetDecentText(log.Tag);

        end else begin
            Part1 := GetDecentText(Log.AppInsightsEventId);
            Part2 := GetDecentText(Log.Message);
            Tags := GetDecentText(log.Tag);
        end;

        if Part2 <> '' then
            Name := Part1 + '.' + Part2 + '{method=' + Tags + '}'
        else
            Name := Part1 + '{Tag=' + Tags + '}';
    end;

    Local procedure GetDecentText(Val: Text): Text
    begin
        exit(Val.Replace('.', '').Replace(' ', ''));
    end;

    local procedure NotifyFailure(NotificationMsg: Text)
    var
        MyNotification: Notification;
    begin
        MyNotification.Id := '481c5cca-3581-4fcf-aa8e-a05fed6fa99a';
        MyNotification.Scope := NotificationScope::LocalScope;
        MyNotification.Message := 'Failure: ' + NotificationMsg;
        MyNotification.Send();
    end;

    local procedure CreateRequestUrl(Server: Text; Port: Integer; Name: Text; FromUNIX: Text; UntilUnix: Text): Text
    var
        TypeHelper: Codeunit "Type Helper";
        UrlLbl: label 'http://%1:%2/ingest?name=%3&from=%4&until=%5', Comment = '%1=server ;%2=port %3=name %4=from %5=until';
    begin
        exit(StrSubstNo(UrlLbl, Server, Port, TypeHelper.UrlEncode(Name), FromUNIX, UntilUnix));
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeUploadToPyroscope(var Log: Record "PerfTool Log Entry WPT"; var IsHandled: Boolean);
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterUploadToPyroscope(var Log: Record "PerfTool Log Entry WPT");
    begin
    end;
}
