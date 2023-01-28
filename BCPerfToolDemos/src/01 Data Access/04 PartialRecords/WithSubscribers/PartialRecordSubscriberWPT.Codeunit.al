codeunit 62208 "PartialRecordSubscriber WPT"
{
    SingleInstance = true;

    trigger Onrun()
    var
        JustSomeTableWPT: Record "Just Some Extended Table 4 WPT";
        Str: Text;
    begin
        If not confirm('Test', false) then error('');
        JustSomeTableWPT.SetLoadFields(Message);
        if JustSomeTableWPT.FindSet() then;
        Str += 'Antal: ' + format(JustSomeTableWPT.count) + '\';
        if JustSomeTableWPT.AreFieldsLoaded(Message) then
            str += 'Message\';
        if JustSomeTableWPT.AreFieldsLoaded(Quantity) then
            str += 'Quantity\';

        if JustSomeTableWPT.AreFieldsLoaded(Color) then
            str += 'Color\';

        if JustSomeTableWPT.AreFieldsLoaded("Color 2") then
            str += 'Color2\';

        Message('Resultat:\%1', str);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Demo - PartialRecordsSS WPT", 'DoLoopJITSubscriber', '', false, false)]
    local procedure DoLoopPartialRecordsSubJITSub(var JustSomeTableWPT: Record "Just Some Extended Table 4 WPT")
    begin
        if JustSomeTableWPT.Quantity > 0 then
       ; // Do Nothing
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Demo - PartialRecordsSS WPT", 'DoLoopAddFieldsSubscriber', '', false, false)]
    local procedure DoLoopSubAddLoadFieldsSub(var JustSomeTableWPT: Record "Just Some Extended Table 4 WPT")
    begin
        // Check if the field is added in PartialRecords
        if not JustSomeTableWPT.AreFieldsLoaded(Quantity) then begin
            JustSomeTableWPT.AddLoadFields(Quantity);
        end;
        if JustSomeTableWPT.Quantity > 0 then
       ; // Do Nothing
    end;
}