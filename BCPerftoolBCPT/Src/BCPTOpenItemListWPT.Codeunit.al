codeunit 75010 "BCPT Open Item List WPT"
{
    // Test codeunits can only run in foreground (UI)
    Subtype = Test;

    trigger OnRun();
    begin
    end;

    [Test]
    procedure OpenItemList()
    var
        ItemList: testpage "Item List";
    begin
        ItemList.OpenView();
        ItemList.Next();
        ItemList.Last();
        ItemList.Close();
    end;
}