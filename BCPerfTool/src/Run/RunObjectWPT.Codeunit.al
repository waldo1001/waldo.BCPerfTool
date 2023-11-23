namespace waldo.BCPerftool.Run;

using System.Utilities;

codeunit 62109 "RunObject WPT"
{
    internal procedure RunObject(ObjType: enum "Perftool Object Types WPT"; ObjId: Integer; ProcedureName: Text) Result: Boolean
    var
        IsHandled: Boolean;
    begin
        OnBeforeRunObject(ObjType, ObjId, ProcedureName, Result, IsHandled);

        DoRunObject(ObjType, ObjId, ProcedureName, Result, IsHandled);

        OnAfterRunObject(ObjType, ObjId, ProcedureName, Result);
    end;

    local procedure DoRunObject(ObjType: enum "Perftool Object Types WPT"; ObjId: Integer; ProcedureName: Text; var Result: Boolean; IsHandled: Boolean)
    var
        RunPerfToolCodeunitWPT: Codeunit "RunPerfToolCodeunit WPT";
        TempBlob: Codeunit "Temp Blob";
        RecRef: RecordRef;
        OutStr: OutStream;
        i: Integer;
    begin
        if IsHandled then
            exit;

        Result := true;

        case ObjType of
            Enum::"Perftool Object Types WPT"::Codeunit:
                if enum::"PerfToolCodeunit WPT".Ordinals().Contains(ObjId) then
                    RunPerfToolCodeunitWPT.RunObject(enum::"PerfToolCodeunit WPT".FromInteger(ObjId), ProcedureName)
                else
                    Result := Codeunit.Run(objid);
            Enum::"Perftool Object Types WPT"::Page:
                page.RunModal(ObjId);
            Enum::"Perftool Object Types WPT"::Query:
                begin
                    TempBlob.CreateOutStream(OutStr);
                    Result := Query.SaveAsXml(objid, OutStr);
                end;
            Enum::"Perftool Object Types WPT"::Report:
                report.Run(objid, false, true);
            Enum::"Perftool Object Types WPT"::Table:
                begin
                    i := 0;
                    RecRef.open(ObjId);
                    if recref.FindSet() then
                        repeat
                            i += 1;
                            if i > 50000 then exit;
                        until RecRef.Next() < 1;
                end;
            else
                Error('Unknown object type %1!', ObjType)
        end;
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeRunObject(ObjType: enum "Perftool Object Types WPT"; ObjId: Integer; ProcedureName: Text; var Result: boolean; var IsHandled: Boolean);
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterRunObject(ObjType: enum "Perftool Object Types WPT"; ObjId: Integer; ProcedureName: Text; var Result: boolean);
    begin
    end;
}