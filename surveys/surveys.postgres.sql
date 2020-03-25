CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  email TEXT NOT NULL,
  password_digest TEXT NOT NULL,
  created_at TIMESTAMP NOT NULL,
  updated_at TIMESTAMP NOT NULL
);

ALTER TABLE users ADD UNIQUE (email);

CREATE TABLE surveys (
  id SERIAL PRIMARY KEY,
  author_id INTEGER NOT NULL,
  title TEXT NOT NULL,
  created_at TIMESTAMP NOT NULL,
  updated_at TIMESTAMP NOT NULL,
  FOREIGN KEY (author_id) REFERENCES users(id)
);

CREATE INDEX ON surveys(author_id);

CREATE TABLE survey_choices (
  id SERIAL PRIMARY KEY,
  survey_id INTEGER NOT NULL,
  description TEXT NOT NULL,
  FOREIGN KEY (survey_id) REFERENCES surveys(id)
);

CREATE INDEX ON survey_choices(survey_id);

CREATE TABLE survey_responses (
  id SERIAL PRIMARY KEY,
  survey_id INTEGER NOT NULL,
  respondent_id INTEGER NOT NULL,
  created_at TIMESTAMP NOT NULL,
  updated_at TIMESTAMP NOT NULL,
  FOREIGN KEY (survey_id) REFERENCES surveys(id),
  FOREIGN KEY (respondent_id) REFERENCES users(id)
);

ALTER TABLE survey_responses ADD UNIQUE (survey_id, respondent_id);
CREATE INDEX ON survey_responses(respondent_id);

CREATE TABLE survey_response_choices (
  id SERIAL PRIMARY KEY,
  survey_choice_id iNTEGER NOT NULL,
  survey_response_id INTEGER NOT NULL,
  created_at TIMESTAMP NOT NULL,
  updated_at TIMESTAMP NOT NULL,
  FOREIGN KEY (survey_choice_id) REFERENCES survey_choices(id),
  FOREIGN KEY (survey_response_id) REFERENCES survey_responses(id)
);

ALTER TABLE survey_response_choices ADD UNIQUE (survey_choice_id, survey_response_id);
CREATE INDEX ON survey_response_choices(survey_response_id);
