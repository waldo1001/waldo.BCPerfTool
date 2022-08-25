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

    views
    {
        addfirst
        {
            view(Data)
            {
                Filters = where("Group Code" = const('1.DATA'));
            }
            view(Queries)
            {
                Filters = where("Group Code" = const('2.QUERIES'));
            }
            view(Events)
            {
                Filters = where("Group Code" = const('3.EVENTS'));
            }
            view(Background)
            {
                Filters = where("Group Code" = const('4.BACKGROUND'));
            }
            view(TempTables)
            {
                Filters = where("Group Code" = const('6.TEMPTABLES'));
            }
            view(Datatypes)
            {
                Filters = where("Group Code" = const('8.DATATYPES'));
            }
            view(LazyEvaluatoin)
            {
                Filters = where("Group Code" = const('9.LazyEvaluation'));
            }
            view(Wrappers)
            {
                Filters = where("Group Code" = const('98.WRAPPERS'));
            }
            view(Retention)
            {
                Filters = where("Group Code" = const('99.RETENTION'));
            }

        }
    }
}