Create view VW_RecentAnswers as
select S.Description 'Survey Description',S.SurveyID, 
Q.QuestionID, Q.QuestionText, 
A.UserID, A.AnswerText from Answer A
inner join Question Q on A.QuestionID = Q.QuestionID
inner join Survey S on A.SurveyID = S.SurveyID
where S.SurveyID = (select max(SurveyID) from Survey)
