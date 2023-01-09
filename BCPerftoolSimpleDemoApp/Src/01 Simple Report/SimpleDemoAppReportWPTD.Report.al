report 62401 "Simple DemoAppReport WPTD"
{
    Caption = 'Simple DemoApp Report';
    UsageCategory = Administration;
    ApplicationArea = All;
    DefaultRenderingLayout = DemoLayout;

    dataset
    {
        dataitem("Demo Table WPTD"; "Demo Table WPTD")
        {
            column(Color_DemoTableWPTD; Color)
            {
            }
            column(Color2_DemoTableWPTD; "Color 2")
            {
            }
            column(DateCreated_DemoTableWPTD; DateCreated)
            {
            }
            column(EntryNo_DemoTableWPTD; "Entry No.")
            {
            }
            column(LastTrigger_DemoTableWPTD; LastTrigger)
            {
            }
            column(Message_DemoTableWPTD; Message)
            {
            }
            column(Message2_DemoTableWPTD; "Message 2")
            {
            }
            column(Quantity_DemoTableWPTD; Quantity)
            {
            }
            column(SystemCreatedAt_DemoTableWPTD; SystemCreatedAt)
            {
            }
            column(SystemCreatedBy_DemoTableWPTD; SystemCreatedBy)
            {
            }
            column(SystemId_DemoTableWPTD; SystemId)
            {
            }
            column(SystemModifiedAt_DemoTableWPTD; SystemModifiedAt)
            {
            }
            column(SystemModifiedBy_DemoTableWPTD; SystemModifiedBy)
            {
            }
        }
    }

    rendering
    {
        layout("DemoLayout")
        {
            Type = Word;
            LayoutFile = './Src/01 Simple Report/DemoLayout.docx';
        }
    }
}