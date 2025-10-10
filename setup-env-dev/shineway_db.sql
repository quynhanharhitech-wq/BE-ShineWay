/*
 Navicat Premium Data Transfer

 Source Server         : postgres
 Source Server Type    : PostgreSQL
 Source Server Version : 160010 (160010)
 Source Host           : localhost:5432
 Source Catalog        : shineway
 Source Schema         : public

 Target Server Type    : PostgreSQL
 Target Server Version : 160010 (160010)
 File Encoding         : 65001

 Date: 09/10/2025 12:01:02
*/


-- ----------------------------
-- Sequence structure for User_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."User_id_seq";
CREATE SEQUENCE "public"."User_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for permission_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."permission_id_seq";
CREATE SEQUENCE "public"."permission_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 2147483647
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for user_authority_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."user_authority_id_seq";
CREATE SEQUENCE "public"."user_authority_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 2147483647
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for user_permission_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."user_permission_id_seq";
CREATE SEQUENCE "public"."user_permission_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 2147483647
START 1
CACHE 1;

-- ----------------------------
-- Table structure for Table
-- ----------------------------
DROP TABLE IF EXISTS "public"."Table";
CREATE TABLE "public"."Table" (
  "id" varchar(50) COLLATE "pg_catalog"."default" NOT NULL,
  "name" varchar(100) COLLATE "pg_catalog"."default" NOT NULL,
  "capacity" int4,
  "area" varchar(100) COLLATE "pg_catalog"."default",
  "status" int4 DEFAULT 1,
  "created_date" timestamp(6) DEFAULT CURRENT_TIMESTAMP,
  "updated_date" timestamp(6) DEFAULT CURRENT_TIMESTAMP,
  "created_by" varchar(50) COLLATE "pg_catalog"."default",
  "updated_by" varchar(50) COLLATE "pg_catalog"."default",
  "is_deleted" bool DEFAULT false
)
;

-- ----------------------------
-- Records of Table
-- ----------------------------

-- ----------------------------
-- Table structure for User
-- ----------------------------
DROP TABLE IF EXISTS "public"."User";
CREATE TABLE "public"."User" (
  "id" int8 NOT NULL DEFAULT nextval('"User_id_seq"'::regclass),
  "user_name" varchar(100) COLLATE "pg_catalog"."default" NOT NULL,
  "password" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "first_name" varchar(100) COLLATE "pg_catalog"."default",
  "middle_name" varchar(100) COLLATE "pg_catalog"."default",
  "last_name" varchar(100) COLLATE "pg_catalog"."default",
  "email" varchar(150) COLLATE "pg_catalog"."default",
  "phone" varchar(20) COLLATE "pg_catalog"."default",
  "dob" date,
  "address" text COLLATE "pg_catalog"."default",
  "gender" char(1) COLLATE "pg_catalog"."default",
  "image_url" text COLLATE "pg_catalog"."default",
  "activated" int4 DEFAULT 0,
  "activation_key" varchar(100) COLLATE "pg_catalog"."default",
  "reset_key" varchar(100) COLLATE "pg_catalog"."default",
  "target_key" varchar(100) COLLATE "pg_catalog"."default",
  "position_id" varchar(50) COLLATE "pg_catalog"."default",
  "created_date" timestamp(6) DEFAULT CURRENT_TIMESTAMP,
  "updated_date" timestamp(6) DEFAULT CURRENT_TIMESTAMP,
  "created_by" varchar(50) COLLATE "pg_catalog"."default",
  "updated_by" varchar(50) COLLATE "pg_catalog"."default",
  "is_deleted" bool DEFAULT false
)
;

-- ----------------------------
-- Records of User
-- ----------------------------

-- ----------------------------
-- Table structure for attendance
-- ----------------------------
DROP TABLE IF EXISTS "public"."attendance";
CREATE TABLE "public"."attendance" (
  "id" varchar(50) COLLATE "pg_catalog"."default" NOT NULL,
  "user_id" int8 NOT NULL,
  "checkin" timestamp(6),
  "checkout" timestamp(6),
  "note" text COLLATE "pg_catalog"."default",
  "created_date" timestamp(6) DEFAULT CURRENT_TIMESTAMP,
  "updated_date" timestamp(6) DEFAULT CURRENT_TIMESTAMP,
  "created_by" varchar(50) COLLATE "pg_catalog"."default",
  "updated_by" varchar(50) COLLATE "pg_catalog"."default",
  "is_deleted" bool DEFAULT false
)
;

-- ----------------------------
-- Records of attendance
-- ----------------------------

-- ----------------------------
-- Table structure for authority
-- ----------------------------
DROP TABLE IF EXISTS "public"."authority";
CREATE TABLE "public"."authority" (
  "name" varchar(100) COLLATE "pg_catalog"."default" NOT NULL,
  "created_date" timestamp(6) DEFAULT CURRENT_TIMESTAMP,
  "updated_date" timestamp(6) DEFAULT CURRENT_TIMESTAMP,
  "created_by" varchar(50) COLLATE "pg_catalog"."default",
  "updated_by" varchar(50) COLLATE "pg_catalog"."default",
  "is_deleted" bool DEFAULT false
)
;

-- ----------------------------
-- Records of authority
-- ----------------------------

