# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

HTTP REQUEST :

- REGISTRATION :
   CREATE : POST => http://localhost:3000/users

- SESSIONS :
   CREATE : POST => http://localhost:3000/users/sign_in
   DESTROY : DELETE => http://localhost:3000/users/sign_out   

- MEMBER REQUEST : 
   INDEX : GET => http://localhost:3000/users_list
   SHOW_USER: GET => http://localhost:3000/user_detail/[user_id]
   SHOW_ME: GET => http://localhost:3000/me
   GESTED_MEALS: GET => http://localhost:3000/guested_meals
   UPDATE_ME: PUT => http://localhost:3000/update_me
   

  get '/guested_meals', to: 'members#guested_meals'

- MEAL REQUEST :
   INDEX : GET => http://localhost:3000/meals
   SHOW: GET => http://localhost:3000/meals/[meal_id]
   CREATE: POST => http://localhost:3000/meals
   UPDATE: PUT => http://localhost:3000/meals/[meal_id]
   DELETE => http://localhost:3000/meals/[meal_id]

- ATTENDANCE REQUEST :
   INDEX : GET => http://localhost:3000/attendances
   SHOW: GET => http://localhost:3000/attendances/[attendance_id]
   CREATE: POST => http://localhost:3000/attendances
   UPDATE: PUT => http://localhost:3000/attendances/[attendance_id]
   DELETE => http://localhost:3000/attendances/[attendance_id]