## Hur man använder API:t
1. Registrera dig som användare i registrerings-applikationen och generera en
API-nyckel för din applikation
2. Skicka en förfrågan till https://registration-1dv450.herokuapp.com/knock/auth_token med request-body som ser ut såhär
```json
{
  "auth": {
    "email": "testcreator@example.com",
    "password": "testcreatorpassword"
    }
}
```
för att få en jwt-token.  
Du får då en response som ser ut såhär:
```json
{
  "jwt": "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJleHAiOjE0NjA1NzM1MDEsImF1ZCI6ZmFsc2UsInN1YiI6MX0.IXR4i8kr1oDm2k6RLtwf6VYWacWQILS8gI2dlE0OuSA"
}
```
3. För att läsa från API:t behöver man skicka med Api-Key som header
```
Api-Key: your_api_key
```
För att kunna skapa och uppdatera resurser behövs även en JWT-token skickas med
```
Authorization: Bearer your_jwt_token
```  

## API-dokumentation
### Pubar
**Hämta en specifik pub - GET** - https://registration-1dv450.herokuapp.com/api/pubs/:id  
Exempel:  
 https://registration-1dv450.herokuapp.com/api/pubs/1

**Hämta alla pubar - GET** - https://registration-1dv450.herokuapp.com/api/pubs  
Exempel (med offset och limit-params):  
https://registration-1dv450.herokuapp.com/api/pubs?offset=1&limit=3  

**Hämta alla pubar nära en adress - GET** - https://registration-1dv450.herokuapp.com/api/pubs?near_address=your_adress  
Exempel:  
https://registration-1dv450.herokuapp.com/api/pubs?near_address=Skräddaretorpsvägen

**Hämta alla pubar nära latitud och longitud - GET** - https://registration-1dv450.herokuapp.com/api/pubs?lat=XX&lng=XX  
Exempel:  
https://registration-1dv450.herokuapp.com/api/pubs?lat=56&lng=16

**Skapa en pub - POST** -
https://registration-1dv450.herokuapp.com/api/pubs  
Exempel:
```json
{
    "pub": {
        "name": "Production test pub",
        "phone_number": "0789426349",  
        "description": "En skön pub, jag testar i produktion yolo",
        "position": {
            "address": "Storgatan 17, Sandviken"
        },
        "tags": [
            { "name": "Skönt!" },
            { "name": "Fint!" }
        ]
    }
}
```
Required params: name, phone_number, description, position


**Uppdatera en pub - PUT** - https://registration-1dv450.herokuapp.com/api/pubs/:id  
Exempel:  
https://registration-1dv450.herokuapp.com/api/pubs/1  
```json
{
  "pub": {
      "name": "Puben som är uppdaterad hihi!"
  }
}
```



**Ta bort en pub - DELTE** - https://registration-1dv450.herokuapp.com/api/pubs/:id  
Exempel:  
https://registration-1dv450.herokuapp.com/api/pubs/1

### Positions

### Tags

### Creators




## Registrerings-applikation

## Ruby version
* Ruby 2.1.5
* Rails 4.2.5

## För att köra appen
```bash
git clone https://github.com/ad222kr/1dv450-registration.git
bundle install --without production
rake db:setup
rails s
```
Applikationen hittas nu på localhost:3000

## Test-data
| email | Lösenord |
|----:|:-------|
| admin@admin.com | adminpassword |
| testuser@example.com | testuserpassword |
| testuser2@example.com | testuser2password |