-- ----------------------------
-- Table structure for category
-- ----------------------------
DROP TABLE IF EXISTS "public"."category";
CREATE TABLE "public"."category" (
  "id" varchar(50) COLLATE "pg_catalog"."default" NOT NULL,
  "name" varchar(100) COLLATE "pg_catalog"."default" NOT NULL,
  "description" text COLLATE "pg_catalog"."default",
  "icon_url" text COLLATE "pg_catalog"."default",
  "created_date" timestamp(6) DEFAULT CURRENT_TIMESTAMP,
  "updated_date" timestamp(6) DEFAULT CURRENT_TIMESTAMP,
  "created_by" varchar(50) COLLATE "pg_catalog"."default",
  "updated_by" varchar(50) COLLATE "pg_catalog"."default",
  "is_deleted" bool DEFAULT false
)
;

-- ----------------------------
-- Records of category
-- ----------------------------

-- ----------------------------
-- Table structure for export
-- ----------------------------
DROP TABLE IF EXISTS "public"."export";
CREATE TABLE "public"."export" (
  "id" varchar(50) COLLATE "pg_catalog"."default" NOT NULL,
  "user_id" int8 NOT NULL,
  "export_date" timestamp(6) DEFAULT CURRENT_TIMESTAMP,
  "note" text COLLATE "pg_catalog"."default",
  "uuid" varchar(100) COLLATE "pg_catalog"."default",
  "created_date" timestamp(6) DEFAULT CURRENT_TIMESTAMP,
  "updated_date" timestamp(6) DEFAULT CURRENT_TIMESTAMP,
  "created_by" varchar(50) COLLATE "pg_catalog"."default",
  "updated_by" varchar(50) COLLATE "pg_catalog"."default",
  "is_deleted" bool DEFAULT false
)
;

-- ----------------------------
-- Records of export
-- ----------------------------

-- ----------------------------
-- Table structure for export_details
-- ----------------------------
DROP TABLE IF EXISTS "public"."export_details";
CREATE TABLE "public"."export_details" (
  "id" varchar(50) COLLATE "pg_catalog"."default" NOT NULL,
  "export_id" varchar(50) COLLATE "pg_catalog"."default",
  "ingredient_id" varchar(50) COLLATE "pg_catalog"."default",
  "quantity" float8 NOT NULL,
  "unit_price" float8 NOT NULL,
  "created_date" timestamp(6) DEFAULT CURRENT_TIMESTAMP,
  "updated_date" timestamp(6) DEFAULT CURRENT_TIMESTAMP,
  "created_by" varchar(50) COLLATE "pg_catalog"."default",
  "updated_by" varchar(50) COLLATE "pg_catalog"."default",
  "is_deleted" bool DEFAULT false
)
;

-- ----------------------------
-- Records of export_details
-- ----------------------------

-- ----------------------------
-- Table structure for feedback
-- ----------------------------
DROP TABLE IF EXISTS "public"."feedback";
CREATE TABLE "public"."feedback" (
  "id" varchar(50) COLLATE "pg_catalog"."default" NOT NULL,
  "user_id" int8 NOT NULL,
  "order_id" varchar(50) COLLATE "pg_catalog"."default",
  "comment" text COLLATE "pg_catalog"."default",
  "rating" int4,
  "created_date" timestamp(6) DEFAULT CURRENT_TIMESTAMP,
  "updated_date" timestamp(6) DEFAULT CURRENT_TIMESTAMP,
  "created_by" varchar(50) COLLATE "pg_catalog"."default",
  "updated_by" varchar(50) COLLATE "pg_catalog"."default",
  "is_deleted" bool DEFAULT false
)
;

-- ----------------------------
-- Records of feedback
-- ----------------------------

-- ----------------------------
-- Table structure for import
-- ----------------------------
DROP TABLE IF EXISTS "public"."import";
CREATE TABLE "public"."import" (
  "id" varchar(50) COLLATE "pg_catalog"."default" NOT NULL,
  "supplier_id" varchar(50) COLLATE "pg_catalog"."default",
  "user_id" int8 NOT NULL,
  "import_date" timestamp(6) DEFAULT CURRENT_TIMESTAMP,
  "note" text COLLATE "pg_catalog"."default",
  "created_date" timestamp(6) DEFAULT CURRENT_TIMESTAMP,
  "updated_date" timestamp(6) DEFAULT CURRENT_TIMESTAMP,
  "created_by" varchar(50) COLLATE "pg_catalog"."default",
  "updated_by" varchar(50) COLLATE "pg_catalog"."default",
  "is_deleted" bool DEFAULT false
)
;

-- ----------------------------
-- Records of import
-- ----------------------------

-- ----------------------------
-- Table structure for import_details
-- ----------------------------
DROP TABLE IF EXISTS "public"."import_details";
CREATE TABLE "public"."import_details" (
  "id" varchar(50) COLLATE "pg_catalog"."default" NOT NULL,
  "import_id" varchar(50) COLLATE "pg_catalog"."default",
  "ingredient_id" varchar(50) COLLATE "pg_catalog"."default",
  "quantity" float8 NOT NULL,
  "unit_price" float8 NOT NULL,
  "created_date" timestamp(6) DEFAULT CURRENT_TIMESTAMP,
  "updated_date" timestamp(6) DEFAULT CURRENT_TIMESTAMP,
  "created_by" varchar(50) COLLATE "pg_catalog"."default",
  "updated_by" varchar(50) COLLATE "pg_catalog"."default",
  "is_deleted" bool DEFAULT false
)
;

-- ----------------------------
-- Records of import_details
-- ----------------------------

