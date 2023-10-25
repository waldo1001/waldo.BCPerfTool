codeunit 62355 "Demo - PartialRecWrite Ext8"
{

    #region Table4_RecWrite_8
    procedure Table4_RecWrite_8()
    var
        JustSomeTableWPT: Record "Just Some Extended Table 4 WPT";
        i, LastId : integer;
    begin
        JustSomeTableWPT.FindLast();
        LastId := JustSomeTableWPT."Entry No.";

        for i := 1 to 100 do begin
            JustSomeTableWPT."Entry No." := LastId + i;
            JustSomeTableWPT."Field51 WPT" := 1;
            JustSomeTableWPT.Insert(false);
        end;
    end;
    #endregion

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Demo - PartialRecWrite WPT", 'OnAfterGetProcedures', '', false, false)]
    local procedure OnAfterGetProcedures(var Result: List of [Text[50]]);
    begin
        Result.Add('Table4_RecWrite_8');
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Demo - PartialRecWrite WPT", 'OnAfterRun', '', false, false)]
    local procedure OnAfterRun(ProcedureName: Text);
    begin
        if ProcedureName = 'Table4_RecWrite_8' then
            Table4_RecWrite_8();
    end;
}