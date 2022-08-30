#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align -c"

RANDOM_NUMBER=$(($RANDOM%1000+1))

echo Enter your username:
read INPUT_NAME

IF_INPUT_NAME_IN_DB=$($PSQL "SELECT username FROM users WHERE username='$INPUT_NAME'")
if [[ -z $IF_INPUT_NAME_IN_DB ]]
then
  echo "Welcome, $INPUT_NAME! It looks like this is your first time here."
  FLAG=1
else
  USERNAME=$($PSQL "SELECT username FROM users WHERE username='$INPUT_NAME'")
  GAMES_PLAYED=$($PSQL "SELECT COUNT(*) FROM games JOIN users USING(user_id) WHERE username='$INPUT_NAME'")
  BEST_GAME=$($PSQL "SELECT min(guesses) FROM games JOIN users USING(user_id) WHERE username='$INPUT_NAME'")
  echo "Welcome back, $USERNAME! You have played $GAMES_PLAYED games, and your best game took $BEST_GAME guesses."
  FLAG=0
fi

COUNTER=0
echo Guess the secret number between 1 and 1000:

GAME(){
  read INPUT_GUESS
  if [[ ! $INPUT_GUESS =~ ^[0-9]+$ ]]
  then
    echo That is not an integer, guess again:
    GAME
  else
    COUNTER=$((COUNTER + 1))
    if [[ $INPUT_GUESS -ne $RANDOM_NUMBER ]]
    then
      if [[ $INPUT_GUESS -lt $RANDOM_NUMBER ]]
      then
        echo "It's higher than that, guess again:"
        GAME
      else
        echo "It's lower than that, guess again:"
        GAME
      fi
    else
      echo "You guessed it in $COUNTER tries. The secret number was $RANDOM_NUMBER. Nice job!"
      if [[ $FLAG -ne 0 ]]
      then
        INSERT_USER=$($PSQL "INSERT INTO users(username) VALUES('$INPUT_NAME')")
        USERNAME=$($PSQL "SELECT username FROM users WHERE username='$INPUT_NAME'")
      fi
      INSERT_GAME=$($PSQL "INSERT INTO games(guesses,user_id) VALUES($COUNTER,(SELECT user_id FROM users WHERE username='$USERNAME'))")
    fi
  fi

}

GAME
