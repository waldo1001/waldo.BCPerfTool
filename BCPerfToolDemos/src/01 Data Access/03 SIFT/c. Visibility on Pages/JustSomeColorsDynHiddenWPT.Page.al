page 62221 "Just Some Colors DynHidden WPT" // Original: page 62210 "Just Some Colors (Good) Hidden WPT"
{
    ApplicationArea = All;
    Caption = 'Just Some Colors (Dynamics Hidden)';
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
                    Visible = VisibleVar;
                }
            }
        }
    }
    trigger OnOpenPage()
    begin
        VisibleVar := false
    end;

    var
        VisibleVar: Boolean;
}
