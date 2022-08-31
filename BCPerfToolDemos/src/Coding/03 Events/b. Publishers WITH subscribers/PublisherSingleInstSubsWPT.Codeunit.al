#pragma warning disable AA0137
codeunit 62263 "Publisher SingleInst Subs WPT"
{
    SingleInstance = true;

    [EventSubscriber(ObjectType::Codeunit, codeunit::"Demo - PublishersWithSubs WPT", 'OnAfterDoingSomethingElse2', '', false, false)]
    local procedure EmptySubscriber()
    begin
    end;

    var
        SalesLine: Record "Sales Line";
        SalesLine1: Record "Sales Line";
        SalesLine2: Record "Sales Line";
        SalesLine3: Record "Sales Line";
        SalesLine4: Record "Sales Line";
        SalesLine5: Record "Sales Line";
        SalesLine6: Record "Sales Line";
        SalesPost2: Codeunit "Sales-Post";
}