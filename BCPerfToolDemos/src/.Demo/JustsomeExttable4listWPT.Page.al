page 62220 "JustSomeExtTable4 list WPT"
{
    ApplicationArea = All;
    Caption = 'JustSomeExtTable4 list';
    PageType = List;
    SourceTable = "Just Some Extended Table 4 WPT";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Entry No. field.';
                }
                field("Message"; Rec.Message)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Message field.';
                }
                field(Message2; Rec."Message 2")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Message 2 field.';
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Quantity field.';
                }
                field(Color; Rec.Color)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Color field.';
                }
                field(Country; Rec.Country)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Country field.';
                }
                field(DateCreated; Rec.DateCreated)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Date Created field.';
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    var
        breakpoint: Integer;
    begin
#pragma warning disable AA0206
        breakpoint := 0; //merely here to set a breakpoint to find out the SQL statement
#pragma warning restore AA0206
    end;
}
