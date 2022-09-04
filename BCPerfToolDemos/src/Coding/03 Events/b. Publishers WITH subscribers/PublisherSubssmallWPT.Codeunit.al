#pragma warning disable AA0137
codeunit 62274 "Publisher Subs (small) WPT"
{
    [EventSubscriber(ObjectType::Codeunit, codeunit::"Demo - PublishersWithSubs WPT", 'OnAfterDoingSomethingSmall', '', false, false)]
    local procedure EmptySubscriber()
    begin
    end;
}