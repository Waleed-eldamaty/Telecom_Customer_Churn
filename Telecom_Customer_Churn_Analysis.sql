USE telecom;

-- Calculate Churn Percentage

SELECT
COUNT(DISTINCT CASE WHEN Customer_Status='Churned' THEN Customer_ID ELSE NULL END) AS Number_of_Churned_Customers,
COUNT(DISTINCT CASE WHEN Customer_Status IS NOT NULL THEN Customer_ID ELSE NULL END) AS Total_Number_of_Customers,
100*COUNT(DISTINCT CASE WHEN Customer_Status='Churned' THEN Customer_ID ELSE NULL END)/COUNT(DISTINCT CASE WHEN Customer_Status IS NOT NULL THEN Customer_ID ELSE NULL END) AS Churn_Percentage
FROM telecom_customer_churn;

-- Percentage of Churned Customers by Age

SELECT

COUNT(DISTINCT CASE WHEN Age_Grouping= 'Youth' then Customer_ID ELSE NULL END) AS Number_of_Churned_Youth,
100*COUNT(DISTINCT CASE WHEN Age_Grouping= 'Youth' then Customer_ID ELSE NULL END)/COUNT(Customer_ID) AS Churned_Youth_percentage,

COUNT(DISTINCT CASE WHEN Age_Grouping= 'Adults' then Customer_ID ELSE NULL END) AS Number_of_Churned_Adults,
100*COUNT(DISTINCT CASE WHEN Age_Grouping= 'Adults' then Customer_ID ELSE NULL END)/COUNT(Customer_ID) AS Churned_Adults_percentage,

COUNT(DISTINCT CASE WHEN Age_Grouping= 'Seniors' then Customer_ID ELSE NULL END) AS Number_of_Churned_Seniors,
100*COUNT(DISTINCT CASE WHEN Age_Grouping= 'Seniors' then Customer_ID ELSE NULL END)/COUNT(Customer_ID) AS Churned_Seniors_percentage

FROM

(
-- To create age group buckets
SELECT
Customer_ID,
CASE
		WHEN Age BETWEEN '19' AND '24' THEN 'Youth'
		WHEN Age BETWEEN '25' AND '64' THEN 'Adults'
        ELSE  'Seniors'
	END AS Age_Grouping
FROM telecom_customer_churn
WHERE Customer_Status = "Churned") AS Churned_By_Age;

-- Percentage of Churned Customers by Subscription Period

SELECT

COUNT(DISTINCT CASE WHEN Subscription_Grouping= 'New' then Customer_ID ELSE NULL END) AS Number_of_Churned_New,
100*COUNT(DISTINCT CASE WHEN Subscription_Grouping= 'New' then Customer_ID ELSE NULL END)/COUNT(Customer_ID) AS Churned_New_percentage,

COUNT(DISTINCT CASE WHEN Subscription_Grouping= 'Old' then Customer_ID ELSE NULL END) AS Number_of_Churned_Old,
100*COUNT(DISTINCT CASE WHEN Subscription_Grouping= 'Old' then Customer_ID ELSE NULL END)/COUNT(Customer_ID) AS Churned_Old_percentage,

COUNT(DISTINCT CASE WHEN Subscription_Grouping= 'Experienced' then Customer_ID ELSE NULL END) AS Number_of_Churned_Experienced,
100*COUNT(DISTINCT CASE WHEN Subscription_Grouping= 'Experienced' then Customer_ID ELSE NULL END)/COUNT(Customer_ID) AS Churned_Experienced_percentage

FROM

(
-- To create Subscription group buckets
SELECT
Customer_ID,
CASE
		WHEN Tenure_in_Months <= '12' THEN 'New'
		WHEN Tenure_in_Months > '12' AND Tenure_in_Months <= '48' THEN 'Old'
        ELSE  'Experienced'
	END AS Subscription_Grouping
FROM telecom_customer_churn
WHERE Customer_Status = "Churned") AS Churned_By_Subscription;



-- Percentage of Churned Customers by Subscription Period & Age

SELECT

-- For Youth Customers

COUNT(DISTINCT CASE WHEN Subscription_Grouping= 'New' AND Age_Grouping= 'Youth' then Customer_ID ELSE NULL END) AS Number_of_Youth_New,
100* COUNT(DISTINCT CASE WHEN Subscription_Grouping= 'New' AND Age_Grouping= 'Youth' then Customer_ID ELSE NULL END) /COUNT(DISTINCT CASE WHEN Age_Grouping = 'Youth' THEN Customer_ID ELSE NULL END) AS Youth_New_Percentage, -- Divide by Youth Churned Customers not all churned customers

COUNT(DISTINCT CASE WHEN Subscription_Grouping= 'Old' AND Age_Grouping= 'Youth' then Customer_ID ELSE NULL END) AS Number_of_Youth_Old,
100* COUNT(DISTINCT CASE WHEN Subscription_Grouping= 'Old' AND Age_Grouping= 'Youth' then Customer_ID ELSE NULL END) /COUNT(DISTINCT CASE WHEN Age_Grouping = 'Youth' THEN Customer_ID ELSE NULL END) AS Youth_Old_Percentage, -- Divide by Youth Churned Customers not all churned customers

COUNT(DISTINCT CASE WHEN Subscription_Grouping= 'Experienced' AND Age_Grouping= 'Youth' then Customer_ID ELSE NULL END) AS Number_of_Youth_Experienced,
100* COUNT(DISTINCT CASE WHEN Subscription_Grouping= 'Experienced' AND Age_Grouping= 'Youth' then Customer_ID ELSE NULL END) /COUNT(DISTINCT CASE WHEN Age_Grouping = 'Youth' THEN Customer_ID ELSE NULL END) AS Youth_Experienced_Percentage, -- Divide by Youth Churned Customers not all churned customers

-- For Adult Customers

COUNT(DISTINCT CASE WHEN Subscription_Grouping= 'New' AND Age_Grouping= 'Adults' then Customer_ID ELSE NULL END) AS Number_of_Adults_New,
100* COUNT(DISTINCT CASE WHEN Subscription_Grouping= 'New' AND Age_Grouping= 'Adults' then Customer_ID ELSE NULL END) /COUNT(DISTINCT CASE WHEN Age_Grouping = 'Adults' THEN Customer_ID ELSE NULL END) AS Adult_New_Percentage, -- Divide by Adult Churned Customers not all churned customers

COUNT(DISTINCT CASE WHEN Subscription_Grouping= 'Old' AND Age_Grouping= 'Adults' then Customer_ID ELSE NULL END) AS Number_of_Adults_Old,
100* COUNT(DISTINCT CASE WHEN Subscription_Grouping= 'Old' AND Age_Grouping= 'Adults' then Customer_ID ELSE NULL END) /COUNT(DISTINCT CASE WHEN Age_Grouping = 'Adults' THEN Customer_ID ELSE NULL END) AS Adult_Old_Percentage, -- Divide by Adult Churned Customers not all churned customers

