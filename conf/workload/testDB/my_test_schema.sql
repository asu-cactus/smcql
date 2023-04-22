
CREATE TABLE remote_surveillance (
    id integer NOT NULL,
    date integer NOT NULL,
    location integer NOT NULL
);

CREATE TABLE surveillance (
    id integer NOT NULL,
    date integer NOT NULL,
    location integer NOT NULL
);

CREATE TABLE passenger (
    id integer NOT NULL,
    name character varying NOT NULL,
    dob character varying NOT NULL,
    country character varying NOT NULL
);

CREATE TABLE remote_passenger (
    id integer NOT NULL,
    name character varying NOT NULL,
    dob character varying NOT NULL,
    country character varying NOT NULL
);

CREATE TABLE site (
       id integer);


-- set up security level of attributes
-- default setting: attribute is private
CREATE ROLE public_attribute;
CREATE ROLE protected_attribute;


GRANT SELECT(id) ON surveillance TO protected_attribute;
GRANT SELECT(date) ON surveillance TO protected_attribute;
GRANT SELECT(location) ON surveillance TO protected_attribute;


GRANT SELECT(id) ON passenger TO public_attribute;
GRANT SELECT(name) ON passenger TO public_attribute;
GRANT SELECT(dob) ON passenger TO public_attribute;
GRANT SELECT(country) ON passenger TO public_attribute;
