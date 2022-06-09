-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.


CREATE TABLE "countries" (
    "country_name_clean" varchar(255)   NOT NULL,
    "region" varchar(255)   NOT NULL,
    CONSTRAINT "pk_countries" PRIMARY KEY (
        "country_name_clean"
     )
);

CREATE TABLE "country_xref" (
    "country_name_original" varchar(255)   NOT NULL,
    "country_name_clean" varchar(255)   NOT NULL,
    CONSTRAINT "pk_country_xref" PRIMARY KEY (
        "country_name_original"
     )
);

CREATE TABLE "worldhappinessreport_2021" (
    "country_name" varchar(50)   NOT NULL,
    "regional_indicator" varchar(50)   NOT NULL,
    "ladder_score" double   NOT NULL,
    "stand_err" double   NOT NULL,
    "up_whisker" double   NOT NULL,
    "low_whisker" double   NOT NULL,
    "log_gdp_per_cap" double   NOT NULL,
    "social_support" double   NOT NULL,
    "healty_life_exp" double   NOT NULL,
    "freedom" double   NOT NULL,
    "generosity" double   NOT NULL,
    "percept_corrupt" double   NOT NULL,
    "ladder_score_distopia" double   NOT NULL,
    "expby_log_gdp_per_cap" double   NOT NULL,
    "expby_social_support" double   NOT NULL,
    "expby_healty_life_exp" double   NOT NULL,
    "expby_freedom" double   NOT NULL,
    "expby_generosity" double   NOT NULL,
    "expby_percept_corrupt" double   NOT NULL,
    "distopia_plus_resid" double   NOT NULL,
    CONSTRAINT "pk_worldhappinessreport_2021" PRIMARY KEY (
        "country_name"
     )
);

CREATE TABLE "suicide_rate" (
    "country_name" varchar(255)   NOT NULL,
    "suicide_rate" double   NOT NULL,
    "iso_code" varchar(255)   NOT NULL
);

CREATE TABLE "screen_time" (
    "country_name_clean" varchar(255)   NOT NULL,
    "country_name_source" varchar(255)   NOT NULL,
    "screen_time_avg" double   NOT NULL
);

CREATE TABLE "median_age" (
    "country_name" varchar(255)   NOT NULL,
    "median_age" double   NOT NULL,
    "iso_code" varchar(255)   NOT NULL
);

CREATE TABLE "meat_consumption" (
    "country_name" varchar(255)   NOT NULL,
    "meat_consumption" double   NOT NULL,
    "iso_code" varchar(255)   NOT NULL
);

CREATE TABLE "land_area" (
    "country_name" varchar(255)   NOT NULL,
    "population_2020" double   NOT NULL,
    "land_area_skm" double   NOT NULL,
    "density_skm" double   NOT NULL
);

CREATE TABLE "covid_world_o_meter" (
    "country_name" varchar(255)   NOT NULL,
    "continent" varchar(255)   NOT NULL,
    "population" double   NOT NULL,
    "total_cases" double   NOT NULL,
    "new_cases" double   NOT NULL,
    "total_deaths" double   NOT NULL,
    "new_deaths" double   NOT NULL,
    "total_recovered" double   NOT NULL,
    "new_recovered" double   NOT NULL,
    "active_cases" double   NOT NULL,
    "serious_critical" double   NOT NULL,
    "cases_per_mil" double   NOT NULL,
    "deaths_per_mil" double   NOT NULL,
    "total_tests" double   NOT NULL,
    "tests_per_mil" double   NOT NULL,
    "who_region" varchar(255)   NOT NULL
);

CREATE TABLE "alcahol_consumption" (
    "country_name" varchar(255)   NOT NULL,
    "both_sexes" double   NOT NULL,
    "male" double   NOT NULL,
    "female" double   NOT NULL
);

ALTER TABLE "country_xref" ADD CONSTRAINT "fk_country_xref_country_name_clean" FOREIGN KEY("country_name_clean")
REFERENCES "countries" ("country_name_clean");

ALTER TABLE "worldhappinessreport_2021" ADD CONSTRAINT "fk_worldhappinessreport_2021_country_name" FOREIGN KEY("country_name")
REFERENCES "country_xref" ("country_name_original");

ALTER TABLE "suicide_rate" ADD CONSTRAINT "fk_suicide_rate_country_name" FOREIGN KEY("country_name")
REFERENCES "country_xref" ("country_name_original");

ALTER TABLE "screen_time" ADD CONSTRAINT "fk_screen_time_country_name_clean" FOREIGN KEY("country_name_clean")
REFERENCES "country_xref" ("country_name_original");

ALTER TABLE "median_age" ADD CONSTRAINT "fk_median_age_country_name" FOREIGN KEY("country_name")
REFERENCES "country_xref" ("country_name_original");

ALTER TABLE "meat_consumption" ADD CONSTRAINT "fk_meat_consumption_country_name" FOREIGN KEY("country_name")
REFERENCES "country_xref" ("country_name_original");

ALTER TABLE "land_area" ADD CONSTRAINT "fk_land_area_country_name" FOREIGN KEY("country_name")
REFERENCES "country_xref" ("country_name_original");

ALTER TABLE "covid_world_o_meter" ADD CONSTRAINT "fk_covid_world_o_meter_country_name" FOREIGN KEY("country_name")
REFERENCES "country_xref" ("country_name_original");

ALTER TABLE "alcahol_consumption" ADD CONSTRAINT "fk_alcahol_consumption_country_name" FOREIGN KEY("country_name")
REFERENCES "country_xref" ("country_name_original");

