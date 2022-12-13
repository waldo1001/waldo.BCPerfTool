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
                field(BatchCount; Rec.BatchCount)
                {
                    ToolTip = 'Specifies how many times to run all lines when running the batch.';
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
            Group(Graphs)
            {
                group(Left2)
                {
                    ShowCaption = false;

                    part(SuiteLines2; "PerfTool Suite SubPage WPT")
                    {
                        Editable = false;
                        ApplicationArea = All;
                        SubPageLink = "PerfTool Code" = Field(Code);
                    }

                }
                group(Right2)
                {
                    ShowCaption = false;
                    part(Chart1; "AveragePerLine Chart WPT")
                    {
                        Caption = 'Averages';
                        Editable = true;
                        ApplicationArea = All;
                    }
                    part(Chart2; "DetailsPerLine Chart WPT")
                    {
                        Caption = 'Details per line';
                        ApplicationArea = All;
                        Provider = SuiteLines2;
                        SubPageLink = "PerfTool Code" = field("PerfTool Code"), "Line No." = field("Line No.");
                    }
                }
            }
        }

    }
    actions
    {
        area(Processing)
        {
            action("Run All")
            {
                Caption = 'Run Once';
                ToolTip = 'Runs all lines once';
                ApplicationArea = All;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                Image = List;
                trigger OnAction()
                begin
                    Rec.RunAll();
                end;
            }
            action("Run Batch")
            {
                Caption = 'Run Batch';
                ToolTip = 'Runs all lines x times (Batch Count)';
                ApplicationArea = All;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                Image = Start;
                trigger OnAction()
                begin
                    Rec.RunAll(Rec.BatchCount);
                end;
            }
        }
        area(Navigation)
        {
            action("Active Sessions")
            {
                Caption = 'Active Sessions';
                ToolTip = 'Shows the current active sessions';
                ApplicationArea = All;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                Image = List;
                RunObject = page "Active Sessions WPT";
            }
            action("Scheduled Tasks")
            {
                Caption = 'Scheduled Tasks';
                ToolTip = 'Shows the current Scheduled Tasks';
                ApplicationArea = All;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                Image = TaskList;
                RunObject = page "Scheduled Tasks WPT";
            }
            action("Open Pyroscope")
            {
                Caption = 'Open Pyroscope';
                ToolTip = 'Opens Pyroscope';
                ApplicationArea = All;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                Image = Open;
                trigger OnAction()
                var
                    PerfToolSetupWPT: Record "PerfTool Setup WPT";
                    UrlLbl: label 'http://%1:4040', Comment = '%1 is Pyroscope server.';
                begin
                    PerfToolSetupWPT.Get();
                    if PerfToolSetupWPT.DisableFlamegraph then exit;
                    if PerfToolSetupWPT.FlameGraphServer = '' then exit;

                    hyperlink(StrSubstNo(Urllbl, PerfToolSetupWPT.FlameGraphServer));
                end;
            }
        }
    }
    trigger OnAfterGetRecord()
    begin
        CurrPage.Chart1.Page.SetViewMode(Rec);
    end;
}
