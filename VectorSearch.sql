
-- SQL Server Vector and Vector search

-- Create a master key for database, if there isn't already one
-- Replace xyz with password to use

CREATE MASTER KEY ENCRYPTION BY PASSWORD = 'xyz';

-- Create the credentials
-- DROP DATABASE SCOPED CREDENTIAL [https://api.openai.com];
-- To use an external API, the credential name has to be a URL - Needs to match the API endpoint, 
-- but can be more generic than the target URL
-- Replace xyz with OpenAI API Key

CREATE DATABASE SCOPED CREDENTIAL [https://api.openai.com]
    WITH IDENTITY = 'HTTPEndpointHeaders', secret = '{ "Authorization": "Bearer xyz"}';
GO

-- Create the Model
-- DROP EXTERNAL MODEL OpenAiApiEmbeddings;

CREATE EXTERNAL MODEL OpenAiApiEmbeddings
AUTHORIZATION dbo
WITH (
    LOCATION = 'https://api.openai.com/v1/embeddings',
    API_FORMAT = 'OpenAI',
    MODEL_TYPE = EMBEDDINGS,
    MODEL = 'text-embedding-3-small',
    CREDENTIAL = [https://api.openai.com]
);
GO

-- Embeddings table --------------------------------------------------------------------------------------------------------------

DROP TABLE IF EXISTS dbo.Embedding;

CREATE TABLE dbo.Embedding(
    ID INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
    Phrase NVARCHAR(MAX) NOT NULL,
    Embedding VECTOR(1536) NOT NULL
);

SELECT * FROM dbo.Embedding;

GO

-- Generate embeddings

INSERT INTO dbo.Embedding(Phrase, Embedding)
SELECT t.Phrase, AI_GENERATE_EMBEDDINGS(Phrase USE MODEL OpenAiApiEmbeddings)
FROM (VALUES
('The Atlanta Falcons play at the Mercedes-Benz stadium in Atlanta, Georgia'),
('The Carolina Panthers play at the Bank Of America stadium in Charlotte, North Carolina'),
('The New Orleans Saints play at the Caesars Superdome on New Orleans, Louisiana'),
('The Tampa Bay Buccaneers play at Raymond James stadium in Tampa, Florida')
) AS t(Phrase);

SELECT * FROM dbo.Embedding;

GO

-- Search

DECLARE @SearchPhrase VARCHAR(MAX) = 'Plays in the state of Georgia';
--DECLARE @SearchPhrase VARCHAR(MAX) = 'Team with a bird nickname';
--DECLARE @SearchPhrase VARCHAR(MAX) = 'Team with a pirate nickname';

DECLARE @SearchPhraseEmbedding VECTOR(1536);

SELECT @SearchPhraseEmbedding = AI_GENERATE_EMBEDDINGS(@SearchPhrase USE MODEL OpenAiApiEmbeddings)

SELECT Phrase,
    VECTOR_DISTANCE('cosine', @SearchPhraseEmbedding, Embedding) AS Distance
FROM dbo.Embedding
ORDER BY VECTOR_DISTANCE('cosine', @SearchPhraseEmbedding, Embedding);

GO
