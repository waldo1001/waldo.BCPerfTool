pageextension 62201 "PerfToolSuitesWPT Ext WPT" extends "PerfTool Suites WPT"
{
    actions
    {
        addfirst(Processing)
        {
            action("Import Demo Data WPT")
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
                    InstallDemosWPT: Codeunit "Install Demos WPT";
                begin
                    InstallDemosWPT.FillSuite();
                end;
            }
        }
    }
}