codeunit 62233 "Complicated Calc Meth WPT"
{
    trigger OnRun()
    var
        Result: Dictionary of [Text, Text];
        Color: Text;
    begin
        page.GetBackgroundParameters().get('Color', Color);

        Result.Add('ComplicatedCalculationResult', Format(ComplicatedCalculation(CopyStr(Color, 1, 10))));

        Page.SetBackgroundTaskResult(Result);
    end;

    procedure ComplicatedCalculation(Color: Code[10]) Total: Decimal
    var
        JustSomeTable: Record "Just Some Table WPT";
    begin
        sleep(1000); //Just to prove the point ;-)

        JustSomeTable.SetCurrentKey(Color);
        JustSomeTable.SetRange(Color, Color);

        if JustSomeTable.FindSet() then
            repeat
                Total += JustSomeTable.Quantity + random(100);
            until JustSomeTable.Next() < 1;
    end;

}
