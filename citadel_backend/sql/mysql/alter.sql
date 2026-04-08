use citadel;

ALTER TABLE individual_guardian
    ADD COLUMN client_id BIGINT NOT NULL AFTER id;

ALTER TABLE individual_guardian
    ADD CONSTRAINT fk_client
    FOREIGN KEY (client_id) REFERENCES client(id)
    ON DELETE CASCADE;

ALTER TABLE `app_users`
    MODIFY `role` ENUM('AGENT', 'CLIENT', 'CORPORATE_CLIENT', 'ADMIN') NOT NULL;


ALTER Table `individual_guardian`
    DROP COLUMN `beneficiary_id`,
    DROP Column `relationship_to_beneficiary`;

ALTER Table `individual_guardian`
    DROP CONSTRAINT individual_guardian_ibfk_1,
    DROP KEY `beneficiary_id`,
    DROP COLUMN `beneficiary_id`,
    DROP COLUMN `relationship_to_beneficiary`;

Create table beneficiary_guardian (
    `id` BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `beneficiary_id` BIGINT NOT NULL,
    `guardian_id` BIGINT NOT NULL,
    `relationship_to_beneficiary` ENUM('FATHER', 'MOTHER', 'UNCLE', 'AUNT', 'BROTHER', 'SISTER', 'GRANDFATHER', 'GRANDMOTHER', 'OTHER') NOT NULL,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP );

DROP TABLE IF EXISTS `beneficiary_guardian`;

CREATE TABLE individual_beneficiary_guardian (
    id BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    individual_beneficiary_id BIGINT NOT NULL,
    individual_guardian_id BIGINT NOT NULL,
    relationship_to_beneficiary VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (individual_beneficiary_id) REFERENCES individual_beneficiaries(id),
    FOREIGN KEY (individual_guardian_id) REFERENCES individual_guardian(id)
);

ALTER TABLE product_type
    MODIFY COLUMN status BOOLEAN;

ALTER TABLE product
    MODIFY COLUMN status BOOLEAN;

ALTER TABLE product
    MODIFY COLUMN risk_level ENUM('HIGH', 'MEDIUM', 'LOW');

ALTER TABLE bank_file_upload
    ADD column remarks VARCHAR(255);

ALTER TABLE bank_file_upload
    DROP column updated_by;

ALTER TABLE checker
    add column updated_by varchar(255);

ALTER TABLE checker
    ADD column remarks VARCHAR(255);

ALTER TABLE approver
    add column updated_by varchar(255);

ALTER TABLE approver
    MODIFY COLUMN status enum('PENDING','APPROVED','FAILED');

ALTER TABLE checker
    MODIFY COLUMN status enum('PENDING','APPROVED','FAILED');

ALTER TABLE bank_file_upload
    MODIFY COLUMN status enum('PENDING','APPROVED','FAILED');

ALTER TABLE product_type
    DROP column image;

ALTER TABLE payment_transaction
    CHANGE COLUMN client_id individual_client_id BIGINT,
    ADD COLUMN corporate_client_id BIGINT DEFAULT NULL AFTER individual_client_id;

ALTER TABLE payment_transaction
    ADD CONSTRAINT fk_individual_client FOREIGN KEY (individual_client_id) REFERENCES client(id),
    ADD CONSTRAINT fk_corporate_client FOREIGN KEY (corporate_client_id) REFERENCES corporate_client(id);

ALTER TABLE payment_transaction
    MODIFY COLUMN individual_client_id BIGINT DEFAULT NULL;

ALTER TABLE payment_transaction CHANGE COLUMN refer_to order_type ENUM('INDIVIDUAL', 'CORPORATE');

-- 1. Update 'agency' table
ALTER TABLE agency MODIFY agency_type ENUM('CITADEL', 'OTHER');

-- 2. Update 'agent' table
ALTER TABLE agent MODIFY agent_role ENUM('MGR', 'P2P', 'SM', 'AVP', 'VP', 'SVP', 'DIRECT_SVP', 'HOS', 'CEO', 'CCSB', 'CWP');

-- 3. Update 'app_users' table
ALTER TABLE app_users MODIFY role ENUM('AGENT', 'CLIENT', 'CORPORATE_CLIENT', 'ADMIN');

-- 4. Update 'approver' table
ALTER TABLE approver MODIFY status ENUM('PENDING', 'APPROVED', 'FAILED');

-- 5. Update 'bank_file_upload' table
ALTER TABLE bank_file_upload MODIFY status ENUM('PENDING', 'APPROVED', 'FAILED');

-- 6. Update 'checker' table
ALTER TABLE checker MODIFY status ENUM('PENDING', 'APPROVED', 'FAILED');

-- 7. Update 'individual_beneficiaries' table
ALTER TABLE individual_beneficiaries MODIFY gender ENUM('MALE', 'FEMALE');

-- 8. Update 'individual_guardian' table
ALTER TABLE individual_guardian MODIFY gender ENUM('MALE', 'FEMALE');

-- 9. Update 'individual_pep_info' table
ALTER TABLE individual_pep_info MODIFY pep_type ENUM('SELF', 'FAMILY', 'ASSOCIATE');

-- 10. Update 'payment' table
ALTER TABLE payment MODIFY payment_method ENUM('ONLINE_BANKING', 'MANUAL_TRANSFER');
ALTER TABLE payment MODIFY payment_status ENUM('PENDING', 'COMPLETED', 'FAILED');

-- 11. Update 'payment_transaction' table
ALTER TABLE payment_transaction MODIFY order_type ENUM('INDIVIDUAL', 'CORPORATE');
ALTER TABLE payment_transaction MODIFY payment_type ENUM('MANUAL', 'ONLINE_BANKING');
ALTER TABLE payment_transaction MODIFY status ENUM('SUCCESS', 'PENDING', 'FAILED');
ALTER TABLE payment_transaction MODIFY transaction_type ENUM('DEBIT', 'CREDIT');

-- 12. Update 'product' table
ALTER TABLE product MODIFY risk_level ENUM('HIGH', 'MEDIUM', 'LOW');

-- 13. Update 'sign_up_history' table
ALTER TABLE sign_up_history MODIFY agency_type ENUM('CITADEL', 'OTHER');
ALTER TABLE sign_up_history MODIFY pep_type ENUM('SELF', 'FAMILY', 'ASSOCIATE');
ALTER TABLE sign_up_history MODIFY user_type ENUM('CORPORATE_CLIENT', 'AGENT', 'CLIENT');

-- 14. Update 'user_details' table
ALTER TABLE user_details MODIFY gender ENUM('MALE', 'FEMALE');
ALTER TABLE user_details MODIFY marital_status ENUM('SINGLE', 'MARRIED');
ALTER TABLE user_details MODIFY resident_status ENUM('RESIDENT', 'NON_RESIDENT');

-- 12/10/2024
-- Step 1: Remove the foreign key constraints
ALTER TABLE product_order_individual
    DROP FOREIGN KEY product_order_individual_ibfk_3,  -- user_detail_id
    DROP FOREIGN KEY product_order_individual_ibfk_4,  -- employment_details_id
    DROP FOREIGN KEY product_order_individual_ibfk_5;  -- individual_pep_status_id

-- Step 2: Remove the specified columns
ALTER TABLE product_order_individual
    DROP COLUMN user_detail_id,
    DROP COLUMN referral_code_agent,
    DROP COLUMN employment_details_id,
    DROP COLUMN individual_pep_status_id;

-- Step 3: Modify the client_id column to allow NULL values
ALTER TABLE product_order_individual
    MODIFY COLUMN client_id BIGINT DEFAULT NULL;

-- Step 4: Add a new column corporate_client_id
ALTER TABLE product_order_individual
    ADD COLUMN corporate_client_id BIGINT DEFAULT NULL AFTER client_id;

-- Step 5: Create a foreign key for corporate_client_id
ALTER TABLE product_order_individual
    ADD CONSTRAINT product_order_individual_ibfk_corporate
        FOREIGN KEY (corporate_client_id) REFERENCES corporate_client (id) ON DELETE SET NULL;

-- Step 6: Add a created_by column
ALTER TABLE product_order_individual
    ADD COLUMN created_by BIGINT UNSIGNED DEFAULT NULL;

-- Step 7: Create a foreign key for created_by
ALTER TABLE product_order_individual DROP COLUMN created_by;
ALTER TABLE product_order_individual ADD COLUMN created_by bigint DEFAULT NULL;

ALTER TABLE product_order_individual
    ADD CONSTRAINT `product_order_individual_ibfk_created_by` FOREIGN KEY (`created_by`) REFERENCES `app_users` (`id`) ON DELETE SET NULL;

ALTER TABLE product_order_individual
    RENAME TO product_order;

ALTER TABLE product_order
    ADD COLUMN purchased_amount DECIMAL(10, 2) AFTER product_id,
    ADD COLUMN status ENUM('PENDING', 'COMPLETE', 'FAILED') DEFAULT 'PENDING' AFTER bank_details_id;

ALTER TABLE product_order
    ADD COLUMN client_type ENUM('INDIVIDUAL', 'CORPORATE') DEFAULT 'INDIVIDUAL' AFTER bank_details_id,
    ADD COLUMN payment_transaction_id BIGINT DEFAULT NULL AFTER client_type;

ALTER TABLE product_order
    ADD CONSTRAINT fk_payment_transaction
        FOREIGN KEY (payment_transaction_id) REFERENCES payment_transaction(id) ON DELETE SET NULL;

ALTER TABLE product_order
    ADD COLUMN start_date TIMESTAMP NULL AFTER status,
    ADD COLUMN end_date TIMESTAMP NULL AFTER start_date;

-- Step 1: Drop the existing foreign key constraint
ALTER TABLE product_order
    DROP FOREIGN KEY product_order_ibfk_1;

ALTER TABLE product_order
    MODIFY client_id BIGINT NULL;

-- Step 2: Add the new foreign key constraint
ALTER TABLE product_order
    ADD CONSTRAINT product_order_ibfk_1 FOREIGN KEY (client_id) REFERENCES client (id) ON DELETE CASCADE;

ALTER TABLE citadel.product
    RENAME COLUMN product_name TO name;

-- 21/10/2024
ALTER TABLE corporate_client
    CHANGE COLUMN user_id app_user_id BIGINT NOT NULL;

-- Add foreign key constraint for app_user_id in corporate_client table
ALTER TABLE corporate_client
    ADD CONSTRAINT fk_corporate_app_user
        FOREIGN KEY (app_user_id) REFERENCES app_users (id);

-- Add foreign key constraint for user_detail_id in corporate_client table
ALTER TABLE corporate_client
    ADD CONSTRAINT fk_corporate_user_detail
        FOREIGN KEY (user_detail_id) REFERENCES user_details (id);

-- Add new column and foreign key constraint in individual_pep_info table
ALTER TABLE citadel.individual_pep_info
    ADD COLUMN corporate_client_id BIGINT NULL,
    ADD CONSTRAINT fk_corporate_client_id
        FOREIGN KEY (corporate_client_id) REFERENCES corporate_client(id);

ALTER TABLE corporate_client
    ADD COLUMN agent_id BIGINT DEFAULT NULL
        AFTER referral_code_agent;

ALTER TABLE corporate_client
    ADD CONSTRAINT fk_corporate_agent
        FOREIGN KEY (agent_id) REFERENCES agent (id);


-- Add status column to client table
ALTER TABLE client
    ADD COLUMN status TINYINT(1) NOT NULL DEFAULT '1'
        AFTER employment_details_id;

ALTER TABLE corporate_client
    DROP COLUMN referral_code_agent,
    DROP COLUMN employment_details_id,
    CHANGE corporate_pep_status_id pep_status_id BIGINT NULL,
    ADD client_id BIGINT NOT NULL AFTER user_detail_id;

ALTER TABLE corporate_client
    DROP FOREIGN KEY fk_corporate_agent,
    DROP COLUMN agent_id;

-- Step 1: Rename the table
RENAME TABLE individual_wealth_income TO wealth_income;

-- Step 2: Drop the existing foreign key constraint
ALTER TABLE client
    DROP FOREIGN KEY fk_individual_wealth_income;

-- Step 3: Add the new foreign key constraint
ALTER TABLE client
    ADD CONSTRAINT fk_wealth_income
        FOREIGN KEY (individual_wealth_income_id) REFERENCES wealth_income (id) ON DELETE SET NULL;

-- Step 1: Drop the foreign key constraint
ALTER TABLE wealth_income
    DROP FOREIGN KEY wealth_income_ibfk_1;

ALTER TABLE wealth_income DROP COLUMN client_id;

ALTER TABLE client
    RENAME COLUMN individual_wealth_income_id TO wealth_income_id;

-- edry@appxtream 22/10/2024 --
ALTER TABLE app_users
    RENAME COLUMN role TO user_type;

ALTER TABLE individual_pep_info
    DROP FOREIGN KEY fk_pep_status_client_id,
    DROP COLUMN client_id;

ALTER TABLE client
    ADD COLUMN pep_info_id BIGINT DEFAULT NULL,
    ADD CONSTRAINT fk_client_pep_info_id FOREIGN KEY (pep_info_id) REFERENCES individual_pep_info(id);

ALTER TABLE corporate_client
    ADD COLUMN pep_info_id BIGINT DEFAULT NULL,
    ADD CONSTRAINT fk_corporate_client_pep_info_id FOREIGN KEY (pep_info_id) REFERENCES individual_pep_info(id);

RENAME TABLE individual_pep_info TO pep_info;

ALTER TABLE corporate_client
    DROP COLUMN pep_status_id;

ALTER TABLE bank_details
    DROP FOREIGN KEY bank_details_ibfk_1;

ALTER TABLE bank_details DROP COLUMN app_user_id;

ALTER TABLE corporate_client
    ADD COLUMN wealth_income_id BIGINT DEFAULT NULL;

ALTER TABLE corporate_client
    ADD CONSTRAINT fk_wealth_income_id
        FOREIGN KEY (wealth_income_id) REFERENCES wealth_income (id)
            ON DELETE SET NULL;

-- thives@appxtream 22/10/2024 --
ALTER TABLE client
    DROP COLUMN agent_referral_code;

ALTER TABLE user_details
    ADD COLUMN mobile_country_code VARCHAR(5) after name;

ALTER TABLE user_details
    RENAME COLUMN ic_passport TO identity_card_number;

ALTER TABLE user_details
    RENAME COLUMN ic_document TO identity_card_image_key,
    RENAME COLUMN selfie_document TO selfie_image_key;

ALTER TABLE user_details
    RENAME COLUMN proof_of_address TO proof_of_address_key;

ALTER TABLE user_details
    RENAME COLUMN onboarding_agreement TO onboarding_agreement_key;

ALTER TABLE client
    ADD COLUMN `employment_type` varchar(255) DEFAULT NULL AFTER agent_id,
    ADD COLUMN `employer_name` varchar(255) DEFAULT NULL AFTER employment_type,
    ADD COLUMN `industry_type` varchar(255) DEFAULT NULL AFTER employer_name,
    ADD COLUMN `job_title` varchar(255) DEFAULT NULL AFTER industry_type,
    ADD COLUMN `employer_address` varchar(255) DEFAULT NULL AFTER job_title,
    ADD COLUMN `employer_postcode` varchar(255) DEFAULT NULL AFTER employer_address,
    ADD COLUMN `employer_city` varchar(255) DEFAULT NULL AFTER employer_postcode,
    ADD COLUMN `employer_state` varchar(255) DEFAULT NULL AFTER employer_city,
    ADD COLUMN `employer_country` varchar(255) DEFAULT NULL AFTER employer_state;

ALTER TABLE client
    DROP COLUMN employment_details_id;

ALTER TABLE client
    ADD COLUMN annual_income_declaration varchar(255) DEFAULT NULL AFTER employer_country,
    ADD COLUMN source_of_income varchar(255) DEFAULT NULL AFTER annual_income_declaration,
    ADD COLUMN source_of_income_remark text DEFAULT NULL AFTER source_of_income;

ALTER TABLE client
    DROP FOREIGN KEY fk_wealth_income;

ALTER TABLE client
    DROP COLUMN wealth_income_id;

ALTER TABLE client
    DROP COLUMN status;

ALTER TABLE sign_up_history
    RENAME COLUMN country_code TO mobile_country_code;

ALTER TABLE sign_up_history
    ADD COLUMN `gender` ENUM('MALE','FEMALE','OTHER') DEFAULT NULL AFTER mobile_number;

ALTER TABLE sign_up_history
    ADD COLUMN `nationality` VARCHAR(255) DEFAULT NULL AFTER country;

ALTER TABLE sign_up_history
    ADD COLUMN `residential_status` ENUM('RESIDENT', 'NON_RESIDENT', 'PERMANENT_RESIDENT', 'CITIZEN') DEFAULT NULL AFTER marital_status;

ALTER TABLE user_details
    MODIFY COLUMN gender VARCHAR(255),
    MODIFY COLUMN resident_status VARCHAR(255),
    MODIFY COLUMN marital_status VARCHAR(255);

-- thives@appxtream 28/10/2024 --
ALTER TABLE `sign_up_history`
    MODIFY COLUMN `user_type` VARCHAR(255) DEFAULT NULL,
    MODIFY COLUMN `agency_type` VARCHAR(255) DEFAULT NULL,
    MODIFY COLUMN `marital_status` VARCHAR(255) DEFAULT NULL,
    MODIFY COLUMN `gender` VARCHAR(255) DEFAULT NULL,
    MODIFY COLUMN `residential_status` VARCHAR(255) DEFAULT NULL,
    MODIFY COLUMN `pep_type` VARCHAR(255) DEFAULT NULL,
    MODIFY COLUMN `employment_type` VARCHAR(255) DEFAULT NULL;

ALTER TABLE client
    MODIFY COLUMN `employment_type` VARCHAR(255) DEFAULT NULL;

ALTER TABLE pep_info
    MODIFY COLUMN `pep_type` VARCHAR(255) DEFAULT NULL;

ALTER TABLE client
    ADD COLUMN member_id VARCHAR(255) NOT NULL after id;

ALTER TABLE agent
    ADD COLUMN agent_id VARCHAR(255) NOT NULL after id;

ALTER TABLE client
    ADD COLUMN pin CHAR(6) DEFAULT NULL CHECK (pin REGEXP '^[0-9]{6}$') after agent_id;

ALTER TABLE app_user_sessions
    RENAME COLUMN user_id TO app_user_id;

ALTER TABLE client
    ADD COLUMN status BOOLEAN DEFAULT TRUE AFTER source_of_income_remark;

ALTER TABLE user_details
    ADD COLUMN digital_signature_key VARCHAR(255) after selfie_image_key;

-- thives@appxtream 05/11/2024 --
ALTER TABLE agent
    MODIFY COLUMN `agent_role` VARCHAR(255) DEFAULT NULL;

-- thives@appxtream 06/11/2024 --
ALTER TABLE `bank_details`
    ADD COLUMN `app_user_id` BIGINT DEFAULT NULL AFTER `id`,
    ADD CONSTRAINT bank_details_ibfk_1 FOREIGN KEY (app_user_id) REFERENCES app_users(id) ON DELETE CASCADE;

ALTER TABLE `bank_details`
    RENAME COLUMN permanent_address TO bank_address;

ALTER TABLE sign_up_history
    DROP COLUMN agency_type;

ALTER TABLE sign_up_history
    RENAME COLUMN identity_card_image_key TO identity_card_front_image_key;

ALTER TABLE sign_up_history
    ADD COLUMN identity_card_back_image_key text default null after identity_card_front_image_key;

ALTER TABLE sign_up_history
    ADD COLUMN proof_of_address_file_key text default null after proof_of_bank_account_key;

ALTER TABLE sign_up_history
    RENAME COLUMN recruit_manager TO recruit_manager_code;

