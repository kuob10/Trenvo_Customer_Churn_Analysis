--Monthly Rev Churn Rate --
WITH monthly_revenue AS (
    SELECT -- group all subscrption by month start date --
        DATE_TRUNC('month', start_date) AS cohort_month,
        SUM(monthly_price) AS revenue
    FROM subscriptions
    GROUP BY 1
),

churned_revenue AS ( -- rev from  users that cancelled --
    SELECT 
        DATE_TRUNC('month', end_date) AS churn_month,
        SUM(monthly_price) AS churned_revenue
    FROM subscriptions
    WHERE end_date IS NOT NULL 
    GROUP BY 1
)

SELECT -- calculating churn rate -- 
    m.cohort_month,
    m.revenue,
    COALESCE(c.churned_revenue, 0) AS churned_revenue,
    ROUND((COALESCE(c.churned_revenue, 0)/ m.revenue)::numeric,4) AS churn_rate
FROM monthly_revenue m
LEFT JOIN churned_revenue c
    ON m.cohort_month = c.churn_month
ORDER BY m.cohort_month;

-- Churn Rate by Acquisition Channel -- 
WITH churn_customer AS ( -- finding amount of churned users by using subscription date --
	SELECT u.acquisition_channel,
		COUNT(s.user_id) AS total_users,
		COUNT(CASE WHEN s.end_date IS NOT NULL THEN 1 END) AS churned_users -- making binary and counting users with end date --
	FROM subscriptions AS s
	INNER JOIN users AS U ON s.user_id = u.user_id
	GROUP BY u.acquisition_channel
)
SELECT
	acquisition_channel,
	total_users,
	churned_users,
	ROUND(churned_users * 100.0 / total_users, 1) AS churn_rate_pct -- .0 makes sure sql doesnt truncate and produce decimal --
FROM churn_customer
ORDER BY churn_rate_pct DESC;

-- LTV by acquisition channel --
WITH customer_lt AS (
	SELECT user_id, -- monthly_price * by month, using current date if end_date = null --
		SUM(monthly_price * EXTRACT(MONTH FROM AGE(COALESCE(end_date, CURRENT_DATE),
	start_date))
	) AS lt_rev
	FROM subscriptions
	GROUP BY user_id
	)
SELECT u.acquisition_channel,
	ROUND(AVG(c.lt_rev)::numeric,2) AS avg_ltv -- calc avg_ltv --
FROM customer_lt AS c
JOIN users AS u
	ON c.user_id = u.user_id
GROUP BY u.acquisition_channel
ORDER BY avg_ltv DESC;

-- Activities of Churned Users --
WITH churned_users AS (
    SELECT user_id, -- grabbing all user_id with subscription end_date --
        end_date
  FROM subscriptions
  WHERE end_date IS NOT NULL
),
last_30day_activity AS (
    SELECT c.user_id,
        COUNT(e.event_id) AS events_last_30
    FROM churned_users c
    LEFT JOIN events e
        ON c.user_id = e.user_id  -- counting events(clicks, logics etc) 30 days leading up to subscription cancelation --
        AND e.event_timestamp BETWEEN c.end_date - INTERVAL '30 days' AND c.end_date        
    GROUP BY c.user_id
)
SELECT -- creating activity buckets based on  number of events --
    user_id,
    events_last_30,
    CASE
        WHEN events_last_30 <= 1 THEN 'Inactive'
        WHEN events_last_30 <= 3 THEN 'Moderate'
        ELSE 'Highly Active'
    END AS activity_bucket
FROM last_30day_activity
ORDER BY events_last_30;
