namespace waldo.BCPerftool.Config;

using System.Security.AccessControl;

permissionsetextension 62101 "D365FULLACCESS Ext WPT" extends "D365 FULL ACCESS"
{
    IncludedPermissionSets = "PerfTool Admin WPT";
}