table 62203 "Just Some Country WPT"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Code"; Code[10])
        {
            Caption = 'Code';
            DataClassification = CustomerContent;
        }
        field(2; Name; Text[100])
        {
            Caption = 'Name';
        }
#pragma warning disable AA0232
        field(3; TotalQuantity; Decimal)
#pragma warning restore AA0232
        {
            Caption = 'Total Qty.';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum("Just Some Table WPT".Quantity where(Country = field(Code)));
        }
        field(4; TotalQuantity2; Decimal)
        {
            Caption = 'Total Qty. 2';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum("Just Some Table WPT".Quantity where("Country 2" = field(Code)));
        }
        field(5; TotalQuantity3; Decimal)
        {
            Caption = 'Total Qty. 3';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum("Just Some Table WPT".Quantity where("Country 3" = field(Code)));
        }
        field(6; "Message"; Text[100])
        {
            DataClassification = CustomerContent;

        }
    }
}