COUNT(DISTINCT CASE WHEN Subscription_Grouping= 'Experienced' AND Age_Grouping= 'Adults' then Customer_ID ELSE NULL END) AS Number_of_Adults_Experienced,
100* COUNT(DISTINCT CASE WHEN Subscription_Grouping= 'Experienced' AND Age_Grouping= 'Adults' then Customer_ID ELSE NULL END) /COUNT(DISTINCT CASE WHEN Age_Grouping = 'Adults' THEN Customer_ID ELSE NULL END) AS Adult_Experienced_Percentage, -- Divide by Adult Churned Customers not all churned customers

-- For Senior Customers

COUNT(DISTINCT CASE WHEN Subscription_Grouping= 'New' AND Age_Grouping= 'Seniors' then Customer_ID ELSE NULL END) AS Number_of_Seniors_New,
100* COUNT(DISTINCT CASE WHEN Subscription_Grouping= 'New' AND Age_Grouping= 'Seniors' then Customer_ID ELSE NULL END) /COUNT(DISTINCT CASE WHEN Age_Grouping = 'Seniors' THEN Customer_ID ELSE NULL END) AS Seniors_New_Percentage, -- Divide by Experienced Churned Customers not all churned customers

COUNT(DISTINCT CASE WHEN Subscription_Grouping= 'Old' AND Age_Grouping= 'Seniors' then Customer_ID ELSE NULL END) AS Number_of_Seniors_Old,
100* COUNT(DISTINCT CASE WHEN Subscription_Grouping= 'Old' AND Age_Grouping= 'Seniors' then Customer_ID ELSE NULL END) /COUNT(DISTINCT CASE WHEN Age_Grouping = 'Seniors' THEN Customer_ID ELSE NULL END) AS Seniors_Old_Percentage, -- Divide by Experienced Churned Customers not all churned customers

COUNT(DISTINCT CASE WHEN Subscription_Grouping= 'Experienced' AND Age_Grouping= 'Seniors' then Customer_ID ELSE NULL END) AS Number_of_Seniors_Experienced,
100* COUNT(DISTINCT CASE WHEN Subscription_Grouping= 'Experienced' AND Age_Grouping= 'Seniors' then Customer_ID ELSE NULL END) /COUNT(DISTINCT CASE WHEN Age_Grouping = 'Seniors' THEN Customer_ID ELSE NULL END) AS Seniors_Experienced_Percentage -- Divide by Experienced Churned Customers not all churned customers

FROM
-- Creating Multiple Buckets/Groupings
(

-- To create Subscription group buckets
SELECT
Customer_ID,
Age,
Tenure_in_months,

CASE
WHEN Age BETWEEN '19' AND '24' THEN 'Youth'
WHEN Age BETWEEN '25' AND '64' THEN 'Adults'
WHEN AGE > 64 THEN  'Seniors'
END AS Age_Grouping,

-- To create Age group buckets
CASE
WHEN Tenure_in_Months <= '12' THEN 'New'
WHEN Tenure_in_Months > '12' AND Tenure_in_Months <= '48' THEN 'Old'
WHEN Tenure_in_Months > '48' THEN  'Experienced'
	END AS Subscription_Grouping 
    
FROM telecom_customer_churn
WHERE Customer_Status = "Churned") AS Total_Grouping;




-- Offers Acceptace for Churned Customers

SELECT
Offer,
COUNT(Customer_ID) AS No_of_Churned_Customers
FROM telecom_customer_churn
WHERE Customer_Status = "Churned"
GROUP BY offer
ORDER BY 2 DESC;

-- Offers Acceptace Rate for Churned Customers

SELECT
COUNT(DISTINCT CASE WHEN Customer_Status='Churned' THEN Customer_ID ELSE NULL END) AS Total_Number_of_Churned_Customers,

COUNT(DISTINCT CASE WHEN offer='None' THEN Customer_ID ELSE NULL END) AS Number_of_Churned_Customers_who_rejected_anyoffer,
100 *COUNT(DISTINCT CASE WHEN offer='None' THEN Customer_ID ELSE NULL END)/COUNT(DISTINCT CASE WHEN Customer_Status='Churned' THEN Customer_ID ELSE NULL END) AS No_Offer_Acceptance_Rate,

COUNT(DISTINCT CASE WHEN offer='Offer A' THEN Customer_ID ELSE NULL END)AS Number_of_Churned_Customers_who_accepted_offerA,
100* COUNT(DISTINCT CASE WHEN offer='Offer A' THEN Customer_ID ELSE NULL END)/COUNT(DISTINCT CASE WHEN Customer_Status='Churned' THEN Customer_ID ELSE NULL END) AS OfferA_Acceptance_Rate,

COUNT(DISTINCT CASE WHEN offer='Offer B' THEN Customer_ID ELSE NULL END)AS Number_of_Churned_Customers_who_accepted_offerB,
100* COUNT(DISTINCT CASE WHEN offer='Offer B' THEN Customer_ID ELSE NULL END)/COUNT(DISTINCT CASE WHEN Customer_Status='Churned' THEN Customer_ID ELSE NULL END) AS OfferB_Acceptance_Rate,

COUNT(DISTINCT CASE WHEN offer='Offer C' THEN Customer_ID ELSE NULL END)AS Number_of_Churned_Customers_who_accepted_offerC,
100* COUNT(DISTINCT CASE WHEN offer='Offer C' THEN Customer_ID ELSE NULL END)/COUNT(DISTINCT CASE WHEN Customer_Status='Churned' THEN Customer_ID ELSE NULL END) AS OfferC_Acceptance_Rate,

COUNT(DISTINCT CASE WHEN offer='Offer D' THEN Customer_ID ELSE NULL END)AS Number_of_Churned_Customers_who_accepted_offerD,
100* COUNT(DISTINCT CASE WHEN offer='Offer D' THEN Customer_ID ELSE NULL END)/COUNT(DISTINCT CASE WHEN Customer_Status='Churned' THEN Customer_ID ELSE NULL END) AS OfferD_Acceptance_Rate,

COUNT(DISTINCT CASE WHEN offer='Offer E' THEN Customer_ID ELSE NULL END)AS Number_of_Churned_Customers_who_accepted_offerE,
100* COUNT(DISTINCT CASE WHEN offer='Offer E' THEN Customer_ID ELSE NULL END)/COUNT(DISTINCT CASE WHEN Customer_Status='Churned' THEN Customer_ID ELSE NULL END) AS OfferE_Acceptance_Rate
FROM telecom_customer_churn
WHERE Customer_Status = "Churned";

-- Churn Category for Churned Customers

SELECT
Churn_Category,
COUNT(DISTINCT CASE WHEN Customer_Status='Churned' THEN Customer_ID ELSE NULL END) AS Number_of_Churned_Customers
FROM telecom_customer_churn
GROUP BY Churn_Category
ORDER BY 2 DESC;

-- Churn Category Rate for Churned Customers
SELECT
COUNT(DISTINCT CASE WHEN Customer_Status='Churned' THEN Customer_ID ELSE NULL END) AS Total_Number_of_Churned_Customers,

