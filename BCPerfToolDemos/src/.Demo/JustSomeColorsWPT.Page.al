page 62203 "Just Some Colors WPT"
{
    ApplicationArea = All;
    Caption = 'Just Some Colors';
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
                field(TotalQuantity; Rec.TotalQuantity)
                {
                    ToolTip = 'Specifies the value of the Total Qty. field.';
                    ApplicationArea = All;
                }
            }
        }
    }
}