-- ----------------------------
-- Table structure for ingredient
-- ----------------------------
DROP TABLE IF EXISTS "public"."ingredient";
CREATE TABLE "public"."ingredient" (
  "id" varchar(50) COLLATE "pg_catalog"."default" NOT NULL,
  "name" varchar(100) COLLATE "pg_catalog"."default" NOT NULL,
  "category_id" varchar(50) COLLATE "pg_catalog"."default",
  "unit_name" varchar(50) COLLATE "pg_catalog"."default",
  "expiry" timestamp(6),
  "created_date" timestamp(6) DEFAULT CURRENT_TIMESTAMP,
  "updated_date" timestamp(6) DEFAULT CURRENT_TIMESTAMP,
  "created_by" varchar(50) COLLATE "pg_catalog"."default",
  "updated_by" varchar(50) COLLATE "pg_catalog"."default",
  "is_deleted" bool DEFAULT false,
  "supplier_id" varchar(50) COLLATE "pg_catalog"."default"
)
;

-- ----------------------------
-- Records of ingredient
-- ----------------------------

-- ----------------------------
-- Table structure for notification
-- ----------------------------
DROP TABLE IF EXISTS "public"."notification";
CREATE TABLE "public"."notification" (
  "id" varchar(50) COLLATE "pg_catalog"."default" NOT NULL,
  "user_id" int8 NOT NULL,
  "message" text COLLATE "pg_catalog"."default",
  "is_read" bool DEFAULT false,
  "created_date" timestamp(6) DEFAULT CURRENT_TIMESTAMP,
  "updated_date" timestamp(6) DEFAULT CURRENT_TIMESTAMP,
  "created_by" varchar(50) COLLATE "pg_catalog"."default",
  "updated_by" varchar(50) COLLATE "pg_catalog"."default",
  "is_deleted" bool DEFAULT false
)
;

-- ----------------------------
-- Records of notification
-- ----------------------------

-- ----------------------------
-- Table structure for order_details
-- ----------------------------
DROP TABLE IF EXISTS "public"."order_details";
CREATE TABLE "public"."order_details" (
  "id" varchar(50) COLLATE "pg_catalog"."default" NOT NULL,
  "order_id" varchar(50) COLLATE "pg_catalog"."default",
  "product_id" varchar(50) COLLATE "pg_catalog"."default",
  "quantity" int4 NOT NULL,
  "price" float8 NOT NULL,
  "created_date" timestamp(6) DEFAULT CURRENT_TIMESTAMP,
  "updated_date" timestamp(6) DEFAULT CURRENT_TIMESTAMP,
  "created_by" varchar(50) COLLATE "pg_catalog"."default",
  "updated_by" varchar(50) COLLATE "pg_catalog"."default",
  "is_deleted" bool DEFAULT false
)
;

-- ----------------------------
-- Records of order_details
-- ----------------------------

-- ----------------------------
-- Table structure for orders
-- ----------------------------
DROP TABLE IF EXISTS "public"."orders";
CREATE TABLE "public"."orders" (
  "id" varchar(50) COLLATE "pg_catalog"."default" NOT NULL,
  "user_id" int8 NOT NULL,
  "table_id" varchar(50) COLLATE "pg_catalog"."default",
  "payment_id" varchar(50) COLLATE "pg_catalog"."default",
  "order_type" varchar(50) COLLATE "pg_catalog"."default",
  "time" timestamp(6) DEFAULT CURRENT_TIMESTAMP,
  "total_amount" float8 DEFAULT 0,
  "payment_status" int4 DEFAULT 0,
  "created_date" timestamp(6) DEFAULT CURRENT_TIMESTAMP,
  "updated_date" timestamp(6) DEFAULT CURRENT_TIMESTAMP,
  "created_by" varchar(50) COLLATE "pg_catalog"."default",
  "updated_by" varchar(50) COLLATE "pg_catalog"."default",
  "is_deleted" bool DEFAULT false
)
;

-- ----------------------------
-- Records of orders
-- ----------------------------

-- ----------------------------
-- Table structure for payment
-- ----------------------------
DROP TABLE IF EXISTS "public"."payment";
CREATE TABLE "public"."payment" (
  "id" varchar(50) COLLATE "pg_catalog"."default" NOT NULL,
  "name" varchar(100) COLLATE "pg_catalog"."default" NOT NULL,
  "status" int4 DEFAULT 1,
  "created_date" timestamp(6) DEFAULT CURRENT_TIMESTAMP,
  "updated_date" timestamp(6) DEFAULT CURRENT_TIMESTAMP,
  "created_by" varchar(50) COLLATE "pg_catalog"."default",
  "updated_by" varchar(50) COLLATE "pg_catalog"."default",
  "is_deleted" bool DEFAULT false
)
;

-- ----------------------------
-- Records of payment
-- ----------------------------

-- ----------------------------
-- Table structure for permission
-- ----------------------------
DROP TABLE IF EXISTS "public"."permission";
CREATE TABLE "public"."permission" (
  "id" int4 NOT NULL DEFAULT nextval('permission_id_seq'::regclass),
  "name" varchar(100) COLLATE "pg_catalog"."default" NOT NULL,
  "resource" varchar(100) COLLATE "pg_catalog"."default",
  "action" varchar(50) COLLATE "pg_catalog"."default",
  "created_date" timestamp(6) DEFAULT CURRENT_TIMESTAMP,
  "updated_date" timestamp(6) DEFAULT CURRENT_TIMESTAMP,
  "created_by" varchar(50) COLLATE "pg_catalog"."default",
  "updated_by" varchar(50) COLLATE "pg_catalog"."default",
  "is_deleted" bool DEFAULT false
)
;

-- ----------------------------
-- Records of permission
-- ----------------------------

