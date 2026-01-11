CREATE TABLE IF NOT EXISTS "stadistics" (
	"id" INTEGER NOT NULL UNIQUE,
	"average" REAL,
	"median" REAL,
	"trend" REAL,
	PRIMARY KEY("id")
);




CREATE TABLE IF NOT EXISTS "product" (
	"id_product" INTEGER NOT NULL UNIQUE,
	"name" VARCHAR(255),
	"category" VARCHAR(255),
	"price" REAL NOT NULL,
	"url" VARCHAR(255),
	PRIMARY KEY("id_product")
);




CREATE TABLE IF NOT EXISTS "platform" (
	"id_platform" INTEGER NOT NULL UNIQUE,
	"name" VARCHAR(255),
	PRIMARY KEY("id_platform")
);




CREATE TABLE IF NOT EXISTS "history" (
	"id" INTEGER NOT NULL UNIQUE,
	"id_product_fk" INTEGER,
	"id_platform_fk" INTEGER,
	"price_stamp" REAL,
	"last_update" TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY("id")
);



ALTER TABLE "history"
ADD FOREIGN KEY("id_product_fk") REFERENCES "product"("id_product")
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE "history"
ADD FOREIGN KEY("id_platform_fk") REFERENCES "platform"("id_platform")
ON UPDATE NO ACTION ON DELETE NO ACTION;