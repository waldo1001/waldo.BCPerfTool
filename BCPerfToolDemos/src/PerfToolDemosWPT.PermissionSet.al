permissionset 62201 "PerfTool Demos WPT"
{
    Assignable = true;
    IncludedPermissionSets = "PerfTool Admin WPT";
    Permissions =
        tabledata "Just Some Country WPT" = RIMD,
        tabledata "Just Some Table WPT" = RIMD,
        tabledata "Just Some Colors WPT" = RIMD,
        tabledata "GroupingResult WPT" = RIMD,
        tabledata "EmptyTable WPT" = RIMD,
        tabledata "Just Some Cue Table WPT" = RIMD,
        tabledata "Table With AutoIncrement WPT" = RIMD,
        tabledata "Table WithNo AutoIncrement WPT" = RIMD;
}