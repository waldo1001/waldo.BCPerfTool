query 62204 "No Decent SumIndex WPT"
{
    QueryType = Normal;
    caption = 'Just some grouping on Color';
    OrderBy = ascending(Color);

    elements
    {
        dataitem(Just_Some_Table; "Just Some Table WPT")
        {
            column(Color; Color) { }

            column(Quantity; Quantity)
            {
                Method = Sum;
            }
            column(Count)
            {
                method = count;
            }
        }
    }
}