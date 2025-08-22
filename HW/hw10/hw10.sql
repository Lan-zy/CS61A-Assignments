CREATE TABLE parents AS
  SELECT 'ace' AS parent, 'bella' AS child UNION
  SELECT 'ace'          , 'charlie'        UNION
  SELECT 'daisy'        , 'hank'           UNION
  SELECT 'finn'         , 'ace'            UNION
  SELECT 'finn'         , 'daisy'          UNION
  SELECT 'finn'         , 'ginger'         UNION
  SELECT 'ellie'        , 'finn';

CREATE TABLE dogs AS
  SELECT 'ace' AS name, 'long' AS fur, 26 AS height UNION
  SELECT 'bella'      , 'short'      , 52           UNION
  SELECT 'charlie'    , 'long'       , 47           UNION
  SELECT 'daisy'      , 'long'       , 46           UNION
  SELECT 'ellie'      , 'short'      , 35           UNION
  SELECT 'finn'       , 'curly'      , 32           UNION
  SELECT 'ginger'     , 'short'      , 28           UNION
  SELECT 'hank'       , 'curly'      , 31;

CREATE TABLE sizes AS
  SELECT 'toy' AS size, 24 AS min, 28 AS max UNION
  SELECT 'mini'       , 28       , 35        UNION
  SELECT 'medium'     , 35       , 45        UNION
  SELECT 'standard'   , 45       , 60;


-- All dogs with parents ordered by decreasing height of their parent
CREATE TABLE by_parent_height AS
  SELECT child FROM parents, dogs
    WHERE parents.parent = dogs.name
    ORDER BY dogs.height DESC;


-- The size of each dogS
CREATE TABLE size_of_dogs AS
  SELECT name, size From dogs as d, sizes as s
    WHERE d.height > s.min AND d.height <= s.max;


-- [Optional] Filling out this helper table is recommended
CREATE TABLE siblings AS
  SELECT a.child AS dog1, b.child AS dog2 From parents as a, parents as b
    WHERE a.parent = b.parent AND a.child < b.child;

-- Sentences about siblings that are the same size
CREATE TABLE sentences AS
  SELECT 'The two siblings, ' || dog1 || ' and ' || dog2 || ', have the same size: ' || d1.size FROM siblings as s, size_of_dogs as d1, size_of_dogs as d2
    WHERE s.dog1 = d1.name AND s.dog2 = d2.name AND d1.size = d2.size;


-- Height range for each fur type where all of the heights differ by no more than 30% from the average height
CREATE TABLE low_variance AS
SELECT fur AS fur, MIN(height) AS min_height, MAX(height) AS max_height
   FROM dogs 
   WHERE height BETWEEN 0.7 * (SELECT AVG(height) FROM dogs) AND 1.3 * (SELECT AVG(height) FROM dogs)
   GROUP BY fur;

