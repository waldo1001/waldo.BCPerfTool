// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
page 62100 "Lookup Codeunits WPT"
{
    Caption = 'Lookup Codeunits';
    PageType = List;
    SourceTable = "Codeunit Metadata";
    Extensible = false;

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field(ID; Rec.ID)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the ID of the test codeunit.';
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the name of the test codeunit.';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ShowAll)
            {
                ApplicationArea = All;
                Caption = 'Show/Hide All';
                Image = Filter;
                Promoted = true;
                PromotedOnly = true;
                ToolTip = 'Show or hide all.';

                trigger OnAction()
                begin
                    ShowAllCodeunits := not ShowAllCodeunits;
                    if ShowAllCodeunits then
                        Rec.SetRange(TableNo)
                    else
                        Rec.SetRange(TableNo, Database::"PerfTool Suite Line WPT");
                    CurrPage.Update(false);
                end;
            }
        }
    }

    trigger OnOpenPage()
    Begin
        Rec.SetFilter(ID, '50000..99999');
    End;

    trigger OnFindRecord(Which: Text): Boolean
    begin
        exit(Rec.Find(Which));
    end;

    var
        ShowAllCodeunits: Boolean;
}