COUNT(DISTINCT CASE WHEN Churn_Category='Competitor' THEN Customer_ID ELSE NULL END) AS Number_of_Churned_Customers_By_Competitors,
100*COUNT(DISTINCT CASE WHEN Churn_Category='Competitor' THEN Customer_ID ELSE NULL END)/COUNT(DISTINCT CASE WHEN Customer_Status='Churned' THEN Customer_ID ELSE NULL END) AS Churn_Percentage_due_to_Competitor,

COUNT(DISTINCT CASE WHEN Churn_Category='Dissatisfaction' THEN Customer_ID ELSE NULL END) AS Number_of_Churned_Customers_By_Dissatisfaction,
100*COUNT(DISTINCT CASE WHEN Churn_Category='Dissatisfaction' THEN Customer_ID ELSE NULL END)/COUNT(DISTINCT CASE WHEN Customer_Status='Churned' THEN Customer_ID ELSE NULL END) AS Churn_Percentage_due_to_Dissatisfaction,

COUNT(DISTINCT CASE WHEN Churn_Category='Attitude' THEN Customer_ID ELSE NULL END) AS Number_of_Churned_Customers_By_Attitude,
100*COUNT(DISTINCT CASE WHEN Churn_Category='Attitude' THEN Customer_ID ELSE NULL END)/COUNT(DISTINCT CASE WHEN Customer_Status='Churned' THEN Customer_ID ELSE NULL END) AS Churn_Percentage_due_to_Attitude,

COUNT(DISTINCT CASE WHEN Churn_Category='Price' THEN Customer_ID ELSE NULL END) AS Number_of_Churned_Customers_By_Price,
100*COUNT(DISTINCT CASE WHEN Churn_Category='Price' THEN Customer_ID ELSE NULL END)/COUNT(DISTINCT CASE WHEN Customer_Status='Churned' THEN Customer_ID ELSE NULL END) AS Churn_Percentage_due_to_Price,

COUNT(DISTINCT CASE WHEN Churn_Category='Other' THEN Customer_ID ELSE NULL END) AS Number_of_Churned_Customers_By_Other_Reasons,
100*COUNT(DISTINCT CASE WHEN Churn_Category='Other' THEN Customer_ID ELSE NULL END)/COUNT(DISTINCT CASE WHEN Customer_Status='Churned' THEN Customer_ID ELSE NULL END) AS Churn_Percentage_due_to_Other
FROM telecom_customer_churn;


-- Customers Percentage by Churn Category and Age

SELECT

-- For Churned_Customers due to Competitor

COUNT(DISTINCT CASE WHEN Churn_Category= 'Competitor' AND Age_Grouping= 'Youth' then Customer_ID ELSE NULL END) AS Number_of_Youth_Competitor,
100* COUNT(DISTINCT CASE WHEN Churn_Category= 'Competitor' AND Age_Grouping= 'Youth' then Customer_ID ELSE NULL END) /COUNT(DISTINCT CASE WHEN Churn_Category= 'Competitor' THEN Customer_ID ELSE NULL END) AS Youth_Competitor_Percentage, -- Divide by Churned Customers due to Competitor not all churned customers

COUNT(DISTINCT CASE WHEN Churn_Category= 'Competitor' AND Age_Grouping= 'Adults' then Customer_ID ELSE NULL END) AS Number_of_Adults_Competitor,
100* COUNT(DISTINCT CASE WHEN Churn_Category= 'Competitor' AND Age_Grouping= 'Adults' then Customer_ID ELSE NULL END) /COUNT(DISTINCT CASE WHEN Churn_Category= 'Competitor' THEN Customer_ID ELSE NULL END) AS Adults_Competitor_Percentage, -- Divide by Churned Customers due to Competitor not all churned customers

COUNT(DISTINCT CASE WHEN Churn_Category= 'Competitor' AND Age_Grouping= 'Seniors' then Customer_ID ELSE NULL END) AS Number_of_Seniors_Competitor,
100* COUNT(DISTINCT CASE WHEN Churn_Category= 'Competitor' AND Age_Grouping= 'Seniors' then Customer_ID ELSE NULL END) /COUNT(DISTINCT CASE WHEN Churn_Category= 'Competitor' THEN Customer_ID ELSE NULL END) AS Seniors_Competitor_Percentage, -- Divide by Churned Customers due to Competitor not all churned customers


-- For Churned_Customers due to Dissatisfaction

COUNT(DISTINCT CASE WHEN Churn_Category= 'Dissatisfaction' AND Age_Grouping= 'Youth' then Customer_ID ELSE NULL END) AS Number_of_Youth_Dissatisfaction,
100* COUNT(DISTINCT CASE WHEN Churn_Category= 'Dissatisfaction' AND Age_Grouping= 'Youth' then Customer_ID ELSE NULL END) /COUNT(DISTINCT CASE WHEN Churn_Category= 'Dissatisfaction' THEN Customer_ID ELSE NULL END) AS Youth_Dissatisfaction_Percentage, -- Divide by Churned Customers due to Dissatisfaction not all churned customers

COUNT(DISTINCT CASE WHEN Churn_Category= 'Dissatisfaction' AND Age_Grouping= 'Adults' then Customer_ID ELSE NULL END) AS Number_of_Adults_Dissatisfaction,
100* COUNT(DISTINCT CASE WHEN Churn_Category= 'Dissatisfaction' AND Age_Grouping= 'Adults' then Customer_ID ELSE NULL END) /COUNT(DISTINCT CASE WHEN Churn_Category= 'Dissatisfaction' THEN Customer_ID ELSE NULL END) AS Adults_Dissatisfaction_Percentage, -- Divide by Churned Customers due to Dissatisfaction not all churned customers

COUNT(DISTINCT CASE WHEN Churn_Category= 'Dissatisfaction' AND Age_Grouping= 'Seniors' then Customer_ID ELSE NULL END) AS Number_of_Seniors_Dissatisfaction,
100* COUNT(DISTINCT CASE WHEN Churn_Category= 'Dissatisfaction' AND Age_Grouping= 'Seniors' then Customer_ID ELSE NULL END) /COUNT(DISTINCT CASE WHEN Churn_Category= 'Dissatisfaction' THEN Customer_ID ELSE NULL END) AS Seniors_Dissatisfaction_Percentage, -- Divide by Churned Customers due to Dissatisfaction not all churned customers


-- For Churned_Customers due to Attitude

COUNT(DISTINCT CASE WHEN Churn_Category= 'Attitude' AND Age_Grouping= 'Youth' then Customer_ID ELSE NULL END) AS Number_of_Youth_Attitude,
100* COUNT(DISTINCT CASE WHEN Churn_Category= 'Attitude' AND Age_Grouping= 'Youth' then Customer_ID ELSE NULL END) /COUNT(DISTINCT CASE WHEN Churn_Category= 'Attitude' THEN Customer_ID ELSE NULL END) AS Youth_Attitude_Percentage, -- Divide by Churned Customers due to Attitude not all churned customers

COUNT(DISTINCT CASE WHEN Churn_Category= 'Attitude' AND Age_Grouping= 'Adults' then Customer_ID ELSE NULL END) AS Number_of_Adults_Attitude,
100* COUNT(DISTINCT CASE WHEN Churn_Category= 'Attitude' AND Age_Grouping= 'Adults' then Customer_ID ELSE NULL END) /COUNT(DISTINCT CASE WHEN Churn_Category= 'Attitude' THEN Customer_ID ELSE NULL END) AS Adults_Attitude_Percentage, -- Divide by Churned Customers due to Attitude not all churned customers

