codeunit 62351 "Demo - PartialRecords Ext WPT"
{
    #region Table4_JITLoading
    local procedure Table4_JITLoading()
    var
        JustSomeTableWPT: Record "Just Some Extended Table 4 WPT";
        i: Integer;
        MyText: Text;
    begin
        JustSomeTableWPT.SetLoadFields(Message);
        if JustSomeTableWPT.FindSet() then;
        repeat
            i += 1;
            if i > 10000 then exit;
            MyText := JustSomeTableWPT."Field53 WPT";
        until JustSomeTableWPT.Next() < 1;
    end;
    #endregion

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Demo - PartialRecords WPT", 'OnAfterGetProcedures', '', false, false)]
    local procedure OnAfterGetProcedures(var Result: List of [Text[50]]);
    begin
        Result.Add('Table4_JITLoading');
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Demo - PartialRecords WPT", 'OnAfterRun', '', false, false)]
    local procedure OnAfterRun(ProcedureName: Text);
    begin
        if ProcedureName = 'Table4_JITLoading' then
            Table4_JITLoading();
    end;


}