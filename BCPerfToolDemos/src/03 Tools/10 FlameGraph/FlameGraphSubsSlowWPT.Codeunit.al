codeunit 62265 "FlameGraph Subs (Slow) WPT"
{
    EventSubscriberInstance = Manual;

    //slow down posting
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnAfterPostGLAcc', '', false, false)]
    local procedure OnAfterPostGLAcc(var Sender: Codeunit "Gen. Jnl.-Post Line"; var GenJnlLine: Record "Gen. Journal Line"; var TempGLEntryBuf: Record "G/L Entry"; var NextEntryNo: Integer; var NextTransactionNo: Integer; Balancing: Boolean);
    begin
        SomeBeautifulCodeFromWaldo();
    end;

    local procedure SomeBeautifulCodeFromWaldo()
    begin
        Sleep(789);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnAfterCheckSalesApprovalPossible', '', false, false)]
    local procedure OnAfterCheckSalesApprovalPossible(var SalesHeader: Record "Sales Header");
    begin
        DoingSomething();
    end;

    local procedure DoingSomething()
    begin
        Sleep(123);
    end;

}