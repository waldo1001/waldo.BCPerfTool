codeunit 62338 "Demo - PartialRecWrite Ext6"
{

    #region Table3_RecWrite_6
    procedure Table3_RecWrite_6()
    var
        JustSomeTableWPT: Record "Just Some Extended Table 3 WPT";
        i, LastId : integer;
    begin
        JustSomeTableWPT.FindLast();
        LastId := JustSomeTableWPT."Entry No.";

        for i := 1 to 100 do begin
            JustSomeTableWPT."Entry No." := LastId + i;
            JustSomeTableWPT."Field36 WPT" := 1;
            JustSomeTableWPT.Insert(false);
        end;
    end;
    #endregion

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Demo - PartialRecWrite WPT", 'OnAfterGetProcedures', '', false, false)]
    local procedure OnAfterGetProcedures(var Result: List of [Text[50]]);
    begin
        Result.Add('Table3_RecWrite_6');
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Demo - PartialRecWrite WPT", 'OnAfterRun', '', false, false)]
    local procedure OnAfterRun(ProcedureName: Text);
    begin
        if ProcedureName = 'Table3_RecWrite_6' then
            Table3_RecWrite_6();
    end;
}