Create table Answer (
	AnswerText varchar(max),
	SurveyID int,
	UserID int,
	QuestionID int
)

Create table Question (
	QuestionText varchar(max),
	QuestionID int  not null
)

ALTER TABLE Question
ADD CONSTRAINT PK_Question
PRIMARY KEY (QuestionID);

Create table Survey (
	SurveyID int not null,
	Description varchar(max)
)

ALTER TABLE Survey
ADD CONSTRAINT PK_Survey
PRIMARY KEY (SurveyID);

ALTER TABLE Answer
ADD CONSTRAINT FK_AnswerQuestion
FOREIGN KEY (QuestionID) REFERENCES Question(QuestionID);

Alter table Answer
ADD CONSTRAINT FK_AnswerSurvey
Foreign key (SurveyID) References Survey(SurveyID);