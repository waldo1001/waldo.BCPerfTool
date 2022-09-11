codeunit 62277 "FlameGraph Subs (Fast) WPT"
{
    EventSubscriberInstance = Manual;
    //Slowing down
    [EventSubscriber(ObjectType::Codeunit, codeunit::"Page Management", 'OnAfterGetPageID', '', false, false)]
    local procedure OnAfterGetPageID(var PageID: Integer)
    begin
        if PageID = page::"Sales Invoice" then sleep(100);
    end;

    [EventSubscriber(ObjectType::Page, page::"Sales Invoice", 'OnOpenPageEvent', '', false, false)]
    local procedure OnOpenPageEvent()
    begin
        sleep(100);
    end;

    [EventSubscriber(ObjectType::Page, page::"Sales Invoice", 'OnAfterGetCurrRecordEvent', '', false, false)]
    local procedure OnAfterGetCurrRecordEvent()
    begin
        sleep(100);
    end;

    [EventSubscriber(ObjectType::Page, page::"Sales Invoice", 'OnAfterOnAfterGetRecord', '', false, false)]
    local procedure OnAfterOnAfterGetRecord()
    begin
        sleep(100);
    end;

    [EventSubscriber(ObjectType::Page, page::"Sales Invoice Subform", 'OnAfterGetRecordEvent', '', false, false)]
    local procedure OnAfterGetRecordEvent()
    begin
        sleep(100);
    end;


    //slow down posting
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnAfterPostGLAcc', '', false, false)]
    local procedure OnAfterPostGLAcc(var Sender: Codeunit "Gen. Jnl.-Post Line"; var GenJnlLine: Record "Gen. Journal Line"; var TempGLEntryBuf: Record "G/L Entry"; var NextEntryNo: Integer; var NextTransactionNo: Integer; Balancing: Boolean);
    begin
        Sleep(100);
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnAfterCheckSalesApprovalPossible', '', false, false)]
    local procedure OnAfterCheckSalesApprovalPossible(var SalesHeader: Record "Sales Header");
    begin
        sleep(100);
    end;


}