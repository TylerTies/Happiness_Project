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




CREATE OR REPLACE VIEW public.combined_data
 AS
 SELECT c.country_name_clean AS country_name,
    c.region,
    max(w.ladder_score) AS ladder_score,
    max(w.stand_err) AS stand_err,
    max(w.up_whisker) AS up_whisker,
    max(w.low_whisker) AS low_whisker,
    max(w.log_gdp_per_cap) AS log_gdp_per_cap,
    max(w.social_support) AS social_support,
    max(w.healty_life_exp) AS healty_life_exp,
    max(w.freedom) AS freedom,
    max(w.generosity) AS generosity,
    max(w.percept_corrupt) AS percept_corrupt,
    max(w.ladder_score_distopia) AS ladder_score_distopia,
    max(w.expby_log_gdp_per_cap) AS expby_log_gdp_per_cap,
    max(w.expby_social_support) AS expby_social_support,
    max(w.expby_healty_life_exp) AS expby_healty_life_exp,
    max(w.expby_freedom) AS expby_freedom,
    max(w.expby_generosity) AS expby_generosity,
    max(w.expby_percept_corrupt) AS expby_percept_corrupt,
    max(w.distopia_plus_resid) AS distopia_plus_resid,
    max(a.both_sexes) AS ac_both_sexes,
    max(a.male) AS ac_male,
    max(a.female) AS ac_female,
    max(cwom.population) AS population_2021,
    max(cwom.total_cases) AS covid_total_cases,
    max(cwom.new_cases) AS covid_new_cases,
    max(cwom.total_deaths) AS covid_total_deaths,
    max(cwom.new_deaths) AS covid_new_deaths,
    max(cwom.total_recovered) AS covid_total_recovered,
    max(cwom.new_recovered) AS covid_new_recovered,
    max(cwom.active_cases) AS covid_active_cases,
    max(cwom.serious_critical) AS covid_serious_critical,
    max(cwom.cases_per_mil) AS covid_cases_per_mil,
    max(cwom.deaths_per_mil) AS covid_deaths_per_mil,
    max(cwom.total_tests) AS covid_total_tests,
    max(cwom.tests_per_mil) AS covid_tests_per_mil,
    max(cwom.who_region::text) AS covid_who_region,
    max(la.population_2020) AS population_2020,
    max(la.land_area_skm) AS land_area_skm,
    max(la.density_skm) AS density_skm,
    max(mc.meat_consumption) AS meat_consumption,
    max(ma.median_age) AS median_age,
    max(st.screen_time_avg) AS screen_time_avg,
    max(sr.suicide_rate) AS suicide_rate,
    max(whh.ladder_2010) AS ladder_2010,
    max(whh.ladder_2011) AS ladder_2011,
    max(whh.ladder_2012) AS ladder_2012,
    max(whh.ladder_2013) AS ladder_2013,
    max(whh.ladder_2014) AS ladder_2014,
    max(whh.ladder_2015) AS ladder_2015,
    max(whh.ladder_2016) AS ladder_2016,
    max(whh.ladder_2017) AS ladder_2017,
    max(whh.ladder_2018) AS ladder_2018,
    max(whh.ladder_2019) AS ladder_2019,
    max(whh.ladder_2020) AS ladder_2020
   FROM countries c
     JOIN country_xref cx ON c.country_name_clean::text = cx.country_name_clean::text
     LEFT JOIN worldhappinessreport_2021 w ON cx.country_name_original::text = w.country_name::text
     LEFT JOIN alcahol_consumption a ON cx.country_name_original::text = a.country_name::text
     LEFT JOIN covid_world_o_meter cwom ON cx.country_name_original::text = cwom.country_name::text
     LEFT JOIN land_area la ON cx.country_name_original::text = la.country_name::text
     LEFT JOIN meat_consumption mc ON cx.country_name_original::text = mc.country_name::text
     LEFT JOIN median_age ma ON cx.country_name_original::text = ma.country_name::text
     LEFT JOIN screen_time st ON cx.country_name_original::text = st.country_name_clean::text
     LEFT JOIN suicide_rate sr ON cx.country_name_original::text = sr.country_name::text
     LEFT JOIN ( SELECT wh.country_name,
            max(
                CASE
                    WHEN wh.year_num = 2010 THEN wh.life_ladder
                    ELSE NULL::double precision
                END) AS ladder_2010,
            max(
                CASE
                    WHEN wh.year_num = 2011 THEN wh.life_ladder
                    ELSE NULL::double precision
                END) AS ladder_2011,
            max(
                CASE
                    WHEN wh.year_num = 2012 THEN wh.life_ladder
                    ELSE NULL::double precision
                END) AS ladder_2012,
            max(
                CASE
                    WHEN wh.year_num = 2013 THEN wh.life_ladder
                    ELSE NULL::double precision
                END) AS ladder_2013,
            max(
                CASE
                    WHEN wh.year_num = 2014 THEN wh.life_ladder
                    ELSE NULL::double precision
                END) AS ladder_2014,
            max(
                CASE
                    WHEN wh.year_num = 2015 THEN wh.life_ladder
                    ELSE NULL::double precision
                END) AS ladder_2015,
            max(
                CASE
                    WHEN wh.year_num = 2016 THEN wh.life_ladder
                    ELSE NULL::double precision
                END) AS ladder_2016,
            max(
                CASE
                    WHEN wh.year_num = 2017 THEN wh.life_ladder
                    ELSE NULL::double precision
                END) AS ladder_2017,
            max(
                CASE
                    WHEN wh.year_num = 2018 THEN wh.life_ladder
                    ELSE NULL::double precision
                END) AS ladder_2018,
            max(
                CASE
                    WHEN wh.year_num = 2019 THEN wh.life_ladder
                    ELSE NULL::double precision
                END) AS ladder_2019,
            max(
                CASE
                    WHEN wh.year_num = 2020 THEN wh.life_ladder
                    ELSE NULL::double precision
                END) AS ladder_2020
           FROM worldhappinessreport_history wh
          GROUP BY wh.country_name) whh ON whh.country_name::text = a.country_name::text
  GROUP BY c.country_name_clean, c.region
 HAVING max(w.ladder_score) IS NOT NULL
  ORDER BY c.country_name_clean;


