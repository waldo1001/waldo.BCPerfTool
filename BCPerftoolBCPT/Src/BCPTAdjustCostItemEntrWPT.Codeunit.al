codeunit 75003 "BCPT Adjust Cost Item Entr WPT"
{
    trigger OnRun()
    begin
        AdjusCostItemEntries();
    end;

    local procedure AdjusCostItemEntries()
    var
        AdjustCostItemEntries: Report "Adjust Cost - Item Entries";
    begin
        //Adjust and post to GL
        AdjustCostItemEntries.SetPostToGL(true);
        AdjustCostItemEntries.UseRequestPage(false);
        AdjustCostItemEntries.Run();
    end;
}