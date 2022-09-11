-- Last executed queries
SELECT TOP 10 qt.query_sql_text,
    q.query_id,
    qt.query_text_id,
    p.plan_id,
    rs.last_execution_time
FROM sys.query_store_query_text AS qt
    JOIN sys.query_store_query AS q ON qt.query_text_id = q.query_text_id
    JOIN sys.query_store_plan AS p ON q.query_id = p.query_id
    JOIN sys.query_store_runtime_stats AS rs ON p.plan_id = rs.plan_id
where query_sql_text like '%Just_Some%'
    or query_sql_text like '%Empty%'
ORDER BY rs.last_execution_time DESC;
-- Number of executions for each query?
SELECT q.query_id,
    qt.query_text_id,
    qt.query_sql_text,
    SUM(rs.count_executions) AS total_execution_count
FROM sys.query_store_query_text AS qt
    JOIN sys.query_store_query AS q ON qt.query_text_id = q.query_text_id
    JOIN sys.query_store_plan AS p ON q.query_id = p.query_id
    JOIN sys.query_store_runtime_stats AS rs ON p.plan_id = rs.plan_id
where query_sql_text like '%Just_Some%'
    or query_sql_text like '%Empty%'
GROUP BY q.query_id,
    qt.query_text_id,
    qt.query_sql_text
ORDER BY total_execution_count DESC;
-- The number of queries with the longest average execution time within last hour?
SELECT TOP 10 rs.avg_duration,
    qt.query_sql_text,
    q.query_id,
    qt.query_text_id,
    p.plan_id,
    GETUTCDATE() AS CurrentUTCTime,
    rs.last_execution_time
FROM sys.query_store_query_text AS qt
    JOIN sys.query_store_query AS q ON qt.query_text_id = q.query_text_id
    JOIN sys.query_store_plan AS p ON q.query_id = p.query_id
    JOIN sys.query_store_runtime_stats AS rs ON p.plan_id = rs.plan_id
WHERE rs.last_execution_time > DATEADD(hour, -1, GETUTCDATE()) -- and(
    --     query_sql_text like '%Just_Some%'
    --     or query_sql_text like '%Empty%'
    -- )
ORDER BY rs.avg_duration DESC;
-- Queries that recently regressed in performance
SELECT qt.query_sql_text,
    q.query_id,
    qt.query_text_id,
    rs1.runtime_stats_id AS runtime_stats_id_1,
    rsi1.start_time AS interval_1,
    p1.plan_id AS plan_1,
    rs1.avg_duration AS avg_duration_1,
    rs2.avg_duration AS avg_duration_2,
    p2.plan_id AS plan_2,
    rsi2.start_time AS interval_2,
    rs2.runtime_stats_id AS runtime_stats_id_2
FROM sys.query_store_query_text AS qt
    JOIN sys.query_store_query AS q ON qt.query_text_id = q.query_text_id
    JOIN sys.query_store_plan AS p1 ON q.query_id = p1.query_id
    JOIN sys.query_store_runtime_stats AS rs1 ON p1.plan_id = rs1.plan_id
    JOIN sys.query_store_runtime_stats_interval AS rsi1 ON rsi1.runtime_stats_interval_id = rs1.runtime_stats_interval_id
    JOIN sys.query_store_plan AS p2 ON q.query_id = p2.query_id
    JOIN sys.query_store_runtime_stats AS rs2 ON p2.plan_id = rs2.plan_id
    JOIN sys.query_store_runtime_stats_interval AS rsi2 ON rsi2.runtime_stats_interval_id = rs2.runtime_stats_interval_id
WHERE rsi1.start_time > DATEADD(hour, -48, GETUTCDATE())
    AND rsi2.start_time > rsi1.start_time
    AND p1.plan_id <> p2.plan_id
    AND rs2.avg_duration > 2 * rs1.avg_duration
