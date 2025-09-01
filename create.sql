CREATE TABLE users (
    user_id INT PRIMARY KEY,
    username VARCHAR(100) NOT NULL UNIQUE,
    email_id VARCHAR(100) NOT NULL UNIQUE,
    user_age INT NOT NULL CHECK (user_age > 0),
    mobile_no INT NOT NULL
);


CREATE TABLE passengers (
    passenger_id CHAR(36) NOT NULL PRIMARY KEY,
    passenger_name VARCHAR(100) NOT NULL,
    passenger_age INT NOT NULL CHECK (passenger_age > 0),
	user_id INT NOT NULL,
	FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
);


CREATE TABLE railway_station (
    station_code INT PRIMARY KEY,
    station_name VARCHAR(100) NOT NULL UNIQUE,
    city VARCHAR(100) NOT NULL,
    state VARCHAR(100) NOT NULL
);

CREATE TABLE insurance (
    insurance_id CHAR(36) NOT NULL PRIMARY KEY,
	passenger_id CHAR(36) NOT NULL,
	insurance_coverage FLOAT,
	FOREIGN KEY (passenger_id) REFERENCES passengers(passenger_id) ON DELETE CASCADE
);


CREATE TABLE train (
    train_no INT PRIMARY KEY,
    train_name VARCHAR(100) NOT NULL UNIQUE,
    source_station_code INT NOT NULL,
    dest_station_code INT NOT NULL,
    total_seats INT NOT NULL CHECK (total_seats >= 0),
    working_days VARCHAR(255) NOT NULL,
    FOREIGN KEY (source_station_code) REFERENCES railway_station(station_code) ON DELETE CASCADE,
    FOREIGN KEY (dest_station_code) REFERENCES railway_station(station_code) ON DELETE CASCADE
);


CREATE TABLE ticket (
    pnr_num CHAR(36) NOT NULL PRIMARY KEY,
    source_station_code INT NOT NULL,
    dest_station_code INT NOT NULL,
    train_no INT NOT NULL,
    user_id INT NOT NULL,
    date DATE NOT NULL,
    passenger_id CHAR(36) NOT NULL,
 seat_type VARCHAR(20) NOT NULL CHECK (seat_type IN ('Economy', 'Business', 'FirstClass')),
    booking_status VARCHAR(20) DEFAULT 'Waiting' CHECK (booking_status IN ('Confirmed', 'Waiting', 'Cancelled')),
    booking_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (source_station_code) REFERENCES railway_station(station_code),
    FOREIGN KEY (dest_station_code) REFERENCES railway_station(station_code),
    FOREIGN KEY (train_no) REFERENCES train(train_no),
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (passenger_id) REFERENCES passenger(passenger_id)
);


Create table feedback (

Feedback_id INT primary key,
Rating INT CHECK (rating >=1 and rating <= 1),
Pnr_num CHAR(36) NOT NULL,
User_id INT,
Foreign key (user_id) references users(user_id) on delete cascade,
Foreign key (pnr_num) references ticket(pnr_num) on delete cascade
);


CREATE TABLE payment (
    payment_id INT PRIMARY KEY,
    pnr_num CHAR(36) NOT NULL,
    ticket_fare DECIMAL(10, 2) NOT NULL CHECK (ticket_fare > 0),
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (pnr_num) REFERENCES ticket(pnr_num)
);


CREATE TABLE cancellation (
    cancellation_id INT PRIMARY KEY,
    pnr_num CHAR(36) NOT NULL,
    cancellation_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    refund_amount DECIMAL(10, 2),
    FOREIGN KEY (pnr_num) REFERENCES ticket(pnr_num) ON DELETE CASCADE
);
CREATE TABLE schedule (
    schedule_id INT PRIMARY KEY,
    train_no INT NOT NULL,
    curr_station_code INT NOT NULL,
    next_station_code INT,
    arr_time TIME NOT NULL,
    dep_time TIME NOT NULL CHECK (arr_time <= dep_time),
    FOREIGN KEY (train_no) REFERENCES train(train_no) ON DELETE CASCADE,
    FOREIGN KEY (curr_station_code) REFERENCES railway_station(station_code),
    FOREIGN KEY (next_station_code) REFERENCES railway_station(station_code)
);