COUNT(DISTINCT CASE WHEN Churn_Category= 'Attitude' AND Age_Grouping= 'Seniors' then Customer_ID ELSE NULL END) AS Number_of_Seniors_Attitude,
100* COUNT(DISTINCT CASE WHEN Churn_Category= 'Attitude' AND Age_Grouping= 'Seniors' then Customer_ID ELSE NULL END) /COUNT(DISTINCT CASE WHEN Churn_Category= 'Attitude' THEN Customer_ID ELSE NULL END) AS Seniors_Attitude_Percentage, -- Divide by Churned Customers due to Attitude not all churned customers


-- For Churned_Customers due to Price

COUNT(DISTINCT CASE WHEN Churn_Category= 'Price' AND Age_Grouping= 'Youth' then Customer_ID ELSE NULL END) AS Number_of_Youth_Price,
100* COUNT(DISTINCT CASE WHEN Churn_Category= 'Price' AND Age_Grouping= 'Youth' then Customer_ID ELSE NULL END) /COUNT(DISTINCT CASE WHEN Churn_Category= 'Price' THEN Customer_ID ELSE NULL END) AS Youth_Price_Percentage, -- Divide by Churned Customers due to Price not all churned customers

COUNT(DISTINCT CASE WHEN Churn_Category= 'Price' AND Age_Grouping= 'Adults' then Customer_ID ELSE NULL END) AS Number_of_Adults_Price,
100* COUNT(DISTINCT CASE WHEN Churn_Category= 'Price' AND Age_Grouping= 'Adults' then Customer_ID ELSE NULL END) /COUNT(DISTINCT CASE WHEN  Churn_Category= 'Price' THEN Customer_ID ELSE NULL END) AS Adults_Price_Percentage, -- Divide by Churned Customers due to Price not all churned customers

COUNT(DISTINCT CASE WHEN Churn_Category= 'Price' AND Age_Grouping= 'Seniors' then Customer_ID ELSE NULL END) AS Number_of_Seniors_Price,
100* COUNT(DISTINCT CASE WHEN Churn_Category= 'Price' AND Age_Grouping= 'Seniors' then Customer_ID ELSE NULL END) /COUNT(DISTINCT CASE WHEN Churn_Category= 'Price' THEN Customer_ID ELSE NULL END) AS Seniors_Price_Percentage, -- Divide by Churned Customers due to Price not all churned customers


-- For Churned_Customers due to other reasons

COUNT(DISTINCT CASE WHEN Churn_Category= 'Other' AND Age_Grouping= 'Youth' then Customer_ID ELSE NULL END) AS Number_of_Youth_Other,
100* COUNT(DISTINCT CASE WHEN Churn_Category= 'Other' AND Age_Grouping= 'Youth' then Customer_ID ELSE NULL END) /COUNT(DISTINCT CASE WHEN Churn_Category= 'Other' THEN Customer_ID ELSE NULL END) AS Youth_Other_Percentage, -- Divide by Churned Customers due to Other Reasons not all churned customers

COUNT(DISTINCT CASE WHEN Churn_Category= 'Other' AND Age_Grouping= 'Adults' then Customer_ID ELSE NULL END) AS Number_of_Adults_Other,
100* COUNT(DISTINCT CASE WHEN Churn_Category= 'Other' AND Age_Grouping= 'Adults' then Customer_ID ELSE NULL END) /COUNT(DISTINCT CASE WHEN Churn_Category= 'Other' THEN Customer_ID ELSE NULL END) AS Adults_Other_Percentage, -- Divide by Churned Customers due to Other Reasons not all churned customers

COUNT(DISTINCT CASE WHEN Churn_Category= 'Other' AND Age_Grouping= 'Seniors' then Customer_ID ELSE NULL END) AS Number_of_Seniors_Other,
100* COUNT(DISTINCT CASE WHEN Churn_Category= 'Other' AND Age_Grouping= 'Seniors' then Customer_ID ELSE NULL END) /COUNT(DISTINCT CASE WHEN Churn_Category= 'Other' THEN Customer_ID ELSE NULL END) AS Seniors_Other_Percentage -- Divide by Churned Customers due to Other Reasons not all churned customers

FROM
(
-- To create Age group buckets
SELECT
Customer_ID,
Age,
Churn_Category,
CASE
WHEN Age BETWEEN '19' AND '24' THEN 'Youth'
WHEN Age BETWEEN '25' AND '64' THEN 'Adults'
WHEN AGE > 64 THEN  'Seniors'
END AS Age_Grouping
FROM telecom_customer_churn
WHERE Customer_Status = "Churned") AS Total_Grouping;

-- Customers Percentage by Churn Category and Age (Another way to present the solution)

SELECT
Churn_category,
-- For Churned_Customers due to Competitor

COUNT(DISTINCT CASE WHEN Churn_Category= 'Competitor' AND Age_Grouping= 'Youth' then Customer_ID ELSE NULL END) AS Number_of_Youth_Competitor,
100* COUNT(DISTINCT CASE WHEN Churn_Category= 'Competitor' AND Age_Grouping= 'Youth' then Customer_ID ELSE NULL END) /COUNT(DISTINCT CASE WHEN Churn_Category= 'Competitor' THEN Customer_ID ELSE NULL END) AS Youth_Competitor_Percentage, -- Divide by Churned Customers due to Competitor not all churned customers

COUNT(DISTINCT CASE WHEN Churn_Category= 'Competitor' AND Age_Grouping= 'Adults' then Customer_ID ELSE NULL END) AS Number_of_Adults_Competitor,
100* COUNT(DISTINCT CASE WHEN Churn_Category= 'Competitor' AND Age_Grouping= 'Adults' then Customer_ID ELSE NULL END) /COUNT(DISTINCT CASE WHEN Churn_Category= 'Competitor' THEN Customer_ID ELSE NULL END) AS Adults_Competitor_Percentage, -- Divide by Churned Customers due to Competitor not all churned customers

COUNT(DISTINCT CASE WHEN Churn_Category= 'Competitor' AND Age_Grouping= 'Seniors' then Customer_ID ELSE NULL END) AS Number_of_Seniors_Competitor,
100* COUNT(DISTINCT CASE WHEN Churn_Category= 'Competitor' AND Age_Grouping= 'Seniors' then Customer_ID ELSE NULL END) /COUNT(DISTINCT CASE WHEN Churn_Category= 'Competitor' THEN Customer_ID ELSE NULL END) AS Seniors_Competitor_Percentage, -- Divide by Churned Customers due to Competitor not all churned customers


-- For Churned_Customers due to Dissatisfaction

