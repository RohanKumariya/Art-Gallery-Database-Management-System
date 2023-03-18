BEGIN;


CREATE TABLE IF NOT EXISTS public."Customer"
(
    customer_acc_no integer NOT NULL,
    first_name character varying(20) NOT NULL,
    middle_name character varying(20),
    last_name character varying(20) NOT NULL,
    billing_address character varying(50) NOT NULL,
    billing_city character varying(20) NOT NULL,
    billing_zip_code numeric(6) NOT NULL,
    billing_state character varying(10) NOT NULL,
    phone numeric(10) NOT NULL,
    PRIMARY KEY (customer_acc_no)
);

CREATE TABLE IF NOT EXISTS public."Employee"
(
    employee_id integer NOT NULL,
    ssn numeric(9) NOT NULL,
    first_name character varying(20) NOT NULL,
    middle_name character varying(20),
    last_name character varying(20) NOT NULL,
    address character varying(50) NOT NULL,
    city character varying(20) NOT NULL,
    zip_code numeric(6) NOT NULL,
    state character varying(20) NOT NULL,
    mobile_number numeric(10) NOT NULL,
    employee_type character varying(10),
    PRIMARY KEY (employee_id)
);

CREATE TABLE IF NOT EXISTS public."Sales_Representative"
(
    semployee_id integer NOT NULL,
    comission integer,
    PRIMARY KEY (semployee_id)
);

CREATE TABLE IF NOT EXISTS public."Driver"
(
    demployee_id integer NOT NULL,
    driver_license_no character varying(10) NOT NULL,
    license_expiration_date date NOT NULL,
    vehicle_number integer NOT NULL,
    PRIMARY KEY (demployee_id)
	CONSTRAINT driver_unique UNIQUE (vehicle_number)
);

CREATE TABLE IF NOT EXISTS public."Vehicle"
(
    vehicle_number integer NOT NULL,
    vehicle_manufacturer character varying(20),
    license_plate_number character varying(20) NOT NULL,
    license_plate_expiration_date date NOT NULL,
    PRIMARY KEY (vehicle_number)
);

CREATE TABLE IF NOT EXISTS public."Shipment"
(
    shipment_number integer NOT NULL,
    delivery_address character varying(50) NOT NULL,
    delivery_city character varying(20) NOT NULL,
    deliver_zip_code numeric(6) NOT NULL,
    vehicle_number integer NOT NULL,
    PRIMARY KEY (shipment_number),
	CONSTRAINT shipment_unique UNIQUE (vehicle_number)
);

CREATE TABLE IF NOT EXISTS public."Artwork"
(
    artwork_id integer NOT NULL,
    description character varying(50),
    unit_price integer,
    quantity_in_stock smallint,
	PRIMARY KEY (artwork_id)
);

CREATE TABLE IF NOT EXISTS public."Orders"
(
    order_number integer NOT NULL,
    semployee_id integer NOT NULL,
    shipment_number integer NOT NULL,
    customer_acc_number integer NOT NULL,
    PRIMARY KEY (order_number),
	CONSTRAINT order_semp UNIQUE (semployee_id),
	CONSTRAINT order_shipment UNIQUE (shipment_number),
	CONSTRAINT order_cust UNIQUE (customer_acc_number)
);

CREATE TABLE IF NOT EXISTS public.assignline
(
    furniture_id integer NOT NULL,
    order_number integer NOT NULL,
    quantity_ordered integer NOT NULL,
    PRIMARY KEY (furniture_id),
	CONSTRAINT order_order UNIQUE (order_number)
);

ALTER TABLE IF EXISTS public."Shipment"
    ADD FOREIGN KEY (vehicle_number)
    REFERENCES public."Vehicle" (vehicle_number) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public."Shipment"
    ADD FOREIGN KEY (shipment_number)
    REFERENCES public."Orders" (shipment_number) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public."Orders"
    ADD FOREIGN KEY (customer_acc_number)
    REFERENCES public."Customer" (customer_acc_no) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public."Orders"
    ADD FOREIGN KEY (semployee_id)
    REFERENCES public."Sales_Representative" (semployee_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.assignline
    ADD FOREIGN KEY (furniture_id)
    REFERENCES public."Artwork" (artwork_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.assignline
    ADD FOREIGN KEY (order_number)
    REFERENCES public."Orders" (order_number) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;

ALTER TABLE IF EXISTS public.employee
    ADD FOREIGN KEY (employee_id)
    REFERENCES public."Sales_Representative" (semployee_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;
	
ALTER TABLE IF EXISTS public.employee
    ADD FOREIGN KEY (employee_id)
    REFERENCES public."Driver" (demployee_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;

ALTER TABLE IF EXISTS public.Driver
    ADD FOREIGN KEY (vehicle_number)
    REFERENCES public."Vehicle" (vehicle_number) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;

END;