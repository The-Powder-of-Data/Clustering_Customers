.tables


SELECT * FROM df_customer
LIMIT 5;

SELECT COUNT(*) from df_customer;


/* connect to the df_accts table and show count of accounts per customer */
SELECT df_customer.cust_id, COUNT(df_accts.acct_type), count(df_accts.acct_nbr)  FROM df_customer
    JOIN df_accts USING ('cust_id')

GROUP By df_customer.cust_id 
ORDER BY count(df_accts.acct_nbr) DESC

LIMIT 5;
/* 3 accounts is max per customer in this dataset*/



/* lets get the customer numbers that have savings accounts and thie ac numbers*/
SELECT count(*) FROM df_savings
LIMIT 5;
/* 421 rows */

/* selecting only where accounts are active */ 
SELECT count(*) FROM df_savings

WHERE account_active LIKE '%Y%'
LIMIT 5;
/* 375 rows */

/* final savings output for python */ 
SELECT cust_id, minimum_balance, account_active, acct_start_date, ending_balance FROM df_savings
WHERE account_active LIKE '%Y%'
ORDER BY ending_balance DESC
LIMIT 5;

SELECT * FROM df_customer
LIMIT 5;


.tables

/* lets look at the credit table */ 
SELECT * FROM df_credit
LIMIT 5;
/* 468 rows*/

SELECT cust_id, credit_limit, credit_rating, account_active as cr_acct, acct_start_date, ending_balance FROM df_credit
WHERE account_active LIKE '%Y%'
LIMIT 5;
/* 423 rows */

SELECT DISTINCT credit_rating, avg(credit_limit) FROM df_credit
GROUP BY credit_rating

ORDER BY credit_rating DESC
LIMIT 10;
/* there doesnt seem to be relation between credit_rating and limit?*/

/* lets look at the transaction table */
SELECT * FROM df_transactions
limit 5;
/* 77580 rows */

SELECT acct_nbr, count(tran_amt), avg(tran_amt), sum(tran_amt) FROM df_transactions
GROUP BY acct_nbr
LIMIT 5;

SELECT * FROM df_accts
WHERE acct_nbr IN ('13624802', '13624803', '13624842')
;

/* now using cleaned data with columns for month/day */
SELECT * FROM df_trans_clean
LIMIT 5;

/* use this to do a windows function to pull out stuff */
SELECT acct_nbr, tran_month, count(tran_amt) as m_t_count, avg(tran_amt) as m_t_avg, sum(tran_amt) as m_t_sum 
FROM df_trans_clean
GROUP BY acct_nbr, tran_month
LIMIT 20;


/* out put we need for part 1 of the acct number table */
SELECT acct_nbr, AVG(m_t_count) AS avg_month_count, AVG(m_t_sum) AS avg_month_amt
FROM (
    SELECT acct_nbr, tran_month, count(tran_amt) as m_t_count, avg(tran_amt) as m_t_avg, sum(tran_amt) as m_t_sum 
    FROM df_trans_clean
    GROUP BY acct_nbr, tran_month
)
GROUP BY acct_nbr
;

/* part 2 of table, will show total spend and total count.... should make a ratio as well*/ 
SELECT acct_nbr, count(tran_amt) as total_count, avg(tran_amt) as total_avg, sum(tran_amt) as total_sum 
FROM df_trans_clean
GROUP BY acct_nbr
;



/* lets join the tables */

SELECT  t1.acct_nbr, avg_month_count, avg_month_amt
FROM (

    SELECT acct_nbr, AVG(m_t_count) AS avg_month_count, AVG(m_t_sum) AS avg_month_amt
    FROM (
        SELECT acct_nbr, tran_month, count(tran_amt) as m_t_count, avg(tran_amt) as m_t_avg, sum(tran_amt) as m_t_sum 
        FROM df_trans_clean
        GROUP BY acct_nbr, tran_month
        ) as t1
GROUP BY acct_nbr
)

;

.tables

SELECT * FROM view_t_metrics
limit 10;

/*1409 rows to start */
SELECT * FROM df_accts
    JOIN view_t_metrics USING ('acct_nbr')
LIMIT 5;
/*after join shows 1397 rows */

SELECT cust_id, count(acct_nbr), avg(t_tot_count), avg(t_tot_avg), avg(t_tot_sum), avg(t_m_av_count), avg(t_m_av_amt)  FROM df_accts
    JOIN view_t_metrics USING ('acct_nbr')
GROUP BY cust_id
;
/* 664 customers */

SELECT COUNT(*) FROM df_customer;

.tables

SELECT cust_id FROM temp_cust_nans;

SELECT count(DISTINCT cust_id) FROM df_accts
LIMIT 5;
/* 665 rows for unique cust_id */ 

SELECT * FROM df_accts
WHERE cust_id IN (
    SELECT cust_id FROM temp_cust_nans  
)
;
