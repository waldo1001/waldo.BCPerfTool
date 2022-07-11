page 62107 "Active Sessions WPT"
{
    ApplicationArea = All;
    Caption = 'Active Sessions';
    PageType = List;
    SourceTable = "Active Session";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Client Type"; Rec."Client Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Client Type field.';
                }
                field("Session ID"; Rec."Session ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Session ID field.';
                }
                field("Login Datetime"; Rec."Login Datetime")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Login Datetime field.';
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the User ID field.';
                }
                field("User SID"; Rec."User SID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the User SID field.';
                }
            }
        }
    }

}
