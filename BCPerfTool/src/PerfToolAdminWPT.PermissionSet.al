namespace waldo.BCPerftool.Config;

using waldo.BCPerftool.Suites;
using waldo.BCPerftool.Analytics;

permissionset 62100 "PerfTool Admin WPT"
{
    Assignable = true;
    Permissions =
        tabledata "PerfTool Suite Header WPT" = RIMD,
        tabledata "PerfTool Suite Line WPT" = RIMD,
        tabledata "PerfTool Group WPT" = RIMD,
        tabledata "PerfTool Log Entry WPT" = RIMD,
        tabledata "PerfTool Setup WPT" = RIMD;
}