#1/bin/bash

PSQL="psql -X --username=freecodecamp --dbname=periodic_table --tuples-only -c"

GATHER_INFO(){
  ELEMENT_NAME=$($PSQL "SELECT name FROM elements WHERE atomic_number=$ATOMIC_NUMBER")
    
  ELEMENT_SYMBOL=$($PSQL "SELECT symbol FROM elements WHERE atomic_number=$ATOMIC_NUMBER")

  #ELEMENT_TYPE=$($PSQL "SELECT type FROM properties WHERE atomic_number=$ATOMIC_NUMBER")
  ELEMENT_TYPE=$($PSQL "SELECT type FROM properties INNER JOIN types USING(type_id) WHERE atomic_number=$ATOMIC_NUMBER")

  ATOMIC_MASS=$($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number=$ATOMIC_NUMBER")

  MELTING_POINT=$($PSQL "SELECT melting_point_celsius FROM properties WHERE atomic_number=$ATOMIC_NUMBER")

  BOILING_POINT=$($PSQL "SELECT boiling_point_celsius FROM properties WHERE atomic_number=$ATOMIC_NUMBER")

  ELEMENT_SYMBOL_F=$(echo $ELEMENT_SYMBOL | sed 's/ |/"/')
  #echo $ELEMENT_NAME $ELEMENT_SYMBOL $ELEMENT_TYPE $ATOMIC_MASS $BOILING_POINT
  echo The element with atomic number $ATOMIC_NUMBER is $ELEMENT_NAME \($ELEMENT_SYMBOL_F\). It\'s a $ELEMENT_TYPE, with a mass of $ATOMIC_MASS amu. $ELEMENT_NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius.
}

if [[ -z $1 ]]
then
  echo Please provide an element as an argument.
else
  if [[ $1 =~ ^[0-9]+$ ]]
  then
    # tell info by atomic_number
    ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE atomic_number=$1")

    #if not found by atomic_number
    if [[ -z $ATOMIC_NUMBER ]]
    then
      echo I could not find that element in the database.
    else
      GATHER_INFO
    fi
  else
    # try find atomic_number by symbol
    ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE symbol='$1'")

    # if not found by symbol
    if [[ -z $ATOMIC_NUMBER ]]
    then
      # try finding by name
      ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE name='$1'")
      # not found in base
      if [[ -z $ATOMIC_NUMBER ]]
      then
        echo I could not find that element in the database.
      else
        GATHER_INFO
      fi
    else
      GATHER_INFO
    fi
  fi
fi

