pageextension 62203 "CustomerList Ext WPT" extends "Customer List"
{
    layout
    {
        addlast(Control1)
        {
            field("TotallyUselessField WPT"; TotallyUseless)
            {
                ApplicationArea = All;
                Caption = 'Totally Useless';
                ToolTip = 'Specifies the value of the Totally Useless field.';
            }
        }

        modify("Phone No.")
        {
            Visible = false;
        }
    }

    var
        TotallyUseless: Text;

    trigger OnOpenPage()
    begin
        Codeunit.Run(Codeunit::"Some Business Logic WPT");
    end;

    trigger OnAfterGetRecord()
    begin
        TotallyUseless := '';
        Rec.CalcTotalSalesWPT();
    end;

}