Feature: Petstore

  Scenario: Añadir una mascota a la tienda
    Given url "https://petstore.swagger.io/v2"
    And path "/pet"
    And request
"""
{
  "id": 1,
  "category": {
    "id": 1,
    "name": "Perros"
  },
  "name": "Zeus",
  "photoUrls": [
    "string"
  ],
  "tags": [
    {
      "id": 1,
      "name": "Blanco"
    }
  ],
  "status": "available"
}
"""
    When method post
    Then status 200
    And match $.name == "Zeus"
    And print response

    And path "/pet"
    Given path response.id
    When method get
    Then status 200

    And path "/pet"
    And request
"""
{
  "id": 1,
  "category": {
    "id": 1,
    "name": "Perros"
  },
  "name": "Thor",
  "photoUrls": [
    "string"
  ],
  "tags": [
    {
      "id": 1,
      "name": "Blanco"
    }
  ],
  "status": "sold"
}
"""
    When method put
    Then status 200
    And print response

    And path "/pet/findByStatus"
    And def status = response.status
    And param status = response.status
    When method get
    Then status 200
    And print response