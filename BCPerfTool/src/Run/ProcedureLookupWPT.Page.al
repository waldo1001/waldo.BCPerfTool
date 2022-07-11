page 62109 "Procedure Lookup WPT"
{
    Caption = 'Procedure Lookup';
    PageType = List;
    SourceTable = "Procedure Buffer WPT";
    SourceTableTemporary = true;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Procedure"; Rec."Procedure")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Procedure field.';
                }
            }
        }
    }
}
