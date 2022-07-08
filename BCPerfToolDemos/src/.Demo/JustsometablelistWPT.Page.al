page 62204 "Just some table list WPT"
{
    ApplicationArea = All;
    Caption = 'Just some table list';
    PageType = List;
    SourceTable = "Just Some Table WPT";
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

    actions
    {
        area(Processing)
        {
            action(GenerateLines)
            {
                ApplicationArea = All;
                caption = 'Generate Lines';
                ToolTip = 'Executes the Generate Lines action.';

                trigger OnAction()
                begin
                    rec.GenerateLines();
                end;
            }
            action(UpdateCountries)
            {
                ApplicationArea = All;
                Caption = 'Update Countries';
                ToolTip = 'Executes the Update Countries action.';

                trigger OnAction()
                begin
                    Rec.UpdateCountries();
                end;
            }
        }
    }
}
