table 62206 "Just Some Cue Table WPT"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'MyField';
            DataClassification = CustomerContent;
        }

        field(10; CountFlowField; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Just Some Table WPT");
        }

#pragma warning disable AA0232
        field(20; SumFlowField; Decimal)
#pragma warning restore AA0232
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Just Some Table WPT".Quantity);
        }

    }

    keys
    {
        key(PK; "Primary Key")
        {
            Clustered = true;
        }
    }

    procedure CalculateSomethingComplex(Color: Code[10]): Decimal
    var
        ComplicatedCalculationMeth: Codeunit "Complicated Calc Meth WPT";
    begin
        exit(ComplicatedCalculationMeth.ComplicatedCalculation(Color));
    end;
}