page 62210 "Just Some Colors (Good) WPT"
{
    ApplicationArea = All;
    Caption = 'Just Some Colors (Good)';
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
                field(TotalQuantity; Rec.TotalQuantity2)
                {
                    ToolTip = 'Specifies the value of the Total Qty. field.';
                    ApplicationArea = All;
                }
            }
        }
    }
}
