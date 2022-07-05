pageextension 62201 "PerfToolSuitesWPT Ext WPT" extends "PerfTool Suites WPT"
{
    actions
    {
        addfirst(Processing)
        {
            action("Reset Demos WPT")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                Caption = 'Import Demo Data';
                Image = Import;
                ToolTip = 'Imports Demo Data from the install-codeunit.';

                trigger OnAction()
                var
                    ResetDemoDataWPT: Report "Reset Demo Data WPT";
                    InstallSuitesWPT: Codeunit "Install Suites WPT";
                begin
                    InstallSuitesWPT.ResetAll();
                    InstallSuitesWPT.FillSuite();
                    ResetDemoDataWPT.RunModal();
                end;
            }
        }
    }
}