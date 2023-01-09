codeunit 62126 "GetFlameGraph Meth WPT"
{
    internal procedure GetFlameGraph(var Log: Record "PerfTool Log Entry WPT"; Svg: Boolean) Base64Encoded: Text
    var
        IsHandled: Boolean;
    begin
        OnBeforeGetFlameGraph(Log, Base64Encoded, IsHandled);

        DoGetFlameGraph(Log, Svg, Base64Encoded, IsHandled);

        OnAfterGetFlameGraph(Log, Base64Encoded);
    end;

    local procedure DoGetFlameGraph(var Log: Record "PerfTool Log Entry WPT"; Svg: Boolean; var Base64EncodedResult: Text; IsHandled: Boolean)
    var
        HTTP: HTTPClient;
        HttpContnt: HttpContent;
        Headers: HttpHeaders;
        Response: HttpResponseMessage;
        InStr: InStream;
        AllContent: Text;

        Content: Text;
        URL: Text;
    begin
        if IsHandled then
            exit;

        Log.CalcFields(ProfilingData);

        Log.ProfilingData.CreateInStream(InStr);

        while not InStr.EOS do begin
            InStr.ReadText(Content);
            AllContent += Content;
        end;

        URL := 'http://blogapi.sshadows.dk/upload';

        HttpContnt.WriteFrom(AllContent);
        HttpContnt.GetHeaders(Headers);
        Headers.Add('color', 'aqua');
        Headers.Add('filter', 'BCPerfTool'); //removes all entries of "BCPerfTool"

        if not Svg then
            Headers.Add('onlyfolded', 'true');

        if Http.Post(URL, HttpContnt, Response) then
            case Response.HttpStatusCode of
                200:
                    Response.Content.ReadAs(Base64EncodedResult);
                else
                    Error('An error occurred while trying to get the flamegraph.');
            end
        else
            Error('Failed to post to flamegraph server');

    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeGetFlameGraph(var Log: Record "PerfTool Log Entry WPT"; var Base64EncodedResult: Text; var IsHandled: Boolean);
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterGetFlameGraph(var Log: Record "PerfTool Log Entry WPT"; Base64EncodedResult: Text);
    begin
    end;
}