CREATE OR REPLACE VIEW public.country_representaion
 AS
 SELECT a.country_name,
    max(
        CASE
            WHEN a.table_code = 'ac'::text THEN 'x'::text
            ELSE NULL::text
        END) AS ac,
    max(
        CASE
            WHEN a.table_code = 'cwom'::text THEN 'x'::text
            ELSE NULL::text
        END) AS cwom,
    max(
        CASE
            WHEN a.table_code = 'la'::text THEN 'x'::text
            ELSE NULL::text
        END) AS la,
    max(
        CASE
            WHEN a.table_code = 'mc'::text THEN 'x'::text
            ELSE NULL::text
        END) AS mc,
    max(
        CASE
            WHEN a.table_code = 'ma'::text THEN 'x'::text
            ELSE NULL::text
        END) AS ma,
    max(
        CASE
            WHEN a.table_code = 'st'::text THEN 'x'::text
            ELSE NULL::text
        END) AS st,
    max(
        CASE
            WHEN a.table_code = 'sr'::text THEN 'x'::text
            ELSE NULL::text
        END) AS sr,
    max(
        CASE
            WHEN a.table_code = 'wh'::text THEN 'x'::text
            ELSE NULL::text
        END) AS wh,
    max(
        CASE
            WHEN a.table_code = 'whh'::text THEN 'x'::text
            ELSE NULL::text
        END) AS whh
   FROM ( SELECT worldhappinessreport_history.country_name,
            'whh'::text AS table_code,
            'x'::text AS col_val
           FROM worldhappinessreport_history
          GROUP BY worldhappinessreport_history.country_name
        UNION
         SELECT alcahol_consumption.country_name,
            'ac'::text AS table_code,
            'x'::text AS col_val
           FROM alcahol_consumption
          GROUP BY alcahol_consumption.country_name
        UNION
         SELECT covid_world_o_meter.country_name,
            'cwom'::text AS table_code,
            'x'::text AS col_val
           FROM covid_world_o_meter
          GROUP BY covid_world_o_meter.country_name
        UNION
         SELECT land_area.country_name,
            'la'::text AS table_code,
            'x'::text AS col_val
           FROM land_area
          GROUP BY land_area.country_name
        UNION
         SELECT meat_consumption.country_name,
            'mc'::text AS table_code,
            'x'::text AS col_val
           FROM meat_consumption
          GROUP BY meat_consumption.country_name
        UNION
         SELECT median_age.country_name,
            'ma'::text AS table_code,
            'x'::text AS col_val
           FROM median_age
          GROUP BY median_age.country_name
        UNION
         SELECT screen_time.country_name_clean AS country_name,
            'st'::text AS table_code,
            'x'::text AS col_val
           FROM screen_time
          GROUP BY screen_time.country_name_clean
        UNION
         SELECT suicide_rate.country_name,
            'sr'::text AS table_code,
            'x'::text AS col_val
           FROM suicide_rate
          GROUP BY suicide_rate.country_name
        UNION
         SELECT worldhappinessreport_2021.country_name,
            'wh'::text AS table_code,
            'x'::text AS col_val
           FROM worldhappinessreport_2021
          GROUP BY worldhappinessreport_2021.country_name) a
  GROUP BY a.country_name;
