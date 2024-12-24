#!/bin/bash
PSQL="psql -X --username=freecodecamp --dbname=periodic_table --tuples-only -c"

MAIN_MENU() {
  if [[ -z $1 ]]
  then
    echo "Please provide an element as an argument."
  else
    PRINT_ELEMENT $1
  fi
}

PRINT_ELEMENT() {
  INPUT=$1
  if [[ ! $INPUT =~ ^[0-9]+$ ]]
  then
    ATOMIC_NUMBER=$(echo $($PSQL "SELECT atomic_number FROM elements WHERE symbol='$INPUT' OR name='$INPUT';") | sed 's/ //g')
  else
    ATOMIC_NUMBER=$(echo $($PSQL "SELECT atomic_number FROM elements WHERE atomic_number=$INPUT;") | sed 's/ //g')
  fi
  
  if [[ -z $ATOMIC_NUMBER ]]
  then
    echo "I could not find that element in the database."
  else
    TYPE_ID=$(echo $($PSQL "SELECT type_id FROM properties WHERE atomic_number=$ATOMIC_NUMBER;") | sed 's/ //g')
    NAME=$(echo $($PSQL "SELECT name FROM elements WHERE atomic_number=$ATOMIC_NUMBER;") | sed 's/ //g')
    SYMBOL=$(echo $($PSQL "SELECT symbol FROM elements WHERE atomic_number=$ATOMIC_NUMBER;") | sed 's/ //g')
    ATOMIC_MASS=$(echo $($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number=$ATOMIC_NUMBER;") | sed 's/ //g')
    MELTING_POINT=$(echo $($PSQL "SELECT melting_point_celsius FROM properties WHERE atomic_number=$ATOMIC_NUMBER;") | sed 's/ //g')
    BOILING_POINT=$(echo $($PSQL "SELECT boiling_point_celsius FROM properties WHERE atomic_number=$ATOMIC_NUMBER;") | sed 's/ //g')
    TYPE=$(echo $($PSQL "SELECT type FROM elements LEFT JOIN properties USING(atomic_number) LEFT JOIN types USING(type_id) WHERE atomic_number=$ATOMIC_NUMBER;") | sed 's/ //g')

    echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
  fi
}
FIX_DB() {
 RENAME_PROPERTIES_WEIGHT=$($PSQL "ALTER TABLE properties RENAME COLUMN weight TO atomic_mass;")
  echo "RENAME_PROPERTIES_WEIGHT                    : $RENAME_PROPERTIES_WEIGHT"

 
  RENAME_MELTING_POINT=$($PSQL"ALTER TABLE properties RENAME COLUMN melting_point TO melting_point_celsius;")
  RENAME_BOILING_POINT=$($PSQL"ALTER TABLE properties RENAME COLUMN boiling_point TO boiling_point_celsius;")
  echo "RENAME_MELTING_POINT             : $RENAME_MELTING_POINT"
  echo "RENAME_BOILING_POINT             : $RENAME_BOILING_POINT"

 
  ALTER_MELTING_POINT=$($PSQL"ALTER TABLE properties ALTER COLUMN melting_point_celsius SET NOT NULL;")
  ALTER_BOILING_POINT=$($PSQL "ALTER TABLE properties ALTER COLUMN boiling_point_celsius SET NOT NULL;")
  echo "ALTER_MELTING_POINT     : $ALTER_MELTING_POINT"
  echo "ALTER_BOILING_POINT     : $ALTER_BOILING_POINT"


  ALTER_SYMBOL_UNIQUE=$($PSQL "ALTER TABLE elements ADD UNIQUE(symbol);")
  ALTER_NAME_UNIQUE=$($PSQL "ALTER TABLE elements ADD UNIQUE(name);")
  echo "ALTER_SYMBOL_UNIQUE                : $ALTER_SYMBOL_UNIQUE"
  echo "ALTER_NAME_UNIQUE                  : $ALTER_NAME_UNIQUE"

  ALTER_SYMBOL_NOT_NULL=$($PSQL "ALTER TABLE elements ALTER COLUMN symbol SET NOT NULL;")
  ALTER_SYMBOL_NOT_NULL=$($PSQL "ALTER TABLE elements ALTER COLUMN name SET NOT NULL;")
  echo "ALTER_SYMBOL_NOT_NULL              : $ALTER_SYMBOL_NOT_NULL"
  echo "ALTER_SYMBOL_NOT_NULL              : $ALTER_SYMBOL_NOT_NULL"

  
  ALTER_ATOMIC_NUMBER_FOREIGN_KEY=$($PSQL "ALTER TABLE properties ADD FOREIGN KEY (atomic_number) REFERENCES elements(atomic_number);")
  echo "ALTER_ATOMIC_NUMBER_FOREIGN_KEY  : $ALTER_ATOMIC_NUMBER_FOREIGN_KEY"

 
  CREATE_TBL_TYPES=$($PSQL "CREATE TABLE types();")
  echo "CREATE_TBL_TYPES                            : $CREATE_TBL_TYPES"

 
  ADD_COLUMN_TYPE_ID=$($PSQL "ALTER TABLE types ADD COLUMN type_id SERIAL PRIMARY KEY;")
  echo "ADD_COLUMN_TYPE_ID                    : $ADD_COLUMN_TYPE_ID"


  ADD_COLUMN_TYPES_TYPE=$($PSQL "ALTER TABLE types ADD COLUMN type VARCHAR(20) NOT NULL;")
  echo "ADD_COLUMN_TYPES_TYPE                       : $ADD_COLUMN_TYPES_TYPE"

  
  INSERT_COLUMN_TYPE=$($PSQL "INSERT INTO types(type) SELECT DISTINCT(type) FROM properties;")
  echo "INSERT_COLUMN_TYPE                    : $INSERT_COLUMN_TYPE"


UPDATE_ELEMENTS_SYMB=$($PSQL "UPDATE elements SET symbol=INITCAP(symbol);")
echo "UPDATE_ELEMENTS_SYMB         : $UPDATE_ELEMENTS_SYMB"


ADD_COLUMN_TYPE_ID=$($PSQL "ALTER TABLE PROPERTIES ADD COLUMN type_id INT;")
ADD_FKEY_TYPE_ID=$($PSQL "ALTER TABLE properties ADD FOREIGN KEY(type_id) REFERENCES types(type_id);")
 echo "ADD_COLUMN_TYPE_ID               : $ADD_COLUMN_TYPE_ID"
  echo "ADD_FKEY_TYPE_ID          : $ADD_FKEY_TYPE_ID"

UPDATE_TYPE_ID=$($PSQL "UPDATE properties SET type_id = (SELECT type_id FROM types WHERE properties.type = types.type);")
ALTER_COLUMN_TYPE_ID=$($PSQL "ALTER TABLE properties ALTER COLUMN type_id SET NOT NULL;")
echo "UPDATE_TYPE_ID                   : $UPDATE_TYPE_ID"
echo "ALTER_COLUMN_TYPE_ID    : $ALTER_COLUMN_TYPE_ID"



INSERT_ELEMENT_FLUORINE=$($PSQL "INSERT INTO elements(atomic_number,symbol,name) VALUES(9,'F','Fluorine');")
INSERT_PROPERTIES_FLUORINE=$($PSQL   "INSERT INTO properties(atomic_mass, melting_point_celsius, boiling_point_celsius, atomic_number, type_id, type) VALUES(18.998,-220,-188.1,9,3,'nonmetal');")
echo "INSERT_ELEMENT_FLUORINE                            : $INSERT_ELEMENT_FLUORINE"
  echo "INSERT_PROPERTIES_FLUORINE                         : $INSERT_PROPERTIES_FLUORINE"

INSERT_ELEMENT_NEON=$($PSQL "INSERT INTO elements(atomic_number, symbol, name) VALUES(10,'Ne','Neon');")
INSERT_PROPERTIES_NEON=$($PSQL "INSERT INTO properties(atomic_mass, melting_point_celsius, boiling_point_celsius, atomic_number, type_id, type) VALUES(20.18,-248.6,-246.1,10,3,'nonmetal');")
echo "INSERT_ELEMENT_NEON                            : $INSERT_ELEMENT_NEON"
  echo "INSERT_PROPERTIES_NEON                         : $INSERT_PROPERTIES_NEON"

 
  ALTER_ATOMIC_MASS_TYPE=$($PSQL "ALTER TABLE PROPERTIES ALTER COLUMN atomic_mass TYPE VARCHAR(9);")
  UPDATE_ATOMIC_MASS=$($PSQL"UPDATE properties SET atomic_mass=CAST(atomic_mass AS FLOAT);")
  echo "ALTER_ATOMIC_MASS_TYPE        : $ALTER_ATOMIC_MASS_TYPE"
  echo "UPDATE_ATOMIC_MASS         : $UPDATE_ATOMIC_MASS"


  
  DELETE_PROP_1000=$($PSQL "DELETE FROM properties WHERE atomic_number=1000;")
  DELETE_ELEM_1000=$($PSQL "DELETE FROM elements WHERE atomic_number=1000;")
  echo "DELETE_PROP_1000                      : $DELETE_PROP_1000"
  echo "DELETE_ELEM_1000                        : $DELETE_ELEM_1000"

 
  DELETE_COLUMN_TYPE=$($PSQL "ALTER TABLE properties DROP COLUMN type;")
  echo "DELETE_COLUMN_TYPE               : $DELETE_COLUMN_TYPE"

}

START_SCRIPT() {
  CHECK=$($PSQL "SELECT COUNT(*) FROM elements WHERE atomic_number=1000;")
  if [[ $CHECK -gt 0 ]]
  then
    FIX_DB
    clear
  fi
  MAIN_MENU $1
}

START_SCRIPT $1