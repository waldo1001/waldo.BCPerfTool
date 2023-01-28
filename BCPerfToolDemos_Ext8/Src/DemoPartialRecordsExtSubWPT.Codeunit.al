codeunit 62352 "Demo - PartialRecordsExtSubWPT"
{
    SingleInstance = true;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Demo - PartialRecordsSS WPT", 'DoLoopAnotherExtJITSubscriber', '', false, false)]
    local procedure DoLoopPartialRecordsSubJITSub(var JustSomeTableWPT: Record "Just Some Extended Table 4 WPT")
    begin
        if JustSomeTableWPT."Field51 WPT" > 0 then
       ; // Do Nothing
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Demo - PartialRecordsSS WPT", 'DoLoopAnotherExtJITSubscriber', '', false, false)]
    local procedure DoLoopSubAddLoadFieldsSub(var JustSomeTableWPT: Record "Just Some Extended Table 4 WPT")
    begin
        // Check if the field is added in PartialRecords
        if not JustSomeTableWPT.AreFieldsLoaded(Quantity) then
            JustSomeTableWPT.AddLoadFields("Field51 WPT");
        if JustSomeTableWPT."Field51 WPT" > 0 then
       ; // Do Nothing
    end;
}