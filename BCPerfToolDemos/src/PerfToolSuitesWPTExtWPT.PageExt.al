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
                    // ResetDemoDataWPT: Report "Reset Demo Data WPT";
                    InstallSuitesWPT: Codeunit "Install Suites WPT";
                    InstallDemoDataWPT: Codeunit "Install Demo Data WPT";
                begin
                    InstallSuitesWPT.ResetAll();
                    InstallSuitesWPT.FillSuite();
                    InstallDemoDataWPT.FillData();
                    // ResetDemoDataWPT.RunModal();
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
                Filters = where("Group Code" = const('01.DATA'));
            }
            view(Queries)
            {
                Filters = where("Group Code" = const('02.QUERIES'));
            }
            view(Events)
            {
                Filters = where("Group Code" = const('03.EVENTS'));
            }
            view(Background)
            {
                Filters = where("Group Code" = const('15.BACKGROUND'));
            }
            view(TempTables)
            {
                Filters = where("Group Code" = const('06.TEMPTABLES'));
            }
            view(Datatypes)
            {
                Filters = where("Group Code" = const('08.DATATYPES'));
            }
            view(LazyEvaluation)
            {
                Filters = where("Group Code" = const('09.LazyEvaluation'));
            }
            view(Wrappers)
            {
                Filters = where("Group Code" = const('10.WRAPPERS'));
            }
            view(Retention)
            {
                Filters = where("Group Code" = const('11.RETENTION'));
            }
            view(BackgroundProcessing)
            {
                Filters = where("Group Code" = const('15.BACKGROUND'));
            }
            view(Tools)
            {
                Filters = where("Group Code" = const('20.TOOLS'));
            }

        }
    }
}