PRAGMA foreign_keys = ON;


DROP TABLE IF EXISTS question_likes;
DROP TABLE IF EXISTS replies;
DROP TABLE IF EXISTS question_follows;
DROP TABLE IF EXISTS questions;
DROP TABLE IF EXISTS users;


CREATE TABLE users (
  id INTEGER PRIMARY KEY,
  fname VARCHAR(30) NOT NULL,
  lname VARCHAR(30)
);


CREATE TABLE questions (
  id INTEGER PRIMARY KEY,
  title TEXT NOT NULL,
  body TEXT,
  user_id INTEGER NOT NULL,

  FOREIGN KEY (user_id) REFERENCES users(id)
);


CREATE TABLE question_follows (
  question_id INTEGER,
  user_id INTEGER,

  PRIMARY KEY (question_id, user_id),
  FOREIGN KEY (question_id) REFERENCES questions(id),
  FOREIGN KEY (user_id) REFERENCES users(id)
);


CREATE TABLE replies (
  id INTEGER PRIMARY KEY,
  question_id INTEGER NOT NULL,
  parent_reply_id INTEGER DEFAULT NULL,
  user_id INTEGER NOT NULL,
  body TEXT NOT NULL,

  FOREIGN KEY (question_id) REFERENCES questions(id),
  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (parent_reply_id) REFERENCES replies(id) --self-referential
);



CREATE TABLE question_likes (
  question_id INTEGER,
  user_id INTEGER,

  PRIMARY KEY (question_id, user_id),
  FOREIGN KEY (question_id) REFERENCES questions(id),
  FOREIGN KEY (user_id) REFERENCES users(id)
);



INSERT INTO
  users(fname, lname)
VALUES
  ('Joe', 'Schmo'),
  ('William', 'McAdams'),
  ('James', 'Lo'),
  ('Danny', 'Xu');


INSERT INTO
  questions(title, body, user_id)
VALUES
  ('Life?', 'What is?', 1),
  ('Question about Time', 'What time is it?', 2),
  ('What time do we eat?', 'So...what time is lunch?', 1);

INSERT INTO
  question_follows(question_id, user_id)
VALUES
  (1, 1),
  (1, 2),
  (1, 3),
  (2, 2),
  (2, 4),
  (3, 1),
  (3, 3),
  (3, 4);

INSERT INTO
  replies(question_id, parent_reply_id, user_id, body)
VALUES
  (1, NULL, 2, 'Programming'),
  (1, NULL, 3, 'Slow decay'),
  (2, NULL, 4, 'Time to eat!'),
  (2, 3, 3, 'NO. Time to sleep!'),
  (2, 4, 2, 'Wrong again. Time to party!');

INSERT INTO
  question_likes(question_id, user_id)
VALUES
  (1, 1),
  (2, 1),
  (3, 1),
  (3, 2);