COUNT(DISTINCT CASE WHEN Churn_Category= 'Dissatisfaction' AND Age_Grouping= 'Youth' then Customer_ID ELSE NULL END) AS Number_of_Youth_Dissatisfaction,
100* COUNT(DISTINCT CASE WHEN Churn_Category= 'Dissatisfaction' AND Age_Grouping= 'Youth' then Customer_ID ELSE NULL END) /COUNT(DISTINCT CASE WHEN Churn_Category= 'Dissatisfaction' THEN Customer_ID ELSE NULL END) AS Youth_Dissatisfaction_Percentage, -- Divide by Churned Customers due to Dissatisfaction not all churned customers

COUNT(DISTINCT CASE WHEN Churn_Category= 'Dissatisfaction' AND Age_Grouping= 'Adults' then Customer_ID ELSE NULL END) AS Number_of_Adults_Dissatisfaction,
100* COUNT(DISTINCT CASE WHEN Churn_Category= 'Dissatisfaction' AND Age_Grouping= 'Adults' then Customer_ID ELSE NULL END) /COUNT(DISTINCT CASE WHEN Churn_Category= 'Dissatisfaction' THEN Customer_ID ELSE NULL END) AS Adults_Dissatisfaction_Percentage, -- Divide by Churned Customers due to Dissatisfaction not all churned customers

COUNT(DISTINCT CASE WHEN Churn_Category= 'Dissatisfaction' AND Age_Grouping= 'Seniors' then Customer_ID ELSE NULL END) AS Number_of_Seniors_Dissatisfaction,
100* COUNT(DISTINCT CASE WHEN Churn_Category= 'Dissatisfaction' AND Age_Grouping= 'Seniors' then Customer_ID ELSE NULL END) /COUNT(DISTINCT CASE WHEN Churn_Category= 'Dissatisfaction' THEN Customer_ID ELSE NULL END) AS Seniors_Dissatisfaction_Percentage, -- Divide by Churned Customers due to Dissatisfaction not all churned customers


-- For Churned_Customers due to Attitude

COUNT(DISTINCT CASE WHEN Churn_Category= 'Attitude' AND Age_Grouping= 'Youth' then Customer_ID ELSE NULL END) AS Number_of_Youth_Attitude,
100* COUNT(DISTINCT CASE WHEN Churn_Category= 'Attitude' AND Age_Grouping= 'Youth' then Customer_ID ELSE NULL END) /COUNT(DISTINCT CASE WHEN Churn_Category= 'Attitude' THEN Customer_ID ELSE NULL END) AS Youth_Attitude_Percentage, -- Divide by Churned Customers due to Attitude not all churned customers

COUNT(DISTINCT CASE WHEN Churn_Category= 'Attitude' AND Age_Grouping= 'Adults' then Customer_ID ELSE NULL END) AS Number_of_Adults_Attitude,
100* COUNT(DISTINCT CASE WHEN Churn_Category= 'Attitude' AND Age_Grouping= 'Adults' then Customer_ID ELSE NULL END) /COUNT(DISTINCT CASE WHEN Churn_Category= 'Attitude' THEN Customer_ID ELSE NULL END) AS Adults_Attitude_Percentage, -- Divide by Churned Customers due to Attitude not all churned customers

COUNT(DISTINCT CASE WHEN Churn_Category= 'Attitude' AND Age_Grouping= 'Seniors' then Customer_ID ELSE NULL END) AS Number_of_Seniors_Attitude,
100* COUNT(DISTINCT CASE WHEN Churn_Category= 'Attitude' AND Age_Grouping= 'Seniors' then Customer_ID ELSE NULL END) /COUNT(DISTINCT CASE WHEN Churn_Category= 'Attitude' THEN Customer_ID ELSE NULL END) AS Seniors_Attitude_Percentage, -- Divide by Churned Customers due to Attitude not all churned customers


-- For Churned_Customers due to Price

COUNT(DISTINCT CASE WHEN Churn_Category= 'Price' AND Age_Grouping= 'Youth' then Customer_ID ELSE NULL END) AS Number_of_Youth_Price,
100* COUNT(DISTINCT CASE WHEN Churn_Category= 'Price' AND Age_Grouping= 'Youth' then Customer_ID ELSE NULL END) /COUNT(DISTINCT CASE WHEN Churn_Category= 'Price' THEN Customer_ID ELSE NULL END) AS Youth_Price_Percentage, -- Divide by Churned Customers due to Price not all churned customers

COUNT(DISTINCT CASE WHEN Churn_Category= 'Price' AND Age_Grouping= 'Adults' then Customer_ID ELSE NULL END) AS Number_of_Adults_Price,
100* COUNT(DISTINCT CASE WHEN Churn_Category= 'Price' AND Age_Grouping= 'Adults' then Customer_ID ELSE NULL END) /COUNT(DISTINCT CASE WHEN  Churn_Category= 'Price' THEN Customer_ID ELSE NULL END) AS Adults_Price_Percentage, -- Divide by Churned Customers due to Price not all churned customers

COUNT(DISTINCT CASE WHEN Churn_Category= 'Price' AND Age_Grouping= 'Seniors' then Customer_ID ELSE NULL END) AS Number_of_Seniors_Price,
100* COUNT(DISTINCT CASE WHEN Churn_Category= 'Price' AND Age_Grouping= 'Seniors' then Customer_ID ELSE NULL END) /COUNT(DISTINCT CASE WHEN Churn_Category= 'Price' THEN Customer_ID ELSE NULL END) AS Seniors_Price_Percentage, -- Divide by Churned Customers due to Price not all churned customers


-- For Churned_Customers due to other reasons

COUNT(DISTINCT CASE WHEN Churn_Category= 'Other' AND Age_Grouping= 'Youth' then Customer_ID ELSE NULL END) AS Number_of_Youth_Other,
100* COUNT(DISTINCT CASE WHEN Churn_Category= 'Other' AND Age_Grouping= 'Youth' then Customer_ID ELSE NULL END) /COUNT(DISTINCT CASE WHEN Churn_Category= 'Other' THEN Customer_ID ELSE NULL END) AS Youth_Other_Percentage, -- Divide by Churned Customers due to Other Reasons not all churned customers

COUNT(DISTINCT CASE WHEN Churn_Category= 'Other' AND Age_Grouping= 'Adults' then Customer_ID ELSE NULL END) AS Number_of_Adults_Other,
100* COUNT(DISTINCT CASE WHEN Churn_Category= 'Other' AND Age_Grouping= 'Adults' then Customer_ID ELSE NULL END) /COUNT(DISTINCT CASE WHEN Churn_Category= 'Other' THEN Customer_ID ELSE NULL END) AS Adults_Other_Percentage, -- Divide by Churned Customers due to Other Reasons not all churned customers

COUNT(DISTINCT CASE WHEN Churn_Category= 'Other' AND Age_Grouping= 'Seniors' then Customer_ID ELSE NULL END) AS Number_of_Seniors_Other,
100* COUNT(DISTINCT CASE WHEN Churn_Category= 'Other' AND Age_Grouping= 'Seniors' then Customer_ID ELSE NULL END) /COUNT(DISTINCT CASE WHEN Churn_Category= 'Other' THEN Customer_ID ELSE NULL END) AS Seniors_Other_Percentage -- Divide by Churned Customers due to Other Reasons not all churned customers

