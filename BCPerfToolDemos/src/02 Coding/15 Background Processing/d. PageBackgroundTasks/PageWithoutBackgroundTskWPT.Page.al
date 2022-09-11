page 62209 "Page Without BackgroundTsk WPT"
{
    Caption = 'Page Without BackgroundTsk';
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Just Some Cue Table WPT";

    layout
    {
        area(Content)
        {
            cuegroup(totals)
            {
                field(CountFlowField; Rec.CountFlowField)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the CountFlowField field.';
                }
                field(SumFlowField; Rec.SumFlowField)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the SumFlowField field.';
                }
                field(SomethingComplex; SomethingComplex)
                {
                    Caption = 'ComplexCalc';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the ComplexCalc field.';
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        if not Rec.get() then begin
            Rec.init();
            Rec.insert();
        end;
    end;

    trigger OnAfterGetCurrRecord()
    begin
        SomethingComplex := Rec.CalculateSomethingComplex('Red');
    end;

    var
        SomethingComplex: Decimal;
}