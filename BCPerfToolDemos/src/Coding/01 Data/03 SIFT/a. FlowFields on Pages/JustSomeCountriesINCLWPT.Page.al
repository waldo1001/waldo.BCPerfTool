page 62212 "Just Some Countries INCL WPT"
{
    ApplicationArea = All;
    Caption = 'Just Some Countries (Incl. Columns)';
    PageType = List;
    SourceTable = "Just Some Country WPT";
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Code"; Rec.Code)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Code field.';
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Name field.';
                }
                field(TotalQuantity; Rec.TotalQuantity3)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Total Qty. field.';
                }
                field("Message"; Rec.Message)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Message field.';
                }

            }
        }
    }
}