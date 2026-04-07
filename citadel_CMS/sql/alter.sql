ALTER TABLE individual_guardian drop constraint fk_client, drop column client_id,  drop column relationship_to_beneficiary;

CREATE TABLE individual_beneficiary_guardian (
    id BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    individual_beneficiary_id BIGINT NOT NULL,
    individual_guardian_id BIGINT NOT NULL,
    relationship_to_beneficiary VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (individual_beneficiary_id) REFERENCES individual_beneficiary(id),
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

# --boonheeloo@gmail.com 29/11/2024--
ALTER TABLE individual_guardian
add column client_id BIGINT After id;

ALTER TABLE individual_guardian
MODIFY COLUMN client_id bigint NOT NULL;