FROM
(
-- To create Age group buckets
SELECT
Customer_ID,
Age,
Churn_Category,
CASE
WHEN Age BETWEEN '19' AND '24' THEN 'Youth'
WHEN Age BETWEEN '25' AND '64' THEN 'Adults'
WHEN AGE > 64 THEN  'Seniors'
END AS Age_Grouping
FROM telecom_customer_churn) AS Total_Grouping
GROUP BY Churn_category;

-- Customers Percentage by Churn Category and Subscription Period

SELECT

-- For Churned_Customers due to Competitor

COUNT(DISTINCT CASE WHEN Churn_Category= 'Competitor' AND Subscription_Grouping = 'New' then Customer_ID ELSE NULL END) AS Number_of_New_Competitor,
100* COUNT(DISTINCT CASE WHEN Churn_Category= 'Competitor' AND Subscription_Grouping = 'New' then Customer_ID ELSE NULL END) /COUNT(DISTINCT CASE WHEN Churn_Category= 'Competitor' THEN Customer_ID ELSE NULL END) AS New_Competitor_Percentage, -- Divide by Churned Customers due to Competitor not all churned customers

COUNT(DISTINCT CASE WHEN Churn_Category= 'Competitor' AND Subscription_Grouping = 'Old' then Customer_ID ELSE NULL END) AS Number_of_Old_Competitor,
100* COUNT(DISTINCT CASE WHEN Churn_Category= 'Competitor' AND Subscription_Grouping = 'Old' then Customer_ID ELSE NULL END) /COUNT(DISTINCT CASE WHEN Churn_Category= 'Competitor' THEN Customer_ID ELSE NULL END) AS Old_Competitor_Percentage, -- Divide by Churned Customers due to Competitor not all churned customers

COUNT(DISTINCT CASE WHEN Churn_Category= 'Competitor' AND Subscription_Grouping = 'Experienced' then Customer_ID ELSE NULL END) AS Number_of_Experienced_Competitor,
100* COUNT(DISTINCT CASE WHEN Churn_Category= 'Competitor' AND Subscription_Grouping = 'Experienced' then Customer_ID ELSE NULL END) /COUNT(DISTINCT CASE WHEN Churn_Category= 'Competitor' THEN Customer_ID ELSE NULL END) AS Experienced_Competitor_Percentage, -- Divide by Churned Customers due to Competitor not all churned customers


-- For Churned_Customers due to Dissatisfaction

COUNT(DISTINCT CASE WHEN Churn_Category= 'Dissatisfaction' AND Subscription_Grouping = 'New' then Customer_ID ELSE NULL END) AS Number_of_New_Dissatisfaction,
100* COUNT(DISTINCT CASE WHEN Churn_Category= 'Dissatisfaction' AND Subscription_Grouping = 'New' then Customer_ID ELSE NULL END) /COUNT(DISTINCT CASE WHEN Churn_Category= 'Dissatisfaction' THEN Customer_ID ELSE NULL END) AS New_Dissatisfaction_Percentage, -- Divide by Churned Customers due to Dissatisfaction not all churned customers

COUNT(DISTINCT CASE WHEN Churn_Category= 'Dissatisfaction' AND Subscription_Grouping = 'Old' then Customer_ID ELSE NULL END) AS Number_of_Old_Dissatisfaction,
100* COUNT(DISTINCT CASE WHEN Churn_Category= 'Dissatisfaction' AND Subscription_Grouping = 'Old' then Customer_ID ELSE NULL END) /COUNT(DISTINCT CASE WHEN Churn_Category= 'Dissatisfaction' THEN Customer_ID ELSE NULL END) AS Old_Dissatisfaction_Percentage, -- Divide by Churned Customers due to Dissatisfaction not all churned customers

COUNT(DISTINCT CASE WHEN Churn_Category= 'Dissatisfaction' AND Subscription_Grouping = 'Experienced' then Customer_ID ELSE NULL END) AS Number_of_Experienced_Dissatisfaction,
100* COUNT(DISTINCT CASE WHEN Churn_Category= 'Dissatisfaction' AND Subscription_Grouping = 'Experienced' then Customer_ID ELSE NULL END) /COUNT(DISTINCT CASE WHEN Churn_Category= 'Dissatisfaction' THEN Customer_ID ELSE NULL END) AS Experienced_Dissatisfaction_Percentage, -- Divide by Churned Customers due to Dissatisfaction not all churned customers


-- For Churned_Customers due to Attitude

COUNT(DISTINCT CASE WHEN Churn_Category= 'Attitude' AND Subscription_Grouping = 'New' then Customer_ID ELSE NULL END) AS Number_of_New_Attitude,
100* COUNT(DISTINCT CASE WHEN Churn_Category= 'Attitude' AND Subscription_Grouping = 'New' then Customer_ID ELSE NULL END) /COUNT(DISTINCT CASE WHEN Churn_Category= 'Attitude' THEN Customer_ID ELSE NULL END) AS New_Attitude_Percentage, -- Divide by Churned Customers due to Attitude not all churned customers

COUNT(DISTINCT CASE WHEN Churn_Category= 'Attitude' AND Subscription_Grouping = 'Old' then Customer_ID ELSE NULL END) AS Number_of_Old_Attitude,
100* COUNT(DISTINCT CASE WHEN Churn_Category= 'Attitude' AND Subscription_Grouping = 'Old' then Customer_ID ELSE NULL END) /COUNT(DISTINCT CASE WHEN Churn_Category= 'Attitude' THEN Customer_ID ELSE NULL END) AS Old_Attitude_Percentage, -- Divide by Churned Customers due to Attitude not all churned customers

COUNT(DISTINCT CASE WHEN Churn_Category= 'Attitude' AND Subscription_Grouping = 'Experienced' then Customer_ID ELSE NULL END) AS Number_of_Experienced_Attitude,
100* COUNT(DISTINCT CASE WHEN Churn_Category= 'Attitude' AND Subscription_Grouping = 'Experienced' then Customer_ID ELSE NULL END) /COUNT(DISTINCT CASE WHEN Churn_Category= 'Attitude' THEN Customer_ID ELSE NULL END) AS Experienced_Attitude_Percentage, -- Divide by Churned Customers due to Attitude not all churned customers


-- For Churned_Customers due to Price

COUNT(DISTINCT CASE WHEN Churn_Category= 'Price' AND Subscription_Grouping = 'New' then Customer_ID ELSE NULL END) AS Number_of_New_Price,
100* COUNT(DISTINCT CASE WHEN Churn_Category= 'Price' AND Subscription_Grouping = 'New' then Customer_ID ELSE NULL END) /COUNT(DISTINCT CASE WHEN Churn_Category= 'Price' THEN Customer_ID ELSE NULL END) AS New_Price_Percentage, -- Divide by Churned Customers due to Price not all churned customers

COUNT(DISTINCT CASE WHEN Churn_Category= 'Price' AND Subscription_Grouping = 'Old' then Customer_ID ELSE NULL END) AS Number_of_Old_Price,
100* COUNT(DISTINCT CASE WHEN Churn_Category= 'Price' AND Subscription_Grouping = 'Old' then Customer_ID ELSE NULL END) /COUNT(DISTINCT CASE WHEN  Churn_Category= 'Price' THEN Customer_ID ELSE NULL END) AS Old_Price_Percentage, -- Divide by Churned Customers due to Price not all churned customers