-- ----------------------------
-- Table structure for position
-- ----------------------------
DROP TABLE IF EXISTS "public"."position";
CREATE TABLE "public"."position" (
  "id" varchar(50) COLLATE "pg_catalog"."default" NOT NULL,
  "name" varchar(100) COLLATE "pg_catalog"."default" NOT NULL,
  "description" text COLLATE "pg_catalog"."default",
  "created_date" timestamp(6) DEFAULT CURRENT_TIMESTAMP,
  "updated_date" timestamp(6) DEFAULT CURRENT_TIMESTAMP,
  "created_by" varchar(50) COLLATE "pg_catalog"."default",
  "updated_by" varchar(50) COLLATE "pg_catalog"."default",
  "is_deleted" bool DEFAULT false
)
;

-- ----------------------------
-- Records of position
-- ----------------------------

-- ----------------------------
-- Table structure for product
-- ----------------------------
DROP TABLE IF EXISTS "public"."product";
CREATE TABLE "public"."product" (
  "id" varchar(50) COLLATE "pg_catalog"."default" NOT NULL,
  "name" varchar(100) COLLATE "pg_catalog"."default" NOT NULL,
  "category_id" varchar(50) COLLATE "pg_catalog"."default",
  "description" text COLLATE "pg_catalog"."default",
  "price" float8 NOT NULL,
  "price_promotion" float8,
  "image_url" text COLLATE "pg_catalog"."default",
  "created_date" timestamp(6) DEFAULT CURRENT_TIMESTAMP,
  "updated_date" timestamp(6) DEFAULT CURRENT_TIMESTAMP,
  "created_by" varchar(50) COLLATE "pg_catalog"."default",
  "updated_by" varchar(50) COLLATE "pg_catalog"."default",
  "is_deleted" bool DEFAULT false
)
;

-- ----------------------------
-- Records of product
-- ----------------------------

-- ----------------------------
-- Table structure for product_ingredient
-- ----------------------------
DROP TABLE IF EXISTS "public"."product_ingredient";
CREATE TABLE "public"."product_ingredient" (
  "id" varchar(50) COLLATE "pg_catalog"."default" NOT NULL,
  "product_id" varchar(50) COLLATE "pg_catalog"."default",
  "ingredient_id" varchar(50) COLLATE "pg_catalog"."default",
  "quantity" float8 NOT NULL,
  "created_date" timestamp(6) DEFAULT CURRENT_TIMESTAMP,
  "updated_date" timestamp(6) DEFAULT CURRENT_TIMESTAMP,
  "created_by" varchar(50) COLLATE "pg_catalog"."default",
  "updated_by" varchar(50) COLLATE "pg_catalog"."default",
  "is_deleted" bool DEFAULT false
)
;

-- ----------------------------
-- Records of product_ingredient
-- ----------------------------

-- ----------------------------
-- Table structure for profile
-- ----------------------------
DROP TABLE IF EXISTS "public"."profile";
CREATE TABLE "public"."profile" (
  "id" varchar(50) COLLATE "pg_catalog"."default" NOT NULL,
  "user_id" int8 NOT NULL,
  "first_name" varchar(100) COLLATE "pg_catalog"."default",
  "middle_name" varchar(100) COLLATE "pg_catalog"."default",
  "last_name" varchar(100) COLLATE "pg_catalog"."default",
  "phone" varchar(20) COLLATE "pg_catalog"."default",
  "email" varchar(150) COLLATE "pg_catalog"."default",
  "dob" date,
  "address" text COLLATE "pg_catalog"."default",
  "gender" char(1) COLLATE "pg_catalog"."default",
  "description" text COLLATE "pg_catalog"."default",
  "image_url" text COLLATE "pg_catalog"."default",
  "created_date" timestamp(6) DEFAULT CURRENT_TIMESTAMP,
  "updated_date" timestamp(6) DEFAULT CURRENT_TIMESTAMP,
  "created_by" varchar(50) COLLATE "pg_catalog"."default",
  "updated_by" varchar(50) COLLATE "pg_catalog"."default",
  "is_deleted" bool DEFAULT false
)
;

-- ----------------------------
-- Records of profile
-- ----------------------------

-- ----------------------------
-- Table structure for salary
-- ----------------------------
DROP TABLE IF EXISTS "public"."salary";
CREATE TABLE "public"."salary" (
  "id" varchar(50) COLLATE "pg_catalog"."default" NOT NULL,
  "user_id" int8 NOT NULL,
  "payment_type" varchar(50) COLLATE "pg_catalog"."default",
  "total_revenue" float8,
  "date_for_salary" date,
  "note" text COLLATE "pg_catalog"."default",
  "created_date" timestamp(6) DEFAULT CURRENT_TIMESTAMP,
  "updated_date" timestamp(6) DEFAULT CURRENT_TIMESTAMP,
  "created_by" varchar(50) COLLATE "pg_catalog"."default",
  "updated_by" varchar(50) COLLATE "pg_catalog"."default",
  "is_deleted" bool DEFAULT false
)
;

-- ----------------------------
-- Records of salary
-- ----------------------------

-- ----------------------------
-- Table structure for supplier
-- ----------------------------
DROP TABLE IF EXISTS "public"."supplier";
CREATE TABLE "public"."supplier" (
  "id" varchar(50) COLLATE "pg_catalog"."default" NOT NULL,
  "name" varchar(100) COLLATE "pg_catalog"."default" NOT NULL,
  "address" text COLLATE "pg_catalog"."default",
  "phone" varchar(20) COLLATE "pg_catalog"."default",
  "created_date" timestamp(6) DEFAULT CURRENT_TIMESTAMP,
  "updated_date" timestamp(6) DEFAULT CURRENT_TIMESTAMP,
  "created_by" varchar(50) COLLATE "pg_catalog"."default",
  "updated_by" varchar(50) COLLATE "pg_catalog"."default",
  "is_deleted" bool DEFAULT false
)
;

