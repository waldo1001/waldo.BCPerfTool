codeunit 62209 "Grouping - Skip Method WPT"
{
    trigger OnRun()
    var
        GroupingResult: Record "GroupingResult WPT";
        JustSomeTable: Record "Just Some Table WPT";
    begin
        GroupingResult.DeleteAll();

        JustSomeTable.SetCurrentKey(Color);

        JustSomeTable.FindFirst();
        repeat
            JustSomeTable.SetRange("Color", JustSomeTable."Color");
            JustSomeTable.CalcSums(Quantity);

            GroupingResult.Init();
            GroupingResult.Color := JustSomeTable."Color";
            GroupingResult.Quantity := JustSomeTable.Quantity;
            GroupingResult.Count := JustSomeTable.Count;
            GroupingResult.insert(false);

            JustSomeTable.FindLast();

            JustSomeTable.SetRange("Color"); //reset color filter
        until JustSomeTable.Next() = 0;

    end;
}