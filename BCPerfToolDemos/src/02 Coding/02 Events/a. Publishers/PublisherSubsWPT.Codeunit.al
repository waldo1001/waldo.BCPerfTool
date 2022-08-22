codeunit 62208 "Publisher Subs WPT"
{
    SingleInstance = true;

    [EventSubscriber(ObjectType::Codeunit, codeunit::"Demo - Publishers WPT", 'OnAfterDoingSomethingElse2', '', false, false)]
    local procedure EmptySubscriber()
    begin
    end;
}