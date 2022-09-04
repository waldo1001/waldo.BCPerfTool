#pragma warning disable AA0232
table 62204 "Just Some Colors WPT"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; Color; Code[10])
        {
            Caption = 'Color';
            DataClassification = CustomerContent;
        }

        field(2; TotalQuantity; Decimal)
        {
            Caption = 'Total Qty.';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum("Just Some Table WPT".Quantity where(Color = field(Color)));
        }
        field(3; TotalQuantity2; Decimal)
        {
            Caption = 'Total Qty. 2';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum("Just Some Table WPT".Quantity where("Color 2" = field(Color)));
        }
    }

    keys
    {
        key(PK; "Color")
        {
            Clustered = true;
        }
    }

}