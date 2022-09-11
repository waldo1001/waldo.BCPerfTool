-- Top 20 most costly queries 
SELECT TOP 20 qs.sql_handle,
    qs.execution_count,
    qs.total_worker_time AS Total_CPU,
    total_CPU_inSeconds = --Converted from microseconds
    qs.total_worker_time / 1000000,
    average_CPU_inSeconds = --Converted from microseconds
    (qs.total_worker_time / 1000000) / qs.execution_count,
    qs.total_elapsed_time,
    total_elapsed_time_inSeconds = --Converted from microseconds
    qs.total_elapsed_time / 1000000,
    st.text,
    qp.query_plan
FROM sys.dm_exec_query_stats AS qs
    CROSS APPLY sys.dm_exec_sql_text(qs.sql_handle) AS st
    CROSS apply sys.dm_exec_query_plan (qs.plan_handle) AS qp
ORDER BY qs.total_worker_time DESC;
-- Problematic queries
SELECT TOP 20 total_worker_time / execution_count AS Avg_CPU_Time,
    Execution_count,
    total_elapsed_time / execution_count as AVG_Run_Time,
    total_elapsed_time,
    (
        SELECT SUBSTRING(
                text,
                statement_start_offset / 2 + 1,
                statement_end_offset
            )
        FROM sys.dm_exec_sql_text(sql_handle)
    ) AS Query_Text
FROM sys.dm_exec_query_stats
ORDER BY Avg_CPU_Time DESC;
-- rarely used indexes
SELECT objects.name AS Table_name,
    indexes.name AS Index_name,
    dm_db_index_usage_stats.user_seeks,
    dm_db_index_usage_stats.user_scans,
    dm_db_index_usage_stats.user_updates
FROM sys.dm_db_index_usage_stats
    INNER JOIN sys.objects ON dm_db_index_usage_stats.OBJECT_ID = objects.OBJECT_ID
    INNER JOIN sys.indexes ON indexes.index_id = dm_db_index_usage_stats.index_id
    AND dm_db_index_usage_stats.OBJECT_ID = indexes.OBJECT_ID
WHERE dm_db_index_usage_stats.user_lookups = 0
    AND dm_db_index_usage_stats.user_seeks = 0
    AND dm_db_index_usage_stats.user_scans = 0
ORDER BY dm_db_index_usage_stats.user_updates DESC;
-- missing indexes
select *
from sys.dm_db_missing_index_details;
-- missing indexes
SELECT mig.*,
    statement AS table_name,
    column_id,
    column_name,
    column_usage
FROM sys.dm_db_missing_index_details AS mid
    CROSS APPLY sys.dm_db_missing_index_columns (mid.index_handle)
    INNER JOIN sys.dm_db_missing_index_groups AS mig ON mig.index_handle = mid.index_handle
ORDER BY mig.index_group_handle,
    mig.index_handle,
    column_id;