ALTER TABLE sign_up_history
    DROP COLUMN agency_name;

ALTER TABLE sign_up_history
    ADD COLUMN bank_postcode VARCHAR(255) DEFAULT NULL AFTER bank_address;

ALTER TABLE sign_up_history
    ADD COLUMN bank_city VARCHAR(255) DEFAULT NULL AFTER bank_postcode,
    ADD COLUMN bank_state VARCHAR(255) DEFAULT NULL AFTER bank_city,
    ADD COLUMN bank_country VARCHAR(255) DEFAULT NULL AFTER bank_state;

ALTER TABLE user_details
    RENAME COLUMN identity_card_image_key TO identity_card_front_image_key;

ALTER TABLE user_details
    ADD COLUMN identity_card_back_image_key text default null after identity_card_front_image_key;

ALTER TABLE user_details
    RENAME COLUMN proof_of_address_key TO proof_of_address_file_key;

-- edry@appxtream.com 08/11/2024 --

-- UPDATE PRODUCT CONFIGURATION --

ALTER TABLE product
    ADD COLUMN code VARCHAR(255) AFTER name;

ALTER TABLE product
    ADD COLUMN tranche_size DECIMAL(10, 2) AFTER code;

ALTER TABLE product
    ADD COLUMN minimum_subscription_amount DECIMAL(10, 2) AFTER tranche_size;

ALTER TABLE product
    ADD COLUMN lock_in_period_option VARCHAR(255) AFTER minimum_subscription_amount;

ALTER TABLE product
    ADD COLUMN lock_in_period_value INT AFTER lock_in_period_option;

ALTER TABLE product
    ADD COLUMN trust_structure_id VARCHAR(255) AFTER lock_in_period_value;

ALTER TABLE product
    ADD COLUMN bank_name VARCHAR(255) AFTER trust_structure_id;

ALTER TABLE product
    ADD COLUMN is_published BOOLEAN DEFAULT TRUE AFTER status;

-- CREATE MANY TO MANY TABLE Product_Reallocation --

CREATE TABLE product_reallocation (
    `product_id` BIGINT NOT NULL,
    `reallocation_id` BIGINT NOT NULL,
    PRIMARY KEY (product_id, reallocation_id),  -- Composite primary key
    FOREIGN KEY (`product_id`) REFERENCES product(`id`),
    FOREIGN KEY (`reallocation_id`) REFERENCES product(`id`)
);

-- CREATE TABLE PRODUCT EARLY REDEMPTION --

CREATE TABLE product_early_redemption (
    `id` BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `product_id` BIGINT NOT NULL,
    `period` INT NOT NULL,
    `condition` VARCHAR(255) NOT NULL,
    `penalty_percentage` DECIMAL(10, 2) NOT NULL,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `created_by` BIGINT DEFAULT NULL,
    `updated_by` BIGINT DEFAULT NULL,
    FOREIGN KEY (`product_id`) REFERENCES product(`id`)
);

CREATE TABLE product_target_return (
    `id` BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `product_id` BIGINT NOT NULL,
    `condition_type` VARCHAR(255) NOT NULL,
    `minimum` DECIMAL(10, 2) NOT NULL,
    `maximum` DECIMAL(10, 2) NOT NULL,
    `target_return_per_annum` DECIMAL(10, 2) NOT NULL,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `created_by` BIGINT DEFAULT NULL,
    `updated_by` BIGINT DEFAULT NULL,
    FOREIGN KEY (`product_id`) REFERENCES product(`id`)
);


-- CREATE TABLE DIVIDEND SCHEDULE COLUMN ( product_id, date_of_month (varchar), created_at, updated_at, created_by, updated_by) --

CREATE TABLE product_dividend_schedule (
    `id` BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `product_id` BIGINT NOT NULL,
    `date_of_month` VARCHAR(255) NOT NULL,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `created_by` BIGINT DEFAULT NULL,
    `updated_by` BIGINT DEFAULT NULL,
    FOREIGN KEY (`product_id`) REFERENCES product(`id`)
);

-- CREATE TABLE AGREEMENT SCHEDULE ( product_id, date_of_month (varchar), created_at, updated_at, created_by, updated_by) --

CREATE TABLE product_agreement_schedule (
    `id` BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `product_id` BIGINT NOT NULL,
    `date_of_month` VARCHAR(255) NOT NULL,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `created_by` BIGINT DEFAULT NULL,
    `updated_by` BIGINT DEFAULT NULL,
    FOREIGN KEY (`product_id`) REFERENCES product(`id`)
);

-- CREATE TABLE PRODUCT COMMISSION ( product_id, agency_type, condition, created_at, updated_at, created_by, updated_by) --

CREATE TABLE product_commission (
    `id` BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `product_id` BIGINT NOT NULL,
    `agency_type` VARCHAR(255) NOT NULL,
    `condition` VARCHAR(255) NOT NULL,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `created_by` BIGINT DEFAULT NULL,
    `updated_by` BIGINT DEFAULT NULL,
    FOREIGN KEY (`product_id`) REFERENCES product(`id`)
);

-- CREATE TABLE PRODUCT AGENT COMMISSION ( product_id, agent_role, commission, created_at , updated_at, created_by, updated_by) --

CREATE TABLE product_agent_commission (
    `id` BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `product_id` BIGINT NOT NULL,
    `agent_role` VARCHAR(255) NOT NULL,
    `commission` DECIMAL(10, 2) NOT NULL,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `created_by` BIGINT DEFAULT NULL,
    `updated_by` BIGINT DEFAULT NULL,
    FOREIGN KEY (`product_id`) REFERENCES product(`id`)
);
-- boonheeloo@gmail.com 06/11/2024 --
ALTER TABLE `individual_beneficiaries`
    MODIFY COLUMN `gender` VARCHAR(255) DEFAULT NULL;

-- boonheeloo@gmail.com 06/11/2024 --
ALTER TABLE `individual_beneficiaries`
    MODIFY COLUMN guardian_id bigint DEFAULT NULL;

-- thives@appxtream 11/11/2024 --
ALTER TABLE individual_beneficiaries
    ADD COLUMN mobile_country_code VARCHAR(5) after marital_status;

-- thives@appxtream 11/11/2024 --
ALTER TABLE individual_beneficiaries
    RENAME COLUMN ic_document_key TO identity_card_front_image_key;

ALTER TABLE individual_beneficiaries
    RENAME COLUMN ic_passport TO identity_card_number;


-- boonheeloo@gmail.com 12/11/2024 --
ALTER TABLE individual_guardian
    ADD COLUMN mobile_country_code VARCHAR(5) after marital_status;

ALTER TABLE individual_guardian
    RENAME COLUMN ic_document_key TO identity_card_front_image_key;

ALTER TABLE individual_guardian
    RENAME COLUMN ic_passport TO identity_card_number;

ALTER TABLE individual_guardian DROP FOREIGN KEY fk_client;

ALTER TABLE individual_guardian DROP COLUMN client_id;

ALTER TABLE individual_beneficiaries ADD COLUMN `relationship_to_guardian` VARCHAR(255) DEFAULT NULL
        AFTER `relationship_to_settlor`;

-- thives@appxtream 12/11/2024 --
ALTER TABLE agent
    RENAME COLUMN recruit_manager TO recruit_manager_id;

ALTER TABLE agent
    DROP FOREIGN KEY `agent_ibfk_3`;

ALTER TABLE `agent`
    DROP COLUMN `bank_details_id`,
    DROP FOREIGN KEY `agent_ibfk_2`;

ALTER TABLE `agent`
    ADD CONSTRAINT `agent_ibfk_2` FOREIGN KEY (`user_detail_id`) REFERENCES `user_details` (`id`);

-- christine260812@gmail.com 12/11/2024 --
ALTER TABLE individual_beneficiaries
    ADD COLUMN is_deleted BOOLEAN DEFAULT FALSE;

ALTER TABLE bank_details
    ADD COLUMN is_deleted BOOLEAN DEFAULT FALSE;

