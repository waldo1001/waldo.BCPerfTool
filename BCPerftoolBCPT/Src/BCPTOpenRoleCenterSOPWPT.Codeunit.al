codeunit 75012 "BCPT Open RoleCenter SOP WPT"
{
    // Test codeunits can only run in foreground (UI)
    Subtype = Test;

    trigger OnRun();
    var
        SOPRC: testpage "SO Processor Activities";
    begin
        SOPRC.OpenView();
        SOPRC.Close();
    end;
}