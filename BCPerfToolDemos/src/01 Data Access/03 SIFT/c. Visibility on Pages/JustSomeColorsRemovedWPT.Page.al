page 62218 "Just Some Colors Removed WPT" // Original: page 62210 "Just Some Colors (Good) Hidden WPT"
{
    ApplicationArea = All;
    Caption = 'Just Some Colors (Removed)';
    PageType = List;
    SourceTable = "Just Some Colors WPT";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Color; Rec.Color)
                {
                    ToolTip = 'Specifies the value of the Color field.';
                    ApplicationArea = All;
                }
            }
        }
    }
}
