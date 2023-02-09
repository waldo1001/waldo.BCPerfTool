page 62219 "Just Some Colors Hidden WPT" // Original: page 62210 "Just Some Colors (Good) Hidden WPT"
{
    ApplicationArea = All;
    Caption = 'Just Some Colors (Hidden)';
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
                    Visible = false;
                }
            }
        }
    }
}
