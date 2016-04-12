## För att använda POSTMAN
[Postman-collection](1dv450-API.json.postman_collection)  
Du behöver sätta några miljövariabler  
1. Authentication: Bearer din_jwt_token_du_får_från_api  
2. Api-Key: 52c1aefb58a0afe043f6121e94e2c3cd  
3. Accept: application/vnd.registration-1dv450.v1  
4. Content-Type: application/json  

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

**Hämta alla pubar som startar med angiven sträng - GET** - https://registration-1dv450.herokuapp.com/api/pubs?starts_with=search_query  
Exepel:  
https://registration-1dv450.herokuapp.com/api/pubs?starts_with=Sve

**Hämta alla pubar nära en adress - GET** - https://registration-1dv450.herokuapp.com/api/pubs?near_address=your_adress  
Exempel:  
https://registration-1dv450.herokuapp.com/api/pubs?near_address=Skräddaretorpsvägen

**Hämta alla pubar nära latitud och longitud - GET** - https://registration-1dv450.herokuapp.com/api/pubs?lat=XX&lng=XX  
Exempel:  
https://registration-1dv450.herokuapp.com/api/pubs?lat=56&lng=16

**Hämta alla pubar kopplad till en specifik tag - GET** - https://registration-1dv450.herokuapp.com/api/tags/:id/pubs  
Exempel:  
https://registration-1dv450.herokuapp.com/api/tags/1/pubs

**Hämta alla pubar kopplad till en specifik creator - GET** - https://registration-1dv450.herokuapp.com/api/creators/:id/pubs  
Exempel:  
https://registration-1dv450.herokuapp.com/api/creators/1/pubs

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
**Hämta alla positioner - GET** - https://registration-1dv450.herokuapp.com/api/positions

**Hämta specifik position - GET** - https://registration-1dv450.herokuapp.com/api/positions/:id  
Exempel:  
https://registration-1dv450.herokuapp.com/api/positions/1

### Tags
**Hämta alla tags - GET** - https://registration-1dv450.herokuapp.com/api/tags/

**Hämta specifik tag - GET** - https://registration-1dv450.herokuapp.com/api/tags/:id  
Exempel:  
https://registration-1dv450.herokuapp.com/api/tags/1/

### Creators
**Hämta alla creators - GET** - https://registration-1dv450.herokuapp.com/api/creators

**Hämta specifik creator - GET** - https://registration-1dv450.herokuapp.com/api/creators/:id  
Exempel:  
https://registration-1dv450.herokuapp.com/api/creators/1




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