COUNT(DISTINCT CASE WHEN Churn_Category= 'Price' AND Subscription_Grouping = 'Experienced' then Customer_ID ELSE NULL END) AS Number_of_Experienced_Price,
100* COUNT(DISTINCT CASE WHEN Churn_Category= 'Price' AND Subscription_Grouping = 'Experienced' then Customer_ID ELSE NULL END) /COUNT(DISTINCT CASE WHEN Churn_Category= 'Price' THEN Customer_ID ELSE NULL END) AS Experienced_Price_Percentage, -- Divide by Churned Customers due to Price not all churned customers


-- For Churned_Customers due to other reasons

COUNT(DISTINCT CASE WHEN Churn_Category= 'Other' AND Subscription_Grouping = 'New' then Customer_ID ELSE NULL END) AS Number_of_New_Other,
100* COUNT(DISTINCT CASE WHEN Churn_Category= 'Other' AND Subscription_Grouping = 'New' then Customer_ID ELSE NULL END) /COUNT(DISTINCT CASE WHEN Churn_Category= 'Other' THEN Customer_ID ELSE NULL END) AS New_Other_Percentage, -- Divide by Churned Customers due to Other Reasons not all churned customers

COUNT(DISTINCT CASE WHEN Churn_Category= 'Other' AND Subscription_Grouping = 'Old' then Customer_ID ELSE NULL END) AS Number_of_Old_Other,
100* COUNT(DISTINCT CASE WHEN Churn_Category= 'Other' AND Subscription_Grouping = 'Old' then Customer_ID ELSE NULL END) /COUNT(DISTINCT CASE WHEN Churn_Category= 'Other' THEN Customer_ID ELSE NULL END) AS Old_Other_Percentage, -- Divide by Churned Customers due to Other Reasons not all churned customers

COUNT(DISTINCT CASE WHEN Churn_Category= 'Other' AND Subscription_Grouping = 'Experienced' then Customer_ID ELSE NULL END) AS Number_of_Experienced_Other,
100* COUNT(DISTINCT CASE WHEN Churn_Category= 'Other' AND Subscription_Grouping = 'Experienced' then Customer_ID ELSE NULL END) /COUNT(DISTINCT CASE WHEN Churn_Category= 'Other' THEN Customer_ID ELSE NULL END) AS Experienced_Other_Percentage -- Divide by Churned Customers due to Other Reasons not all churned customers

FROM
(
-- To create Age group buckets
SELECT
Customer_ID,
Churn_Category,
Tenure_in_Months,
-- To create Subscription group buckets
CASE
WHEN Tenure_in_Months <= '12' THEN 'New'
WHEN Tenure_in_Months > '12' AND Tenure_in_Months <= '48' THEN 'Old'
WHEN Tenure_in_Months > '48' THEN  'Experienced'
	END AS Subscription_Grouping 
FROM telecom_customer_churn
WHERE Customer_Status = "Churned") AS Total_Grouping;

-- Customers Percentage by Churn Category and Subscription Period (Another Way of Presenting the Solution)

SELECT
Churn_Category,
-- For Churned_Customers due to Competitor

COUNT(DISTINCT CASE WHEN Churn_Category= 'Competitor' AND Subscription_Grouping = 'New' then Customer_ID ELSE NULL END) AS Number_of_New_Competitor,
100* COUNT(DISTINCT CASE WHEN Churn_Category= 'Competitor' AND Subscription_Grouping = 'New' then Customer_ID ELSE NULL END) /COUNT(DISTINCT CASE WHEN Churn_Category= 'Competitor' THEN Customer_ID ELSE NULL END) AS New_Competitor_Percentage, -- Divide by Churned Customers due to Competitor not all churned customers

COUNT(DISTINCT CASE WHEN Churn_Category= 'Competitor' AND Subscription_Grouping = 'Old' then Customer_ID ELSE NULL END) AS Number_of_Old_Competitor,
100* COUNT(DISTINCT CASE WHEN Churn_Category= 'Competitor' AND Subscription_Grouping = 'Old' then Customer_ID ELSE NULL END) /COUNT(DISTINCT CASE WHEN Churn_Category= 'Competitor' THEN Customer_ID ELSE NULL END) AS Old_Competitor_Percentage, -- Divide by Churned Customers due to Competitor not all churned customers

COUNT(DISTINCT CASE WHEN Churn_Category= 'Competitor' AND Subscription_Grouping = 'Experienced' then Customer_ID ELSE NULL END) AS Number_of_Experienced_Competitor,
100* COUNT(DISTINCT CASE WHEN Churn_Category= 'Competitor' AND Subscription_Grouping = 'Experienced' then Customer_ID ELSE NULL END) /COUNT(DISTINCT CASE WHEN Churn_Category= 'Competitor' THEN Customer_ID ELSE NULL END) AS Experienced_Competitor_Percentage, -- Divide by Churned Customers due to Competitor not all churned customers


-- For Churned_Customers due to Dissatisfaction

COUNT(DISTINCT CASE WHEN Churn_Category= 'Dissatisfaction' AND Subscription_Grouping = 'New' then Customer_ID ELSE NULL END) AS Number_of_New_Dissatisfaction,
100* COUNT(DISTINCT CASE WHEN Churn_Category= 'Dissatisfaction' AND Subscription_Grouping = 'New' then Customer_ID ELSE NULL END) /COUNT(DISTINCT CASE WHEN Churn_Category= 'Dissatisfaction' THEN Customer_ID ELSE NULL END) AS New_Dissatisfaction_Percentage, -- Divide by Churned Customers due to Dissatisfaction not all churned customers

COUNT(DISTINCT CASE WHEN Churn_Category= 'Dissatisfaction' AND Subscription_Grouping = 'Old' then Customer_ID ELSE NULL END) AS Number_of_Old_Dissatisfaction,
100* COUNT(DISTINCT CASE WHEN Churn_Category= 'Dissatisfaction' AND Subscription_Grouping = 'Old' then Customer_ID ELSE NULL END) /COUNT(DISTINCT CASE WHEN Churn_Category= 'Dissatisfaction' THEN Customer_ID ELSE NULL END) AS Old_Dissatisfaction_Percentage, -- Divide by Churned Customers due to Dissatisfaction not all churned customers

COUNT(DISTINCT CASE WHEN Churn_Category= 'Dissatisfaction' AND Subscription_Grouping = 'Experienced' then Customer_ID ELSE NULL END) AS Number_of_Experienced_Dissatisfaction,
100* COUNT(DISTINCT CASE WHEN Churn_Category= 'Dissatisfaction' AND Subscription_Grouping = 'Experienced' then Customer_ID ELSE NULL END) /COUNT(DISTINCT CASE WHEN Churn_Category= 'Dissatisfaction' THEN Customer_ID ELSE NULL END) AS Experienced_Dissatisfaction_Percentage, -- Divide by Churned Customers due to Dissatisfaction not all churned customers


-- For Churned_Customers due to Attitude

