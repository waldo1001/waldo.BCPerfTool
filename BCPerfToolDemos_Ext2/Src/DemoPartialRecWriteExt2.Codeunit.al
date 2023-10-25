codeunit 62310 "Demo - PartialRecWrite Ext2"
{

    #region Table1_RecWrite_2
    procedure Table1_RecWrite_2()
    var
        JustSomeTableWPT: Record "Just Some Extended Table 1 WPT";
        i, LastId : integer;
    begin
        JustSomeTableWPT.FindLast();
        LastId := JustSomeTableWPT."Entry No.";

        for i := 1 to 100 do begin
            JustSomeTableWPT."Entry No." := LastId + i;
            JustSomeTableWPT."Field6 WPT" := 1;
            JustSomeTableWPT.Insert(false);
        end;
    end;
    #endregion

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Demo - PartialRecWrite WPT", 'OnAfterGetProcedures', '', false, false)]
    local procedure OnAfterGetProcedures(var Result: List of [Text[50]]);
    begin
        Result.Add('Table1_RecWrite_2');
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Demo - PartialRecWrite WPT", 'OnAfterRun', '', false, false)]
    local procedure OnAfterRun(ProcedureName: Text);
    begin
        if ProcedureName = 'Table1_RecWrite_2' then
            Table1_RecWrite_2();
    end;
}