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
#pragma warning disable AA0232
        field(2; TotalQuantity; Decimal)
#pragma warning restore AA0232
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