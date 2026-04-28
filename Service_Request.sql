CREATE TABLE service_requests (
    ticket_id VARCHAR(20),
    device_name VARCHAR(100),
    issue_type VARCHAR(100),
    priority VARCHAR(20),
    status VARCHAR(30),
    created_date DATE,
    closed_date TIMESTAMP,
    assigned_engineer VARCHAR(50),
    sla_hours INT,
    resolution_hours INT,
    customer_location VARCHAR(50)
);


Select * from service_request_dashboard;

Select count(*) ticket_id from service_requests;

Select status,count(*) as request_status
from service_requests
group by status;

Select status,priority,count(*) as request_status
from service_requests
group by priority,status;

SELECT COUNT(*) AS sla_breach_count
FROM service_requests
WHERE resolution_hours > sla_hours;

SELECT assigned_engineer,
       COUNT(*) AS total_requests,
       ROUND(AVG(resolution_hours), 2) AS avg_resolution_hours
FROM service_requests
WHERE resolution_hours IS NOT NULL
GROUP BY assigned_engineer
ORDER BY total_requests DESC;

CREATE VIEW service_request_dashboard AS
SELECT
    ticket_id,
    device_name,
    issue_type,
    priority,
    status,
    created_date,
    closed_date,
    assigned_engineer,
    sla_hours,
    resolution_hours,
    customer_location,
    CASE
        WHEN resolution_hours > sla_hours THEN 'SLA Breached'
        ELSE 'Within SLA'
    END AS sla_status
	TO_CHAR(created_date, 'YYYY-MM') AS month_year
FROM service_requests;

CREATE OR REPLACE VIEW service_request_dashboard AS
SELECT
    ticket_id,
    device_name,
    issue_type,
    priority,
    status,
    created_date,
    closed_date,
    assigned_engineer,
    sla_hours,
    resolution_hours,
    customer_location,
    CASE
        WHEN resolution_hours > sla_hours THEN 'SLA Breached'
        ELSE 'Within SLA'
    END AS sla_status,
    TO_CHAR(created_date, 'YYYY-MM') AS month_year
FROM service_requests;

