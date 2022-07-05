page 62104 "PerfTool Suite WPT"
{
    Caption = 'PerfTool Suite';
    PageType = ListPlus;
    SourceTable = "PerfTool Suite Header WPT";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Code"; Rec."Code")
                {
                    ToolTip = 'Specifies the value of the Code field.';
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                    ApplicationArea = All;
                }
                field("Group Code"; Rec."Group Code")
                {
                    ToolTip = 'Specifies the value of the Group Code field.';
                    ApplicationArea = All;
                }
                field(CurrentTag; Rec.CurrentTag)
                {
                    ToolTip = 'Specifies the value of the Current Tag field.';
                    ApplicationArea = All;
                }
            }
            group(Lines)
            {
                group(Left)
                {
                    ShowCaption = false;

                    part(SuiteLines; "PerfTool Suite SubPage WPT")
                    {
                        ApplicationArea = All;
                        SubPageLink = "PerfTool Code" = Field(Code);
                    }
                }
                group(Right)
                {
                    ShowCaption = false;

                    part(Logs1; "PerfTool Log SubPage WPT")
                    {
                        Caption = 'Logs';
                        ApplicationArea = All;
                        Provider = SuiteLines;
                        SubPageLink = Identifier = field(SystemId);
                    }
                    part(Logs2; "PerfTool Log SubPage WPT")
                    {
                        Caption = 'All Logs';
                        ApplicationArea = All;
                        SubPageLink = AlternativeKey = field(Code);
                    }
                }

            }
        }

        // area(FactBoxes)
        // {
        //     part(Log; "PerfTool Log FactBox WPT")
        //     {
        //         ApplicationArea = All;
        //         Provider = SuiteLines;
        //         SubPageLink = Identifier = field(SystemId);
        //     }
        // }
    }
}
