page 62206 "GroupingResult List WPT"
{
    ApplicationArea = All;
    Caption = 'GroupingResult List';
    PageType = List;
    SourceTable = "GroupingResult WPT";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Color; Rec.Color)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Location Code field.';
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Quantity field.';
                }
                field("Count"; Rec.Count)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Count field.';
                }
            }
        }
    }
}
