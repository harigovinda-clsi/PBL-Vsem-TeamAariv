-- Database: CampusSaarthiDB (PostgreSQL)

CREATE TABLE users (
    student_id VARCHAR(20) PRIMARY KEY, -- e.g., '260112459'
    roll_no VARCHAR(20) UNIQUE NOT NULL, -- e.g., '2318756'
    branch VARCHAR(30) NOT NULL,         -- CSE, AI/ML, Cybersecurity, ECE, etc.
    mobile VARCHAR(15) NOT NULL,
    wallet_balance NUMERIC(10, 2) DEFAULT 500.00
);

-- Index for O(log N) branch-based queries and matching
CREATE INDEX idx_users_branch ON users(branch);

CREATE TABLE print_jobs (
    job_id SERIAL PRIMARY KEY,
    student_id VARCHAR(20) REFERENCES users(student_id) ON DELETE CASCADE,
    service_type VARCHAR(30) NOT NULL, -- 'xerox', 'lamination', 'thesis', 'stationery'
    quantity INT NOT NULL,
    total_price NUMERIC(8, 2) NOT NULL,
    status VARCHAR(20) DEFAULT 'QUEUED', -- 'QUEUED', 'PROCESSING', 'COMPLETED'
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_print_status ON print_jobs(status);

CREATE TABLE canteen_bookings (
    booking_id SERIAL PRIMARY KEY,
    student_id VARCHAR(20) REFERENCES users(student_id),
    tier VARCHAR(20) NOT NULL, -- 'normal' or 'priority'
    guests INT NOT NULL,
    total_fee NUMERIC(8, 2) NOT NULL,
    slot_time TIMESTAMP NOT NULL
);