-- ----------------------------
-- Records of supplier
-- ----------------------------

-- ----------------------------
-- Table structure for unit
-- ----------------------------
DROP TABLE IF EXISTS "public"."unit";
CREATE TABLE "public"."unit" (
  "name" varchar(50) COLLATE "pg_catalog"."default" NOT NULL,
  "type" varchar(50) COLLATE "pg_catalog"."default",
  "created_date" timestamp(6) DEFAULT CURRENT_TIMESTAMP,
  "updated_date" timestamp(6) DEFAULT CURRENT_TIMESTAMP,
  "created_by" varchar(50) COLLATE "pg_catalog"."default",
  "updated_by" varchar(50) COLLATE "pg_catalog"."default",
  "is_deleted" bool DEFAULT false
)
;

-- ----------------------------
-- Records of unit
-- ----------------------------

-- ----------------------------
-- Table structure for user_authority
-- ----------------------------
DROP TABLE IF EXISTS "public"."user_authority";
CREATE TABLE "public"."user_authority" (
  "id" int4 NOT NULL DEFAULT nextval('user_authority_id_seq'::regclass),
  "user_id" int8 NOT NULL,
  "authority_name" varchar(100) COLLATE "pg_catalog"."default" NOT NULL,
  "created_date" timestamp(6) DEFAULT CURRENT_TIMESTAMP,
  "created_by" varchar(50) COLLATE "pg_catalog"."default",
  "is_deleted" bool DEFAULT false
)
;

-- ----------------------------
-- Records of user_authority
-- ----------------------------

-- ----------------------------
-- Table structure for user_permission
-- ----------------------------
DROP TABLE IF EXISTS "public"."user_permission";
CREATE TABLE "public"."user_permission" (
  "id" int4 NOT NULL DEFAULT nextval('user_permission_id_seq'::regclass),
  "user_id" int8 NOT NULL,
  "permission_id" int4 NOT NULL,
  "created_date" timestamp(6) DEFAULT CURRENT_TIMESTAMP,
  "created_by" varchar(50) COLLATE "pg_catalog"."default",
  "is_deleted" bool DEFAULT false
)
;

-- ----------------------------
-- Records of user_permission
-- ----------------------------

-- ----------------------------
-- Function structure for update_updated_date
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."update_updated_date"();
CREATE OR REPLACE FUNCTION "public"."update_updated_date"()
  RETURNS "pg_catalog"."trigger" AS $BODY$
BEGIN
    NEW.updated_date = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."User_id_seq"
OWNED BY "public"."User"."id";
SELECT setval('"public"."User_id_seq"', 1, false);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."permission_id_seq"
OWNED BY "public"."permission"."id";
SELECT setval('"public"."permission_id_seq"', 1, false);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."user_authority_id_seq"
OWNED BY "public"."user_authority"."id";
SELECT setval('"public"."user_authority_id_seq"', 1, false);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."user_permission_id_seq"
OWNED BY "public"."user_permission"."id";
SELECT setval('"public"."user_permission_id_seq"', 1, false);

-- ----------------------------
-- Triggers structure for table Table
-- ----------------------------
CREATE TRIGGER "trigger_update_table" BEFORE UPDATE ON "public"."Table"
FOR EACH ROW
EXECUTE PROCEDURE "public"."update_updated_date"();

-- ----------------------------
-- Primary Key structure for table Table
-- ----------------------------
ALTER TABLE "public"."Table" ADD CONSTRAINT "Table_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table User
-- ----------------------------
CREATE INDEX "idx_user_email" ON "public"."User" USING btree (
  "email" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);
CREATE INDEX "idx_user_phone" ON "public"."User" USING btree (
  "phone" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);

-- ----------------------------
-- Triggers structure for table User
-- ----------------------------
CREATE TRIGGER "trigger_update_user" BEFORE UPDATE ON "public"."User"
FOR EACH ROW
EXECUTE PROCEDURE "public"."update_updated_date"();

-- ----------------------------
-- Uniques structure for table User
-- ----------------------------
ALTER TABLE "public"."User" ADD CONSTRAINT "User_user_name_key" UNIQUE ("user_name");

-- ----------------------------
-- Primary Key structure for table User
-- ----------------------------
ALTER TABLE "public"."User" ADD CONSTRAINT "User_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table attendance
-- ----------------------------
CREATE INDEX "idx_attendance_user_id" ON "public"."attendance" USING btree (
  "user_id" "pg_catalog"."int8_ops" ASC NULLS LAST
);

-- ----------------------------
-- Triggers structure for table attendance
-- ----------------------------
CREATE TRIGGER "trigger_update_attendance" BEFORE UPDATE ON "public"."attendance"
FOR EACH ROW
EXECUTE PROCEDURE "public"."update_updated_date"();

-- ----------------------------
-- Primary Key structure for table attendance
-- ----------------------------
ALTER TABLE "public"."attendance" ADD CONSTRAINT "attendance_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Triggers structure for table authority
-- ----------------------------
CREATE TRIGGER "trigger_update_authority" BEFORE UPDATE ON "public"."authority"
FOR EACH ROW
EXECUTE PROCEDURE "public"."update_updated_date"();

-- ----------------------------
-- Primary Key structure for table authority
-- ----------------------------
ALTER TABLE "public"."authority" ADD CONSTRAINT "authority_pkey" PRIMARY KEY ("name");