ORDER BY q.query_id,
    rsi1.start_time,
    rsi2.start_time;
-- Queries that recently regressed in performance (comparing recent vs. history execution)? 
--- "Recent" workload - last 1 hour
DECLARE @recent_start_time datetimeoffset;
DECLARE @recent_end_time datetimeoffset;
SET @recent_start_time = DATEADD(hour, -1, SYSUTCDATETIME());
SET @recent_end_time = SYSUTCDATETIME();
--- "History" workload
DECLARE @history_start_time datetimeoffset;
DECLARE @history_end_time datetimeoffset;
SET @history_start_time = DATEADD(hour, -24, SYSUTCDATETIME());
SET @history_end_time = SYSUTCDATETIME();
WITH hist AS (
    SELECT p.query_id query_id,
        ROUND(
            ROUND(
                CONVERT(
                    FLOAT,
                    SUM(rs.avg_duration * rs.count_executions)
                ) * 0.001,
                2
            ),
            2
        ) AS total_duration,
        SUM(rs.count_executions) AS count_executions,
        COUNT(distinct p.plan_id) AS num_plans
    FROM sys.query_store_runtime_stats AS rs
        JOIN sys.query_store_plan AS p ON p.plan_id = rs.plan_id
    WHERE (
            rs.first_execution_time >= @history_start_time
            AND rs.last_execution_time < @history_end_time
        )
        OR (
            rs.first_execution_time <= @history_start_time
            AND rs.last_execution_time > @history_start_time
        )
        OR (
            rs.first_execution_time <= @history_end_time
            AND rs.last_execution_time > @history_end_time
        )
    GROUP BY p.query_id
),
recent AS (
    SELECT p.query_id query_id,
        ROUND(
            ROUND(
                CONVERT(
                    FLOAT,
                    SUM(rs.avg_duration * rs.count_executions)
                ) * 0.001,
                2
            ),
            2
        ) AS total_duration,
        SUM(rs.count_executions) AS count_executions,
        COUNT(distinct p.plan_id) AS num_plans
    FROM sys.query_store_runtime_stats AS rs
        JOIN sys.query_store_plan AS p ON p.plan_id = rs.plan_id
    WHERE (
            rs.first_execution_time >= @recent_start_time
            AND rs.last_execution_time < @recent_end_time
        )
        OR (
            rs.first_execution_time <= @recent_start_time
            AND rs.last_execution_time > @recent_start_time
        )
        OR (
            rs.first_execution_time <= @recent_end_time
            AND rs.last_execution_time > @recent_end_time
        )
    GROUP BY p.query_id
)
SELECT results.query_id AS query_id,
    results.query_text AS query_text,
    results.additional_duration_workload AS additional_duration_workload,
    results.total_duration_recent AS total_duration_recent,
    results.total_duration_hist AS total_duration_hist,
    ISNULL(results.count_executions_recent, 0) AS count_executions_recent,
    ISNULL(results.count_executions_hist, 0) AS count_executions_hist
FROM (
        SELECT hist.query_id AS query_id,
            qt.query_sql_text AS query_text,
            ROUND(
                CONVERT(
                    float,
                    recent.total_duration / recent.count_executions - hist.total_duration / hist.count_executions
                ) *(recent.count_executions),
                2
            ) AS additional_duration_workload,
            ROUND(recent.total_duration, 2) AS total_duration_recent,
            ROUND(hist.total_duration, 2) AS total_duration_hist,
            recent.count_executions AS count_executions_recent,
            hist.count_executions AS count_executions_hist
        FROM hist
            JOIN recent ON hist.query_id = recent.query_id
            JOIN sys.query_store_query AS q ON q.query_id = hist.query_id
            JOIN sys.query_store_query_text AS qt ON q.query_text_id = qt.query_text_id
    ) AS results
WHERE additional_duration_workload > 0
ORDER BY additional_duration_workload DESC OPTION (
        MERGE
        JOIN
    );