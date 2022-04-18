/*Selecione todos os países 
Select * from country;*/

/*Selecione todos os países e suas respectivas ligas 
Select C1.name 'País',L1.name 'League' from country C1 inner join league L1 on C1.id = L1.country_id; */

/*Selecione players com overall acima de 85
Select * from Player_Attributes where overall_rating > 85;*/

/*Selecione players com overall acima ou igual a 85 e com potencial acima de 90
Select * from Player_Attributes where overall_rating >= 85 and potential > 90;*/

/*Selecione o maior potencial
Select max(potential) 'Maior potencial' from Player_Attributes;*/

/*Selecione os jogadores com o maior potencial
Select P1.player_name 'Jogador', PA1.date 'Data', PA1.potential 'Potencial' from Player_Attributes PA1 inner join Player P1 on PA1.player_api_id = P1.player_api_id where PA1.potential =(Select max(potential) from Player_Attributes);*/

/*Selecione os times que foram atualizados mais vezes
Select T1.team_long_name 'Time', COUNT(TA1.date) as quantidade from Team T1 inner join Team_Attributes TA1 on T1.team_api_id = TA1.team_api_id group by TA1.team_api_id having count(TA1.date) = 
(Select MAX(data.quantidade) from (Select COUNT(TA1.date) as quantidade from Team T1 inner join Team_Attributes TA1 on T1.team_api_id = TA1.team_api_id group by TA1.team_api_id) data); */

/*Liste as temporadas e seus respectivos números de partidas
Select season 'Temporada', count(*) 'Contagem' from Match group by season;*/

/*Selecione os 100 primeiros times que tiveram mais partidas em casa
Select T1.team_long_name 'Time', Count(*) 'Contagem' from Match M1 inner join Team T1 on T1.team_api_id = M1.home_team_api_id group by M1.home_team_api_id order by Count(*) desc LIMIT 100;*/

/*Selecione os 100 primeiros times que tiveram a melhor média de gols fora de cada
Select T1.team_long_name 'Time', printf("%.3f",AVG(M1.away_team_goal)) 'Média de gols' from Match M1 inner join Team T1 on T1.team_api_id = M1.away_team_api_id group by M1.away_team_api_id order by AVG(M1.away_team_goal) desc LIMIT 100;*/

/*Selecione os 500 confrontos que mais apareceram
Select T1.team_long_name 'Time de casa', T2.team_long_name 'Time de fora', Count(*) 'Quantidade de partidas' from Match M1 inner join Team T1 on M1.home_team_api_id = T1.team_api_id 
inner join Team T2 on M1.away_team_api_id = T2.team_api_id group by M1.home_team_api_id,M1.away_team_api_id order by Count(*) desc LIMIT 500;*/

/*Selecione os times que tem uma média de gols maior fora de casa do que em casa
Select T1.team_long_name 'Time',  printf("%.3f",AVG(M1.away_team_goal)) 'Média de gols fora de casa', printf("%.3f",AVG(M1.home_team_goal)) 'Média de gols em casa' from Match M1 inner join Team T1 on M1.away_team_api_id = T1.team_api_id 
or M1.home_team_api_id = T1.team_api_id group by M1.home_team_api_id having AVG(M1.away_team_goal) > AVG(M1.home_team_goal);*/

/*Selecione os 150 times com a melhor média de gols
Select T1.team_long_name 'Time', printf("%.3f",(AVG(M1.away_team_goal) + AVG(M1.home_team_goal))/2) 'Média de gols' from Match M1 inner join Team T1 on M1.away_team_api_id = T1.team_api_id 
or M1.home_team_api_id = T1.team_api_id group by M1.home_team_api_id order by (AVG(M1.away_team_goal) + AVG(M1.home_team_goal))/2 desc limit 150;*/