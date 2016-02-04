== README

## Registrerings-applikation

## Ruby version
* Ruby 2.1.5
* Rails 4.2.5

## För att köra appen
1. ```sh git clone https://github.com/ad222kr/1dv450-registration.git ``` 
2. ```sh bundle install --without production ``` för att installera gems
3. ```sh rake db:setup ``` för att skapa databasen och generara test-data
4. ```js rails s ```
5. Applikationen hittas nu på localhost:3000

## Test-data
| email | Lösenord |
|----:|:-------|
| admin@admin.com | adminpassword |
| testuser@example.com | testuserpassword |
| testuser2@example.com | testuser2password |
