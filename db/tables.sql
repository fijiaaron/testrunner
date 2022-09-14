CREATE TABLE test_case (
	test_case_id INTEGER,
	test_case_prefix VARCHAR,
	test_case_title VARCHAR,
	test_case_description TEXT,
	test_steps TEXT,
	expected_results TEXT,
	pre_conditions TEXT,
	test_conditions TEXT,
	post_conditions TEXT,
	features TEXT,
	requirements TEXT,
	categories TEXT,
	tags TEXT,
	metadata TEXT,
	created TIMESTAMP,
	updated TIMESTAMP,
	version_id VARCHAR,

	PRIMARY KEY (test_case_id)
);

CREATE TABLE test_group (
	test_group_id INTEGER PRIMARY KEY,
	test_case_id INTEGER references test_case(test_case_id),
	test_group_prefix VARCHAR,
	test_group_title VARCHAR,
	test_group_description TEXT,
	categories TEXT,
	tags TEXT,
	metadata TEXT,
	created TIMESTAMP,
	updated TIMESTAMP,
	version_id VARCHAR
);

CREATE TABLE test_run (
	test_run_id INTEGER,
	test_run_status VARCHAR,
	test_run_started TIMESTAMP,
	test_run_finished TIMESTAMP,
	test_run_title VARCHAR,
	test_run_description TEXT,
	environment VARCHAR,
	settings TEXT,
	tags TEXT,
	metadata TEXT,
	created TIMESTAMP,
	updated TIMESTAMP,
	version_id VARCHAR,

	PRIMARY KEY (test_run_id)
);


CREATE TABLE test_result (
	test_result_id INTEGER,
	test_case_id INTEGER REFERENCES test_case(test_case_id),
	test_result_status VARCHAR,
	results TEXT,
	details TEXT,
	comments TEXT,
	attachments TEXT,
	tags TEXT,
	metadata TEXT,
	created TIMESTAMP,

	PRIMARY KEY (test_result_id)
);

CREATE TABLE test_error (
	test_error_id INTEGER,
	test_case_id INTEGER,

	error_message TEXT,
	error_stack_trace TEXT,
	details TEXT,
	comments TEXT,
	tags TEXT,
	metadata TEXT,
	created TIMESTAMP,

	PRIMARY KEY test_result_id,
	FOREIGN KEY test_case_id
);


CREATE TABLE test_execution (
	test_execution_id INTEGER,
	test_case_id INTEGER REFERENCES test_case(test_case_id),
	test_run_id INTEGER REFERENCES test_run(test_run_id),
	test_result_id INTEGER REFERENCES test_result(test_result_id),
	test_error_id INTEGER REFERENCES test_error(test_error_id),
	test_execution_status VARCHAR,
	test_started TIMESTAMP,
	test_finished TIMESTAMP,
	completed BOOLEAN,
	passed BOOLEAN,
	errored BOOLEAN,
	blocked BOOLEAN,
	skipped BOOLEAN,
	aborted BOOLEAN,
	settings TEXT,
	metadata TEXT,

	PRIMARY KEY (test_execution_id)
);
