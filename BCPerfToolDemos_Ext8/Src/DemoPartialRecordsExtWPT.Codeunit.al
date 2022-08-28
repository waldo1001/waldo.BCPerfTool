codeunit 62351 "Demo - PartialRecords Ext WPT"
{
    // #region FindSetWithPartialrecords2
    // local procedure FindSetWithPartialrecords2()
    // var
    //     JustSomeTableWPT: Record "Just Some Extended Table 4 WPT";
    //     i: Integer;
    // begin
    //     JustSomeTableWPT.SetLoadFields("Field54 WPT");
    //     if JustSomeTableWPT.FindSet() then;
    //     repeat
    //         i += 1;
    //         if i > 10000 then exit;
    //     until JustSomeTableWPT.Next() < 1;
    // end;
    // #endregion

    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Demo - PartialRecords WPT", 'OnAfterGetProcedures', '', false, false)]
    // local procedure OnAfterGetProcedures(var Result: List of [Text[50]]);
    // begin
    //     Result.Add('FindSetWithPartialrecords2');
    // end;

    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Demo - PartialRecords WPT", 'OnAfterRun', '', false, false)]
    // local procedure OnAfterRun(ProcedureName: Text);
    // begin
    //     if ProcedureName = 'FindSetWithPartialrecords2' then
    //         FindSetWithPartialrecords2();
    // end;


}