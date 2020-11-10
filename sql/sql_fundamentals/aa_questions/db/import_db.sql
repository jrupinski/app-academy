-- This line makes database respect foreign key constraints
-- this makes sure you can't delete users if there are remaining foreign keys 
-- that depend on it
PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS question_likes;
DROP TABLE IF EXISTS question_follows; 
DROP TABLE IF EXISTS replies;
DROP TABLE IF EXISTS questions; 
DROP TABLE IF EXISTS users; 

-- USERS

CREATE TABLE users (
  id INTEGER PRIMARY KEY,
  fname VARCHAR(255) NOT NULL,
  lname VARCHAR(255) NOT NULL
);

-- QUESTIONS

CREATE TABLE questions (
  id INTEGER PRIMARY KEY,
  title VARCHAR(255) NOT NULL,
  body TEXT NOT NULL,
  author_id INTEGER NOT NULL,

  FOREIGN KEY (author_id) REFERENCES users(id)
);

-- QUESTION_FOLLOWS

CREATE TABLE question_follows (
  id INTEGER PRIMARY KEY,
  user_id INTEGER NOT NULL,
  question_id INTEGER NOT NULL,

  FOREIGN KEY (question_id) REFERENCES questions(id),
  FOREIGN KEY (user_id) REFERENCES users(id)
);

-- REPLIES

CREATE TABLE replies (
  id INTEGER PRIMARY KEY,
  user_id INTEGER NOT NULL,
  question_id INTEGER NOT NULL,
  question_subject VARCHAR(255) NOT NULL,
  question_body TEXT NOT NULL,
  parent_reply_id INTEGER,

  FOREIGN KEY (parent_reply_id) REFERENCES replies(id)
);

-- QUESTION_LIKES

CREATE TABLE question_likes (
  id INTEGER PRIMARY KEY,
  user_id INTEGER NOT NULL,
  question_id INTEGER NOT NULL,

  FOREIGN KEY (question_id) REFERENCES questions(id),
  FOREIGN KEY (user_id) REFERENCES users(id)
);

-- SEEDING THE DATABASE --
-- seeding users
INSERT INTO
  users(fname, lname)
VALUES
  ("Jakub", "Rupinski"), ("Johnny", "Test"), ("John", "Marston");

-- seeding questions
INSERT INTO
  questions(title, body, author_id)
VALUES
  ("How are you?", "Hope ur well. :)", 
  (SELECT
    id
  FROM
    users
  WHERE
    users.fname = "Jakub" AND users.lname = "Rupinski")
);

INSERT INTO
  questions(title, body, author_id)
VALUES
  ("Do you need a question?", "ohh man", 
  (SELECT
    id
  FROM
    users
  WHERE
    users.fname = "Johnny" AND users.lname = "Test")
);

INSERT INTO
  questions(title, body, author_id)
VALUES
  ("Why can't I come up with more questions?", "Tell me why", 
  (SELECT
    id
  FROM
    users
  WHERE
    users.fname = "Jakub" AND users.lname = "Rupinski")
);


INSERT INTO
  questions(title, body, author_id)
VALUES
  ("Do you like chocolate?", "Yasssssss!", 
  (SELECT
    id
  FROM
    users
  WHERE
    users.fname = "Jakub" AND users.lname = "Rupinski")
);

INSERT INTO
  questions(title, body, author_id)
VALUES
  ("Is this another question?", "Yeah boi", 
  (SELECT
    id
  FROM
    users
  WHERE
    users.fname = "Johnny" AND users.lname = "Test")
);


-- seeding questions_follows
INSERT INTO
  question_follows(user_id, question_id)
VALUES
  (
  (SELECT
    id
  FROM
    users
  WHERE
    fname = "Jakub" AND lname = "Rupinski"),
  (SELECT
    id
  FROM
    questions
  WHERE
    title = "How are you?")
);

-- seeding replies
-- 
-- parent reply
INSERT INTO
  replies(user_id, question_id, question_subject, question_body, parent_reply_id)
VALUES
  (
    (SELECT
      id
    FROM
      users
    WHERE
    fname = "Jakub" AND lname = "Rupinski"),

    (SELECT
      id
    FROM
      questions
    WHERE
      title = "How are you?"),
      
    (SELECT
      title
    FROM
      questions
    WHERE
      title = "How are you?"),
      
    (SELECT
      body
    FROM
      questions
    WHERE
      title = "How are you?"),

    NULL
  );

-- reply to the parent
INSERT INTO
  replies(user_id, question_id, question_subject, question_body, parent_reply_id)
VALUES
  ((SELECT
    id
  FROM
    users
  WHERE
  fname = "Johnny" AND lname = "Test"),

  (SELECT
    id
  FROM
    questions
  WHERE
    title = "Do you need a question?"),
    
  (SELECT
    title
  FROM
    questions
  WHERE
    title = "Do you need a question?"),
    
  (SELECT
    body
  FROM
    questions
  WHERE
    title = "Do you need a question?"),
    
  (SELECT
    id
  FROM
    replies
  WHERE
    id = 1)
);

INSERT INTO
  replies(user_id, question_id, question_subject, question_body, parent_reply_id)
VALUES
  ((SELECT
    id
  FROM
    users
  WHERE
  fname = "Johnny" AND lname = "Test"),

  (SELECT
    id
  FROM
    questions
  WHERE
    title = "Is this another question?"),
    
  (SELECT
    title
  FROM
    questions
  WHERE
    title = "Is this another question?"),
    
  (SELECT
    body
  FROM
    questions
  WHERE
    title = "Is this another question?"),
    
  (SELECT
    id
  FROM
    replies
  WHERE
    question_id = 
      (SELECT
        id
      FROM
        questions
      WHERE
        title = "Do you need a question?")
  )     
);

INSERT INTO
  replies(user_id, question_id, question_subject, question_body, parent_reply_id)
VALUES
  (1,
  4,
  (SELECT
    title
  FROM
    questions
  WHERE
    id = 4),
    
  (SELECT
    body
  FROM
    questions
  WHERE
    id = 3),
  3);

-- seeding question_likes
INSERT INTO
  question_likes(user_id, question_id)
VALUES
  (
  (SELECT
    id
  FROM
    users
  WHERE
    lname = "Test"),

  (SELECT
    id
  FROM
    questions
  WHERE
    title = "How are you?")
  );

  INSERT INTO
  question_likes(user_id, question_id)
VALUES
  (
  (SELECT
    id
  FROM
    users
  WHERE
    fname = "Jakub" AND lname = "Rupinski"),

  (SELECT
    id
  FROM
    questions
  WHERE
    title = "How are you?")
  );