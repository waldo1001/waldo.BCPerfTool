page 62113 "PerfTool Setup WPT"
{

    PageType = Card;
    SourceTable = "PerfTool Setup WPT";
    Caption = 'PerfTool Setup';
    InsertAllowed = false;
    DeleteAllowed = false;
    UsageCategory = Administration;


    layout
    {
        area(content)
        {
            group(General)
            {
                field(FlameGraphServer; Rec.FlameGraphServer)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the FlameGraphServer field.';
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        Rec.InsertIfNotExists();
    end;
}
