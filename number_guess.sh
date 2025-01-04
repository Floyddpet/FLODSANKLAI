#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align -c"
INPUT_NAME() {
  echo "Enter your username:"
  read NAME
  n=${#NAME}

  #When you run your script, you should prompt the user for a username with Enter your username:, and take a username as input.Your database should allow usernames that are 22 characters
  if [[ ! $n -le 22 ]] || [[ ! $n -gt 0 ]]
  then
    INPUT_NAME
  else
    USER_NAME=$(echo $($PSQL "SELECT username FROM users WHERE username='$NAME';") | sed 's/ //g')
    if [[ ! -z $USER_NAME ]]
    then
      #If that username has been used before, it should print Welcome back, <username>! You have played <games_played> games, and your best game took <best_game> guesses., 
      #with <username> being a users name from the database,
      #<games_played> being the total number of games that user has played, 
      #and <best_game> being the fewest number of guesses it took that user to win the game
      USER_ID=$(echo $($PSQL "SELECT user_id FROM users WHERE username='$USER_NAME';") | sed 's/ //g')
      USER_NAME=$(echo $($PSQL "SELECT username FROM users WHERE user_id='$USER_ID';") | sed 's/ //g')
      GAMES_PLAYED=$(echo $($PSQL "SELECT frequent_games FROM users WHERE user_id=$USER_ID;") | sed 's/ //g')
      BEST_GAME=$(echo $($PSQL "SELECT MIN(best_guess) FROM users LEFT JOIN games USING(user_id) WHERE user_id=$USER_ID;") | sed 's/ //g')
      echo "Welcome back, $USER_NAME! You have played $GAMES_PLAYED games, and your best game took $BEST_GAME guesses."
    else
      #If the username has not been used before, you should print Welcome, <username>! It looks like this is your first time here.
      USER_NAME=$NAME
      echo -e "\nWelcome, $USER_NAME! It looks like this is your first time here."
    fi

    #Your script should randomly generate a number that users have to guess
    #The next line printed should be Guess the secret number between 1 and 1000: and input from the user should be read
    CORRECT_ANSWER=$(( $RANDOM % 1000 + 1 ))
    TOTAL_GUESSES=0
    INPUT_GUESS $USER_NAME $CORRECT_ANSWER $TOTAL_GUESSES
  fi
}

INPUT_GUESS() {
  USER_NAME=$1
  CORRECT_ANSWER=$2
  TOTAL_GUESSES=$3
  NUMBER_GUESSED=$4

  if [[ -z $NUMBER_GUESSED ]]
  then
    echo "Guess the secret number between 1 and 1000:"
    read NUMBER_GUESSED
  else
    #If anything other than an integer is input as a guess, it should print That is not an integer, guess again:
    echo "That is not an integer, guess again:"
    read NUMBER_GUESSED
  fi

  TOTAL_GUESSES=$(( $TOTAL_GUESSES + 1 ))
  if [[ ! $NUMBER_GUESSED =~ ^[0-9]+$ ]]
  then
    INPUT_GUESS $USER_NAME $CORRECT_ANSWER $TOTAL_GUESSES $NUMBER_GUESSED
  else
    CHECK_ANSWER $USER_NAME $CORRECT_ANSWER $TOTAL_GUESSES $NUMBER_GUESSED
  fi
}

CHECK_ANSWER() {
  USER_NAME=$1 
  CORRECT_ANSWER=$2 
  TOTAL_GUESSES=$3
  NUMBER_GUESSED=$4
  
  #Until they guess the secret number, 
  #it should print 
  #It's lower than that, guess again: if the previous input was higher than the secret number, and
  #It's higher than that, guess again: if the previous input was lower than the secret number. 
  #Asking for input each time until they input the secret number.
  if [[ $NUMBER_GUESSED -lt $CORRECT_ANSWER ]]
  then
    echo "It's lower than that, guess again:"
    read NUMBER_GUESSED
  elif [[ $NUMBER_GUESSED -gt $CORRECT_ANSWER ]]
  then
    echo "It's higher than that, guess again:"
    read NUMBER_GUESSED
  else
    TOTAL_GUESSES=$TOTAL_GUESSES
  fi

  TOTAL_GUESSES=$(( $TOTAL_GUESSES + 1 ))
  if [[ ! $NUMBER_GUESSED =~ ^[0-9]+$ ]]
  then
    INPUT_GUESS $USER_NAME $CORRECT_ANSWER $TOTAL_GUESSES $NUMBER_GUESSED
  elif [[ $NUMBER_GUESSED -lt $CORRECT_ANSWER ]] || [[ $NUMBER_GUESSED -gt $CORRECT_ANSWER ]]
  then
    CHECK_ANSWER $USER_NAME $CORRECT_ANSWER $TOTAL_GUESSES $NUMBER_GUESSED
  elif [[ $NUMBER_GUESSED -eq $CORRECT_ANSWER ]]
  then
    #When the secret number is guessed, your script should print You guessed it in <number_of_guesses> tries. The secret number was <secret_number>. 
    #Nice job! and finish running
    SAVE_USER $USER_NAME $TOTAL_GUESSES
    NUMBER_OF_GUESSES=$TOTAL_GUESSES
    SECRET_NUMBER=$CORRECT_ANSWER
    echo "You guessed it in $NUMBER_OF_GUESSES tries. The secret number was $SECRET_NUMBER. Nice job!"
  fi

}

SAVE_USER() {
  USER_NAME=$1 
  TOTAL_GUESSES=$2

  CHECK_NAME=$($PSQL "SELECT username FROM users WHERE username='$USER_NAME';")
  if [[ -z $CHECK_NAME ]]
  then
    INSERT_NEW_USER=$($PSQL "INSERT INTO users(username, frequent_games) VALUES('$USER_NAME',1);")
  else
    GET_GAME_NAME=$(( $($PSQL "SELECT frequent_games FROM users WHERE username='$USER_NAME';") + 1))
    UPDATE_EXISTING_USER=$($PSQL "UPDATE users SET frequent_games=$GET_GAME_NAME WHERE username='$USER_NAME';")
  fi
  SAVE_GAME $USER_NAME $TOTAL_GUESSES
}


SAVE_GAME() {
  USER_NAME=$1 
  NUMBER_OF_GUESSES=$2

  USER_ID=$($PSQL "SELECT user_id FROM users WHERE username='$USER_NAME';")
  INSERT_GAME=$($PSQL "INSERT INTO games(user_id, best_guess) VALUES($USER_ID, $NUMBER_OF_GUESSES);")
  USER_NAME=$($PSQL "SELECT username FROM users WHERE user_id=$USER_ID;")
}


INPUT_NAME
