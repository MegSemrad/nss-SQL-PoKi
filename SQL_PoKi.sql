-- 1. What grades are stored in the database?
        SELECT
            Name
        FROM Grade;




-- 2. What emotions may be associated with a poem?
        SELECT
            Name
        FROM Emotion;




-- 3. How many poems are in the database?
        SELECT 
            COUNT(p.Id) 
        FROM Poem p;




-- 4. Sort authors alphabetically by name. What are the names of the top 76 authors?
        SELECT 
            TOP 76 Name
        FROM 
            Author 
        ORDER BY Name;




-- 5. Starting with the above query, add the grade of each of the authors.
        SELECT 
            TOP 76 Author.Name,
            Grade.Name AS Grade
        FROM 
            Author 
        LEFT JOIN Grade ON Author.GradeId = Grade.Id
        ORDER BY Name;




-- 6. Starting with the above query, add the recorded gender of each of the authors.
        SELECT 
            TOP 76 Author.Name,
            Grade.Name AS Grade,
            Gender.Name AS Gender
        FROM 
            Author 
        LEFT JOIN Grade ON Author.GradeId = Grade.Id
        LEFT JOIN Gender ON Author.GenderId = Gender.Id

        ORDER BY Name;




-- 7. What is the total number of words in all poems in the database?
        SELECT SUM(WordCount) AS TotalNumberWordInAllPoems
        FROM Poem;




-- 8. Which poem has the fewest characters?
    SELECT Poem.CharCount, Poem.Title AS PoemTitle 
    FROM Poem
    WHERE Poem.CharCount = (
        SELECT MIN(Poem.CharCount)
        FROM Poem
    );




-- 9. How many authors are in the third grade?
-- Can use [] as belowo to allow for spacing between alias words OR can use '' OR can use AS AliasName
        SELECT 
            COUNT(Author.id) [Number Of Third Grade Authors]
        FROM Author
            LEFT JOIN Grade ON Author.GradeId = Grade.Id
        WHERE   
            Grade.Name = '3rd Grade';



-- 10. How many authors are in the first, second or third grades?
        SELECT 
            COUNT(author.id) AS NumberOfAuthors, Grade.Name AS Grade
        FROM Author
            LEFT JOIN Grade ON Author.GradeId = Grade.Id
        GROUP BY Grade.Name
        HAVING Grade.Name = '1st Grade'
            OR Grade.Name = '2nd Grade'
            OR Grade.Name = '3rd Grade';





-- 11. What is the total number of poems written by fourth graders?
        SELECT 
            COUNT(Poem.Id) [Number Of Poems By Fourth Graders]
        FROM  Poem
            LEFT JOIN Author ON Poem.AuthorId = Author.Id
            LEFT JOIN Grade ON Author.GradeId = Grade.Id
        WHERE   
            Grade.Name = '4th Grade';




-- 12. How many poems are there per grade?
        SELECT 
            COUNT(Poem.Id) AS NumberOfPoems, Grade.Name AS Grade
        FROM Poem   
            LEFT JOIN Author ON Poem.AuthorId = Author.Id
            LEFT JOIN Grade ON Author.GradeId = Grade.Id
        GROUP BY Grade.Id, Grade.Name
        ORDER BY Grade.Name;





-- 13. How many authors are in each grade? (Order your results by grade starting with 1st Grade)
        SELECT 
            COUNT(Author.Id) AS NumberOfAuthors, Grade.Name AS Grade
        FROM Author   
            LEFT JOIN Grade ON Author.GradeId = Grade.Id
        GROUP BY Grade.Id, Grade.Name
        ORDER BY Grade.Name;




-- 14. What is the title of the poem that has the most words?
        SELECT 
            TOP 1 Poem.Title, Poem.WordCount
        FROM Poem
        ORDER BY Poem.WordCount DESC; 




-- 15. Which author(s) have the most poems? (Remember authors can have the same name.)
        SELECT TOP 1 Poem.AuthorId, COUNT (Poem.AuthorId) AS NumberOfPoems, Author.Name
        FROM Poem
            LEFT JOIN Author ON Poem.AuthorId = Author.Id
        GROUP BY Poem.AuthorId, Author.Name
        ORDER BY NumberOfPoems DESC;
        



-- 16. How many poems have an emotion of sadness?
        SELECT 
            COUNT(PoemEmotion.id) AS PoemCountAboutSaddness
        FROM PoemEmotion   
            LEFT JOIN Emotion ON PoemEmotion.EmotionId = Emotion.Id 
        WHERE   
            Emotion.Name = 'Sadness';
        



-- 17. How many poems are not associated with any emotion?
        SELECT 
            COUNT(Poem.Id) [Emotionless Poems]
        FROM Poem
        LEFT JOIN PoemEmotion ON Poem.Id = PoemEmotion.PoemId
        WHERE PoemEmotion.PoemId IS NULL 




-- 18. Which emotion is associated with the least number of poems?
        SELECT 
            COUNT(PoemEmotion.EmotionId) AS EmotionCount,
            Emotion.Name
        FROM PoemEmotion    
            LEFT JOIN Emotion ON PoemEmotion.EmotionId = Emotion.Id
        WHERE PoemEmotion.EmotionId = (
            SELECT MIN(PoemEmotion.EmotionId)
            FROM PoemEmotion
            )
        GROUP BY  PoemEmotion.EmotionId, Emotion.Name;
    



-- 19. Which grade has the largest number of poems with an emotion of joy?
        SELECT 
            Grade.Name AS Grade,
            COUNT (Poem.Id) AS NumberOfPoems,
            Emotion.Name AS Emotion
        FROM Emotion
            LEFT JOIN PoemEmotion ON Emotion.Id = PoemEmotion.EmotionId
            LEFT JOIN Poem ON PoemEmotion.PoemId = Poem.Id
            LEFT JOIN Author ON Poem.AuthorId = Author.Id
            LEFT JOIN Grade ON Author.GradeId = Grade.Id 
        WHERE Emotion.Name = 'Joy'
        GROUP BY Grade.Name, Emotion.Name
        



-- 20. Which gender has the least number of poems with an emotion of fear?