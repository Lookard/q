#!/bin/bash

PSQL="psql -X --username=freecodecamp --dbname=salon --tuples-only -c"

echo -e "\n~~~~~ SALOOOOON ~~~~~\n"

#echo $($PSQL "TRUNCATE appointments,customers")

MAIN_PAGE(){
  # get available services
  AVAILABLE_SERVICES=$($PSQL "SELECT * FROM services")

  # show available services
  echo -e "\nHere are the services we have available:\n"
  echo "$AVAILABLE_SERVICES" | while read SERVICE_ID BAR NAME
  do
    echo "$SERVICE_ID) $NAME"
  done

  # ask a service to choose
  echo -e "\nWhich one would you like to book for?"

  # read input for service id
  read SERVICE_ID_SELECTED

  # check if this service exists
  TRY_FIND_SERVICE=$($PSQL "
  SELECT service_id FROM services
  WHERE service_id = $SERVICE_ID_SELECTED
  ")
  # echo $TRY_FIND_SERVICE

  # if it is not exist
  if [[ -z $TRY_FIND_SERVICE ]]
  then
    echo No such service
    MAIN_PAGE 
  else
    # service exists
    # ask for user phone
    echo -e "\nWhat is your phone number?"
    read CUSTOMER_PHONE

    # try finding phone in database
    TRY_FIND_PHONE=$($PSQL "
    SELECT phone FROM customers
    WHERE phone = '$CUSTOMER_PHONE' 
    ")

    # if not found
    if [[ -z $TRY_FIND_PHONE ]]
    then
      # it's a new customer. Ask for a name
      echo -e "\nSeems like you are a new client. What is your name?"
      read CUSTOMER_NAME

      APPEND_NEW_CUSTOMER=$($PSQL "
      INSERT INTO customers(name,phone)
      VALUES('$CUSTOMER_NAME','$CUSTOMER_PHONE')
      ")
    fi
    # find customer name by phone
    CUSTOMER_NAME=$($PSQL "
    SELECT name FROM customers
    WHERE phone = '$CUSTOMER_PHONE' 
    ")
    CUSTOMER_NAME_F=$(echo $CUSTOMER_NAME | sed 's/^ //')
    echo -e "\nWhat time would be ok for you, $CUSTOMER_NAME_F?"

    #ask for appointment time
    read SERVICE_TIME

    #add appointment
    APPEND_NEW_APPOINTMENT=$($PSQL "
    INSERT INTO appointments(customer_id,service_id,time)
    VALUES
    (
      (SELECT customer_id FROM customers WHERE name='$CUSTOMER_NAME'),
      ('$SERVICE_ID_SELECTED'),
      ('$SERVICE_TIME')
    )
    ")
    SERVICE_NAME=$($PSQL "
    SELECT name FROM services
    WHERE service_id=$SERVICE_ID_SELECTED
    ")
    SERVICE_NAME_F=$(echo $SERVICE_NAME | sed 's/^ //')
    echo "I have put you down for a $SERVICE_NAME_F at $SERVICE_TIME, $CUSTOMER_NAME_F."
  fi
}

MAIN_PAGE

