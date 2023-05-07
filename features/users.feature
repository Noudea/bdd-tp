Feature: Users Management
  Scenario: List users
    When I list the "users"
    Then I should have response "OK"
    And following "users" list:
      | id                                    | lastName | firstName | birthDate | phone         | address                                 | email          |
      | f92fefd1-4059-447b-89c6-a7e2482f7a5f | Dumbledore| Albus    | 1950-01-01 | +33654543456 | bureau du directeur,chateau de poudlard | albus@mail.com |
      | c5e0357f-2eb7-4180-84e7-5c8efeab2c83 | Potter | Harry    | 1980-01-01 | +33654543456 | lit numéro 2, dortoir des garçons, griffondor, chateau de poudlard | harry@mail.com |

  Scenario: Where I get get an user
    Given a "user" with id "f92fefd1-4059-447b-89c6-a7e2482f7a5f"
    When I get the "users"
    Then I should have response "OK"
    And following "user" item:
      | id                                    | lastName | firstName | birthDate | phone         | address                                 | email          |
      | f92fefd1-4059-447b-89c6-a7e2482f7a5f | Dumbledore| Albus    | 1950-01-01 | +33654543456 | bureau du directeur,chateau de poudlard | albus@mail.com |

  Scenario: Where I get get an user with the wrong uuid format
    Given a "user" with id "f92fefd1-4059-4dsq7b-89c6-a7edqs482f7a5f"
    When I get the "users"
    Then I should have response "BAD_REQUEST"
    And following "error" item:
      | message                | status  | code |
      | id is not valid | 400     | BAD_REQUEST |

  Scenario: Where I get get an user that does not exist
    Given a "user" with id "36abf4fb-7367-4280-b824-7438ced8aecc"
    When I get the "users"
    Then I should have response "NOT_FOUND"
    And following "error" item:
      | message                   | status      | code |
      | User not found | 404     | NOT_FOUND |

  Scenario: Create a user
    When I create the following "user"
      | lastName | firstName | birthDate |phone|address|email|
      | Ron| Weasley    | 1980-03-01 | +33654543456 | Le terrier | ron@email.com |
    Then I should have response "CREATED"
    And following new "user" item
      | lastName | firstName | birthDate |phone|address|email|
      | Ron| Weasley    | 1980-03-01 | +33654543456 | Le terrier | ron@email.com |

  Scenario: Create a order with wrong birthDate format
    When I create the following "user"
      | lastName | firstName | birthDate |phone|address|email|
      | Ron| Weasley    | 19803-01 | +33654543456 | Le terrier | ron@email.com |
    Then I should have response "BAD_REQUEST"
    And following "error" item:
      | message                                        | status      | code |
      | birthDate is not valid format should be YYYY-MM-DD | 400     | BAD_REQUEST |

  Scenario: Create a user with wrong phoneNumber format
    When I create the following "user"
      | lastName | firstName | birthDate |phone|address|email|
      | Ron| Weasley    | 1980-03-01 | +33654543123456 | Le terrier | ron@email.com |
    Then I should have response "BAD_REQUEST"
    And following "error" item:
      | message                                        | status      | code |
      | phone is not valid | 400     | BAD_REQUEST |

  Scenario: Where I update a user
    Given a "user" with id "f92fefd1-4059-447b-89c6-a7e2482f7a5f"
    When I update the following "user" with following data:
      | lastName | firstName | birthDate |phone|address|email|
      | Dumbledore| Albus    | 1950-01-01 | +33654543456 | bureau du directeur,chateau de poudlard | albusleboss@mail.com |
    Then I should have response "OK"
    And following "user" item:
      |id| lastName | firstName | birthDate |phone|address|email|
      |f92fefd1-4059-447b-89c6-a7e2482f7a5f| Dumbledore| Albus    | 1950-01-01 | +33654543456 | bureau du directeur,chateau de poudlard | albusleboss@mail.com |


  Scenario: Where I update a user with the wrong uuid format
    Given a "user" with id "f92fefd1-4059-447dsqdsqb-89c6-a7e2482f7a5f"
    When I update the following "user" with following data:
      | lastName | firstName | birthDate |phone|address|email|
      | Dumbledore| Albus    | 1950-01-01 | +33654543456 | bureau du directeur,chateau de poudlard | albusleboss@mail.com |
    Then I should have response "BAD_REQUEST"
    And following "error" item:
      | message                | status  | code |
      | id is not valid | 400     | BAD_REQUEST |

  Scenario: Where I update a user with wrong phoneNumber format
    Given a "user" with id "f92fefd1-4059-447b-89c6-a7e2482f7a5f"
    When I update the following "user" with following data:
      | lastName | firstName | birthDate |phone|address|email|
      | Dumbledore| Albus    | 1950-01-01 | +33654dsq543456 | bureau du directeur,chateau de poudlard | albusleboss@mail.com |
    Then I should have response "BAD_REQUEST"
    And following "error" item:
      | message             | status      | code |
      | phone is not valid | 400     | BAD_REQUEST |

  Scenario: Where I update a user with wrong birthDate format
    Given a "user" with id "f92fefd1-4059-447b-89c6-a7e2482f7a5f"
    When I update the following "user" with following data:
      | lastName | firstName | birthDate |phone|address|email|
      | Dumbledore| Albus    | 1950dsq-01-01 | +33654543456 | bureau du directeur,chateau de poudlard | albusleboss@mail.com |
    Then I should have response "BAD_REQUEST"
    And following "error" item:
      | message             | status      | code |
      | birthDate is not valid format should be YYYY-MM-DD | 400     | BAD_REQUEST |

  Scenario: Where I update a user that does not exist
    Given a "user" with id "ae2a7f15-974f-4d61-80ba-04cda796d758"
    When I update the following "user" with following data:
      | lastName | firstName | birthDate |phone|address|email|
      | Dumbledore| Albus    | 1950-01-01 | +33654543456 | bureau du directeur,chateau de poudlard | albusleboss@mail.com |
    Then I should have response "NOT_FOUND"
    And following "error" item:
      | message                   | status      | code |
      | User not found | 404     | NOT_FOUND |

  Scenario: Where I delete a user
    Given a "user" with id "c5e0357f-2eb7-4180-84e7-5c8efeab2c83"
    When I delete the "user"
    Then I should have response "OK"
    And following "user" deleted item:
      | id                                    | lastName | firstName | birthDate | phone         | address                                 | email          |
      | c5e0357f-2eb7-4180-84e7-5c8efeab2c83 | Potter | Harry    | 1980-01-01 | +33654543456 | lit numéro 2, dortoir des garçons, griffondor, chateau de poudlard | harry@mail.com |

  Scenario: Where I delete a user and id is not valid
    Given a "user" with id "c5e0357f-2eb7-4180-8efeab2c83"
    When I delete the "user"
    Then I should have response "BAD_REQUEST"
    And following "error" item:
      | message                | status  | code |
      | id is not valid | 400     | BAD_REQUEST |

  Scenario: Where I delete a user and user does not exist
    Given a "user" with id "ae2a7f15-974f-4d61-80ba-04cda796d758"
    When I delete the "user"
    Then I should have response "NOT_FOUND"
    And following "error" item:
      | message                   | status      | code |
      | User not found | 404     | NOT_FOUND |

