report 62201 "Reset Demo Data WPT"
{
    Caption = 'Reset Performance Demo Data';
    UsageCategory = Administration;
    ApplicationArea = All;
    ProcessingOnly = true;

    dataset
    {
        dataitem("Just Some Table WPT"; "Just Some Table WPT")
        {
            trigger OnAfterGetRecord()
            begin
                if "Just Some Table WPT"."Message 2" <> "Just Some Table WPT".Message then begin
                    "Just Some Table WPT"."Message 2" := "Just Some Table WPT".Message;
                    "Just Some Table WPT".Modify();
                end;
            end;
        }
        dataitem("EmptyTable WPT"; "EmptyTable WPT")
        {
            trigger OnPreDataItem()
            begin
                "EmptyTable WPT".DeleteAll(true);
                CurrReport.Break();
            end;
        }
        dataitem("PerfTool Log Entry WPT"; "PerfTool Log Entry WPT")
        {
            trigger OnPreDataItem()
            begin
                "PerfTool Log Entry WPT".DeleteAll(true);
                CurrReport.Break();
            end;
        }
        dataitem(JustSomeCountryWPT; "Just Some Country WPT")
        {
            trigger OnPreDataItem()
            begin
                JustSomeCountryWPT.ModifyAll(Message, '');
                CurrReport.Break();
            end;
        }
    }
}