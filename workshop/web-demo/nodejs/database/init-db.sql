-- create table for images

CREATE TABLE images
(
  imageid serial UNIQUE PRIMARY KEY,
  description character varying(10485760) NOT NULL,
  url character varying(255) NOT NULL
);

ALTER TABLE images
  OWNER TO dockeruser;
ALTER ROLE dockeruser CONNECTION LIMIT -1;

-- add image data
INSERT INTO images (description, url) VALUES('cat image', 'https://ichef.bbci.co.uk/images/ic/720x405/p0517py6.jpg');
INSERT INTO images (description, url) VALUES('cat image', 'https://ichef.bbci.co.uk/images/ic/720x405/p0517py6.jpg');
INSERT INTO images (description, url) VALUES('cat image', 'https://ichef.bbci.co.uk/images/ic/720x405/p0517py6.jpg');