-- ----------------------------
-- Triggers structure for table category
-- ----------------------------
CREATE TRIGGER "trigger_update_category" BEFORE UPDATE ON "public"."category"
FOR EACH ROW
EXECUTE PROCEDURE "public"."update_updated_date"();

-- ----------------------------
-- Primary Key structure for table category
-- ----------------------------
ALTER TABLE "public"."category" ADD CONSTRAINT "category_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table export
-- ----------------------------
CREATE INDEX "idx_export_user_id" ON "public"."export" USING btree (
  "user_id" "pg_catalog"."int8_ops" ASC NULLS LAST
);

-- ----------------------------
-- Triggers structure for table export
-- ----------------------------
CREATE TRIGGER "trigger_update_export" BEFORE UPDATE ON "public"."export"
FOR EACH ROW
EXECUTE PROCEDURE "public"."update_updated_date"();

-- ----------------------------
-- Primary Key structure for table export
-- ----------------------------
ALTER TABLE "public"."export" ADD CONSTRAINT "export_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Triggers structure for table export_details
-- ----------------------------
CREATE TRIGGER "trigger_update_export_details" BEFORE UPDATE ON "public"."export_details"
FOR EACH ROW
EXECUTE PROCEDURE "public"."update_updated_date"();

-- ----------------------------
-- Primary Key structure for table export_details
-- ----------------------------
ALTER TABLE "public"."export_details" ADD CONSTRAINT "export_details_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Triggers structure for table feedback
-- ----------------------------
CREATE TRIGGER "trigger_update_feedback" BEFORE UPDATE ON "public"."feedback"
FOR EACH ROW
EXECUTE PROCEDURE "public"."update_updated_date"();

-- ----------------------------
-- Checks structure for table feedback
-- ----------------------------
ALTER TABLE "public"."feedback" ADD CONSTRAINT "feedback_rating_check" CHECK (rating >= 1 AND rating <= 5);

