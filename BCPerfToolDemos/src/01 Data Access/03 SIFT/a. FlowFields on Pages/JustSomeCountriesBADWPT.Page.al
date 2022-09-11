page 62211 "Just Some Countries BAD WPT"
{
    ApplicationArea = All;
    Caption = 'Just Some Countries (Key)';
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
                field(TotalQuantity; Rec.TotalQuantity)
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