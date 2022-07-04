codeunit 62109 "RunObject WPT"
{
    internal procedure RunObject(ObjType: enum "Perftool Object Types WPT"; ObjId: Integer) Result: Boolean
    var
        IsHandled: Boolean;
    begin
        OnBeforeRunObject(ObjType, ObjId, Result, IsHandled);

        DoRunObject(ObjType, ObjId, Result, IsHandled);

        OnAfterRunObject(ObjType, ObjId, Result);
    end;

    local procedure DoRunObject(ObjType: enum "Perftool Object Types WPT"; ObjId: Integer; var Result: Boolean; IsHandled: Boolean)
    var
        RecRef: RecordRef;
        OutStr: OutStream;
    begin
        if IsHandled then
            exit;

        Result := true;

        case ObjType of
            Enum::"Perftool Object Types WPT"::Codeunit:
                Result := Codeunit.Run(objid);
            Enum::"Perftool Object Types WPT"::Page:
                Page.Run(objid);
            Enum::"Perftool Object Types WPT"::Query:
                Result := Query.SaveAsXml(objid, OutStr);
            Enum::"Perftool Object Types WPT"::Report:
                report.Run(objid, false, true);
            Enum::"Perftool Object Types WPT"::Table:
                begin
                    RecRef.open(ObjId);
#pragma warning disable AA0181
                    recref.FindSet();
#pragma warning restore AA0181
                end;
            else
                Error('Unknown object type %1!', ObjType)
        end;
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeRunObject(ObjType: enum "Perftool Object Types WPT"; ObjId: Integer; var Result: boolean; var IsHandled: Boolean);
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterRunObject(ObjType: enum "Perftool Object Types WPT"; ObjId: Integer; var Result: boolean);
    begin
    end;
}