-- ----------------------------
-- Primary Key structure for table feedback
-- ----------------------------
ALTER TABLE "public"."feedback" ADD CONSTRAINT "feedback_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table import
-- ----------------------------
CREATE INDEX "idx_import_supplier_id" ON "public"."import" USING btree (
  "supplier_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);
CREATE INDEX "idx_import_user_id" ON "public"."import" USING btree (
  "user_id" "pg_catalog"."int8_ops" ASC NULLS LAST
);

-- ----------------------------
-- Triggers structure for table import
-- ----------------------------
CREATE TRIGGER "trigger_update_import" BEFORE UPDATE ON "public"."import"
FOR EACH ROW
EXECUTE PROCEDURE "public"."update_updated_date"();

-- ----------------------------
-- Primary Key structure for table import
-- ----------------------------
ALTER TABLE "public"."import" ADD CONSTRAINT "import_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Triggers structure for table import_details
-- ----------------------------
CREATE TRIGGER "trigger_update_import_details" BEFORE UPDATE ON "public"."import_details"
FOR EACH ROW
EXECUTE PROCEDURE "public"."update_updated_date"();

-- ----------------------------
-- Primary Key structure for table import_details
-- ----------------------------
ALTER TABLE "public"."import_details" ADD CONSTRAINT "import_details_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table ingredient
-- ----------------------------
CREATE INDEX "idx_ingredient_category_id" ON "public"."ingredient" USING btree (
  "category_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);
CREATE INDEX "idx_ingredient_supplier_id" ON "public"."ingredient" USING btree (
  "supplier_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);

-- ----------------------------
-- Triggers structure for table ingredient
-- ----------------------------
CREATE TRIGGER "trigger_update_ingredient" BEFORE UPDATE ON "public"."ingredient"
FOR EACH ROW
EXECUTE PROCEDURE "public"."update_updated_date"();

-- ----------------------------
-- Primary Key structure for table ingredient
-- ----------------------------
ALTER TABLE "public"."ingredient" ADD CONSTRAINT "ingredient_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Triggers structure for table notification
-- ----------------------------
CREATE TRIGGER "trigger_update_notification" BEFORE UPDATE ON "public"."notification"
FOR EACH ROW
EXECUTE PROCEDURE "public"."update_updated_date"();

-- ----------------------------
-- Primary Key structure for table notification
-- ----------------------------
ALTER TABLE "public"."notification" ADD CONSTRAINT "notification_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Triggers structure for table order_details
-- ----------------------------
CREATE TRIGGER "trigger_update_order_details" BEFORE UPDATE ON "public"."order_details"
FOR EACH ROW
EXECUTE PROCEDURE "public"."update_updated_date"();

-- ----------------------------
-- Primary Key structure for table order_details
-- ----------------------------
ALTER TABLE "public"."order_details" ADD CONSTRAINT "order_details_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table orders
-- ----------------------------
CREATE INDEX "idx_orders_table_id" ON "public"."orders" USING btree (
  "table_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);
CREATE INDEX "idx_orders_user_id" ON "public"."orders" USING btree (
  "user_id" "pg_catalog"."int8_ops" ASC NULLS LAST
);

-- ----------------------------
-- Triggers structure for table orders
-- ----------------------------
CREATE TRIGGER "trigger_update_orders" BEFORE UPDATE ON "public"."orders"
FOR EACH ROW
EXECUTE PROCEDURE "public"."update_updated_date"();

-- ----------------------------
-- Primary Key structure for table orders
-- ----------------------------
ALTER TABLE "public"."orders" ADD CONSTRAINT "orders_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Triggers structure for table payment
-- ----------------------------
CREATE TRIGGER "trigger_update_payment" BEFORE UPDATE ON "public"."payment"
FOR EACH ROW
EXECUTE PROCEDURE "public"."update_updated_date"();

-- ----------------------------
-- Primary Key structure for table payment
-- ----------------------------
ALTER TABLE "public"."payment" ADD CONSTRAINT "payment_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Triggers structure for table permission
-- ----------------------------
CREATE TRIGGER "trigger_update_permission" BEFORE UPDATE ON "public"."permission"
FOR EACH ROW
EXECUTE PROCEDURE "public"."update_updated_date"();

-- ----------------------------
-- Primary Key structure for table permission
-- ----------------------------
ALTER TABLE "public"."permission" ADD CONSTRAINT "permission_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Triggers structure for table position
-- ----------------------------
CREATE TRIGGER "trigger_update_position" BEFORE UPDATE ON "public"."position"
FOR EACH ROW
EXECUTE PROCEDURE "public"."update_updated_date"();

-- ----------------------------
-- Primary Key structure for table position
-- ----------------------------
ALTER TABLE "public"."position" ADD CONSTRAINT "position_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table product
-- ----------------------------
CREATE INDEX "idx_product_category_id" ON "public"."product" USING btree (
  "category_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);

-- ----------------------------
-- Triggers structure for table product
-- ----------------------------
CREATE TRIGGER "trigger_update_product" BEFORE UPDATE ON "public"."product"
FOR EACH ROW
EXECUTE PROCEDURE "public"."update_updated_date"();

-- ----------------------------
-- Primary Key structure for table product
-- ----------------------------
ALTER TABLE "public"."product" ADD CONSTRAINT "product_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Triggers structure for table product_ingredient
-- ----------------------------
CREATE TRIGGER "trigger_update_product_ingredient" BEFORE UPDATE ON "public"."product_ingredient"
FOR EACH ROW
EXECUTE PROCEDURE "public"."update_updated_date"();

-- ----------------------------
-- Primary Key structure for table product_ingredient
-- ----------------------------
ALTER TABLE "public"."product_ingredient" ADD CONSTRAINT "product_ingredient_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table profile
-- ----------------------------
CREATE INDEX "idx_profile_email" ON "public"."profile" USING btree (
  "email" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);
CREATE INDEX "idx_profile_phone" ON "public"."profile" USING btree (
  "phone" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);
CREATE INDEX "idx_profile_user_id" ON "public"."profile" USING btree (
  "user_id" "pg_catalog"."int8_ops" ASC NULLS LAST
);

-- ----------------------------
-- Triggers structure for table profile
-- ----------------------------
CREATE TRIGGER "trigger_update_profile" BEFORE UPDATE ON "public"."profile"
FOR EACH ROW
EXECUTE PROCEDURE "public"."update_updated_date"();

-- ----------------------------
-- Primary Key structure for table profile
-- ----------------------------
ALTER TABLE "public"."profile" ADD CONSTRAINT "profile_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table salary
-- ----------------------------
CREATE INDEX "idx_salary_user_id" ON "public"."salary" USING btree (
  "user_id" "pg_catalog"."int8_ops" ASC NULLS LAST
);

-- ----------------------------
-- Triggers structure for table salary
-- ----------------------------
CREATE TRIGGER "trigger_update_salary" BEFORE UPDATE ON "public"."salary"
FOR EACH ROW
EXECUTE PROCEDURE "public"."update_updated_date"();

-- ----------------------------
-- Primary Key structure for table salary
-- ----------------------------
ALTER TABLE "public"."salary" ADD CONSTRAINT "salary_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Triggers structure for table supplier
-- ----------------------------
CREATE TRIGGER "trigger_update_supplier" BEFORE UPDATE ON "public"."supplier"
FOR EACH ROW
EXECUTE PROCEDURE "public"."update_updated_date"();

-- ----------------------------
-- Primary Key structure for table supplier
-- ----------------------------
ALTER TABLE "public"."supplier" ADD CONSTRAINT "supplier_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Triggers structure for table unit
-- ----------------------------
CREATE TRIGGER "trigger_update_unit" BEFORE UPDATE ON "public"."unit"
FOR EACH ROW
EXECUTE PROCEDURE "public"."update_updated_date"();

-- ----------------------------
-- Primary Key structure for table unit
-- ----------------------------
ALTER TABLE "public"."unit" ADD CONSTRAINT "unit_pkey" PRIMARY KEY ("name");

-- ----------------------------
-- Uniques structure for table user_authority
-- ----------------------------
ALTER TABLE "public"."user_authority" ADD CONSTRAINT "user_authority_user_id_authority_name_key" UNIQUE ("user_id", "authority_name");

-- ----------------------------
-- Primary Key structure for table user_authority
-- ----------------------------
ALTER TABLE "public"."user_authority" ADD CONSTRAINT "user_authority_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Uniques structure for table user_permission
-- ----------------------------
ALTER TABLE "public"."user_permission" ADD CONSTRAINT "user_permission_user_id_permission_id_key" UNIQUE ("user_id", "permission_id");

-- ----------------------------
-- Primary Key structure for table user_permission
-- ----------------------------
ALTER TABLE "public"."user_permission" ADD CONSTRAINT "user_permission_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Foreign Keys structure for table User
-- ----------------------------
ALTER TABLE "public"."User" ADD CONSTRAINT "User_position_id_fkey" FOREIGN KEY ("position_id") REFERENCES "public"."position" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- ----------------------------
-- Foreign Keys structure for table attendance
-- ----------------------------
ALTER TABLE "public"."attendance" ADD CONSTRAINT "attendance_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "public"."User" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- ----------------------------
-- Foreign Keys structure for table export
-- ----------------------------
ALTER TABLE "public"."export" ADD CONSTRAINT "export_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "public"."User" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- ----------------------------
-- Foreign Keys structure for table export_details
-- ----------------------------
ALTER TABLE "public"."export_details" ADD CONSTRAINT "export_details_export_id_fkey" FOREIGN KEY ("export_id") REFERENCES "public"."export" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION;
ALTER TABLE "public"."export_details" ADD CONSTRAINT "export_details_ingredient_id_fkey" FOREIGN KEY ("ingredient_id") REFERENCES "public"."ingredient" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- ----------------------------
-- Foreign Keys structure for table feedback
-- ----------------------------
ALTER TABLE "public"."feedback" ADD CONSTRAINT "feedback_order_id_fkey" FOREIGN KEY ("order_id") REFERENCES "public"."orders" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION;
ALTER TABLE "public"."feedback" ADD CONSTRAINT "feedback_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "public"."User" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- ----------------------------
-- Foreign Keys structure for table import
-- ----------------------------
ALTER TABLE "public"."import" ADD CONSTRAINT "import_supplier_id_fkey" FOREIGN KEY ("supplier_id") REFERENCES "public"."supplier" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION;
ALTER TABLE "public"."import" ADD CONSTRAINT "import_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "public"."User" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- ----------------------------
-- Foreign Keys structure for table import_details
-- ----------------------------
ALTER TABLE "public"."import_details" ADD CONSTRAINT "import_details_import_id_fkey" FOREIGN KEY ("import_id") REFERENCES "public"."import" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION;
ALTER TABLE "public"."import_details" ADD CONSTRAINT "import_details_ingredient_id_fkey" FOREIGN KEY ("ingredient_id") REFERENCES "public"."ingredient" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- ----------------------------
-- Foreign Keys structure for table ingredient
-- ----------------------------
ALTER TABLE "public"."ingredient" ADD CONSTRAINT "fk_ingredient_supplier" FOREIGN KEY ("supplier_id") REFERENCES "public"."supplier" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION;
ALTER TABLE "public"."ingredient" ADD CONSTRAINT "ingredient_category_id_fkey" FOREIGN KEY ("category_id") REFERENCES "public"."category" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION;
ALTER TABLE "public"."ingredient" ADD CONSTRAINT "ingredient_unit_name_fkey" FOREIGN KEY ("unit_name") REFERENCES "public"."unit" ("name") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- ----------------------------
-- Foreign Keys structure for table notification
-- ----------------------------
ALTER TABLE "public"."notification" ADD CONSTRAINT "notification_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "public"."User" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- ----------------------------
-- Foreign Keys structure for table order_details
-- ----------------------------
ALTER TABLE "public"."order_details" ADD CONSTRAINT "order_details_order_id_fkey" FOREIGN KEY ("order_id") REFERENCES "public"."orders" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION;
ALTER TABLE "public"."order_details" ADD CONSTRAINT "order_details_product_id_fkey" FOREIGN KEY ("product_id") REFERENCES "public"."product" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- ----------------------------
-- Foreign Keys structure for table orders
-- ----------------------------
ALTER TABLE "public"."orders" ADD CONSTRAINT "orders_payment_id_fkey" FOREIGN KEY ("payment_id") REFERENCES "public"."payment" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION;
ALTER TABLE "public"."orders" ADD CONSTRAINT "orders_table_id_fkey" FOREIGN KEY ("table_id") REFERENCES "public"."Table" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION;
ALTER TABLE "public"."orders" ADD CONSTRAINT "orders_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "public"."User" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- ----------------------------
-- Foreign Keys structure for table product
-- ----------------------------
ALTER TABLE "public"."product" ADD CONSTRAINT "product_category_id_fkey" FOREIGN KEY ("category_id") REFERENCES "public"."category" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- ----------------------------
-- Foreign Keys structure for table product_ingredient
-- ----------------------------
ALTER TABLE "public"."product_ingredient" ADD CONSTRAINT "product_ingredient_ingredient_id_fkey" FOREIGN KEY ("ingredient_id") REFERENCES "public"."ingredient" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION;
ALTER TABLE "public"."product_ingredient" ADD CONSTRAINT "product_ingredient_product_id_fkey" FOREIGN KEY ("product_id") REFERENCES "public"."product" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- ----------------------------
-- Foreign Keys structure for table profile
-- ----------------------------
ALTER TABLE "public"."profile" ADD CONSTRAINT "profile_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "public"."User" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- ----------------------------
-- Foreign Keys structure for table salary
-- ----------------------------
ALTER TABLE "public"."salary" ADD CONSTRAINT "salary_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "public"."User" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- ----------------------------
-- Foreign Keys structure for table user_authority
-- ----------------------------
ALTER TABLE "public"."user_authority" ADD CONSTRAINT "user_authority_authority_name_fkey" FOREIGN KEY ("authority_name") REFERENCES "public"."authority" ("name") ON DELETE NO ACTION ON UPDATE NO ACTION;
ALTER TABLE "public"."user_authority" ADD CONSTRAINT "user_authority_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "public"."User" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- ----------------------------
-- Foreign Keys structure for table user_permission
-- ----------------------------
ALTER TABLE "public"."user_permission" ADD CONSTRAINT "user_permission_permission_id_fkey" FOREIGN KEY ("permission_id") REFERENCES "public"."permission" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION;
ALTER TABLE "public"."user_permission" ADD CONSTRAINT "user_permission_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "public"."User" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION;
