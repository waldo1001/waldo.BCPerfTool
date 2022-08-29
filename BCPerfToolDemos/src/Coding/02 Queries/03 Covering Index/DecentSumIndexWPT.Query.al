query 62205 "Decent SumIndex WPT"
{
    QueryType = Normal;
    caption = 'Just some grouping on Color';
    OrderBy = ascending(Color_2);

    elements
    {
        dataitem(Just_Some_Table; "Just Some Table WPT")
        {
            column(Color_2; "Color 2") { }

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