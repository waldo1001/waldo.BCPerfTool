page 62216 "NewTable WPT"
{
    Caption = 'NewTable';
    PageType = List;
    SourceTable = "New Table WPT";
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
                    ToolTip = 'Specifies the value of the Color field.';
                }
                field("Color 2"; Rec."Color 2")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Color 2 field.';
                }
                field(Country; Rec.Country)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Country field.';
                }
                field("Country 2"; Rec."Country 2")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Country 2 field.';
                }
                field("Country 3"; Rec."Country 3")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Country 3 field.';
                }
                field(DateCreated; Rec.DateCreated)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Date Created field.';
                }
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Entry No. field.';
                }
                field(LastTrigger; Rec.LastTrigger)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the LastTrigger field.';
                }
                field("Message"; Rec.Message)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Message field.';
                }
                field("Message 2"; Rec."Message 2")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Message 2 field.';
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Quantity field.';
                }
                field(SystemCreatedAt; Rec.SystemCreatedAt)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the SystemCreatedAt field.';
                }
                field(SystemCreatedBy; Rec.SystemCreatedBy)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the SystemCreatedBy field.';
                }
                field(SystemId; Rec.SystemId)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the SystemId field.';
                }
                field(SystemModifiedAt; Rec.SystemModifiedAt)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the SystemModifiedAt field.';
                }
                field(SystemModifiedBy; Rec.SystemModifiedBy)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the SystemModifiedBy field.';
                }
            }
        }
    }
}
