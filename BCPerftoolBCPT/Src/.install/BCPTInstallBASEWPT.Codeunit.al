codeunit 75000 "BCPT Install BASE WPT"
{
    Subtype = Install;

    var
        TestSuiteTagLbl: label 'BaseAppTests', Locked = true;

    trigger OnInstallAppPerCompany()
    begin
        SetupSuites();
    end;

    procedure SetupSuites()
    begin
        SetupPOSSuite();
    end;

    local procedure SetupPOSSuite()
    var
        BCPTTestSuite: Codeunit "BCPT Test Suite";
    begin
        BCPTTestSuite.CreateTestSuiteHeader('BASE', 'BaseApp Tests', 20, 500, 1000, 20, TestSuiteTagLbl);
        BCPTTestSuite.AddLineToTestSuiteHeader('BASE', codeunit::"BCPT Adjust Cost Item Entr WPT", 3, 'Adjust Cost Item Entries', 500, 1000, 5, false, '');
        BCPTTestSuite.AddLineToTestSuiteHeader('BASE', codeunit::"BCPT Calc Plan Worksheet WPT", 3, 'Calculate Plan Worksheet', 500, 1000, 5, false, '');
        BCPTTestSuite.AddLineToTestSuiteHeader('BASE', codeunit::"BCPT Create PO with 20 Lns WPT", 3, 'Create PO with 20 Lines', 500, 1000, 5, false, '');
        BCPTTestSuite.AddLineToTestSuiteHeader('BASE', codeunit::"BCPT Create SO with 20 Lns WPT", 3, 'Create SO with 20 Lines', 500, 1000, 5, false, '');
        BCPTTestSuite.AddLineToTestSuiteHeader('BASE', codeunit::"BCPT Create SQ with 20 Lns WPT", 3, 'Create SQ with 20 Lines', 500, 1000, 5, false, '');
        BCPTTestSuite.AddLineToTestSuiteHeader('BASE', codeunit::"BCPT Det.Trial Bal. Report WPT", 3, 'Detail Trial Bal. Report', 500, 1000, 5, false, '');
        BCPTTestSuite.AddLineToTestSuiteHeader('BASE', codeunit::"BCPT Open Chart of Acc. WPT", 3, 'Open Chart of Accounts', 500, 1000, 5, false, '');
        BCPTTestSuite.AddLineToTestSuiteHeader('BASE', codeunit::"BCPT Open Customer List WPT", 3, 'Open Customer List', 500, 1000, 5, false, '');
        BCPTTestSuite.AddLineToTestSuiteHeader('BASE', codeunit::"BCPT Open Item List WPT", 3, 'Open Item List', 500, 1000, 5, false, '');
        BCPTTestSuite.AddLineToTestSuiteHeader('BASE', codeunit::"BCPT Open Purch. Inv. List WPT", 3, 'Open Purch. Invoice List', 500, 1000, 5, false, '');
        BCPTTestSuite.AddLineToTestSuiteHeader('BASE', codeunit::"BCPT Open RoleCenter SOP WPT", 3, 'Open RoleCenter SOP', 500, 1000, 5, false, '');
        BCPTTestSuite.AddLineToTestSuiteHeader('BASE', codeunit::"BCPT Open Sls Inv List WPT", 3, 'Open Sales Invoice List', 500, 1000, 5, false, '');
        BCPTTestSuite.AddLineToTestSuiteHeader('BASE', codeunit::"BCPT Open Vendor List WPT", 3, 'Open Vendor List', 500, 1000, 5, false, '');
        BCPTTestSuite.AddLineToTestSuiteHeader('BASE', codeunit::"BCPT Post G/L Entries WPT", 3, 'Post G/L Entries', 500, 1000, 5, false, '');
        BCPTTestSuite.AddLineToTestSuiteHeader('BASE', codeunit::"BCPT Post Item Journal WPT", 3, 'Post Item Journal', 500, 1000, 5, false, '');
        BCPTTestSuite.AddLineToTestSuiteHeader('BASE', codeunit::"BCPT Post Purch. Inv. WPT", 3, 'Post Purch. Inv.', 500, 1000, 5, false, '');
        BCPTTestSuite.AddLineToTestSuiteHeader('BASE', codeunit::"BCPT Post Sls with 20 Lns WPT", 3, 'Post Sales with 20 Lines', 500, 1000, 5, false, '');
        BCPTTestSuite.AddLineToTestSuiteHeader('BASE', codeunit::"BCPT PurchPost with 20 Lns WPT", 3, 'Purch. Post with 20 Lines', 500, 1000, 5, false, '');
    end;

}