-- Question 1: What is your age?
-- Average of ages
Select avg(cast(A.AnswerText as int)) 'Average' from dbo.Answer A
where A.QuestionID = 1


-- Question 3: What country do you live in?
-- Top 5 countries with the most employees in 2018 answers
select top 5 A.AnswerText, count(*) 'Number' from dbo.Answer A
where A.QuestionID = 3
and A.SurveyID = 2018
group by A.AnswerText
order by count(*) desc


-- Question 33: Do you currently have a mental health disorder?
-- Percentage of each answer per year
select 
A.surveyID,
FORMAT(sum(CASE WHEN AnswerText = 'Dont Know' then 1 else 0 end)*1.0/count(*),'P') 'Dont Know',
FORMAT(sum(CASE WHEN AnswerText = 'Maybe' then 1 else 0 end)*1.0/count(*),'P')  'Maybe',
FORMAT(sum(CASE WHEN AnswerText = 'No' then 1 else 0 end)*1.0/count(*),'P')  'No',
FORMAT(sum(CASE WHEN AnswerText = 'Possibly' then 1 else 0 end)*1.0/count(*),'P')  'Possibly',
FORMAT(sum(CASE WHEN AnswerText = 'Yes' then 1 else 0 end)*1.0/count(*),'P')  'Yes'
from Answer A
where A.QuestionID = 33
group by A.SurveyID
order by A.SurveyID	asc


-- Question 59: Describe the conversation you had with your employer about your mental health, including their reactions and what actions were taken to address your mental health issue/questions.
-- Minimum and maximum response size
SELECT min(len(AnswerText)) 'Min Len',max(len(AnswerText)) 'Max Len'  from Answer
where questionID = 59


-- Question 86: Briefly describe what you think the industry as a whole and/or employers could do to improve mental health support for employees.
-- Choosing a random answer for each year
SELECT SurveyID, MAX(AnswerText) 'Answer'
FROM (
    SELECT SurveyID, AnswerText, ROW_NUMBER() OVER (PARTITION BY SurveyID ORDER BY NEWID()) AS a
    FROM Answer
	where QuestionID = 86
) subquery
WHERE a = 1
GROUP BY SurveyID;


-- Question 117: Which of the following best describes your work position?
-- Number of employees by positions (Only positions with a count greater than 50 will appear)
select A.AnswerText, count(*) 'Number' from dbo.Answer A
where A.QuestionID = 117
group by A.AnswerText
having count(*) > 50
order by count(*) desc


-- Question 117: Which of the following best describes your work position? + Question 118: Do you work remotely?
-- Percentage of remote workers distributed by position (Limited to 2016 survey)
Select Q117.[AnswerText 117], Q118.[AnswerText 118], FORMAT(Count(*)*1.0/CountQ117.[CountQ117],'P') '%'
from
(select AnswerText 'AnswerText 117', UserID from answer 
where QuestionID = 117
and SurveyID = 2016) Q117
inner join
(select AnswerText 'AnswerText 118', UserID from answer 
where QuestionID = 118
and SurveyID = 2016) Q118
on Q117.UserID = Q118.UserID
inner join
(select AnswerText 'AnswerText 117', Count(*) 'CountQ117' from answer 
where QuestionID = 117
and SurveyID = 2016
group by AnswerText) CountQ117
on Q117.[AnswerText 117] = CountQ117.[AnswerText 117]
group by Q117.[AnswerText 117], Q118.[AnswerText 118], CountQ117.[CountQ117]
order by Q117.[AnswerText 117]


-- Shortest and longest year of application of questions
select *, 
(Select min(SurveyID) from Answer A where A.QuestionID = Q.QuestionID) 'Min',
(Select max(SurveyID) from Answer A where A.QuestionID = Q.QuestionID) 'Max'
from Question Q