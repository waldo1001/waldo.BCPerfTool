page 62103 "PerfTool Suite SubPage WPT"
{
    Caption = 'PerfTool Suite Lines';
    PageType = ListPart;
    SourceTable = "PerfTool Suite Line WPT";
    AutoSplitKey = true;

    layout
    {
        area(content)
        {
            repeater(General)
            {

                field("Line No."; Rec."Line No.")
                {
                    ToolTip = 'Specifies the value of the Line No. field.';
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;
                }
                field("Object Name"; Rec.GetObjectName())
                {
                    Caption = 'Object Name';
                    ToolTip = 'Specifies the value of the Codeunit Name field.';
                    ApplicationArea = All;

                    trigger OnDrillDown()
                    begin
                        case Rec."Object Type" of
                            Rec."Object Type"::Table:
                                Hyperlink(GetUrl(CLIENTTYPE::Web, CompanyName, ObjectType::Table, Rec."Object ID"));
                            Rec."Object Type"::Codeunit:
                                Hyperlink(GetUrl(CLIENTTYPE::Web, CompanyName, ObjectType::Codeunit, Rec."Object ID"));
                            Rec."Object Type"::Page:
                                Hyperlink(GetUrl(CLIENTTYPE::Web, CompanyName, ObjectType::Page, Rec."Object ID"));
                            Rec."Object Type"::Query:
                                Hyperlink(GetUrl(CLIENTTYPE::Web, CompanyName, ObjectType::Query, Rec."Object ID"));
                            Rec."Object Type"::Report:
                                Hyperlink(GetUrl(CLIENTTYPE::Web, CompanyName, ObjectType::Report, Rec."Object ID"));
                        end;
                    end;
                }
                field(RunFld; RunLbl)
                {
                    Caption = 'Run';
                    ToolTip = 'Runs the object';
                    ApplicationArea = All;
                    Editable = false;
                    Width = 1;

                    trigger OnDrillDown()
                    begin
                        Rec.Run(False);
                        // CurrPage.Update(false);
                    end;
                }
                field(DisableFromBatch; Rec.DisableFromBatch)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Disable From Batch field.';
                }
                field(SelectLatestVersion; Rec.SelectLatestVersion)
                {
                    ToolTip = 'Specifies if the cache should be used or not.';
                    ApplicationArea = All;
                }
                field("Run Performance Analyzer"; Rec."Run Performance Analyzer")
                {
                    ToolTip = 'Specifies if the performance analyzer should run or not.';
                    ApplicationArea = All;
                    Width = 5;
                }
                field("Object Type"; Rec."Object Type")
                {
                    ToolTip = 'Specifies the value of the Object Type field.';
                    ApplicationArea = All;
                }
                field("Object ID"; Rec."Object ID")
                {
                    ToolTip = 'Specifies the value of the Object ID field.';
                    ApplicationArea = All;
                }
                field("PerfTool Code"; Rec."PerfTool Code")
                {
                    ToolTip = 'Specifies the value of the Code field.';
                    ApplicationArea = All;
                    Visible = false;
                }
                field(PerfToolCodeunit; Rec.PerfToolCodeunit)
                {
                    ToolTip = 'Specifies the value of the PerfTool Codeunit field.';
                    ApplicationArea = All;
                }
                field("Procedure Name"; Rec."Procedure Name")
                {
                    ToolTip = 'Specifies the value of the Procedure field.';
                    ApplicationArea = All;
                }
                field("Avg. noOfSqlStatements"; Rec."Avg. noOfSqlStatements")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Avg. No. of SQL Statements field.';
                }
                field("Avg. noOfSqlRowsRead"; Rec."Avg. noOfSqlRowsRead")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Avg. No. Of Sql Rows Read field.';
                }
                field("Avg. Duration"; Rec."Avg. Duration")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Avg. Duraction field.';
                }


            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Run")
            {
                ApplicationArea = All;
                Caption = 'Run';
                Image = Start;
                ToolTip = 'Runs the codeunit';
                Scope = Repeater;

                trigger OnAction()
                begin
                    Rec.Run(false);
                    // CurrPage.Update(false);
                end;
            }
            action(LogEntries)
            {
                ApplicationArea = All;
                Caption = 'Log';
                Image = Entries;
                ToolTip = 'Shows the log';
                Scope = Repeater;
                RunObject = page "PerfTool Log Entries WPT";
                RunPageLink = Identifier = field(SystemId);
                RunPageView = sorting(Id) order(descending);
            }
            action(ClearLogEntries)
            {
                ApplicationArea = All;
                Caption = 'Clear Log';
                Image = Delete;
                ToolTip = 'Clears the log for this line';
                Scope = Repeater;

                trigger OnAction()
                begin
                    Rec.ClearLog();
                end;
            }
        }

    }
    var
        RunLbl: Label '▶️';
}
