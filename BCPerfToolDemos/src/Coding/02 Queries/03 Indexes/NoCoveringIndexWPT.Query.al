query 62206 "No CoveringIndex WPT"
{
    QueryType = Normal;

    elements
    {
        dataitem(Just_Some_Colors_WPT; "Just Some Colors WPT")
        {
            column(Color; Color) { }
            dataitem(Just_Some_Table_WPT; "Just Some Table WPT")
            {
                DataItemLink = Color = Just_Some_Colors_WPT.Color;

                column("Message"; Message) { }
            }
        }
    }
}