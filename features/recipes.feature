Feature: Recipes Management
  Scenario: List recipes
    When I list the "recipes"
    Then I should have response "OK"
      And following "recipes" list:
        | id | name | ingredients | procedure |
        | a35ce12d-d52b-4a07-90ad-68e985b779e7 | Chausson aux pommes | pommes, pate feuilletée, sucre | faire compote, former chausson, cuire |
        | dc466424-4297-481a-a8de-aa0898852da1 | Quiche thon tomate  | thon, tomate, pate feuilletée, oeuf, creme | couper thon, tomates, mélanger creme et oeufs, mettre dans moule, cuire |


  Scenario: Where I get get an recipe
    Given a "recipe" with id "a35ce12d-d52b-4a07-90ad-68e985b779e7"
    When I get the "recipes"
    Then I should have response "OK"
    And following "recipe" item:
      | id                                    | name                | ingredients                     | procedure                            |
      | a35ce12d-d52b-4a07-90ad-68e985b779e7 | Chausson aux pommes | pommes, pate feuilletée, sucre | faire compote, former chausson, cuire |

  Scenario: Where I get get an recipe that does not exist
    Given a "recipe" with id "3a347449-b295-4ad2-976d-4984bc86ea9a"
    When I get the "recipes"
    Then I should have response "NOT_FOUND"
    And following "error" item:
      | message                   | status      | code |
      | Recipe not found | 404     | NOT_FOUND |

  Scenario: Where I get get an recipe with the wrong uuid format
    Given a "recipe" with id "dbcbb733-8099-4abe190440b4"
    When I get the "recipes"
    Then I should have response "BAD_REQUEST"
    And following "error" item:
      | message                | status  | code |
      | id is not valid | 400     | BAD_REQUEST |

  Scenario: Create a recipe
    When I create the following "recipe"
        | name | ingredients | procedure |
        | Gratin dauphinois | pomme de terre, lait, beurre, fromage, creme | couper pommes de terre, les bouillir dans lait, cuire dans plat avec fromage |
        Then I should have response "CREATED"
        And following new "recipe" item
        | name | ingredients | procedure |
        | Gratin dauphinois | pomme de terre, lait, beurre, fromage, creme | couper pommes de terre, les bouillir dans lait, cuire dans plat avec fromage |

    Scenario: Where I update a recipe
      Given a "recipe" with id "a35ce12d-d52b-4a07-90ad-68e985b779e7"
      When I update the following "recipe" with following data:
        |      name | ingredients             | procedure                                       |
        | Croissant | pate feuilletée, beurre | couper un triangle, mettre le beurre, le rouler |
      Then I should have response "OK"
        And following "recipe" item:
          |id                                      |name      | ingredients             | procedure                                       |
          | a35ce12d-d52b-4a07-90ad-68e985b779e7  |Croissant | pate feuilletée, beurre | couper un triangle, mettre le beurre, le rouler |

  Scenario: Where I update a order with the wrong uuid format
    Given a "recipe" with id "dbcbb733-8099-ddbe1dsqdqs90440b4"
    When I update the following "recipe" with following data:
      |      name | ingredients             | procedure                                       |
      | Croissant | pate feuilletée, beurre | couper un triangle, mettre le beurre, le rouler |
    Then I should have response "BAD_REQUEST"
    And following "error" item:
      | message                | status  | code |
      | id is not valid | 400     | BAD_REQUEST |

    Scenario: Where I delete a recipe
      Given a "recipe" with id "dc466424-4297-481a-a8de-aa0898852da1"
      When I delete the "recipe"
      Then I should have response "OK"
        And following "recipe" deleted item:
          |id                                      |name      | ingredients             | procedure                                       |
          | dc466424-4297-481a-a8de-aa0898852da1 | Quiche thon tomate  | thon, tomate, pate feuilletée, oeuf, creme | couper thon, tomates, mélanger creme et oeufs, mettre dans moule, cuire |

  Scenario: Where I delete an order with the wrong uuid format
    Given a "recipe" with id "dc466424-4298de-aa0898852da1"
    When I delete the "recipe"
    Then I should have response "BAD_REQUEST"
    And following "error" item:
      | message                | status  | code |
      | id is not valid | 400     | BAD_REQUEST |
