codeunit 62208 "Grouping - Query WPT"
{
    trigger OnRun()
    var
        GroupingResult: Record "GroupingResult WPT";
        GroupingJustSomeTable: Query "GroupingJustSomeTable WPT";
    begin
        GroupingResult.DeleteAll();

        GroupingJustSomeTable.Open();

        while GroupingJustSomeTable.Read() do begin
            GroupingResult.Init();
            GroupingResult.Color := GroupingJustSomeTable.Color;
            GroupingResult.Quantity := GroupingJustSomeTable.Quantity;
            GroupingResult.Count := GroupingJustSomeTable.Count;
            GroupingResult.insert(false);
        end;

        GroupingJustSomeTable.Close();

        page.Run(page::"GroupingResult List WPT");
    end;
}