-- zack@nexstream.com.my 11 Nov 2024
CREATE TABLE IF NOT EXISTS `niu_application`
(
    `id`         bigint    NOT NULL AUTO_INCREMENT,
    `client_id` bigint    NOT NULL,
    `amount_requested_in_rm` int    DEFAULT NULL,
    `tenure`  varchar(50)    DEFAULT NULL,
    `application_type`  varchar(10)    DEFAULT NULL,
    `full_name`  varchar(500)    DEFAULT NULL,
    `nric`  varchar(20)    DEFAULT NULL,
    `address`  varchar(500)    DEFAULT NULL,
    `postcode`  varchar(10)    DEFAULT NULL,
    `city`  varchar(50)    DEFAULT NULL,
    `state`  varchar(50)    DEFAULT NULL,
    `country`  varchar(50)    DEFAULT NULL,
    `moblile_country_code`  varchar(10)    DEFAULT NULL,
    `mobile_number`  varchar(50)    DEFAULT NULL,
    `email`  varchar(100)    DEFAULT NULL,
    `nature_of_business`  varchar(100)    DEFAULT NULL,
    `purpose_of_advances`  varchar(100)    DEFAULT NULL,
    `first_signee_name`  varchar(500)    DEFAULT NULL,
    `first_signee_nric`  varchar(20)    DEFAULT NULL,
    `first_signee_signed_date`  datetime    DEFAULT NULL,
    `first_signee_signature`  varchar(500)    DEFAULT NULL,
    `second_signee_name`  varchar(500)    DEFAULT NULL,
    `second_signee_nric`  varchar(20)    DEFAULT NULL,
    `second_signee_signed_date`  datetime    DEFAULT NULL,
    `second_signee_signature`  varchar(500)    DEFAULT NULL,
    `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;

CREATE TABLE IF NOT EXISTS `niu_application_document`
(
    `id`         bigint    NOT NULL AUTO_INCREMENT,
    `niu_application_id` bigint    NOT NULL,
    `filename` varchar(100)    DEFAULT NULL,
    `url` varchar(500)    DEFAULT NULL,
    `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;


-- ADD NEW COLUMN FOR PRODUCT_ORDER

ALTER TABLE individual_guardian
    ADD COLUMN client_id BIGINT NOT NULL AFTER id;

ALTER TABLE individual_guardian
    ADD CONSTRAINT fk_client
        FOREIGN KEY (client_id) REFERENCES client(id)
            ON DELETE CASCADE;

ALTER TABLE `app_users`
    MODIFY `role` ENUM('AGENT', 'CLIENT', 'CORPORATE_CLIENT', 'ADMIN') NOT NULL;


ALTER Table `individual_guardian`
    DROP COLUMN `beneficiary_id`,
    DROP Column `relationship_to_beneficiary`;

ALTER Table `individual_guardian`
    DROP CONSTRAINT individual_guardian_ibfk_1,
    DROP KEY `beneficiary_id`,
    DROP COLUMN `beneficiary_id`,
    DROP COLUMN `relationship_to_beneficiary`;

Create table beneficiary_guardian (
                                      `id` BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
                                      `beneficiary_id` BIGINT NOT NULL,
                                      `guardian_id` BIGINT NOT NULL,
                                      `relationship_to_beneficiary` ENUM('FATHER', 'MOTHER', 'UNCLE', 'AUNT', 'BROTHER', 'SISTER', 'GRANDFATHER', 'GRANDMOTHER', 'OTHER') NOT NULL,
                                      `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                                      `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP );

DROP TABLE IF EXISTS `beneficiary_guardian`;

CREATE TABLE individual_beneficiary_guardian (
                                                 id BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
                                                 individual_beneficiary_id BIGINT NOT NULL,
                                                 individual_guardian_id BIGINT NOT NULL,
                                                 relationship_to_beneficiary VARCHAR(255),
                                                 created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                                                 updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                                                 FOREIGN KEY (individual_beneficiary_id) REFERENCES individual_beneficiaries(id),
                                                 FOREIGN KEY (individual_guardian_id) REFERENCES individual_guardian(id)
);

ALTER TABLE product_type
    MODIFY COLUMN status BOOLEAN;

ALTER TABLE product
    MODIFY COLUMN status BOOLEAN;

ALTER TABLE product
    MODIFY COLUMN risk_level ENUM('HIGH', 'MEDIUM', 'LOW');

ALTER TABLE bank_file_upload
    ADD column remarks VARCHAR(255);

ALTER TABLE bank_file_upload
    DROP column updated_by;

ALTER TABLE checker
    add column updated_by varchar(255);

ALTER TABLE checker
    ADD column remarks VARCHAR(255);

ALTER TABLE approver
    add column updated_by varchar(255);

ALTER TABLE approver
    MODIFY COLUMN status enum('PENDING','APPROVED','FAILED');

ALTER TABLE checker
    MODIFY COLUMN status enum('PENDING','APPROVED','FAILED');

ALTER TABLE bank_file_upload
    MODIFY COLUMN status enum('PENDING','APPROVED','FAILED');

ALTER TABLE product_type
    DROP column image;

ALTER TABLE payment_transaction
    CHANGE COLUMN client_id individual_client_id BIGINT,
    ADD COLUMN corporate_client_id BIGINT DEFAULT NULL AFTER individual_client_id;

ALTER TABLE payment_transaction
    ADD CONSTRAINT fk_individual_client FOREIGN KEY (individual_client_id) REFERENCES client(id),
    ADD CONSTRAINT fk_corporate_client FOREIGN KEY (corporate_client_id) REFERENCES corporate_client(id);

ALTER TABLE payment_transaction
    MODIFY COLUMN individual_client_id BIGINT DEFAULT NULL;

ALTER TABLE payment_transaction CHANGE COLUMN refer_to order_type ENUM('INDIVIDUAL', 'CORPORATE');

-- 1. Update 'agency' table
ALTER TABLE agency MODIFY agency_type ENUM('CITADEL', 'OTHER');

-- 2. Update 'agent' table
ALTER TABLE agent MODIFY agent_role ENUM('MGR', 'P2P', 'SM', 'AVP', 'VP', 'SVP', 'DIRECT_SVP', 'HOS', 'CEO', 'CCSB', 'CWP');

-- 3. Update 'app_users' table
ALTER TABLE app_users MODIFY role ENUM('AGENT', 'CLIENT', 'CORPORATE_CLIENT', 'ADMIN');

-- 4. Update 'approver' table
ALTER TABLE approver MODIFY status ENUM('PENDING', 'APPROVED', 'FAILED');

-- 5. Update 'bank_file_upload' table
ALTER TABLE bank_file_upload MODIFY status ENUM('PENDING', 'APPROVED', 'FAILED');

-- 6. Update 'checker' table
ALTER TABLE checker MODIFY status ENUM('PENDING', 'APPROVED', 'FAILED');

-- 7. Update 'individual_beneficiaries' table
ALTER TABLE individual_beneficiaries MODIFY gender ENUM('MALE', 'FEMALE');

-- 8. Update 'individual_guardian' table
ALTER TABLE individual_guardian MODIFY gender ENUM('MALE', 'FEMALE');

-- 9. Update 'individual_pep_info' table
ALTER TABLE individual_pep_info MODIFY pep_type ENUM('SELF', 'FAMILY', 'ASSOCIATE');

-- 10. Update 'payment' table
ALTER TABLE payment MODIFY payment_method ENUM('ONLINE_BANKING', 'MANUAL_TRANSFER');
ALTER TABLE payment MODIFY payment_status ENUM('PENDING', 'COMPLETED', 'FAILED');

-- 11. Update 'payment_transaction' table
ALTER TABLE payment_transaction MODIFY order_type ENUM('INDIVIDUAL', 'CORPORATE');
ALTER TABLE payment_transaction MODIFY payment_type ENUM('MANUAL', 'ONLINE_BANKING');
ALTER TABLE payment_transaction MODIFY status ENUM('SUCCESS', 'PENDING', 'FAILED');
ALTER TABLE payment_transaction MODIFY transaction_type ENUM('DEBIT', 'CREDIT');

-- 12. Update 'product' table
ALTER TABLE product MODIFY risk_level ENUM('HIGH', 'MEDIUM', 'LOW');

-- 13. Update 'sign_up_history' table
ALTER TABLE sign_up_history MODIFY agency_type ENUM('CITADEL', 'OTHER');
ALTER TABLE sign_up_history MODIFY pep_type ENUM('SELF', 'FAMILY', 'ASSOCIATE');
ALTER TABLE sign_up_history MODIFY user_type ENUM('CORPORATE_CLIENT', 'AGENT', 'CLIENT');

-- 14. Update 'user_details' table
ALTER TABLE user_details MODIFY gender ENUM('MALE', 'FEMALE');
ALTER TABLE user_details MODIFY marital_status ENUM('SINGLE', 'MARRIED');
ALTER TABLE user_details MODIFY resident_status ENUM('RESIDENT', 'NON_RESIDENT');

-- 12/10/2024
-- Step 1: Remove the foreign key constraints
ALTER TABLE product_order_individual
    DROP FOREIGN KEY product_order_individual_ibfk_3,  -- user_detail_id
    DROP FOREIGN KEY product_order_individual_ibfk_4,  -- employment_details_id
    DROP FOREIGN KEY product_order_individual_ibfk_5;  -- individual_pep_status_id

-- Step 2: Remove the specified columns
ALTER TABLE product_order_individual
    DROP COLUMN user_detail_id,
    DROP COLUMN referral_code_agent,
    DROP COLUMN employment_details_id,
    DROP COLUMN individual_pep_status_id;

-- Step 3: Modify the client_id column to allow NULL values
ALTER TABLE product_order_individual
    MODIFY COLUMN client_id BIGINT DEFAULT NULL;

-- Step 4: Add a new column corporate_client_id
ALTER TABLE product_order_individual
    ADD COLUMN corporate_client_id BIGINT DEFAULT NULL AFTER client_id;

-- Step 5: Create a foreign key for corporate_client_id
ALTER TABLE product_order_individual
    ADD CONSTRAINT product_order_individual_ibfk_corporate
        FOREIGN KEY (corporate_client_id) REFERENCES corporate_client (id) ON DELETE SET NULL;

-- Step 6: Add a created_by column
ALTER TABLE product_order_individual
    ADD COLUMN created_by BIGINT UNSIGNED DEFAULT NULL;

-- Step 7: Create a foreign key for created_by
ALTER TABLE product_order_individual DROP COLUMN created_by;
ALTER TABLE product_order_individual ADD COLUMN created_by bigint DEFAULT NULL;

ALTER TABLE product_order_individual
    ADD CONSTRAINT `product_order_individual_ibfk_created_by` FOREIGN KEY (`created_by`) REFERENCES `app_users` (`id`) ON DELETE SET NULL;

ALTER TABLE product_order_individual
    RENAME TO product_order;

ALTER TABLE product_order
    ADD COLUMN purchased_amount DECIMAL(10, 2) AFTER product_id,
    ADD COLUMN status ENUM('PENDING', 'COMPLETE', 'FAILED') DEFAULT 'PENDING' AFTER bank_details_id;

ALTER TABLE product_order
    ADD COLUMN client_type ENUM('INDIVIDUAL', 'CORPORATE') DEFAULT 'INDIVIDUAL' AFTER bank_details_id,
    ADD COLUMN payment_transaction_id BIGINT DEFAULT NULL AFTER client_type;

ALTER TABLE product_order
    ADD CONSTRAINT fk_payment_transaction
        FOREIGN KEY (payment_transaction_id) REFERENCES payment_transaction(id) ON DELETE SET NULL;

ALTER TABLE product_order
    ADD COLUMN start_date TIMESTAMP NULL AFTER status,
    ADD COLUMN end_date TIMESTAMP NULL AFTER start_date;

-- Step 1: Drop the existing foreign key constraint
ALTER TABLE product_order
    DROP FOREIGN KEY product_order_ibfk_1;

ALTER TABLE product_order
    MODIFY client_id BIGINT NULL;

-- Step 2: Add the new foreign key constraint
ALTER TABLE product_order
    ADD CONSTRAINT product_order_ibfk_1 FOREIGN KEY (client_id) REFERENCES client (id) ON DELETE CASCADE;

ALTER TABLE citadel.product
    RENAME COLUMN product_name TO name;

-- 21/10/2024
ALTER TABLE corporate_client
    CHANGE COLUMN user_id app_user_id BIGINT NOT NULL;

-- Add foreign key constraint for app_user_id in corporate_client table
ALTER TABLE corporate_client
    ADD CONSTRAINT fk_corporate_app_user
        FOREIGN KEY (app_user_id) REFERENCES app_users (id);

-- Add foreign key constraint for user_detail_id in corporate_client table
ALTER TABLE corporate_client
    ADD CONSTRAINT fk_corporate_user_detail
        FOREIGN KEY (user_detail_id) REFERENCES user_details (id);

-- Add new column and foreign key constraint in individual_pep_info table
ALTER TABLE citadel.individual_pep_info
    ADD COLUMN corporate_client_id BIGINT NULL,
    ADD CONSTRAINT fk_corporate_client_id
        FOREIGN KEY (corporate_client_id) REFERENCES corporate_client(id);

ALTER TABLE corporate_client
    ADD COLUMN agent_id BIGINT DEFAULT NULL
        AFTER referral_code_agent;

ALTER TABLE corporate_client
    ADD CONSTRAINT fk_corporate_agent
        FOREIGN KEY (agent_id) REFERENCES agent (id);


-- Add status column to client table
ALTER TABLE client
    ADD COLUMN status TINYINT(1) NOT NULL DEFAULT '1'
        AFTER employment_details_id;

ALTER TABLE corporate_client
    DROP COLUMN referral_code_agent,
    DROP COLUMN employment_details_id,
    CHANGE corporate_pep_status_id pep_status_id BIGINT NULL,
    ADD client_id BIGINT NOT NULL AFTER user_detail_id;

ALTER TABLE corporate_client
    DROP FOREIGN KEY fk_corporate_agent,
    DROP COLUMN agent_id;

-- Step 1: Rename the table
RENAME TABLE individual_wealth_income TO wealth_income;

-- Step 2: Drop the existing foreign key constraint
ALTER TABLE client
    DROP FOREIGN KEY fk_individual_wealth_income;

-- Step 3: Add the new foreign key constraint
ALTER TABLE client
    ADD CONSTRAINT fk_wealth_income
        FOREIGN KEY (individual_wealth_income_id) REFERENCES wealth_income (id) ON DELETE SET NULL;

-- Step 1: Drop the foreign key constraint
ALTER TABLE wealth_income
    DROP FOREIGN KEY wealth_income_ibfk_1;

ALTER TABLE wealth_income DROP COLUMN client_id;

ALTER TABLE client
    RENAME COLUMN individual_wealth_income_id TO wealth_income_id;

-- edry@appxtream 22/10/2024 --
ALTER TABLE app_users
    RENAME COLUMN role TO user_type;

ALTER TABLE individual_pep_info
    DROP FOREIGN KEY fk_pep_status_client_id,
    DROP COLUMN client_id;

ALTER TABLE client
    ADD COLUMN pep_info_id BIGINT DEFAULT NULL,
    ADD CONSTRAINT fk_client_pep_info_id FOREIGN KEY (pep_info_id) REFERENCES individual_pep_info(id);

ALTER TABLE corporate_client
    ADD COLUMN pep_info_id BIGINT DEFAULT NULL,
    ADD CONSTRAINT fk_corporate_client_pep_info_id FOREIGN KEY (pep_info_id) REFERENCES individual_pep_info(id);

RENAME TABLE individual_pep_info TO pep_info;

ALTER TABLE corporate_client
    DROP COLUMN pep_status_id;

ALTER TABLE bank_details
    DROP FOREIGN KEY bank_details_ibfk_1;

ALTER TABLE bank_details DROP COLUMN app_user_id;

ALTER TABLE corporate_client
    ADD COLUMN wealth_income_id BIGINT DEFAULT NULL;

ALTER TABLE corporate_client
    ADD CONSTRAINT fk_wealth_income_id
        FOREIGN KEY (wealth_income_id) REFERENCES wealth_income (id)
            ON DELETE SET NULL;

-- thives@appxtream 22/10/2024 --
ALTER TABLE client
    DROP COLUMN agent_referral_code;

ALTER TABLE user_details
    ADD COLUMN mobile_country_code VARCHAR(5) after name;

ALTER TABLE user_details
    RENAME COLUMN ic_passport TO identity_card_number;

ALTER TABLE user_details
    RENAME COLUMN ic_document TO identity_card_image_key,
    RENAME COLUMN selfie_document TO selfie_image_key;

ALTER TABLE user_details
    RENAME COLUMN proof_of_address TO proof_of_address_key;

ALTER TABLE user_details
    RENAME COLUMN onboarding_agreement TO onboarding_agreement_key;

ALTER TABLE client
    ADD COLUMN `employment_type` varchar(255) DEFAULT NULL AFTER agent_id,
    ADD COLUMN `employer_name` varchar(255) DEFAULT NULL AFTER employment_type,
    ADD COLUMN `industry_type` varchar(255) DEFAULT NULL AFTER employer_name,
    ADD COLUMN `job_title` varchar(255) DEFAULT NULL AFTER industry_type,
    ADD COLUMN `employer_address` varchar(255) DEFAULT NULL AFTER job_title,
    ADD COLUMN `employer_postcode` varchar(255) DEFAULT NULL AFTER employer_address,
    ADD COLUMN `employer_city` varchar(255) DEFAULT NULL AFTER employer_postcode,
    ADD COLUMN `employer_state` varchar(255) DEFAULT NULL AFTER employer_city,
    ADD COLUMN `employer_country` varchar(255) DEFAULT NULL AFTER employer_state;

ALTER TABLE client
    DROP COLUMN employment_details_id;

ALTER TABLE client
    ADD COLUMN annual_income_declaration varchar(255) DEFAULT NULL AFTER employer_country,
    ADD COLUMN source_of_income varchar(255) DEFAULT NULL AFTER annual_income_declaration,
    ADD COLUMN source_of_income_remark text DEFAULT NULL AFTER source_of_income;

ALTER TABLE client
    DROP FOREIGN KEY fk_wealth_income;

ALTER TABLE client
    DROP COLUMN wealth_income_id;

ALTER TABLE client
    DROP COLUMN status;

ALTER TABLE sign_up_history
    RENAME COLUMN country_code TO mobile_country_code;

ALTER TABLE sign_up_history
    ADD COLUMN `gender` ENUM('MALE','FEMALE','OTHER') DEFAULT NULL AFTER mobile_number;

ALTER TABLE sign_up_history
    ADD COLUMN `nationality` VARCHAR(255) DEFAULT NULL AFTER country;

ALTER TABLE sign_up_history
    ADD COLUMN `residential_status` ENUM('RESIDENT', 'NON_RESIDENT', 'PERMANENT_RESIDENT', 'CITIZEN') DEFAULT NULL AFTER marital_status;

ALTER TABLE user_details
    MODIFY COLUMN gender VARCHAR(255),
    MODIFY COLUMN resident_status VARCHAR(255),
    MODIFY COLUMN marital_status VARCHAR(255);

-- thives@appxtream 28/10/2024 --
ALTER TABLE `sign_up_history`
    MODIFY COLUMN `user_type` VARCHAR(255) DEFAULT NULL,
    MODIFY COLUMN `agency_type` VARCHAR(255) DEFAULT NULL,
    MODIFY COLUMN `marital_status` VARCHAR(255) DEFAULT NULL,
    MODIFY COLUMN `gender` VARCHAR(255) DEFAULT NULL,
    MODIFY COLUMN `residential_status` VARCHAR(255) DEFAULT NULL,
    MODIFY COLUMN `pep_type` VARCHAR(255) DEFAULT NULL,
    MODIFY COLUMN `employment_type` VARCHAR(255) DEFAULT NULL;

ALTER TABLE client
    MODIFY COLUMN `employment_type` VARCHAR(255) DEFAULT NULL;

ALTER TABLE pep_info
    MODIFY COLUMN `pep_type` VARCHAR(255) DEFAULT NULL;

ALTER TABLE client
    ADD COLUMN member_id VARCHAR(255) NOT NULL after id;

ALTER TABLE agent
    ADD COLUMN agent_id VARCHAR(255) NOT NULL after id;

ALTER TABLE client
    ADD COLUMN pin CHAR(6) DEFAULT NULL CHECK (pin REGEXP '^[0-9]{6}$') after agent_id;

ALTER TABLE app_user_sessions
    RENAME COLUMN user_id TO app_user_id;

ALTER TABLE client
    ADD COLUMN status BOOLEAN DEFAULT TRUE AFTER source_of_income_remark;

ALTER TABLE user_details
    ADD COLUMN digital_signature_key VARCHAR(255) after selfie_image_key;

-- thives@appxtream 05/11/2024 --
ALTER TABLE agent
    MODIFY COLUMN `agent_role` VARCHAR(255) DEFAULT NULL;

-- thives@appxtream 06/11/2024 --
ALTER TABLE `bank_details`
    ADD COLUMN `app_user_id` BIGINT DEFAULT NULL AFTER `id`,
    ADD CONSTRAINT bank_details_ibfk_1 FOREIGN KEY (app_user_id) REFERENCES app_users(id) ON DELETE CASCADE;

ALTER TABLE `bank_details`
    RENAME COLUMN permanent_address TO bank_address;

ALTER TABLE sign_up_history
    DROP COLUMN agency_type;

ALTER TABLE sign_up_history
    RENAME COLUMN identity_card_image_key TO identity_card_front_image_key;

ALTER TABLE sign_up_history
    ADD COLUMN identity_card_back_image_key text default null after identity_card_front_image_key;

ALTER TABLE sign_up_history
    ADD COLUMN proof_of_address_file_key text default null after proof_of_bank_account_key;

ALTER TABLE sign_up_history
    RENAME COLUMN recruit_manager TO recruit_manager_code;

ALTER TABLE sign_up_history
    DROP COLUMN agency_name;

ALTER TABLE sign_up_history
    ADD COLUMN bank_postcode VARCHAR(255) DEFAULT NULL AFTER bank_address;

ALTER TABLE sign_up_history
    ADD COLUMN bank_city VARCHAR(255) DEFAULT NULL AFTER bank_postcode,
    ADD COLUMN bank_state VARCHAR(255) DEFAULT NULL AFTER bank_city,
    ADD COLUMN bank_country VARCHAR(255) DEFAULT NULL AFTER bank_state;

ALTER TABLE user_details
    RENAME COLUMN identity_card_image_key TO identity_card_front_image_key;

ALTER TABLE user_details
    ADD COLUMN identity_card_back_image_key text default null after identity_card_front_image_key;

ALTER TABLE user_details
    RENAME COLUMN proof_of_address_key TO proof_of_address_file_key;

-- edry@appxtream.com 08/11/2024 --

-- UPDATE PRODUCT CONFIGURATION --

ALTER TABLE product
    ADD COLUMN code VARCHAR(255) AFTER name;

ALTER TABLE product
    ADD COLUMN tranche_size DECIMAL(10, 2) AFTER code;

ALTER TABLE product
    ADD COLUMN minimum_subscription_amount DECIMAL(10, 2) AFTER tranche_size;

ALTER TABLE product
    ADD COLUMN lock_in_period_option VARCHAR(255) AFTER minimum_subscription_amount;

ALTER TABLE product
    ADD COLUMN lock_in_period_value INT AFTER lock_in_period_option;

ALTER TABLE product
    ADD COLUMN trust_structure_id VARCHAR(255) AFTER lock_in_period_value;

ALTER TABLE product
    ADD COLUMN bank_name VARCHAR(255) AFTER trust_structure_id;

ALTER TABLE product
    ADD COLUMN is_published BOOLEAN DEFAULT TRUE AFTER status;

-- CREATE TABLE PRODUCT EARLY REDEMPTION --

CREATE TABLE product_early_redemption (
                                          `id` BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
                                          `product_id` BIGINT NOT NULL,
                                          `period` INT NOT NULL,
                                          `condition` VARCHAR(255) NOT NULL,
                                          `penalty_percentage` DECIMAL(10, 2) NOT NULL,
                                          `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                                          `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                                          `created_by` BIGINT DEFAULT NULL,
                                          `updated_by` BIGINT DEFAULT NULL,
                                          FOREIGN KEY (`product_id`) REFERENCES product(`id`)
);

CREATE TABLE product_target_return (
                                       `id` BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
                                       `product_id` BIGINT NOT NULL,
                                       `condition_type` VARCHAR(255) NOT NULL,
                                       `minimum` DECIMAL(10, 2) NOT NULL,
                                       `maximum` DECIMAL(10, 2) NOT NULL,
                                       `target_return_per_annum` DECIMAL(10, 2) NOT NULL,
                                       `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                                       `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                                       `created_by` BIGINT DEFAULT NULL,
                                       `updated_by` BIGINT DEFAULT NULL,
                                       FOREIGN KEY (`product_id`) REFERENCES product(`id`)
);


-- CREATE TABLE DIVIDEND SCHEDULE COLUMN ( product_id, date_of_month (varchar), created_at, updated_at, created_by, updated_by) --

CREATE TABLE product_dividend_schedule (
                                           `id` BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
                                           `product_id` BIGINT NOT NULL,
                                           `date_of_month` VARCHAR(255) NOT NULL,
                                           `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                                           `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                                           `created_by` BIGINT DEFAULT NULL,
                                           `updated_by` BIGINT DEFAULT NULL,
                                           FOREIGN KEY (`product_id`) REFERENCES product(`id`)
);

-- CREATE TABLE AGREEMENT SCHEDULE ( product_id, date_of_month (varchar), created_at, updated_at, created_by, updated_by) --

CREATE TABLE product_agreement_schedule (
                                            `id` BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
                                            `product_id` BIGINT NOT NULL,
                                            `date_of_month` VARCHAR(255) NOT NULL,
                                            `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                                            `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                                            `created_by` BIGINT DEFAULT NULL,
                                            `updated_by` BIGINT DEFAULT NULL,
                                            FOREIGN KEY (`product_id`) REFERENCES product(`id`)
);

-- CREATE TABLE PRODUCT COMMISSION ( product_id, agency_type, condition, created_at, updated_at, created_by, updated_by) --

CREATE TABLE product_commission (
                                    `id` BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
                                    `product_id` BIGINT NOT NULL,
                                    `agency_type` VARCHAR(255) NOT NULL,
                                    `condition` VARCHAR(255) NOT NULL,
                                    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                                    `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                                    `created_by` BIGINT DEFAULT NULL,
                                    `updated_by` BIGINT DEFAULT NULL,
                                    FOREIGN KEY (`product_id`) REFERENCES product(`id`)
);

-- CREATE TABLE PRODUCT AGENT COMMISSION ( product_id, agent_role, commission, created_at , updated_at, created_by, updated_by) --

CREATE TABLE product_agent_commission (
                                          `id` BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
                                          `product_id` BIGINT NOT NULL,
                                          `agent_role` VARCHAR(255) NOT NULL,
                                          `commission` DECIMAL(10, 2) NOT NULL,
                                          `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                                          `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                                          `created_by` BIGINT DEFAULT NULL,
                                          `updated_by` BIGINT DEFAULT NULL,
                                          FOREIGN KEY (`product_id`) REFERENCES product(`id`)
);
-- boonheeloo@gmail.com 06/11/2024 --
ALTER TABLE `individual_beneficiaries`
    MODIFY COLUMN `gender` VARCHAR(255) DEFAULT NULL;

-- boonheeloo@gmail.com 06/11/2024 --
ALTER TABLE `individual_beneficiaries`
    MODIFY COLUMN guardian_id bigint DEFAULT NULL;

-- thives@appxtream 11/11/2024 --
ALTER TABLE individual_beneficiaries
    ADD COLUMN mobile_country_code VARCHAR(5) after marital_status;

-- thives@appxtream 11/11/2024 --
ALTER TABLE individual_beneficiaries
    RENAME COLUMN ic_document_key TO identity_card_front_image_key;

ALTER TABLE individual_beneficiaries
    RENAME COLUMN ic_passport TO identity_card_number;

-- zack@nexstream.com.my 11 Nov 2024
CREATE TABLE IF NOT EXISTS `niu_application`
(
    `id`         bigint    NOT NULL AUTO_INCREMENT,
    `client_id` bigint    NOT NULL,
    `amount_requested_in_rm` int    DEFAULT NULL,
    `tenure`  varchar(50)    DEFAULT NULL,
    `application_type`  varchar(10)    DEFAULT NULL,
    `full_name`  varchar(500)    DEFAULT NULL,
    `nric`  varchar(20)    DEFAULT NULL,
    `address`  varchar(500)    DEFAULT NULL,
    `postcode`  varchar(10)    DEFAULT NULL,
    `city`  varchar(50)    DEFAULT NULL,
    `state`  varchar(50)    DEFAULT NULL,
    `country`  varchar(50)    DEFAULT NULL,
    `moblile_country_code`  varchar(10)    DEFAULT NULL,
    `mobile_number`  varchar(50)    DEFAULT NULL,
    `email`  varchar(100)    DEFAULT NULL,
    `nature_of_business`  varchar(100)    DEFAULT NULL,
    `purpose_of_advances`  varchar(100)    DEFAULT NULL,
    `first_signee_name`  varchar(500)    DEFAULT NULL,
    `first_signee_nric`  varchar(20)    DEFAULT NULL,
    `first_signee_signed_date`  datetime    DEFAULT NULL,
    `first_signee_signature`  varchar(500)    DEFAULT NULL,
    `second_signee_name`  varchar(500)    DEFAULT NULL,
    `second_signee_nric`  varchar(20)    DEFAULT NULL,
    `second_signee_signed_date`  datetime    DEFAULT NULL,
    `second_signee_signature`  varchar(500)    DEFAULT NULL,
    `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;

CREATE TABLE IF NOT EXISTS `niu_application_document`
(
    `id`         bigint    NOT NULL AUTO_INCREMENT,
    `niu_application_id` bigint    NOT NULL,
    `filename` varchar(100)    DEFAULT NULL,
    `url` varchar(500)    DEFAULT NULL,
    `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;


-- ADD NEW COLUMN FOR PRODUCT_ORDER
ALTER TABLE product_order
    DROP FOREIGN KEY fk_payment_transaction,
    DROP COLUMN payment_transaction_id,
    MODIFY status VARCHAR(255) DEFAULT NULL,
    ADD COLUMN remark VARCHAR(255) DEFAULT NULL AFTER status;

-- edry@appxtream.com 12/11/2024 --

-- ADD DIVIDEN COLUMN FOR PRODUCT_ORDER
ALTER TABLE product_order
    ADD COLUMN dividend DECIMAL(10, 2) DEFAULT NULL AFTER purchased_amount;

ALTER TABLE product_order
    ADD COLUMN investment_tenure_month INT DEFAULT NULL AFTER dividend;


CREATE TABLE distribution_beneficiary (
                id BIGINT AUTO_INCREMENT PRIMARY KEY,
                product_order_id BIGINT,
                beneficiary_id BIGINT,
                percentage DOUBLE,
                type VARCHAR(255),
                CONSTRAINT fk_product_order FOREIGN KEY (product_order_id) REFERENCES product_order(id),
                CONSTRAINT fk_beneficiary FOREIGN KEY (beneficiary_id) REFERENCES individual_beneficiaries(id)
);

-- thives@appxtream 12/11/2024 --
ALTER TABLE bank_details
    ADD COLUMN is_deleted BOOLEAN DEFAULT FALSE AFTER bank_account_proof_key;

ALTER TABLE `niu_application` RENAME COLUMN `full_name` TO `name`;
ALTER TABLE `niu_application` RENAME COLUMN `nric` TO `document_number`;

-- christine260812@gmail.com 13/11/2024 --
ALTER TABLE individual_beneficiaries
    ADD COLUMN is_deleted BOOLEAN DEFAULT FALSE AFTER address_proof_key;

-- boonheeloo@gmail.com 13/11/2024 --
ALTER TABLE individual_guardian
    ADD COLUMN is_deleted BOOLEAN DEFAULT FALSE;

ALTER TABLE individual_guardian DROP FOREIGN KEY fk_client;

ALTER TABLE individual_guardian DROP COLUMN client_id;

ALTER TABLE user_details ADD COLUMN profile_picture_image_key TEXT DEFAULT NULL;

-- zack@nexstream.com.my 13 Nov 2024
CREATE TABLE IF NOT EXISTS `notifications`
(
    `id`                         bigint NOT NULL AUTO_INCREMENT,
    `app_user_id`                bigint NOT NULL,
    `one_signal_notification_id` varchar(255) DEFAULT NULL,
    `type`                      varchar(50) DEFAULT NULL,
    `title`                      varchar(255) DEFAULT NULL,
    `message`                    varchar(500) DEFAULT NULL,
    `imageUrl`                   varchar(500) DEFAULT NULL,
    `hasRead`                    tinyint(1)   DEFAULT NULL,
    `launchUrl`                  varchar(500) DEFAULT NULL,
    `createdAt`                  datetime     DEFAULT NULL,
    PRIMARY KEY (`id`),
    INDEX `app_user_id` (`app_user_id`),
    INDEX `one_signal_notification_id` (`one_signal_notification_id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4;

ALTER TABLE `app_user_sessions` ADD COLUMN `one_signal_subscription_id` VARCHAR(255) DEFAULT NULL AFTER `session_token`;

-- thives@appxtream.com 14/11/2024 --
ALTER TABLE client RENAME COLUMN member_id TO client_id;

ALTER TABLE product_type RENAME COLUMN product_type_name TO name;

ALTER TABLE product ADD COLUMN priority INTEGER DEFAULT NULL AFTER is_published;

ALTER TABLE product_order MODIFY COLUMN purchased_amount INTEGER DEFAULT 0;

-- boonheeloo@gmail.com 14/11/2024 --
ALTER TABLE individual_beneficiaries
    ADD COLUMN identity_card_back_image_key TEXT DEFAULT NULL
        AFTER identity_card_front_image_key;

ALTER TABLE individual_guardian
    ADD COLUMN identity_card_back_image_key TEXT DEFAULT NULL
        AFTER identity_card_front_image_key;

-- christine260812@gmail.com 14/11/2024
-- Create the corporate_details table if it doesn't exist
CREATE TABLE IF NOT EXISTS `corporate_details` (
       `id` bigint NOT NULL AUTO_INCREMENT,
       `entity_name` varchar(255) DEFAULT NULL,
       `entity_type` varchar(100) DEFAULT NULL,
       `registration_number` varchar(50) DEFAULT NULL,
       `date_incorporation` bigint DEFAULT NULL,
       `place_incorporation` varchar(100) DEFAULT NULL,
       `business_type` varchar(100) DEFAULT NULL,
       `registered_address` varchar(255) DEFAULT NULL,
       `postcode` varchar(20) DEFAULT NULL,
       `city` varchar(100) DEFAULT NULL,
       `state` varchar(100) DEFAULT NULL,
       `country` varchar(100) DEFAULT NULL,
       `have_different_registered_address` tinyint(1) DEFAULT '0',
       `business_address` varchar(255) DEFAULT NULL,
       `business_postcode` varchar(20) DEFAULT NULL,
       `business_city` varchar(100) DEFAULT NULL,
       `business_state` varchar(100) DEFAULT NULL,
       `business_country` varchar(100) DEFAULT NULL,
       `contact_is_myself` tinyint(1) DEFAULT '0',
       `contact_designation` varchar(100) DEFAULT NULL,
       `mobile_country_code` varchar(10) DEFAULT NULL,
       `mobile_number` varchar(20) DEFAULT NULL,
       `email` varchar(100) DEFAULT NULL,
       `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
       `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
       PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Add corporate_details_id and is_not_bankcrupt to corporate_client
ALTER TABLE corporate_client
    ADD COLUMN corporate_details_id BIGINT NOT NULL AFTER bank_details_id,
    ADD COLUMN is_not_bankcrupt BOOLEAN DEFAULT 0 AFTER corporate_details_id;

-- Modify column positions
ALTER TABLE corporate_client
    MODIFY COLUMN pep_info_id BIGINT DEFAULT NULL AFTER corporate_details_id,
    MODIFY COLUMN wealth_income_id BIGINT DEFAULT NULL AFTER pep_info_id,
    MODIFY COLUMN is_not_bankcrupt BOOLEAN DEFAULT 0 AFTER wealth_income_id,
    MODIFY COLUMN created_at TIMESTAMP NULL DEFAULT NULL AFTER is_not_bankcrupt;

-- Add the foreign key constraint to corporate_client
ALTER TABLE corporate_client
    ADD CONSTRAINT fk_corporate_details
        FOREIGN KEY (corporate_details_id) REFERENCES corporate_details(id);

-- Company beneficiaries, guardian
CREATE TABLE IF NOT EXISTS `company_guardian` (
                                                  `id` bigint NOT NULL AUTO_INCREMENT,
                                                  `full_name` varchar(255) DEFAULT NULL,
                                                  `ic_passport` varchar(255) DEFAULT NULL,
                                                  `dob` date DEFAULT NULL,
                                                  `gender` enum('MALE', 'FEMALE') DEFAULT NULL,
                                                  `nationality` varchar(255) DEFAULT NULL,
                                                  `address` text,
                                                  `postcode` varchar(255) DEFAULT NULL,
                                                  `city` varchar(255) DEFAULT NULL,
                                                  `state` varchar(255) DEFAULT NULL,
                                                  `country` varchar(255) DEFAULT NULL,
                                                  `residential_status` varchar(255) DEFAULT NULL,
                                                  `marital_status` varchar(255) DEFAULT NULL,
                                                  `mobile_country_code` varchar(5) DEFAULT NULL,
                                                  `mobile_number` varchar(255) DEFAULT NULL,
                                                  `email` varchar(255) DEFAULT NULL,
                                                  `ic_document_key` text,
                                                  `address_proof_key` text,
                                                  `is_deleted` tinyint(1) DEFAULT '0',
                                                  `created_at` timestamp NULL DEFAULT NULL,
                                                  `updated_at` timestamp NULL DEFAULT NULL,
                                                  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE IF NOT EXISTS `company_beneficiaries` (
                                                       `id` bigint NOT NULL AUTO_INCREMENT,
                                                       `client_id` bigint DEFAULT NULL,
                                                       `company_guardian_id` bigint DEFAULT NULL,
                                                       `relationship_to_settlor` varchar(255) DEFAULT NULL,
                                                       `relationship_to_guardian` varchar(255) DEFAULT NULL,
                                                       `full_name` varchar(255) DEFAULT NULL,
                                                       `identity_card_number` varchar(255) DEFAULT NULL,
                                                       `dob` date DEFAULT NULL,
                                                       `gender` varchar(255) DEFAULT NULL,
                                                       `nationality` varchar(255) DEFAULT NULL,
                                                       `address` text,
                                                       `postcode` varchar(255) DEFAULT NULL,
                                                       `city` varchar(255) DEFAULT NULL,
                                                       `state` varchar(255) DEFAULT NULL,
                                                       `country` varchar(255) DEFAULT NULL,
                                                       `residential_status` varchar(255) DEFAULT NULL,
                                                       `marital_status` varchar(255) DEFAULT NULL,
                                                       `mobile_country_code` varchar(5) DEFAULT NULL,
                                                       `mobile_number` varchar(255) DEFAULT NULL,
                                                       `email` varchar(255) DEFAULT NULL,
                                                       `identity_card_front_image_key` text,
                                                       `address_proof_key` text,
                                                       `is_deleted` tinyint(1) DEFAULT '0',
                                                       `created_at` timestamp NULL DEFAULT NULL,
                                                       `updated_at` timestamp NULL DEFAULT NULL,
                                                       PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

ALTER TABLE `company_beneficiaries`
    ADD CONSTRAINT `fk_company_beneficiaries_client_id`
        FOREIGN KEY (`client_id`) REFERENCES `corporate_client`(`id`),
    ADD CONSTRAINT `fk_company_beneficiaries_company_guardian_id`
        FOREIGN KEY (`company_guardian_id`) REFERENCES `company_guardian`(`id`);

ALTER TABLE company_beneficiaries
    ADD COLUMN identity_card_back_image_key TEXT DEFAULT NULL
        AFTER identity_card_front_image_key;

-- zack@nexstream.com.my 14 Nov 2024
CREATE TABLE IF NOT EXISTS `contact_us_form_submission`
(
    `id`                  bigint NOT NULL AUTO_INCREMENT,
    `name`                varchar(255) DEFAULT NULL,
    `mobile_country_code` varchar(5)   DEFAULT NULL,
    `mobile_number`       varchar(255) DEFAULT NULL,
    `email`               varchar(500) DEFAULT NULL,
    `reason`              varchar(500) DEFAULT NULL,
    `remark`              varchar(500) DEFAULT NULL,
    `created_at`          datetime     DEFAULT NULL,
    PRIMARY KEY (`id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4;

-- thives@appxtream.com 15/11/2024 --
ALTER TABLE product_order
    ADD COLUMN order_reference_number VARCHAR(255) NOT NULL after id;

ALTER TABLE corporate_details
    MODIFY COLUMN `date_incorporation` timestamp DEFAULT NULL;

ALTER TABLE corporate_details
    RENAME COLUMN `have_different_registered_address` TO `is_different_business_address`;

ALTER TABLE corporate_details
    ADD COLUMN contact_name VARCHAR(255) DEFAULT NULL AFTER contact_is_myself;

ALTER TABLE corporate_details
    RENAME COLUMN mobile_country_code TO contact_mobile_country_code,
    RENAME COLUMN mobile_number TO contact_mobile_number,
    RENAME COLUMN email TO contact_email;

ALTER TABLE corporate_details
    ADD COLUMN digital_signature_key VARCHAR(255) DEFAULT NULL AFTER contact_email;

ALTER TABLE corporate_client
    DROP COLUMN bank_details_id;

# ALTER TABLE corporate_client
#     DROP COLUMN app_user_id;

ALTER TABLE corporate_client
    ADD COLUMN is_bankrupt BOOLEAN DEFAULT FALSE AFTER is_not_bankcrupt;

ALTER TABLE corporate_client
    DROP COLUMN is_not_bankcrupt;

ALTER TABLE corporate_client
    ADD COLUMN annual_income_declaration varchar(255) DEFAULT NULL,
    ADD COLUMN source_of_income varchar(255) DEFAULT NULL,
    ADD COLUMN source_of_income_remark text DEFAULT NULL;

ALTER TABLE corporate_client
    DROP FOREIGN KEY fk_wealth_income_id,
    DROP COLUMN wealth_income_id;

ALTER TABLE corporate_client
    MODIFY COLUMN `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP AFTER source_of_income_remark,
    MODIFY COLUMN `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP AFTER source_of_income_remark;

ALTER TABLE company_beneficiaries
    RENAME COLUMN client_id TO corporate_client_id;

ALTER TABLE product_order MODIFY COLUMN purchased_amount DECIMAL(10,2) DEFAULT 0.0;

ALTER TABLE distribution_beneficiary
    ADD COLUMN `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
    ADD COLUMN `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;

ALTER TABLE `distribution_beneficiary`
    ADD COLUMN `main_beneficary_id` bigint DEFAULT NULL AFTER beneficiary_id;

ALTER TABLE `distribution_beneficiary`
    ADD CONSTRAINT `fk_main_beneficiary`
        FOREIGN KEY (`main_beneficary_id`) REFERENCES `distribution_beneficiary` (`id`) ON DELETE CASCADE;

ALTER TABLE distribution_beneficiary RENAME COLUMN beneficiary_id TO individual_beneficiary_id;
ALTER TABLE distribution_beneficiary RENAME COLUMN type TO beneficiary_type;
ALTER TABLE distribution_beneficiary RENAME COLUMN main_beneficary_id TO main_beneficiary_id;

ALTER TABLE distribution_beneficiary
    DROP constraint fk_main_beneficiary;
ALTER TABLE distribution_beneficiary
    DROP KEY fk_main_beneficiary;

ALTER TABLE `distribution_beneficiary`
    ADD CONSTRAINT `fk_main_beneficiary`
        FOREIGN KEY (`main_beneficiary_id`) REFERENCES `individual_beneficiaries` (`id`) ON DELETE CASCADE;

RENAME TABLE distribution_beneficiary TO product_beneficiaries;

-- zack@nexstream.com 15 Nov 2024
ALTER TABLE `client` MODIFY COLUMN `pin` CHAR(4) DEFAULT NULL CHECK (pin REGEXP '^[0-9]{4}$');

CREATE TABLE IF NOT EXISTS `secure_tag`
(
    `id`         bigint    NOT NULL AUTO_INCREMENT,
    `client_id` bigint    NOT NULL,
    `agent_id` bigint    NOT NULL,
    `token`        varchar(500)    DEFAULT NULL,
    `status`        varchar(20)    DEFAULT NULL,
    `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `expired_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4;
ALTER TABLE `secure_tag` MODIFY COLUMN status enum('PENDING_APPROVAL', 'APPROVED', 'REJECTED', 'CANCELLED', 'EXPIRED');

-- boonheeloo@gmail.com 15/11/2024 --
ALTER TABLE corporate_client
    CHANGE COLUMN is_not_bankcrupt is_bankrupt TINYINT(1) DEFAULT '0';

ALTER Table `corporate_client`
    DROP CONSTRAINT fk_corporate_app_user,
    DROP KEY `fk_corporate_app_user`,
    DROP COLUMN `app_user_id`;

ALTER TABLE corporate_client
    DROP COLUMN is_bankrupt;

-- thives@nexstream.com 18/11/2024 --
ALTER TABLE product_order
    DROP COLUMN client_type;

-- boonheeloo@gmail.com 18/11/2024 --
ALTER TABLE corporate_shareholders
    CHANGE COLUMN ic_document_key identity_card_front_image_key TEXT,
    ADD COLUMN identity_card_back_image_key TEXT DEFAULT NULL AFTER identity_card_front_image_key;

ALTER TABLE corporate_shareholders
    CHANGE COLUMN user_id app_user_id BIGINT NOT NULL;

ALTER TABLE corporate_shareholders
    ADD COLUMN mobile_country_code VARCHAR(5) DEFAULT NULL
        AFTER percentage_of_shareholdings;

ALTER TABLE corporate_shareholders
CHANGE COLUMN ic_passport identity_card_number VARCHAR(255) DEFAULT NULL;

ALTER TABLE corporate_shareholders
    DROP COLUMN nationality;

-- boonheeloo@gmail.com 19/11/2024 --
ALTER TABLE `pep_info`
    DROP FOREIGN KEY `fk_corporate_client_id`;

ALTER TABLE `pep_info`
    DROP INDEX `fk_corporate_client_id`;

ALTER TABLE `pep_info`
    DROP COLUMN `corporate_client_id`;

-- christine260812@gmail.com 19/11/2024
ALTER TABLE `bank_details`
    ADD COLUMN `individual_beneficiary_id` BIGINT DEFAULT NULL AFTER `app_user_id`,
    ADD CONSTRAINT bank_details_ibfk_2 FOREIGN KEY (individual_beneficiary_id) REFERENCES individual_beneficiaries(id) ON DELETE CASCADE,
    ADD COLUMN `corporate_shareholders_id` BIGINT DEFAULT NULL AFTER `individual_beneficiary_id`,
    ADD CONSTRAINT wallet_history_ibfk_3 FOREIGN KEY (corporate_shareholders_id) REFERENCES corporate_shareholders(id) ON DELETE CASCADE;

ALTER TABLE corporate_client
    ADD COLUMN is_deleted BOOLEAN DEFAULT FALSE AFTER source_of_income_remark;

ALTER TABLE corporate_details
    ADD COLUMN is_deleted BOOLEAN DEFAULT FALSE AFTER digital_signature_key;

ALTER TABLE corporate_shareholders
    ADD COLUMN is_deleted BOOLEAN DEFAULT FALSE AFTER address_proof_key;

-- boonheeloo@gmail.com 20/11/2024 --
ALTER TABLE corporate_details
    ADD COLUMN company_document TEXT
        AFTER digital_signature_key;
-- remember to clear table before execute--
ALTER TABLE corporate_client
    MODIFY COLUMN annual_income_declaration VARCHAR(255) NOT NULL,
    MODIFY COLUMN source_of_income VARCHAR(255) NOT NULL;

-- boonheeloo@gmail.com 22/11/2024 --
ALTER TABLE corporate_shareholders
    ADD COLUMN pep_info BIGINT DEFAULT NULL AFTER app_user_id;

-- christine260812@gmail.com 26/11/2024 --
CREATE TABLE IF NOT EXISTS `corporate_bank_details` (
      `id` bigint NOT NULL AUTO_INCREMENT,
      `corporate_client_id` bigint DEFAULT NULL,
      `bank_name` varchar(255) DEFAULT NULL,
      `account_number` varchar(255) DEFAULT NULL,
      `account_holder_name` varchar(255) DEFAULT NULL,
      `bank_address` varchar(255) DEFAULT NULL,
      `postcode` varchar(255) DEFAULT NULL,
      `city` varchar(255) DEFAULT NULL,
      `state` varchar(255) DEFAULT NULL,
      `country` varchar(255) DEFAULT NULL,
      `swift_code` varchar(255) DEFAULT NULL,
      `bank_account_proof_key` text,
      `is_deleted`  tinyint(1) DEFAULT '0',
      `created_at` timestamp NULL DEFAULT NULL,
      `updated_at` timestamp NULL DEFAULT NULL,
      PRIMARY KEY (`id`),
      KEY `corporate_id` (`corporate_client_id`),
      CONSTRAINT `corporate_bank_details_ibfk_1` FOREIGN KEY (`corporate_client_id`) REFERENCES `corporate_client` (`id`)
)ENGINE = InnoDB DEFAULT CHARSET = utf8mb4;

-- boonheeloo@gmail.com 26/11/2024 --
RENAME TABLE company_beneficiaries TO corporate_beneficiaries;

-- boonheeloo@gmail.com 27/11/2024 --
ALTER TABLE corporate_shareholders
    DROP FOREIGN KEY corporate_shareholders_ibfk_1;

ALTER TABLE corporate_shareholders
    CHANGE COLUMN app_user_id corporate_client_id BIGINT AFTER id;

-- zack@nexstream.com.my @ 28 Nov 2024
ALTER TABLE `secure_tag` ADD COLUMN `has_read` tinyint(1) DEFAULT false;

-- thives@appxtream.com 28/11/2024 --
ALTER TABLE corporate_shareholders
    DROP COLUMN corporate_client_id;

CREATE TABLE IF NOT EXISTS corporate_shareholders_pivot(
    `id` BIGINT NOT NULL AUTO_INCREMENT,
    `corporate_client_id` BIGINT DEFAULT NULL,
    `corporate_shareholder_id` BIGINT NOT NULL,
    `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    FOREIGN KEY (`corporate_client_id`) REFERENCES corporate_client(`id`) ON DELETE CASCADE,
    FOREIGN KEY (`corporate_shareholder_id`) REFERENCES corporate_shareholders(`id`) ON DELETE CASCADE
);

ALTER TABLE corporate_shareholders_pivot
    ADD COLUMN is_deleted BOOLEAN DEFAULT FALSE AFTER corporate_shareholder_id;

-- thives@appxtream.com 29/11/2024 --
ALTER Table `individual_guardian`
    ADD COLUMN client_id BIGINT DEFAULT NULL;
ALTER Table `individual_guardian`
    ADD CONSTRAINT `individual_guardian_ibfk_1` FOREIGN KEY (`client_id`) REFERENCES `client` (`id`);

-- christine260812@gmail.com @ 2/12/2024 --
ALTER TABLE `corporate_client`
    ADD COLUMN corporate_client_id VARCHAR(255) DEFAULT NULL AFTER id;

-- boonheeloo@gmail.com 3/12/2024 --
RENAME TABLE company_guardian TO corporate_guardian;

ALTER TABLE corporate_guardian
    ADD COLUMN corporate_client_id BIGINT NOT NULL AFTER id;

ALTER TABLE corporate_guardian
    CHANGE COLUMN ic_passport identity_card_number VARCHAR(255);

-- thives@appxtream.com 03/12/2024 --
ALTER TABLE corporate_client
    ADD COLUMN status BOOLEAN DEFAULT FALSE AFTER source_of_income_remark;

ALTER TABLE corporate_client
    ADD COLUMN approval_status VARCHAR(255) DEFAULT "PENDING" AFTER source_of_income_remark;

ALTER TABLE corporate_client
    ADD COLUMN approver_id BIGINT DEFAULT NULL AFTER created_at;

-- thives@appxtream.com 04/12/2024 --
ALTER TABLE agency
    RENAME COLUMN company_reg_number TO agency_reg_number;

ALTER TABLE agency
    RENAME COLUMN agency_pic TO agency_pic_name;

ALTER TABLE agency
    ADD COLUMN agency_pic_id VARCHAR(255) DEFAULT NULL,
    ADD COLUMN office_postcode VARCHAR(10) DEFAULT NULL,
    ADD COLUMN office_city VARCHAR(255) DEFAULT NULL,
    ADD COLUMN office_state VARCHAR(255) DEFAULT NULL;

ALTER TABLE agency
    DROP COLUMN representative_name,
    DROP COLUMN representative_email,
    DROP COLUMN representative_contact_number,
    DROP COLUMN representative_nric_passport,
    DROP COLUMN recruited_by,
    DROP COLUMN cms_credentials_id,
    DROP COLUMN bank_name,
    DROP COLUMN bank_address,
    DROP COLUMN account_holder_name,
    DROP COLUMN account_number,
    DROP COLUMN swift_code;

ALTER TABLE niu_application
    RENAME COLUMN moblile_country_code TO mobile_country_code;

-- boonheeloo@gmail.com 4/12/2024 --
ALTER TABLE agent
    MODIFY COLUMN status VARCHAR(255) DEFAULT NULL,
    ADD COLUMN agency_agreement_date date DEFAULT NULL,
    ADD COLUMN agency_agreement_key text DEFAULT NULL;

-- boonheeloo@gmail.com 5/12/2024 --
CREATE TABLE `agent_role_settings` (

    `id` BIGINT NOT NULL AUTO_INCREMENT,
    `role_code` varchar(50) NOT NULL,
    `role_description` varchar(255) DEFAULT NULL,
    `tier` int DEFAULT NULL,
    `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    UNIQUE KEY `role_code` (`role_code`)
);

INSERT INTO `agent_role_settings` (`role_code`, `role_description`, `tier`)
VALUES
    ('MGR', 'Manager', NULL),
    ('P2P', 'Peer to Peer', NULL),
    ('SM', 'Sales Manager', NULL),
    ('AVP', 'Assistant Vice President', NULL),
    ('VP', 'Vice President', NULL),
    ('SVP', 'Senior Vice President', NULL),
    ('DIRECT_SVP', 'Director Senior Vice President', NULL),
    ('HOS', 'Head of Service', NULL),
    ('CEO', 'Chief Executive Officer', NULL),
    ('CCSB', 'Chief Customer Service Boss', NULL),
    ('CWP', 'Chief Workforce Planner', NULL);

ALTER TABLE agent
    RENAME COLUMN agent_role TO agent_role_id;

ALTER TABLE agent
    MODIFY COLUMN agent_role_id BIGINT;

ALTER TABLE `agent`
    ADD CONSTRAINT `agent_ibfk_4`
        FOREIGN KEY (`agent_role_id`)
            REFERENCES `agent_role_settings` (`id`);

-- boonheeloo@gmail.com 6/12/2024 --
CREATE TABLE redemption_details (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    client_id BIGINT,
    corporate_client_id BIGINT,
    product_id BIGINT,
    fund_status VARCHAR(255),
    type VARCHAR(255),
    amount DOUBLE,
    status VARCHAR(255),
    created_at TIMESTAMP,
    updated_at TIMESTAMP,
    created_by VARCHAR(255),
    CONSTRAINT `redemption_details_ibfk_1` FOREIGN KEY (client_id) REFERENCES client(id),
    CONSTRAINT `redemption_details_ibfk_2` FOREIGN KEY (corporate_client_id) REFERENCES corporate_client(id),
    CONSTRAINT `redemption_details_ibfk_3` FOREIGN KEY (product_id) REFERENCES product(id)
);

ALTER TABLE client
    ADD COLUMN agreement_number VARCHAR(255);

ALTER TABLE corporate_client
    ADD COLUMN agreement_number VARCHAR(255);

-- christine260812@gmail.com @ 6/12/2024
ALTER table product_commission
    ADD COLUMN threshold DECIMAL(10, 2) AFTER `condition`;

ALTER TABLE product_commission
    CHANGE COLUMN agency_type agency_id bigint NOT NULL;

ALTER TABLE product_commission
    ADD CONSTRAINT product_commission_ibfk_2
        FOREIGN KEY (agency_id) REFERENCES agency (id);

-- boonheeloo@gmail.com 9/12/2024 --
ALTER TABLE agent
    MODIFY COLUMN app_user_id BIGINT DEFAULT NULL;

-- thives@appxtream.com 9/12/2024
ALTER TABLE client
    ADD COLUMN onboarding_agreement_key TEXT DEFAULT NULL;

ALTER TABLE client
    MODIFY COLUMN `client_id` varchar(255) DEFAULT NULL,
    MODIFY COLUMN `app_user_id` bigint DEFAULT NULL,
    MODIFY COLUMN `user_detail_id` bigint DEFAULT NULL;

CREATE TABLE IF NOT EXISTS corporate_documents(
    id BIGINT NOT NULL AUTO_INCREMENT,
    corporate_details_id BIGINT DEFAULT NULL,
    company_document_name VARCHAR(255) DEFAULT NULL,
    company_document_key TEXT DEFAULT NULL,
    created_at TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    FOREIGN KEY (`corporate_details_id`) REFERENCES corporate_details(`id`)
);

-- thives@appxtream.com 10/12/2024
ALTER TABLE corporate_shareholders
    ADD COLUMN client_id BIGINT DEFAULT NULL;

ALTER TABLE corporate_shareholders
    ADD CONSTRAINT `corporate_shareholders_ibfk_1`
        FOREIGN KEY (`client_id`)
            REFERENCES `client` (`id`);

ALTER TABLE corporate_shareholders
    ADD CONSTRAINT `corporate_shareholders_ibfk_2`
        FOREIGN KEY (`pep_info`)
            REFERENCES `pep_info` (`id`);

-- boonheeloo@gmail.com 10/12/2024 --
ALTER TABLE `redemption_details`
    CHANGE COLUMN `fund_status` `fund_status` ENUM('MATURED', 'NOT COMPLETE', 'ACTIVE') DEFAULT 'NOT COMPLETE',

    CHANGE COLUMN `type` `type` ENUM('PARTIAL', 'FULL', 'REFUND') DEFAULT NULL,

    CHANGE COLUMN `status` `status` TINYINT(1) DEFAULT 0;

-- thives@appxtream.com 10/12/2024
ALTER TABLE app_users ADD COLUMN is_deleted BOOLEAN DEFAULT FALSE;

-- christine260812@gmail.com @ 13/12/2024
ALTER TABLE corporate_guardian
    DROP COLUMN ic_document_key,
    ADD COLUMN identity_card_front_image_key TEXT DEFAULT NULL AFTER email,
    ADD COLUMN identity_card_back_image_key TEXT DEFAULT NULL AFTER identity_card_front_image_key;

-- thives@appxtream.com 13/12/2024
ALTER TABLE bank_details
    ADD COLUMN agency_id bigint DEFAULT NULL;

ALTER TABLE bank_details
    ADD CONSTRAINT `bank_details_ibfk_4` FOREIGN KEY (`agency_id`) REFERENCES `agency` (`id`) ON DELETE CASCADE;

ALTER TABLE bank_details
    ADD KEY `bank_details_ibfk_4` (`agency_id`);

-- edry@appxtream.com @ 13/12/2024
ALTER TABLE `agency`
    ADD COLUMN `recruit_manager_id` BIGINT DEFAULT NULL;

-- thives@appxtream.com 14/12/2024
ALTER TABLE `agency`
    ADD COLUMN agency_agreement_date DATE DEFAULT NULL;

ALTER TABLE settings
    ADD COLUMN updated_at TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;

-- thives@appxtream.com 15/12/2024
ALTER TABLE client DROP COLUMN onboarding_agreement_key;
ALTER TABLE client DROP COLUMN agreement_number;

-- thives@appxtream.com 15/12/2024
ALTER TABLE sign_up_history MODIFY COLUMN dob datetime;

ALTER TABLE app_users DROP INDEX email_address;

-- boonheeloo@gmail.com 16/12/2024 --
CREATE TABLE product_dividend_history (
                                          id BIGINT AUTO_INCREMENT PRIMARY KEY,
                                          dividend_file_id VARCHAR(255) NOT NULL,
                                          dividend_csv_key TEXT,
                                          status_checker ENUM('PENDING_CHECKER', 'APPROVE_CHECKER', 'REJECT_CHECKER') DEFAULT 'PENDING_CHECKER',
                                          remarks_checker TEXT,
                                          status_approver ENUM('PENDING_APPROVER', 'APPROVE_APPROVER', 'REJECT_APPROVER') DEFAULT 'PENDING_APPROVER',
                                          remarks_approver TEXT,
                                          created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                                          updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                                          checked_at TIMESTAMP NULL DEFAULT NULL,
                                          approved_at TIMESTAMP NULL DEFAULT NULL
);

-- boonheeloo@gmail.com 17/12/2024 --
ALTER TABLE product_dividend_history
    ADD COLUMN checked_by VARCHAR(255) DEFAULT NULL,
    ADD COLUMN approved_by VARCHAR(255) DEFAULT NULL;

-- christine260812@gmail.com @ 16/12/2024
CREATE TABLE IF NOT EXISTS product_commission_history (
      id BIGINT AUTO_INCREMENT PRIMARY KEY,
      commission_file_id VARCHAR(255) DEFAULT NULL,
      commission_csv_key TEXT,
      status_checker ENUM('PENDING_CHECKER', 'APPROVE_CHECKER', 'REJECT_CHECKER') DEFAULT 'PENDING_CHECKER',
      remarks_checker TEXT,
      status_approver ENUM('PENDING_APPROVER', 'APPROVE_APPROVER', 'REJECT_APPROVER') DEFAULT 'PENDING_APPROVER',
      remarks_approver TEXT,
      created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
      updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
      checked_at TIMESTAMP NULL DEFAULT NULL,
      approved_at TIMESTAMP NULL DEFAULT NULL,
      checked_by VARCHAR(255) DEFAULT NULL,
      approved_by VARCHAR(255) DEFAULT NULL
);

-- christine260812@gmail.com @ 17/12/2024 --
ALTER TABLE user_details
ADD COLUMN remarks TEXT;

-- thives@appxtream.com @ 17/12/2024
ALTER TABLE agency
    ADD COLUMN agency_id VARCHAR(255) DEFAULT NULL AFTER agency_code;

ALTER TABLE sign_up_history RENAME COLUMN agency_code TO agency_id;

ALTER TABLE product_target_return
    ADD COLUMN is_prorated BOOLEAN DEFAULT FALSE AFTER target_return_per_annum;

ALTER TABLE product_dividend_schedule
    ADD COLUMN frequency_of_payout ENUM('MONTHLY', 'QUARTERLY' ) DEFAULT 'QUARTERLY'
        AFTER date_of_month;

ALTER TABLE agency
    ADD COLUMN created_by VARCHAR(255) DEFAULT NULL,
    ADD COLUMN updated_by VARCHAR(255) DEFAULT NULL;

-- christine260812@gmail.com @ 18/12/2024 --
ALTER TABLE corporate_documents
ADD COLUMN is_deleted BOOLEAN DEFAULT FALSE;

-- thives@appxtream.com @ 18/12/2024
ALTER TABLE product_dividend_schedule
    MODIFY COLUMN date_of_month INTEGER default -1;

ALTER TABLE product_agreement_schedule
    MODIFY COLUMN date_of_month INTEGER default -1;

-- thives@appxtream.com @ 18/12/2024
ALTER TABLE product_order
    ADD COLUMN updated_by BIGINT DEFAULT NULL,
    ADD CONSTRAINT `product_order_ibfk_updated_by` FOREIGN KEY (`updated_by`) REFERENCES `app_users` (`id`) ON DELETE SET NULL;

ALTER TABLE product_order
    ADD COLUMN payment_method VARCHAR(255) DEFAULT NULL;

ALTER TABLE product_order
    ADD COLUMN payment_status VARCHAR(255) DEFAULT NULL;

-- thives@appxtream.com @ 18/12/2024
CREATE TABLE IF NOT EXISTS product_order_payment_receipt (
   id BIGINT NOT NULL AUTO_INCREMENT,
   product_order_id BIGINT DEFAULT NULL,
   payment_receipt_key TEXT DEFAULT NULL,
   upload_status VARCHAR(255) DEFAULT NULL,
   created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
   updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
   PRIMARY KEY (`id`),
   FOREIGN KEY (`product_order_id`) REFERENCES product_order(`id`) ON DELETE SET NULL
);

-- thives@appxtream.com @ 18/12/2024
ALTER TABLE product_order
    ADD COLUMN status_finance VARCHAR(255) DEFAULT NULL,
    ADD COLUMN remark_finance TEXT DEFAULT NULL,
    ADD COLUMN financed_by VARCHAR(255) DEFAULT NULL,
    ADD COLUMN finance_updated_at TIMESTAMP DEFAULT NULL;

ALTER TABLE product_order
    ADD COLUMN status_checker VARCHAR(255) DEFAULT NULL,
    ADD COLUMN remark_checker TEXT DEFAULT NULL,
    ADD COLUMN checked_by VARCHAR(255) DEFAULT NULL,
    ADD COLUMN checker_updated_at TIMESTAMP DEFAULT NULL;

ALTER TABLE product_order
    ADD COLUMN status_approver VARCHAR(255) DEFAULT NULL,
    ADD COLUMN remark_approver TEXT DEFAULT NULL,
    ADD COLUMN approved_by VARCHAR(255) DEFAULT NULL,
    ADD COLUMN approver_updated_at TIMESTAMP DEFAULT NULL;

ALTER TABLE product_order
    ADD COLUMN agreement_key TEXT DEFAULT NULL,
    ADD COLUMN agreement_date TIMESTAMP DEFAULT NULL;

ALTER TABLE product_order
    ADD COLUMN official_receipt_key TEXT DEFAULT NULL,
    ADD COLUMN official_receipt_date TIMESTAMP DEFAULT NULL;

ALTER TABLE product_order
    ADD COLUMN soa_key TEXT DEFAULT NULL,
    ADD COLUMN soa_date TIMESTAMP DEFAULT NULL;

-- edry@appxtream.com @ 18/12/2024
ALTER TABLE users
    ADD COLUMN agency_id bigint unsigned DEFAULT NULL AFTER role_id;

-- thives@appxtream.com @ 19/12/2024
ALTER TABLE agency
    MODIFY COLUMN status BOOLEAN DEFAULT TRUE;

ALTER TABLE product_target_return
    ADD COLUMN threshold_amount DECIMAL(10,2) DEFAULT NULL AFTER condition_type;

ALTER TABLE product_target_return
    MODIFY COLUMN `minimum` decimal(10,2) DEFAULT NULL,
    MODIFY COLUMN `maximum` decimal(10,2) DEFAULT NULL;

-- thives@appxtream.com @ 19/12/2024
ALTER TABLE product_order
    ADD COLUMN is_prorated BOOLEAN DEFAULT NULL,
    ADD COLUMN payout_frequency VARCHAR(255) DEFAULT NULL,
    ADD COLUMN calculation_day_of_month INTEGER DEFAULT NULL,
    ADD COLUMN last_dividend_calculation_date TIMESTAMP DEFAULT NULL;

-- thives@appxtream.com @ 19/12/2024
ALTER TABLE product_order
    ADD COLUMN period_starting_date DATE DEFAULT NULL AFTER agreement_date,
    ADD COLUMN period_ending_date DATE DEFAULT NULL AFTER period_starting_date;

CREATE TABLE IF NOT EXISTS product_dividend_calculation_history (
    id BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    product_order_id BIGINT NOT NULL,
    dividend_amount DECIMAL(10,2) DEFAULT NULL,
    period_starting_date DATE DEFAULT NULL,
    period_ending_date DATE DEFAULT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (product_order_id) REFERENCES product_order(id)
);

-- christine260812@gmail.com @ 19/12/2024 --
ALTER TABLE product_order
    MODIFY COLUMN status_checker VARCHAR(255) DEFAULT 'PENDING_CHECKER',
    MODIFY COLUMN status_approver VARCHAR(255) DEFAULT 'PENDING_APPROVER';

ALTER TABLE users
    ADD COLUMN mobile_number varchar(50) DEFAULT NULL AFTER name;

ALTER TABLE users
    ADD COLUMN created_by BIGINT DEFAULT NULL,
    ADD COLUMN updated_by BIGINT DEFAULT NULL;

-- thives@appxtream.com @ 20/12/2024
ALTER TABLE corporate_client
    DROP FOREIGN KEY `fk_corporate_client_pep_info_id`,
    DROP COLUMN pep_info_id;

-- thives@appxtream.com @ 20/12/2024
ALTER TABLE corporate_client
    MODIFY COLUMN agreement_number TEXT DEFAULT NULL;

ALTER TABLE corporate_client
    RENAME COLUMN agreement_number TO onboarding_agreement_key;

ALTER TABLE corporate_client
    ADD COLUMN profile_picture_image_key TEXT DEFAULT NULL;

ALTER TABLE product_order
    MODIFY COLUMN status_finance VARCHAR(255) DEFAULT 'PENDING_FINANCE';

-- boonheeloo@gmail.com 20/12/2024 --
ALTER TABLE redemption_details
    MODIFY COLUMN created_at TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
    MODIFY COLUMN updated_at TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;

-- christine260812@gmail.com 20/12/2024 --
ALTER TABLE user_details
    ADD COLUMN `is_same_corresponding_address` TINYINT DEFAULT FALSE AFTER country,
    ADD COLUMN `corresponding_address` varchar(255) DEFAULT NULL AFTER is_same_corresponding_address,
    ADD COLUMN `corresponding_postcode` varchar(255) DEFAULT NULL AFTER corresponding_address,
    ADD COLUMN `corresponding_city` varchar(255) DEFAULT NULL AFTER corresponding_postcode,
    ADD COLUMN `corresponding_state` varchar(255) DEFAULT NULL AFTER corresponding_city,
    ADD COLUMN `corresponding_country` varchar(255) DEFAULT NULL AFTER corresponding_state;

ALTER TABLE user_details
    ADD COLUMN `corresponding_address_proof_key` TEXT AFTER corresponding_state;

-- thives@appxtream.com @ 21/12/2024 --
ALTER TABLE product_order
    ADD COLUMN submission_date TIMESTAMP DEFAULT NULL AFTER updated_at;

ALTER TABLE product_order
    ADD COLUMN payment_date TIMESTAMP DEFAULT NULL AFTER payment_status;

ALTER TABLE product_order
    ADD COLUMN start_tenure DATE DEFAULT NULL AFTER agreement_date;

ALTER TABLE product_order
    ADD COLUMN end_tenure DATE DEFAULT NULL AFTER start_tenure;

ALTER TABLE product_order
    DROP COLUMN start_date,
    DROP COLUMN end_date,
    DROP COLUMN remark;

ALTER TABLE product_order
    ADD COLUMN client_agreement_status VARCHAR(255) DEFAULT NULL AFTER agreement_date,
    ADD COLUMN witness_agreement_status VARCHAR(255) DEFAULT NULL AFTER client_agreement_status;

-- thives@appxtream.com @ 22/12/2024 --
ALTER TABLE product_agreement_schedule
    DROP COLUMN date_of_month;

ALTER TABLE product_agreement_schedule
    DROP FOREIGN KEY product_agreement_schedule_ibfk_1,
    DROP COLUMN product_id;

ALTER TABLE product_agreement_schedule
    ADD COLUMN submission_due_date DATE DEFAULT NULL AFTER id,
    ADD COLUMN approval_due_date DATE DEFAULT NULL AFTER submission_due_date;

ALTER TABLE product_agreement_schedule
    MODIFY COLUMN created_by VARCHAR(255) DEFAULT NULL,
    MODIFY COLUMN updated_by VARCHAR(255) DEFAULT NULL;

CREATE TABLE IF NOT EXISTS product_agreement_schedule_pivot(
    `id` BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `product_type_id` BIGINT NOT NULL,
    `product_agreement_schedule_id` BIGINT NOT NULL,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `created_by` VARCHAR(255) DEFAULT NULL,
    `updated_by` VARCHAR(255) DEFAULT NULL,
    FOREIGN KEY (product_type_id) REFERENCES product_type(id) ON DELETE CASCADE,
    FOREIGN KEY (product_agreement_schedule_id) REFERENCES product_agreement_schedule(id) ON DELETE CASCADE
);

ALTER TABLE product
    ADD CONSTRAINT fk_product_type FOREIGN KEY (product_type_id) REFERENCES product_type(id) ON DELETE CASCADE;

ALTER TABLE product_order
    MODIFY COLUMN agreement_date DATE DEFAULT NULL;

ALTER TABLE product
    ADD COLUMN is_prorated BOOLEAN DEFAULT TRUE AFTER minimum_subscription_amount;

ALTER TABLE product
    DROP COLUMN dividend_rate;

ALTER TABLE product_target_return
    DROP COLUMN is_prorated;

ALTER TABLE product_dividend_schedule
    MODIFY COLUMN frequency_of_payout VARCHAR(255) NOT NULL DEFAULT 'QUARTERLY';

ALTER TABLE product_dividend_schedule
    ADD COLUMN structure_type VARCHAR(255) NOT NULL DEFAULT 'FIXED';

ALTER TABLE product_order
    ADD COLUMN structure_type VARCHAR(255) NOT NULL DEFAULT 'FIXED' AFTER is_prorated;

-- edry@appxtream.com @ 23/12/2024 --
ALTER TABLE client
    ADD COLUMN  created_by VARCHAR(255) AFTER created_at,
    ADD COLUMN updated_by VARCHAR(255) AFTER updated_at;

ALTER TABLE agent
    ADD COLUMN created_by VARCHAR(255) AFTER created_at,
    ADD COLUMN updated_by VARCHAR(255) AFTER updated_at;

-- boonheeloo@gmail.com 24/12/2024 --
ALTER TABLE user_details
    ADD COLUMN identity_doc_type VARCHAR(255) AFTER marital_status;

ALTER TABLE sign_up_history
    ADD COLUMN identity_doc_type VARCHAR(255) AFTER referral_code_agent;

ALTER TABLE individual_beneficiaries
    ADD COLUMN identity_doc_type VARCHAR(255) AFTER email;

ALTER TABLE individual_guardian
    ADD COLUMN identity_doc_type VARCHAR(255) AFTER email;

ALTER TABLE corporate_beneficiaries
    ADD COLUMN identity_doc_type VARCHAR(255) AFTER email;

ALTER TABLE corporate_guardian
    ADD COLUMN identity_doc_type VARCHAR(255) AFTER email;

ALTER TABLE corporate_shareholders
    ADD COLUMN identity_doc_type VARCHAR(255) AFTER country;

-- christine260812@gmail.com @ 24/12/2024 --
ALTER TABLE individual_beneficiary_guardian
    ADD COLUMN is_deleted BOOLEAN DEFAULT FALSE;

-- thives@appxtream.com @ 25/12/2024 --
ALTER TABLE individual_beneficiary_guardian
    ADD COLUMN relationship_to_guardian VARCHAR(255) DEFAULT NULL AFTER individual_guardian_id;

ALTER TABLE individual_beneficiaries
    DROP FOREIGN KEY `individual_beneficiaries_ibfk_2`,
    DROP COLUMN `guardian_id`,
    DROP COLUMN `relationship_to_guardian`;

-- christine260812@gmail.com @ 27/12/2024 --
ALTER TABLE sign_up_history
    ADD COLUMN `is_same_corresponding_address` TINYINT DEFAULT TRUE,
    ADD COLUMN `corresponding_address` varchar(255) DEFAULT NULL AFTER is_same_corresponding_address,
    ADD COLUMN `corresponding_postcode` varchar(255) DEFAULT NULL AFTER corresponding_address,
    ADD COLUMN `corresponding_city` varchar(255) DEFAULT NULL AFTER corresponding_postcode,
    ADD COLUMN `corresponding_state` varchar(255) DEFAULT NULL AFTER corresponding_city,
    ADD COLUMN `corresponding_country` varchar(255) DEFAULT NULL AFTER corresponding_state,
    ADD COLUMN `corresponding_address_proof_key` TEXT AFTER corresponding_country;

AlTER TABLE user_details
    MODIFY COLUMN `is_same_corresponding_address` TINYINT DEFAULT TRUE;

-- thives@appxtream.com @ 27/12/2024 --
ALTER TABLE product_type
    ADD COLUMN created_by VARCHAR(255) DEFAULT NULL,
    ADD COLUMN updated_by VARCHAR(255) DEFAULT NULL;

ALTER TABLE product
    DROP COLUMN risk_level;

ALTER TABLE product
    DROP COLUMN priority;

ALTER TABLE product
    DROP COLUMN display_on_app;

ALTER TABLE product_target_return
    MODIFY COLUMN created_by VARCHAR(255) DEFAULT NULL,
    MODIFY COLUMN updated_by VARCHAR(255) DEFAULT NULL;

ALTER TABLE product_dividend_schedule
    MODIFY COLUMN created_by VARCHAR(255) DEFAULT NULL,
    MODIFY COLUMN updated_by VARCHAR(255) DEFAULT NULL;

-- thives@appxtream.com @ 03/01/2025 --
ALTER TABLE product_dividend_schedule
    DROP COLUMN date_of_month;

-- thives@appxtream.com @ 04/01/2025 --
ALTER TABLE product_order
    ADD COLUMN client_signature_key TEXT DEFAULT NULL AFTER client_agreement_status;
ALTER TABLE product_order
    ADD COLUMN client_signature_date DATE DEFAULT NULL AFTER client_signature_key;

CREATE TABLE IF NOT EXISTS `faceid_image_validate`
(
    `id`                   bigint(20) NOT NULL AUTO_INCREMENT,
    `selfie_filename`      varchar(200) DEFAULT NULL,
    `id_document_filename` varchar(200) DEFAULT NULL,
    `id_number`            varchar(50)  DEFAULT NULL,
    `confidence`           double       DEFAULT NULL,
    `liveness_score`       double       DEFAULT NULL,
    `valid`                tinyint(1)   DEFAULT NULL,
    `created_at`           datetime     DEFAULT NULL,
    PRIMARY KEY (`id`),
    UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4;

-- christine260812@gmail.com @ 6/1/2025 --
ALTER TABLE corporate_client
 ADD COLUMN approval_status_remark TEXT DEFAULT NULL AFTER approval_status;

-- edry@appxtream.com @ 7/1/2025 --
ALTER TABLE agent
    ADD COLUMN pin CHAR(6) DEFAULT NULL CHECK (pin REGEXP '^[0-9]{6}$') after agent_id;

-- thives@appxtream.com @ 07/01/2025 --
ALTER TABLE product
    MODIFY COLUMN `tranche_size` decimal(15,2) DEFAULT NULL;

ALTER TABLE product_dividend_schedule
    ADD COLUMN `date_of_month` INT DEFAULT NULL;

ALTER TABLE `users` DROP CONSTRAINT users_role_id_foreign;
ALTER TABLE `users` ADD CONSTRAINT users_role_id_foreign FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE SET NULL;

-- thives@appxtream.com @ 08/01/2025 --
ALTER TABLE product_order
    DROP COLUMN calculation_day_of_month;

ALTER TABLE product_order
    ADD COLUMN remark VARCHAR(255) DEFAULT NULL AFTER status;

ALTER TABLE product_order
    ADD COLUMN payment_transaction_id TEXT DEFAULT NULL AFTER payment_date,
    ADD COLUMN payment_bank_name VARCHAR(255) DEFAULT NULL AFTER payment_transaction_id;

CREATE TABLE IF NOT EXISTS `maintenance_window`
(
    `id`             bigint(20) NOT NULL AUTO_INCREMENT,
    `start_datetime` datetime     DEFAULT NULL,
    `end_datetime`   datetime     DEFAULT NULL,
    `status`        tinyint(1)   DEFAULT NULL,
    `created_at`     datetime     DEFAULT NULL,
    `created_by`     varchar(200) DEFAULT NULL,
    `updated_at`     datetime     DEFAULT NULL,
    `updated_by`     varchar(200) DEFAULT NULL,
    PRIMARY KEY (`id`),
    UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4;

ALTER TABLE product
    ADD COLUMN created_by VARCHAR(255) AFTER created_at,
    ADD COLUMN updated_by VARCHAR(255) AFTER updated_at;
-- edry@appxtream.com @ 08/01/2025 --

ALTER TABLE `agent`
    DROP CONSTRAINT `agent_chk_1`,  -- Drop the old check constraint
    MODIFY COLUMN `pin` CHAR(4) DEFAULT NULL,  -- Modify the `pin` column to be a 4-character field
    ADD CONSTRAINT `agent_chk_1` CHECK (pin REGEXP '^[0-9]{4}$');

ALTER TABLE `corporate_client`
    ADD COLUMN `reference_number` VARCHAR(255) DEFAULT NULL AFTER `profile_picture_image_key`;


-- christine260812@gmail.com @ 09/01/2025 --
ALTER TABLE client
    DROP FOREIGN KEY fk_agent;

ALTER TABLE client
    ADD CONSTRAINT fk_agent FOREIGN KEY (agent_id) REFERENCES agent(id) ON DELETE CASCADE;

ALTER TABLE client
    DROP FOREIGN KEY fk_agent;

ALTER TABLE client
    ADD CONSTRAINT fk_agent FOREIGN KEY (agent_id) REFERENCES agent(id) ON DELETE SET NULL;

-- thives@appxtream.com @ 08/01/2025 --
ALTER TABLE corporate_details
    ADD COLUMN status VARCHAR(255) DEFAULT 'DRAFT' AFTER is_deleted;

ALTER TABLE corporate_details
    DROP COLUMN digital_signature_key,
    DROP COLUMN company_document;

ALTER TABLE corporate_client
    ADD COLUMN digital_signature_key TEXT DEFAULT NULL AFTER approver_id;

ALTER TABLE corporate_shareholders
    DROP FOREIGN KEY corporate_shareholders_ibfk_1;

ALTER TABLE corporate_shareholders
    DROP COLUMN client_id;

ALTER TABLE corporate_shareholders
    ADD COLUMN corporate_client_id BIGINT DEFAULT NULL;

ALTER TABLE corporate_shareholders
    ADD CONSTRAINT `corporate_shareholders_ibfk_1`
        FOREIGN KEY (`corporate_client_id`)
            REFERENCES `corporate_client` (`id`);

ALTER TABLE corporate_shareholders
    ADD COLUMN status VARCHAR(255) DEFAULT 'DRAFT';

ALTER TABLE corporate_client
    MODIFY COLUMN `annual_income_declaration` VARCHAR(255) DEFAULT NULL,
    MODIFY COLUMN `source_of_income` VARCHAR(255) DEFAULT NULL;

ALTER TABLE corporate_client
    ADD COLUMN approval_remark TEXT DEFAULT NULL AFTER approval_status;

-- thives@appxtream.com @ 11/01/2025 --
ALTER TABLE product_order
    ADD COLUMN agreement_file_name VARCHAR(255) DEFAULT NULL AFTER approver_updated_at;

ALTER TABLE product_dividend_calculation_history
    ADD COLUMN reference_number VARCHAR(255) DEFAULT NULL AFTER id,
    ADD COLUMN approval_status VARCHAR(255) DEFAULT 'PENDING' AFTER created_at ,
    ADD COLUMN payment_status VARCHAR(255) DEFAULT 'PENDING' AFTER approval_status,
    ADD COLUMN payment_date TIMESTAMP DEFAULT NULL AFTER payment_status,
    ADD COLUMN payment_transaction_id VARCHAR(255) DEFAULT NULL AFTER payment_date;


-- thives@appxtream.com @ 13/01/2025 --
ALTER TABLE corporate_client DROP COLUMN status;

-- boonheeloo@gmail.com @ 13/01/2025 --
ALTER TABLE document_type
    ADD COLUMN created_by VARCHAR(255) AFTER created_at,
    ADD COLUMN updated_by VARCHAR(255) AFTER updated_at;

ALTER TABLE product_agreement
    ADD COLUMN created_by VARCHAR(255) AFTER created_at,
    ADD COLUMN updated_by VARCHAR(255) AFTER updated_at;

-- christine260812@gmail.com @ 15/01/2025 --
-- DO NO RUN THIS SQL IN DEV DATABASE, ALREADY EXECUTED --
DROP TABLE IF EXISTS product_reallocation;
-- DO NO RUN THIS SQL IN DEV DATABASE, ALREADY EXECUTED --
CREATE TABLE IF NOT EXISTS product_reallocation(
    `id` BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `product_id` BIGINT NOT NULL,
    `reallocate_product_id` BIGINT NOT NULL,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `created_by` VARCHAR(255) DEFAULT NULL,
    `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `updated_by` VARCHAR(255) DEFAULT NULL,
    FOREIGN KEY (product_id) REFERENCES product(id) ON DELETE CASCADE,
    FOREIGN KEY (reallocate_product_id) REFERENCES product(id) ON DELETE CASCADE
);

-- thives@appxtream.com @ 14/01/2025 --
RENAME TABLE product_commission TO product_agency_commission_configuration;

ALTER TABLE product_agency_commission_configuration
    ADD COLUMN agency_type VARCHAR(255) DEFAULT NULL AFTER id, -- IN_HOUSE,EXTERNAL--
    ADD COLUMN product_type VARCHAR(255) DEFAULT 'NEW' AFTER product_id, -- NEW,ROLLOVER --
    ADD COLUMN year INT DEFAULT NULL AFTER threshold,
    ADD COLUMN commission DOUBLE DEFAULT 0.0 AFTER year;

ALTER TABLE product_agency_commission_configuration
    DROP FOREIGN KEY `product_agency_commission_configuration_ibfk_2`,
    DROP COLUMN agency_id;

ALTER TABLE product_agency_commission_configuration
    MODIFY COLUMN threshold DECIMAL(15,2) DEFAULT 0.0;

ALTER TABLE product_agency_commission_configuration
    MODIFY COLUMN created_by VARCHAR(255) DEFAULT NULL,
    MODIFY COLUMN updated_by VARCHAR(255) DEFAULT NULL;

-- thives@appxtream.com @ 14/01/2025 --
RENAME TABLE product_agent_commission to product_agent_commission_configuration;

ALTER TABLE product_agent_commission_configuration
    ADD COLUMN year int DEFAULT NULL AFTER product_id;

ALTER TABLE product_agent_commission_configuration
    MODIFY COLUMN created_by VARCHAR(255) DEFAULT NULL,
    MODIFY COLUMN updated_by VARCHAR(255) DEFAULT NULL;

ALTER TABLE product_agent_commission_configuration
    ADD COLUMN product_type VARCHAR(255) DEFAULT 'NEW' AFTER product_id;

ALTER TABLE product_agent_commission_configuration
    MODIFY COLUMN commission DOUBLE DEFAULT 0.0;

ALTER TABLE product_agent_commission_configuration
    RENAME COLUMN product_type TO product_order_type;

ALTER TABLE product_agent_commission_configuration
    DROP COLUMN agent_role;

ALTER TABLE product_agent_commission_configuration
    ADD COLUMN mgr_commission DOUBLE DEFAULT NULL AFTER `year`,
    ADD COLUMN p2p_commission DOUBLE DEFAULT NULL AFTER mgr_commission,
    ADD COLUMN sm_commission DOUBLE DEFAULT NULL AFTER p2p_commission,
    ADD COLUMN avp_commission DOUBLE DEFAULT NULL AFTER sm_commission,
    ADD COLUMN vp_commission DOUBLE DEFAULT NULL AFTER avp_commission;

ALTER TABLE agent_commission_configuration
    DROP COLUMN commission;

RENAME TABLE product_agent_commission_configuration TO agent_commission_configuration;

-- thives@appxtream.com @ 14/01/2025 --
CREATE TABLE IF NOT EXISTS product_rollover_history(
    `id` BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `product_order_id` BIGINT NOT NULL,
    `status` VARCHAR(255) DEFAULT NULL,
    `status_approver` VARCHAR(255) DEFAULT 'PENDING_APPROVER',
    `remark_approver` TEXT DEFAULT NULL,
    `approved_by` VARCHAR(255) DEFAULT NULL,
    `approver_updated_at` TIMESTAMP NULL DEFAULT NULL,
    `agreement_key` TEXT DEFAULT NULL,
    `agreement_date` DATE DEFAULT NULL,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (product_order_id) REFERENCES product_order(id) ON DELETE CASCADE
);

ALTER TABLE product_agency_commission_configuration
    DROP COLUMN agency_type;

ALTER TABLE product_agency_commission_configuration
    RENAME COLUMN product_type to product_order_type;

ALTER TABLE product_order
    ADD COLUMN product_order_type VARCHAR(255) DEFAULT 'NEW' AFTER order_reference_number;

RENAME TABLE product_agency_commission_configuration TO agency_commission_configuration;

ALTER TABLE agency_commission_configuration
    MODIFY COLUMN commission DOUBLE NOT NULL;

ALTER TABLE agency_commission_configuration
    MODIFY COLUMN `condition` VARCHAR(255) DEFAULT NULL;

-- thives@appxtream.com @ 17/01/2025 --
ALTER TABLE product_order
    ADD COLUMN agent_id BIGINT DEFAULT NULL AFTER corporate_client_id;

ALTER TABLE product_order
    ADD CONSTRAINT product_order_ibfk_agent_id
        FOREIGN KEY (agent_id) REFERENCES agent(id)
            ON DELETE SET NULL;

ALTER TABLE product_order
    ADD COLUMN agency_id BIGINT DEFAULT NULL AFTER agent_id;

ALTER TABLE product_order
    ADD CONSTRAINT product_order_ibfk_agency_id
        FOREIGN KEY (agency_id) REFERENCES agency(id)
            ON DELETE SET NULL;

CREATE TABLE IF NOT EXISTS agency_commission_calculation_history(
    `id` BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `agency_id` BIGINT DEFAULT NULL,
    `product_id` BIGINT DEFAULT NULL,
    `product_order_id` BIGINT DEFAULT NULL,
    `purchased_amount` DOUBLE DEFAULT 0,
    `commission_rate` DOUBLE DEFAULT 0,
    `commission_amount` DOUBLE DEFAULT 0,
    `calculated_date` DATE DEFAULT NULL,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (agency_id) REFERENCES agency(id) ON DELETE SET NULL,
    FOREIGN KEY (product_id) REFERENCES product(id) ON DELETE SET NULL,
    FOREIGN KEY (product_order_id) REFERENCES product_order(id) ON DELETE SET NULL
);

ALTER TABLE agency_commission_calculation_history
    ADD COLUMN product_order_type VARCHAR(255) NOT NULL AFTER product_order_id;

-- thives@appxtream.com @ 21/01/2025 --
ALTER TABLE agency_commission_calculation_history
    MODIFY COLUMN purchased_amount DECIMAL(15,2) DEFAULT NULL,
    MODIFY COLUMN commission_amount DECIMAL(15,2) DEFAULT NULL;

ALTER TABLE agency_commission_calculation_history
    ADD COLUMN client_name VARCHAR(255) DEFAULT NULL AFTER commission_amount,
    ADD COLUMN order_submission_date TIMESTAMP DEFAULT NULL AFTER client_name,
    ADD COLUMN order_agreement_date DATE NULL AFTER order_submission_date,
    ADD COLUMN order_agreement_number VARCHAR(255) DEFAULT NULL AFTER order_agreement_date;

ALTER TABLE product_order ADD COLUMN client_name VARCHAR(255) DEFAULT NULL;

ALTER TABLE agency_commission_calculation_history
    ADD COLUMN ytd_sales DECIMAL(15,2) DEFAULT 0 AFTER purchased_amount;

-- christine260812@gmail.com @ 22/01/2025 --
ALTER TABLE product_beneficiaries
    ADD COLUMN `corporate_beneficiary_id` bigint DEFAULT NULL AFTER `main_beneficiary_id`,
    ADD COLUMN `corporate_main_beneficiary_id` bigint DEFAULT NULL AFTER `corporate_beneficiary_id`;

-- thives@appxtrean.com @ 22/01/2025 --
ALTER TABLE bank_details
    ADD COLUMN corporate_client_id BIGINT DEFAULT NULL AFTER agency_id;

ALTER TABLE bank_details
    ADD CONSTRAINT `bank_details_ibfk_5`
        FOREIGN KEY (corporate_client_id) REFERENCES corporate_client (id) ON DELETE CASCADE;

-- edry@appxtream.com 27/01/2025 --
CREATE TABLE product_withdrawal_history (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    product_order_id BIGINT,
    order_reference_number VARCHAR(255),
    withdrawal_method VARCHAR(255),
    withdrawal_amount DOUBLE,
    withdrawal_reason VARCHAR(255),
    withdrawal_status ENUM('PENDING', 'APPROVED', 'REJECTED'),
    withdrawal_agreement_key VARCHAR(255),
    created_by BIGINT,
    updated_by VARCHAR(255),
    created_at TIMESTAMP,
    updated_at TIMESTAMP,
    FOREIGN KEY (product_order_id) REFERENCES product_order(id),
    FOREIGN KEY (created_by) REFERENCES app_users(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS esms_history (
    id bigint(20) NOT NULL AUTO_INCREMENT,
    mobile_number varchar(50) NULL,
    client_name varchar(200) NULL,
    otp varchar(10) NULL,
    status varchar(50) NULL,
    remarks varchar(255) NULL,
    expired_at datetime NULL,
    created_at datetime NULL,
    PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- edry@appxtream 05/02/2025 --
ALTER TABLE product_withdrawal_history
    ADD COLUMN status_approver VARCHAR(255) DEFAULT NULL,
    ADD COLUMN remark_approver TEXT DEFAULT NULL,
    ADD COLUMN approved_by VARCHAR(255) DEFAULT NULL,
    ADD COLUMN approver_updated_at TIMESTAMP DEFAULT NULL,
    ADD COLUMN status_checker VARCHAR(255) DEFAULT NULL,
    ADD COLUMN remark_checker TEXT DEFAULT NULL,
    ADD COLUMN checked_by VARCHAR(255) DEFAULT NULL,
    ADD COLUMN checker_updated_at TIMESTAMP DEFAULT NULL;

-- thives@appxtream 06/02/2025 --
CREATE TABLE IF NOT EXISTS `agent_commission_calculation_history` (
    `id` bigint NOT NULL AUTO_INCREMENT,
    `order_submission_date` timestamp NULL DEFAULT NULL,
    `order_agreement_date` date DEFAULT NULL,
    `client_name` varchar(255) DEFAULT NULL,
    `order_agreement_number` varchar(255) DEFAULT NULL,
    `purchased_amount` decimal(15,2) DEFAULT NULL,

    `mgr_id` bigint DEFAULT NULL,
    `mgr_digital_id` varchar(255) DEFAULT NULL,
    `mgr_name` varchar(255) DEFAULT NULL,
    `mgr_role` varchar(255) DEFAULT NULL,
    `mgr_commission_percentage` DOUBLE DEFAULT NULL,
    `mgr_commission_amount` DOUBLE DEFAULT NULL,

    `p2p_id` bigint DEFAULT NULL,
    `p2p_digital_id` varchar(255) DEFAULT NULL,
    `p2p_commission_percentage` DOUBLE DEFAULT NULL,
    `p2p_commission_amount` DOUBLE DEFAULT NULL,

    `sm_id` bigint DEFAULT NULL,
    `sm_digital_id` varchar(255) DEFAULT NULL,
    `sm_commission_percentage` DOUBLE DEFAULT NULL,
    `sm_commission_amount` DOUBLE DEFAULT NULL,

    `avp_id` bigint DEFAULT NULL,
    `avp_digital_id` varchar(255) DEFAULT NULL,
    `avp_commission_percentage` DOUBLE DEFAULT NULL,
    `avp_commission_amount` DOUBLE DEFAULT NULL,

    `vp_id` bigint DEFAULT NULL,
    `vp_digital_id` varchar(255) DEFAULT NULL,
    `vp_commission_percentage` DOUBLE DEFAULT NULL,
    `vp_commission_amount` DOUBLE DEFAULT NULL,

    `product_id` bigint DEFAULT NULL,
    `product_order_id` bigint DEFAULT NULL,
    `product_order_type` varchar(255) NOT NULL,
    `calculated_date` date DEFAULT NULL,
    `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    PRIMARY KEY (`id`),
    FOREIGN KEY (mgr_id) REFERENCES agent(id) ON DELETE SET NULL,
    FOREIGN KEY (p2p_id) REFERENCES agent(id) ON DELETE SET NULL,
    FOREIGN KEY (sm_id) REFERENCES agent(id) ON DELETE SET NULL,
    FOREIGN KEY (avp_id) REFERENCES agent(id) ON DELETE SET NULL,
    FOREIGN KEY (vp_id) REFERENCES agent(id) ON DELETE SET NULL,
    FOREIGN KEY (product_id) REFERENCES product(id) ON DELETE SET NULL,
    FOREIGN KEY (product_order_id) REFERENCES product_order(id) ON DELETE SET NULL
);

ALTER TABLE agent_commission_configuration
    MODIFY COLUMN p2p_commission DOUBLE DEFAULT 0,
    MODIFY COLUMN sm_commission DOUBLE DEFAULT 0,
    MODIFY COLUMN avp_commission DOUBLE DEFAULT 0,
    MODIFY COLUMN vp_commission DOUBLE DEFAULT 0;

-- thives@appxtream 10/02/2025 --
ALTER TABLE niu_application DROP COLUMN client_id;

ALTER TABLE niu_application ADD COLUMN app_user_id BIGINT DEFAULT NULL AFTER id;

ALTER TABLE niu_application
    ADD CONSTRAINT `niu_application_ibfk_app_user_id`
        FOREIGN KEY (`app_user_id`)
            REFERENCES `app_users` (`id`) ON DELETE SET NULL;

ALTER TABLE niu_application ADD COLUMN corporate_client_id BIGINT DEFAULT NULL AFTER app_user_id;

ALTER TABLE niu_application
    ADD CONSTRAINT `niu_application_ibfk_corporate_client_id`
        FOREIGN KEY (`corporate_client_id`)
            REFERENCES `corporate_client` (`id`) ON DELETE SET NULL;

ALTER TABLE corporate_client DROP COLUMN approval_remark;

-- thives@appxtream 13/02/2025 --
CREATE TABLE IF NOT EXISTS product_agreement_date (
    id BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    product_type_id BIGINT NOT NULL,
    date_of_month INTEGER NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_by VARCHAR(255) DEFAULT NULL,
    updated_by VARCHAR(255) DEFAULT NULL,
    FOREIGN KEY (`product_type_id`) REFERENCES product_type(`id`)
);

-- thives@appxtream 19/02/2025 --
ALTER TABLE product add column profit_sharing_footer_note TEXT DEFAULT NULL;

-- thives@appxtream 20/02/2025 --
ALTER TABLE product_dividend_schedule
    MODIFY COLUMN date_of_month INT DEFAULT 15;

ALTER TABLE product_order
    ADD COLUMN profit_sharing_schedule_key VARCHAR(255) DEFAULT NULL AFTER witness_agreement_status;

-- zack@nexstream.com.my @ 2025-Feb-20
ALTER TABLE `product_dividend_history` DROP COLUMN `dividend_file_id`;

CREATE TABLE IF NOT EXISTS `product_dividend_history_pivot`(
    `id` BIGINT NOT NULL AUTO_INCREMENT,
    `product_dividend_history_id` BIGINT DEFAULT NULL,
    `product_dividend_calculation_history_id` BIGINT NOT NULL,
    `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    FOREIGN KEY (`product_dividend_history_id`) REFERENCES product_dividend_history(`id`) ON DELETE CASCADE,
    FOREIGN KEY (`product_dividend_calculation_history_id`) REFERENCES product_dividend_calculation_history(`id`) ON DELETE CASCADE
);

ALTER TABLE `product_dividend_history` ADD COLUMN `generated_bank_file` tinyint(1) DEFAULT 0;

-- thives@appxtream 24/02/2025 --
ALTER TABLE product_dividend_history
    ADD COLUMN csv_file_name VARCHAR(255) DEFAULT NULL AFTER id;

ALTER TABLE product_dividend_history
    ADD COLUMN bank_result_csv TEXT DEFAULT NULL;

ALTER TABLE product_dividend_history
    ADD COLUMN updated_bank_result BOOLEAN DEFAULT FALSE;

-- christine@appstream 21/02/2025 --
ALTER TABLE redemption_details MODIFY COLUMN status enum('PENDING', 'APPROVED', 'REJECTED');

ALTER TABLE redemption_details
    DROP FOREIGN KEY redemption_details_ibfk_3,
    DROP COLUMN product_id;

ALTER TABLE redemption_details
    ADD COLUMN product_order_id BIGINT AFTER corporate_client_id,
    ADD CONSTRAINT `redemption_details_ibfk_3` FOREIGN KEY (product_order_id) REFERENCES product_order(id);

ALTER TABLE redemption_details
    ADD COLUMN status_checker VARCHAR(255) DEFAULT NULL,
    ADD COLUMN remark_checker TEXT DEFAULT NULL,
    ADD COLUMN checked_by VARCHAR(255) DEFAULT NULL,
    ADD COLUMN checker_updated_at TIMESTAMP DEFAULT NULL,
    ADD COLUMN status_approver VARCHAR(255) DEFAULT NULL,
    ADD COLUMN remark_approver TEXT DEFAULT NULL,
    ADD COLUMN approved_by VARCHAR(255) DEFAULT NULL,
    ADD COLUMN approver_updated_at TIMESTAMP DEFAULT NULL;

ALTER TABLE redemption_details
    MODIFY fund_status VARCHAR(255),
    MODIFY type VARCHAR(255),
    MODIFY status VARCHAR(255);

-- christine@appstream 26/02/2025
ALTER TABLE product_reallocation
    ADD COLUMN product_order_id BIGINT AFTER id,
    ADD CONSTRAINT `product_reallocation_ibfk_3` FOREIGN KEY (product_order_id) REFERENCES product_order(id);

ALTER TABLE product_reallocation
    ADD COLUMN status_checker VARCHAR(255) DEFAULT NULL,
    ADD COLUMN remark_checker TEXT DEFAULT NULL,
    ADD COLUMN checked_by VARCHAR(255) DEFAULT NULL,
    ADD COLUMN checker_updated_at TIMESTAMP DEFAULT NULL,
    ADD COLUMN status_approver VARCHAR(255) DEFAULT NULL,
    ADD COLUMN remark_approver TEXT DEFAULT NULL,
    ADD COLUMN approved_by VARCHAR(255) DEFAULT NULL,
    ADD COLUMN approver_updated_at TIMESTAMP DEFAULT NULL;

ALTER TABLE product_reallocation
    ADD COLUMN status VARCHAR(255) AFTER reallocate_product_id;

ALTER TABLE product_reallocation
    ADD COLUMN reallocate_remark VARCHAR(255) AFTER reallocate_product_id;

ALTER TABLE product_rollover_history
    ADD COLUMN status_checker VARCHAR(255) DEFAULT NULL after status,
    ADD COLUMN remark_checker TEXT DEFAULT NULL after status_checker,
    ADD COLUMN checked_by VARCHAR(255) DEFAULT NULL after remark_checker,
    ADD COLUMN checker_updated_at TIMESTAMP DEFAULT NULL after checked_by,
    ADD COLUMN created_by BIGINT DEFAULT NULL after created_at;

ALTER TABLE product_rollover_history
    ADD COLUMN amount DOUBLE DEFAULT NULL AFTER product_order_id;

ALTER TABLE product_reallocation
   ADD COLUMN `client_id` bigint DEFAULT NULL after id,
   ADD CONSTRAINT `product_reallocation_ibfk_4` FOREIGN KEY (client_id) REFERENCES client(id);

ALTER TABLE product_rollover_history
    ADD COLUMN `client_id` bigint DEFAULT NULL after id,
    ADD CONSTRAINT `product_rollover_history_ibfk_2` FOREIGN KEY (client_id) REFERENCES client(id);


-- thives@appxtream 27/02/2025 --
ALTER TABLE corporate_client
    ADD COLUMN agent_id BIGINT DEFAULT NULL AFTER client_id;

ALTER TABLE corporate_client
    ADD CONSTRAINT fk_agent_id
        FOREIGN KEY (agent_id) REFERENCES agent (id) ON DELETE SET NULL;

-- christine@appxtream 27/02/2025 --
ALTER TABLE redemption_details
 RENAME TO product_redemption;

ALTER TABLE product_redemption
    ADD COLUMN agent_id BIGINT DEFAULT NULL AFTER client_id;

ALTER TABLE product_reallocation
    ADD COLUMN agent_id BIGINT DEFAULT NULL AFTER client_id;

ALTER TABLE product_rollover_history
    ADD COLUMN agent_id BIGINT DEFAULT NULL AFTER client_id;

ALTER TABLE product_reallocation
    ADD COLUMN amount DOUBLE AFTER product_id;

ALTER TABLE product_reallocation
    DROP COLUMN reallocate_remark;

-- thives@appxtream 03/03/2025 --
ALTER TABLE agent_commission_calculation_history
    ADD COLUMN generated_commission_file BOOLEAN DEFAULT FALSE,
    ADD COLUMN generated_bank_file BOOLEAN DEFAULT FALSE,
    ADD COLUMN reference_number VARCHAR(255) DEFAULT NULL AFTER id;

ALTER TABLE agency_commission_calculation_history
    ADD COLUMN generated_commission_file BOOLEAN DEFAULT FALSE,
    ADD COLUMN generated_bank_file BOOLEAN DEFAULT FALSE,
    ADD COLUMN reference_number VARCHAR(255) DEFAULT NULL AFTER id;

ALTER TABLE agency_commission_calculation_history
    ADD COLUMN agency_name VARCHAR(255) DEFAULT NULL AFTER agency_id;

ALTER TABLE agent_commission_calculation_history
    ADD COLUMN p2p_name VARCHAR(255) DEFAULT NULL AFTER p2p_digital_id,
    ADD COLUMN sm_name VARCHAR(255) DEFAULT NULL AFTER sm_digital_id,
    ADD COLUMN avp_name VARCHAR(255) DEFAULT NULL AFTER avp_digital_id,
    ADD COLUMN vp_name VARCHAR(255) DEFAULT NULL AFTER vp_digital_id;

ALTER TABLE agent_commission_calculation_history
    MODIFY COLUMN p2p_commission_percentage DOUBLE DEFAULT 0,
    MODIFY COLUMN p2p_commission_amount DOUBLE DEFAULT 0,
    MODIFY COLUMN sm_commission_percentage DOUBLE DEFAULT 0,
    MODIFY COLUMN sm_commission_amount DOUBLE DEFAULT 0,
    MODIFY COLUMN avp_commission_percentage DOUBLE DEFAULT 0,
    MODIFY COLUMN avp_commission_amount DOUBLE DEFAULT 0,
    MODIFY COLUMN vp_commission_percentage DOUBLE DEFAULT 0,
    MODIFY COLUMN vp_commission_amount DOUBLE DEFAULT 0;

ALTER TABLE agency_commission_calculation_history
    ADD COLUMN product_commission_history_id BIGINT DEFAULT NULL;

ALTER TABLE agency_commission_calculation_history
    ADD CONSTRAINT fk_product_commission_history_id
        FOREIGN KEY (product_commission_history_id) REFERENCES product_commission_history (id) ON DELETE SET NULL;

ALTER TABLE agent_commission_calculation_history
    ADD COLUMN product_commission_history_id BIGINT DEFAULT NULL;

ALTER TABLE agent_commission_calculation_history
    ADD CONSTRAINT agent_commission_calculation_history_ibfk_8
        FOREIGN KEY (product_commission_history_id) REFERENCES product_commission_history (id) ON DELETE SET NULL;

-- thives@appxtream 04/03/2025 --
ALTER TABLE agent_commission_calculation_history
    DROP COLUMN generated_bank_file;

ALTER TABLE agency_commission_calculation_history
    DROP COLUMN generated_bank_file;

ALTER TABLE product_dividend_calculation_history
    DROP COLUMN approval_status;

ALTER TABLE agency_commission_calculation_history
    ADD COLUMN payment_status VARCHAR(255) DEFAULT 'PENDING',
    ADD COLUMN payment_date TIMESTAMP NULL DEFAULT NULL,
    ADD COLUMN payment_transaction_id VARCHAR(255) DEFAULT NULL;

ALTER TABLE agent_commission_calculation_history
    ADD COLUMN payment_status VARCHAR(255) DEFAULT 'PENDING',
    ADD COLUMN payment_date TIMESTAMP NULL DEFAULT NULL,
    ADD COLUMN payment_transaction_id VARCHAR(255) DEFAULT NULL;

ALTER TABLE product_commission_history
    ADD COLUMN agency_type VARCHAR(255) NOT NULL AFTER id;

-- thives@appxtream 05/03/2025 --
ALTER TABLE product_withdrawal_history RENAME TO product_early_redemption_history;

ALTER TABLE product_early_redemption RENAME TO product_early_redemption_configuration;

ALTER TABLE product_early_redemption_configuration
    ADD COLUMN period_type VARCHAR(255) NOT NULL DEFAULT 'MONTH' AFTER id;

ALTER TABLE product_early_redemption_history
    DROP COLUMN created_by,
    DROP COLUMN updated_by;

ALTER TABLE product_early_redemption_history
    ADD COLUMN client_signature_status VARCHAR(255) DEFAULT 'PENDING';

ALTER TABLE product_early_redemption_history
    ADD COLUMN penalty_amount DOUBLE DEFAULT NULL AFTER withdrawal_amount,
    ADD COLUMN penalty_percentage DOUBLE DEFAULT NULL AFTER penalty_amount;

ALTER TABLE product_early_redemption_history
    ADD COLUMN payment_status VARCHAR(255) DEFAULT NULL,
    ADD COLUMN payment_date TIMESTAMP DEFAULT NULL;

ALTER TABLE product_order
    MODIFY COLUMN structure_type VARCHAR(255) DEFAULT NULL;

-- thives@appxtream 06/03/2025 --
ALTER TABLE product_early_redemption_history
    ADD COLUMN client_signature_key VARCHAR(255) DEFAULT NULL AFTER client_signature_status,
    ADD COLUMN client_signature_date DATE DEFAULT NULL AFTER client_signature_key;

ALTER TABLE product_early_redemption_configuration
    MODIFY COLUMN penalty_percentage DOUBLE NOT NULL DEFAULT 0;

ALTER TABLE product_early_redemption_history
    MODIFY COLUMN withdrawal_status VARCHAR(255) NOT NULL DEFAULT 'IN_REVIEW';

ALTER TABLE product
    ADD CONSTRAINT `unique_product_code` UNIQUE (code);

ALTER TABLE product_type
    ADD CONSTRAINT `unique_product_type_name` UNIQUE (name);

ALTER TABLE product_rollover_history
    DROP CONSTRAINT `product_rollover_history_ibfk_2`;

ALTER TABLE product_rollover_history
    DROP COLUMN client_id,
    DROP COLUMN agent_id;

ALTER TABLE product_reallocation
    DROP CONSTRAINT `product_reallocation_ibfk_1`,
    DROP CONSTRAINT `product_reallocation_ibfk_4`;

ALTER TABLE product_reallocation
    DROP COLUMN client_id,
    DROP COLUMN agent_id,
    DROP COLUMN product_id;

ALTER TABLE product_redemption
    DROP CONSTRAINT `product_redemption_ibfk_1`,
    DROP CONSTRAINT `product_redemption_ibfk_2`;

ALTER TABLE product_redemption
    DROP COLUMN client_id,
    DROP COLUMN agent_id,
    DROP COLUMN corporate_client_id;

-- thives@appxtream 08/03/2025 --
CREATE TABLE agent_commission_history (
    `id` BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `agent_id` BIGINT NOT NULL,
    `agent_commission_calculation_history_id` BIGINT NOT NULL,
    `commission_percentage` DOUBLE DEFAULT NULL,
    `commission_amount` DOUBLE DEFAULT NULL,
    `payment_status` varchar(255) DEFAULT 'PENDING',
    `payment_date` timestamp NULL DEFAULT NULL,
    `payment_transaction_id` varchar(255) DEFAULT NULL,
    FOREIGN KEY (`agent_id`) REFERENCES agent(`id`),
    FOREIGN KEY (`agent_commission_calculation_history_id`) REFERENCES agent_commission_calculation_history(`id`)
);

ALTER TABLE agent_commission_history
    ADD COLUMN `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    ADD COLUMN `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;

ALTER TABLE agent_commission_history
    DROP CONSTRAINT `agent_commission_history_ibfk_1`;

ALTER TABLE agent_commission_history
    DROP COLUMN agent_id;

ALTER TABLE agent_commission_history
    ADD COLUMN agent_id VARCHAR(255) NOT NULL AFTER id;

ALTER TABLE agent_commission_calculation_history
    DROP COLUMN payment_status,
    DROP COLUMN payment_date,
    DROP COLUMN payment_transaction_id;

ALTER TABLE agent_commission_history
    ADD COLUMN commission_type VARCHAR(255) NOT NULL AFTER id;

ALTER TABLE user_details
    MODIFY COLUMN identity_card_number VARCHAR(255) NOT NULL,
    MODIFY COLUMN identity_doc_type VARCHAR(255) NOT NULL,
    MODIFY COLUMN email VARCHAR(255) NOT NULL;

CREATE TABLE IF NOT EXISTS agency_product_tier (
    `id` BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `agency_id` BIGINT NOT NULL,
    `product_id` BIGINT NOT NULL,
    `product_order_type` VARCHAR(255) NOT NULL,
    `year` INT NOT NULL,
    `commission` DOUBLE NOT NULL,
    FOREIGN KEY (`agency_id`) REFERENCES agency(`id`),
    FOREIGN KEY (`product_id`) REFERENCES product(`id`)
);

CREATE TABLE IF NOT EXISTS product_reallocation_configuration (
    `id` BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `product_id` BIGINT NOT NULL,
    `reallocatable_product_id` BIGINT NOT NULL,
    FOREIGN KEY (`product_id`) REFERENCES product(`id`),
    FOREIGN KEY (`reallocatable_product_id`) REFERENCES product(`id`)
);

-- christine@appxtream 05/03/2025 --
CREATE TABLE IF NOT EXISTS product_agreement_pivot(
       `id` BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
       `product_id` BIGINT NOT NULL,
       `product_agreement_id` BIGINT NOT NULL,
       `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
       `created_by` VARCHAR(255) DEFAULT NULL,
       `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
       `updated_by` VARCHAR(255) DEFAULT NULL,
       FOREIGN KEY (product_id) REFERENCES product(id) ON DELETE CASCADE,
       FOREIGN KEY (product_agreement_id) REFERENCES product_agreement(id) ON DELETE CASCADE
);

ALTER TABLE product_agreement
    ADD COLUMN client_type TEXT AFTER document_type_id;

ALTER TABLE product_agreement MODIFY COLUMN document_editor LONGTEXT;

ALTER TABLE corporate_client ADD COLUMN company_stamp_key text default null;

-- christine@appxstream 10/03/2025
ALTER table product_dividend_history ADD COLUMN updated_dividend_csv_key TEXT after dividend_csv_key;

-- thives@appxtream 10/03/2025 --
ALTER TABLE agent_commission_configuration
    MODIFY COLUMN `mgr_commission` double NOT NULL DEFAULT 0,
    MODIFY COLUMN `p2p_commission` double NOT NULL DEFAULT 0,
    MODIFY COLUMN `sm_commission` double NOT NULL DEFAULT 0,
    MODIFY COLUMN `avp_commission` double NOT NULL DEFAULT 0,
    MODIFY COLUMN `vp_commission` double NOT NULL DEFAULT 0;

ALTER TABLE agent_commission_calculation_history
    MODIFY COLUMN p2p_commission_percentage DOUBLE NOT NULL DEFAULT 0,
    MODIFY COLUMN p2p_commission_amount DOUBLE NOT NULL DEFAULT 0,
    MODIFY COLUMN sm_commission_percentage DOUBLE NOT NULL DEFAULT 0,
    MODIFY COLUMN sm_commission_amount DOUBLE NOT NULL DEFAULT 0,
    MODIFY COLUMN avp_commission_percentage DOUBLE NOT NULL DEFAULT 0,
    MODIFY COLUMN avp_commission_amount DOUBLE NOT NULL DEFAULT 0,
    MODIFY COLUMN vp_commission_percentage DOUBLE NOT NULL DEFAULT 0,
    MODIFY COLUMN vp_commission_amount DOUBLE NOT NULL DEFAULT 0;

ALTER TABLE agency_commission_calculation_history
    MODIFY COLUMN generated_commission_file BOOLEAN NOT NULL DEFAULT FALSE;

ALTER TABLE agent_commission_calculation_history
    MODIFY COLUMN generated_commission_file BOOLEAN NOT NULL DEFAULT FALSE;

ALTER TABLE product_commission_history
    ADD COLUMN `generated_bank_file` tinyint(1) DEFAULT '0',
    ADD COLUMN `bank_result_csv` text,
    ADD COLUMN `updated_bank_result` tinyint(1) DEFAULT '0';

-- thives@appxtream 12/03/2025 --
ALTER TABLE product_rollover_history
    ADD COLUMN rollover_product_order_id BIGINT DEFAULT NULL AFTER product_order_id;

ALTER TABLE product_rollover_history
    ADD CONSTRAINT product_rollover_history_ibfk_2 FOREIGN KEY (rollover_product_order_id) REFERENCES product_order (id) ON DELETE CASCADE;

ALTER TABLE product_rollover_history
    DROP COLUMN status_checker,
    DROP COLUMN remark_checker,
    DROP COLUMN checked_by,
    DROP COLUMN checker_updated_at,
    DROP COLUMN status_approver,
    DROP COLUMN remark_approver,
    DROP COLUMN approved_by,
    DROP COLUMN approver_updated_at,
    DROP COLUMN agreement_key,
    DROP COLUMN agreement_date;

-- zack@nexstream.com.my @ 2025-Mar-13
INSERT INTO `settings` (`key`, display_name, value, `type`, `order`, `group`, `updated_at`) VALUE ('admin.cimb.bank.excel.commission.template', 'CIMB Bank Excel Commission Template', null, 'file', 39, 'Admin', NOW());

ALTER TABLE `agent_commission_calculation_history` ADD COLUMN `remark` VARCHAR(500) DEFAULT NULL;
ALTER TABLE `agency_commission_calculation_history` ADD COLUMN `remark` VARCHAR(500) DEFAULT NULL;

ALTER TABLE `product_commission_history` ADD COLUMN `updated_commission_csv_key` VARCHAR(200) after `commission_csv_key`;

INSERT INTO `settings` (`key`, display_name, value, `type`, `order`, `group`, `updated_at`) VALUE ('admin.cimb.bank.excel.dividend.template', 'CIMB Bank Excel Dividend Template', null, 'file', 40, 'Admin', NOW());


-- thives@nexstream.com.my @ 2025-Mar-13
ALTER TABLE product_agreement MODIFY COLUMN client_type VARCHAR(255) DEFAULT 'INDIVIDUAL';

UPDATE product_agreement
SET client_type = 'INDIVIDUAL'
WHERE client_type IS NULL;

-- christine@appxtream.com.my @ 2025-Mar-13
ALTER TABLE product
    DROP COLUMN product_agreement_id;

ALTER TABLE product_reallocation
    DROP COLUMN status_checker,
    DROP COLUMN remark_checker,
    DROP COLUMN checked_by,
    DROP COLUMN checker_updated_at,
    DROP COLUMN status_approver,
    DROP COLUMN remark_approver,
    DROP COLUMN approved_by,
    DROP COLUMN approver_updated_at;

ALTER TABLE product_reallocation
    ADD COLUMN reallocate_product_order_id BIGINT DEFAULT NULL AFTER product_order_id;

ALTER TABLE product_reallocation
    ADD CONSTRAINT reallocate_rollover_history_ibfk_4 FOREIGN KEY (reallocate_product_order_id) REFERENCES product_order (id) ON DELETE CASCADE;

-- thives@nexstream.com.my @ 2025-Mar-13
ALTER TABLE product_redemption
    ADD COLUMN payment_status VARCHAR(255) DEFAULT 'PENDING',
    ADD COLUMN payment_date TIMESTAMP DEFAULT NULL;

ALTER TABLE product_early_redemption_history
    ADD COLUMN redemption_reference_number VARCHAR(255) DEFAULT NULL AFTER id;

ALTER TABLE product_order ADD COLUMN dividend_counter INT DEFAULT 0;

-- thives@nexstream.com.my @ 2025-Mar-13
DROP TABLE corporate_bank_details;

ALTER TABLE product_order
    MODIFY COLUMN dividend_counter INT NOT NULL DEFAULT 0;

-- christine@appxtream.com.my @ 2025-Mar-19
UPDATE citadel.agent_role_settings
SET role_description = 'Senior Manager'
WHERE role_code = 'SM';

-- thives@nexstream.com.my @ 2025-Mar-20
ALTER TABLE product_early_redemption_history
    ADD COLUMN bank_result_csv TEXT DEFAULT NULL;

ALTER TABLE product_early_redemption_history
    ADD COLUMN updated_bank_result BOOLEAN DEFAULT FALSE;

ALTER TABLE product_redemption
    ADD COLUMN bank_result_csv TEXT DEFAULT NULL;

ALTER TABLE product_redemption
    ADD COLUMN updated_bank_result BOOLEAN DEFAULT FALSE;

ALTER TABLE product_redemption
    ADD COLUMN generated_bank_file BOOLEAN DEFAULT FALSE;

ALTER TABLE product_early_redemption_history
    ADD COLUMN generated_bank_file BOOLEAN DEFAULT FALSE;

-- thives@nexstream.com.my @ 2025-Mar-24
ALTER TABLE agent_commission_calculation_history
    ADD COLUMN svp_id BIGINT DEFAULT NULL AFTER vp_commission_amount,
    ADD COLUMN svp_digital_id VARCHAR(255) DEFAULT NULL AFTER svp_id,
    ADD COLUMN svp_name VARCHAR(255) DEFAULT NULL AFTER svp_digital_id,
    ADD COLUMN svp_commission_percentage DOUBLE DEFAULT '0' AFTER svp_name;

-- thives@nexstream.com.my @ 2025-Mar-28
ALTER TABLE product_early_redemption_history
    ADD COLUMN witness_signature_status VARCHAR(255) DEFAULT NULL AFTER client_signature_date;

ALTER TABLE product_early_redemption_history
    ADD COLUMN agent_id BIGINT DEFAULT NULL;

ALTER TABLE product_early_redemption_history
    ADD CONSTRAINT product_early_redemption_history_ibfk_3
        FOREIGN KEY (agent_id) REFERENCES agent(id)
            ON DELETE SET NULL;

-- thives@nexstream.com.my @ 2025-Apr-04
UPDATE `citadel`.`agent_role_settings` SET `role_description` = 'Head of Sales' WHERE (`role_code` = 'HOS');
UPDATE `citadel`.`agent_role_settings` SET `role_description` = 'Direct Senior Vice President' WHERE (`role_code` = 'DIRECT_SVP');
UPDATE `citadel`.`agent_role_settings` SET `role_description` = 'CEO' WHERE (`role_code` = 'CEO');
UPDATE `citadel`.`agent_role_settings` SET `role_description` = 'CCSB' WHERE (`role_code` = 'CCSB');
UPDATE `citadel`.`agent_role_settings` SET `role_description` = 'CWP' WHERE (`role_code` = 'CWP');

-- thives@nexstream.com.my @ 2025-Apr-16
ALTER TABLE bank_details DROP COLUMN account_holder_type;

-- thives@nexstream.com.my @ 2025-Apr-17
ALTER TABLE product_order DROP COLUMN payment_transaction_id;
ALTER TABLE product_order DROP COLUMN payment_bank_name;

-- christine@appxtream.com @ 2025-Apr-22
ALTER TABLE product_early_redemption_history ADD COLUMN supporting_document_key VARCHAR(255) DEFAULT NULL;

-- thives@nexstream.com.my @ 2025-Apr-23
ALTER TABLE product
    ADD COLUMN bank_account_name VARCHAR(255) DEFAULT NULL,
    ADD COLUMN bank_account_number VARCHAR(255) DEFAULT NULL;

ALTER TABLE product
    ADD COLUMN enable_living_trust BOOLEAN DEFAULT TRUE;

ALTER TABLE product_order
    ADD COLUMN enable_living_trust BOOLEAN DEFAULT FALSE;

ALTER TABLE product
    ADD COLUMN trusteeFeeFirstDividend DOUBLE DEFAULT 0,
    ADD COLUMN trusteeFeeLastDividend DOUBLE DEFAULT 0;Í

ALTER TABLE product
    RENAME COLUMN trusteeFeeFirstDividend TO trustee_fee_first_dividend,
    RENAME COLUMN trusteeFeeLastDividend TO trustee_fee_last_dividend;

ALTER TABLE product_dividend_calculation_history
    ADD COLUMN trustee_fee_amount DOUBLE DEFAULT 0 AFTER dividend_amount;

-- christine@appxtream.com @ 2025-Apr-23
ALTER TABLE product_agreement
    ADD COLUMN overwrite_agreement_key VARCHAR(255) DEFAULT NULL AFTER upload_document;

ALTER TABLE product_agreement ADD COLUMN product_type VARCHAR(255) DEFAULT 'NEW' AFTER client_type;

ALTER TABLE product_dividend_calculation_history ADD COLUMN dividend_quarter INTEGER DEFAULT 0;

-- thives@appxtream.com @ 2025-May-16
ALTER TABLE product_dividend_calculation_history ADD COLUMN closing_date date DEFAULT NULL AFTER period_ending_date;

ALTER TABLE product_order ADD COLUMN imported BOOLEAN DEFAULT FALSE;

-- zack@nexstream.com.my @ 2025-July-08
ALTER TABLE `product_order` ADD COLUMN `unsigned_agreement_key` VARCHAR(255) DEFAULT NULL;
ALTER TABLE `product_order` ADD COLUMN `physical_signed_agreement_files` VARCHAR(1000) DEFAULT NULL;
ALTER TABLE `product_order` ADD COLUMN `physical_signed_agreement_files_updated_at` TIMESTAMP DEFAULT NULL;
ALTER TABLE `product_order` ADD COLUMN `physical_signed_agreement_files_updated_by` VARCHAR(255) DEFAULT NULL;
ALTER TABLE `product_order` ADD COLUMN `received_physical_signed_agreement_files` TINYINT(1) DEFAULT 0;
ALTER TABLE `product_order` ADD COLUMN `received_physical_signed_agreement_files_updated_at` TIMESTAMP DEFAULT NULL;
ALTER TABLE `product_order` ADD COLUMN `received_physical_signed_agreement_files_updated_by` VARCHAR(255) DEFAULT NULL;

-- thives@nexstream.com.my @ 2025-July-23
ALTER TABLE product_order
    ADD COLUMN witness_signature_date DATE DEFAULT NULL AFTER witness_agreement_status;

ALTER TABLE product_order
    ADD COLUMN physical_signed_agreement_files_reminder_sent BOOLEAN DEFAULT FALSE;


-- thives@nexstream.com.my @ 2025-Aug-06
ALTER TABLE product_order ADD COLUMN client_two_agreement_status VARCHAR(50) DEFAULT NULL;
ALTER TABLE product_order ADD COLUMN client_two_signature_key VARCHAR(255) DEFAULT NULL;
ALTER TABLE product_order ADD COLUMN client_two_signature_date DATE DEFAULT NULL;
ALTER TABLE product_order ADD COLUMN client_two_signature_name VARCHAR(255) DEFAULT NULL;
ALTER TABLE product_order ADD COLUMN client_two_signature_id_number VARCHAR(50) DEFAULT NULL;
ALTER TABLE product_order ADD COLUMN client_two_role VARCHAR(100) DEFAULT NULL;

-- Set client_two_agreement_status to 'SUCCESS' for existing corporate client records
UPDATE product_order 
SET client_two_agreement_status = 'SUCCESS' 
WHERE corporate_client_id IS NOT NULL;

-- Create client_two_signature table for step 9
CREATE TABLE IF NOT EXISTS client_two_signature (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    product_order_id BIGINT NOT NULL,
    unique_identifier VARCHAR(255) UNIQUE NOT NULL,
    expiry_at DATETIME DEFAULT (DATE_ADD(NOW(), INTERVAL 24 HOUR)),
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (product_order_id) REFERENCES product_order(id) ON DELETE CASCADE
);

-- christine@appxtream.com @ 2025-Aug-08
ALTER TABLE product_order
    ADD COLUMN client_role VARCHAR(100) DEFAULT NULL AFTER client_name;

-- thives@nexstream.com.my @ 2025-September-11
ALTER TABLE product_agreement
    DROP COLUMN product_type,
    DROP COLUMN valid_from,
    DROP COLUMN valid_until;