COUNT(DISTINCT CASE WHEN Churn_Category= 'Attitude' AND Subscription_Grouping = 'New' then Customer_ID ELSE NULL END) AS Number_of_New_Attitude,
100* COUNT(DISTINCT CASE WHEN Churn_Category= 'Attitude' AND Subscription_Grouping = 'New' then Customer_ID ELSE NULL END) /COUNT(DISTINCT CASE WHEN Churn_Category= 'Attitude' THEN Customer_ID ELSE NULL END) AS New_Attitude_Percentage, -- Divide by Churned Customers due to Attitude not all churned customers

COUNT(DISTINCT CASE WHEN Churn_Category= 'Attitude' AND Subscription_Grouping = 'Old' then Customer_ID ELSE NULL END) AS Number_of_Old_Attitude,
100* COUNT(DISTINCT CASE WHEN Churn_Category= 'Attitude' AND Subscription_Grouping = 'Old' then Customer_ID ELSE NULL END) /COUNT(DISTINCT CASE WHEN Churn_Category= 'Attitude' THEN Customer_ID ELSE NULL END) AS Old_Attitude_Percentage, -- Divide by Churned Customers due to Attitude not all churned customers

COUNT(DISTINCT CASE WHEN Churn_Category= 'Attitude' AND Subscription_Grouping = 'Experienced' then Customer_ID ELSE NULL END) AS Number_of_Experienced_Attitude,
100* COUNT(DISTINCT CASE WHEN Churn_Category= 'Attitude' AND Subscription_Grouping = 'Experienced' then Customer_ID ELSE NULL END) /COUNT(DISTINCT CASE WHEN Churn_Category= 'Attitude' THEN Customer_ID ELSE NULL END) AS Experienced_Attitude_Percentage, -- Divide by Churned Customers due to Attitude not all churned customers


-- For Churned_Customers due to Price

COUNT(DISTINCT CASE WHEN Churn_Category= 'Price' AND Subscription_Grouping = 'New' then Customer_ID ELSE NULL END) AS Number_of_New_Price,
100* COUNT(DISTINCT CASE WHEN Churn_Category= 'Price' AND Subscription_Grouping = 'New' then Customer_ID ELSE NULL END) /COUNT(DISTINCT CASE WHEN Churn_Category= 'Price' THEN Customer_ID ELSE NULL END) AS New_Price_Percentage, -- Divide by Churned Customers due to Price not all churned customers

COUNT(DISTINCT CASE WHEN Churn_Category= 'Price' AND Subscription_Grouping = 'Old' then Customer_ID ELSE NULL END) AS Number_of_Old_Price,
100* COUNT(DISTINCT CASE WHEN Churn_Category= 'Price' AND Subscription_Grouping = 'Old' then Customer_ID ELSE NULL END) /COUNT(DISTINCT CASE WHEN  Churn_Category= 'Price' THEN Customer_ID ELSE NULL END) AS Old_Price_Percentage, -- Divide by Churned Customers due to Price not all churned customers

COUNT(DISTINCT CASE WHEN Churn_Category= 'Price' AND Subscription_Grouping = 'Experienced' then Customer_ID ELSE NULL END) AS Number_of_Experienced_Price,
100* COUNT(DISTINCT CASE WHEN Churn_Category= 'Price' AND Subscription_Grouping = 'Experienced' then Customer_ID ELSE NULL END) /COUNT(DISTINCT CASE WHEN Churn_Category= 'Price' THEN Customer_ID ELSE NULL END) AS Experienced_Price_Percentage, -- Divide by Churned Customers due to Price not all churned customers


-- For Churned_Customers due to other reasons

COUNT(DISTINCT CASE WHEN Churn_Category= 'Other' AND Subscription_Grouping = 'New' then Customer_ID ELSE NULL END) AS Number_of_New_Other,
100* COUNT(DISTINCT CASE WHEN Churn_Category= 'Other' AND Subscription_Grouping = 'New' then Customer_ID ELSE NULL END) /COUNT(DISTINCT CASE WHEN Churn_Category= 'Other' THEN Customer_ID ELSE NULL END) AS New_Other_Percentage, -- Divide by Churned Customers due to Other Reasons not all churned customers

COUNT(DISTINCT CASE WHEN Churn_Category= 'Other' AND Subscription_Grouping = 'Old' then Customer_ID ELSE NULL END) AS Number_of_Old_Other,
100* COUNT(DISTINCT CASE WHEN Churn_Category= 'Other' AND Subscription_Grouping = 'Old' then Customer_ID ELSE NULL END) /COUNT(DISTINCT CASE WHEN Churn_Category= 'Other' THEN Customer_ID ELSE NULL END) AS Old_Other_Percentage, -- Divide by Churned Customers due to Other Reasons not all churned customers

COUNT(DISTINCT CASE WHEN Churn_Category= 'Other' AND Subscription_Grouping = 'Experienced' then Customer_ID ELSE NULL END) AS Number_of_Experienced_Other,
100* COUNT(DISTINCT CASE WHEN Churn_Category= 'Other' AND Subscription_Grouping = 'Experienced' then Customer_ID ELSE NULL END) /COUNT(DISTINCT CASE WHEN Churn_Category= 'Other' THEN Customer_ID ELSE NULL END) AS Experienced_Other_Percentage -- Divide by Churned Customers due to Other Reasons not all churned customers

FROM
(
-- To create Age group buckets
SELECT
Customer_ID,
Churn_Category,
Tenure_in_Months,
-- To create Subscription group buckets
CASE
WHEN Tenure_in_Months <= '12' THEN 'New'
WHEN Tenure_in_Months > '12' AND Tenure_in_Months <= '48' THEN 'Old'
WHEN Tenure_in_Months > '48' THEN  'Experienced'
	END AS Subscription_Grouping 
FROM telecom_customer_churn) AS total_grouping
GROUP BY Churn_Category;

-- Churn Reasons with the Biggest Revenue Loss
SELECT
Churn_Category,
Churn_Reason,
COUNT(CASE WHEN Customer_Status="Churned" THEN Customer_ID ELSE NULL END) AS Number_of_Churned_Customers,
ROUND(CASE WHEN Customer_Status="Churned" THEN SUM(Total_Revenue) ELSE NULL END) AS Total_Churned_Revenue
FROM telecom_customer_churn
Group BY 1,2
Order BY 3 DESC;

-- High Value Customers
SELECT
Subscription_Grouping,
 ROUND(SUM(Total_Revenue))AS Total_Revenue,
 ROUND(SUM(Number_of_Referrals)) AS Total_Referrals
FROM
(
-- To create Subscription group buckets
SELECT
Customer_ID,
Total_Revenue,
Number_of_Referrals,
Tenure_in_Months,
CASE
WHEN Tenure_in_Months <= '12' THEN 'New'
WHEN Tenure_in_Months > '12' AND Tenure_in_Months <= '48' THEN 'Old'
WHEN Tenure_in_Months > '48' THEN  'Experienced'
	END AS Subscription_Grouping 
FROM telecom_customer_churn) AS total_grouping
GROUP BY Subscription_Grouping
ORDER BY 2 DESC;
