query 62202 "GroupingJustSomeTable WPT"
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