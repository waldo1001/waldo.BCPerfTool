namespace waldo.System;

page 62108 "Scheduled Tasks WPT"
{

    ApplicationArea = All;
    Caption = 'Scheduled Tasks';
    PageType = List;
    SourceTable = "Scheduled Task";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(ID; Rec.ID)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the ID of the scheduled task.';
                }
                field("Run Codeunit"; Rec."Run Codeunit")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the ID of the codeunit to run.';
                }
                field("Failure Codeunit"; Rec."Failure Codeunit")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the ID of a backup codeunit to run if the codeunit specified for the task fails.';
                }
                field(Company; Rec.Company)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the company name for which this task was scheduled.';
                }
                field("Is Ready"; Rec."Is Ready")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies whether the task has been scheduled.';
                }
                field("Not Before"; Rec."Not Before")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Not Before field.';
                }
                field("Record"; Rec.Record)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Record field.';
                }
                field(Timeout; Rec.Timeout)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Timeout field.';
                }
                field("User App ID"; Rec."User App ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the User App ID field.';
                }
                field("User Format ID"; Rec."User Format ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the User Format ID field.';
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the User ID field.';
                }
                field("User Language ID"; Rec."User Language ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the User Language ID field.';
                }
                field("User Name"; Rec."User Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the username of the user who scheduled the task.';
                }
                field("User Time Zone"; Rec."User Time Zone")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the User Time Zone field.';
                }
            }
        }
    }

}
