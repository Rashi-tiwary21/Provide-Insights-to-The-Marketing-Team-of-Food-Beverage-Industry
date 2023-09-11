#  Who prefers energy drink more? (male/female/non-binary?)

Select Gender as Gender, COUNT(Respondent_ID) as Total_Respondents FROM codex.dim_repondents
GROUP BY Gender
ORDER BY Total_Respondents DESC;

#  Which age group prefers energy drinks more?

Select Age as Age, COUNT(Respondent_ID) as Total_Respondents FROM codex.dim_repondents
GROUP BY Age
ORDER BY Total_Respondents DESC;

#  Which type of marketing reaches the most Youth (15-30) ?

SELECT
    COUNT(dr.Respondent_ID) as Total_Respondents, dr.Age , fsr.Marketing_Channels 
FROM
    codex.dim_repondents dr 
INNER JOIN
    codex.fact_survey_responses fsr ON dr.Respondent_ID = fsr.Respondent_ID
WHERE
    dr.Age IN ('19-30','15-18')
GROUP BY
    dr.Age, fsr.Marketing_Channels
ORDER BY
    Total_Respondents DESC;
    
    
#  What are the preferred ingredients of energy drinks among respondents?

SELECT  
Ingredients_expected as Preferred_Ingredients,
COUNT(Respondent_Id) as Total_Respondants
FROM 
  codex.fact_survey_responses
GROUP BY
  Ingredients_expected
ORDER BY 
  Total_Respondants DESC;
  
#  What packaging preferences do respondents have for energy drinks?

SELECT 
Packaging_preference ,
COUNT(Respondent_Id) as Total_Respondants
FROM 
  codex.fact_survey_responses
GROUP BY
  Packaging_preference
ORDER BY 
  Total_Respondants DESC;
  
  
#   Who are the current market leaders?

SELECT 
Current_brands as Brands , 
COUNT(Respondent_ID) as Total_Respondents
FROM
 codex.fact_survey_responses
GROUP BY 
Current_brands
ORDER BY 
Total_Respondents DESC;


#  What are the primary reasons consumers prefer those brands over ours?

WITH CTE AS (
    SELECT 
        Current_brands as Brands,
        Reasons_for_choosing_brands, 
        COUNT(Respondent_ID) as Total_Respondents
    FROM
        codex.fact_survey_responses
    GROUP BY 
        Current_brands, Reasons_for_choosing_brands
)
SELECT 
    CTE.Brands, 
    CTE.Reasons_for_choosing_brands, 
    COUNT(fsr.Respondent_ID) as Total_Respondents
FROM 
    codex.fact_survey_responses fsr
JOIN 
    CTE ON fsr.Current_brands = CTE.Brands
GROUP BY 
    CTE.Brands, CTE.Reasons_for_choosing_brands
ORDER BY 
    Total_Respondents DESC;


#  Which marketing channel can be used to reach more customers?

SELECT Marketing_channels, 
COUNT(Respondent_ID) as Total_Respondents
FROM
 codex.fact_survey_responses
GROUP BY 
Marketing_channels
ORDER BY 
Total_Respondents DESC;

#  How effective are different marketing strategies and channels in reaching our customers?

SELECT
    fsr.Marketing_Channels,
    SUM(CASE WHEN dr.Age >= 15 AND dr.Age <= 18 THEN 1 ELSE 0 END) AS Age_15_18_Count,
    SUM(CASE WHEN dr.Age >= 19 AND dr.Age <= 30 THEN 1 ELSE 0 END) AS Age_19_30_Count,
    SUM(CASE WHEN dr.Age >= 31 AND dr.Age <= 45 THEN 1 ELSE 0 END) AS Age_31_45_Count,
    SUM(CASE WHEN dr.Age >= 46 AND dr.Age <= 65 THEN 1 ELSE 0 END) AS Age_46_65_Count,
    SUM(CASE WHEN dr.Age >= 66 THEN 1 ELSE 0 END) AS Age_65plus_Count
FROM
    codex.fact_survey_responses fsr
JOIN
    codex.dim_repondents dr ON fsr.Respondent_ID = dr.Respondent_ID
GROUP BY
    fsr.Marketing_Channels
ORDER BY
    fsr.Marketing_Channels;


#  What do people think about our brand? (overall rating) ?

SELECT 
Current_brands as Brands,
ROUND(avg(Taste_experience),2)as Avg_Rating
FROM codex.fact_survey_responses
GROUP BY 
Current_brands
ORDER BY 
Avg_Rating DESC;


#  Which cities do we need to focus more on?

SELECT
    dc.City,
    COUNT(dr.Respondent_ID) AS Total_Respondents
FROM
    codex.dim_cities dc
JOIN
    codex.dim_repondents dr ON dc.City_ID = dr.City_ID
GROUP BY
    dc.City
ORDER BY
    Total_Respondents DESC;
    
#   Where do respondents prefer to purchase energy drinks?

SELECT 
Purchase_location,
COUNT(Respondent_ID) as Total_Respondents
FROM codex.fact_survey_responses
GROUP BY 
Purchase_location
ORDER BY 
Total_Respondents DESC;


#  What are the typical consumption situations for energy drinks among respondents?


SELECT 
Typical_consumption_situations as Consumption_Situation ,
COUNT(Respondent_ID) as Total_Respondents
FROM codex.fact_survey_responses
GROUP BY 
Typical_consumption_situations 
ORDER BY 
Total_Respondents DESC;

#  What factors influence respondents' purchase decisions, such as price range and limited edition packaging?

SELECT Price_Range,
count(Respondent_ID) as Total_Respondents 
FROM codex.fact_survey_responses
GROUP BY 
Price_range
ORDER BY
Total_Respondents DESC;

SELECT Limited_edition_Packaging,
COUNT(Respondent_ID) as Total_Respondents
FROM codex.fact_survey_responses
GROUP BY 
Limited_edition_packaging
ORDER BY
Total_Respondents DESC;


#   Which area of business should we focus more on our product development? (Branding/taste/availability)


SELECT Brand_perception,
COUNT(Respondent_ID) as Total_Respondents
FROM codex.fact_survey_responses
GROUP BY 
Brand_perception
ORDER BY
Total_Respondents DESC;

SELECT Reasons_preventing_trying as Reason_for_not_choosing,
COUNT(Respondent_ID) as Total_Respondents
FROM codex.fact_survey_responses
GROUP BY 
Reasons_preventing_trying
ORDER BY
Total_Respondents DESC;

SELECT Taste_experience as Rating,
COUNT(Respondent_ID) as Total_Respondents
FROM codex.fact_survey_responses
GROUP BY 
Rating
ORDER BY
Total_Respondents DESC;










