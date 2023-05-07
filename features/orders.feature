Feature: Order Management
  Scenario: List order
    When I list the "orders"
    Then I should have response "OK"
    And following "orders" list:
      | id                                    | orderDate | recipeId                                | quantity | userId |
      | dbcbb733-8099-4aec-bbda-ddbe190440b4 | 2023-09-20 | a35ce12d-d52b-4a07-90ad-68e985b779e7    | 1        | f92fefd1-4059-447b-89c6-a7e2482f7a5f     |
      | 5ebce9c0-6bfe-41f1-bce6-8824845d2deb | 2023-09-20 | dc466424-4297-481a-a8de-aa0898852da1    | 1        | c5e0357f-2eb7-4180-84e7-5c8efeab2c83      |

  Scenario: Where I get get an order
    Given a "order" with id "dbcbb733-8099-4aec-bbda-ddbe190440b4"
    When I get the "orders"
    Then I should have response "OK"
    And following "order" item:
      |id                                  | orderDate | recipeId                                | quantity | userId |
      |dbcbb733-8099-4aec-bbda-ddbe190440b4| 2023-09-20| a35ce12d-d52b-4a07-90ad-68e985b779e7    | 1        | f92fefd1-4059-447b-89c6-a7e2482f7a5f  |

  Scenario: Where I get get an order that does not exist
    Given a "order" with id "3a347449-b295-4ad2-976d-4984bc86ea9a"
    When I get the "orders"
    Then I should have response "NOT_FOUND"
    And following "error" item:
      | message                   | status      | code |
      | Order not found | 404     | NOT_FOUND |

  Scenario: Where I get get an order with the wrong uuid format
    Given a "order" with id "dbcbb733-8099-4abe190440b4"
    When I get the "orders"
    Then I should have response "BAD_REQUEST"
    And following "error" item:
      | message                | status  | code |
      | id is not valid | 400     | BAD_REQUEST |

  Scenario: Create a order
    When I create the following "order"
      | orderDate | recipeId                                | quantity | userId |
      | 2023-09-20| a35ce12d-d52b-4a07-90ad-68e985b779e7    | 10 | c5e0357f-2eb7-4180-84e7-5c8efeab2c83  |
    Then I should have response "CREATED"
    And following new "order" item
      | orderDate | recipeId                                | quantity | userId |
      | 2023-09-20| a35ce12d-d52b-4a07-90ad-68e985b779e7    | 10 | c5e0357f-2eb7-4180-84e7-5c8efeab2c83  |

  Scenario: Create a order with date in the past
    When I create the following "order"
      | orderDate | recipeId                                | quantity | userId |
      | 2022-03-20| a35ce12d-d52b-4a07-90ad-68e985b779e7    | 10 | c5e0357f-2eb7-4180-84e7-5c8efeab2c83  |
    Then I should have response "BAD_REQUEST"
    And following "error" item:
      | message                            | status      | code |
      | orderDate must be in the future | 400     | BAD_REQUEST |

  Scenario: Create a order where recipe does not exist
    When I create the following "order"
      | orderDate | recipeId                                | quantity | userId |
      | 2023-09-20| dbd3c633-4795-47dd-b68e-c970e0c963fd   | 10 | c5e0357f-2eb7-4180-84e7-5c8efeab2c83  |
    Then I should have response "NOT_FOUND"
    And following "error" item:
      | message                   | status      | code |
      | Recipe not found | 404     | NOT_FOUND |

  Scenario: Create a order where user does not exist
    When I create the following "order"
      | orderDate | recipeId                                | quantity | userId |
      | 2023-09-20| a35ce12d-d52b-4a07-90ad-68e985b779e7    | 10 | 3a347449-b295-4ad2-976d-4984bc86ea9a |
    Then I should have response "NOT_FOUND"
    And following "error" item:
      | message         | status      | code |
      | User not found | 404     | NOT_FOUND |

  Scenario: Create a order with wrong date format
    When I create the following "order"
      | orderDate | recipeId                                | quantity | userId |
      | 20-03-2302 | a35ce12d-d52b-4a07-90ad-68e985b779e7    | 10 | c5e0357f-2eb7-4180-84e7-5c8efeab2c83  |
    Then I should have response "BAD_REQUEST"
    And following "error" item:
      | message                                        | status      | code |
      | orderDate is not valid format should be YYYY-MM-DD | 400     | BAD_REQUEST |

  Scenario: Create a order with wrong recipeId uuid format
    When I create the following "order"
      | orderDate | recipeId                                | quantity | userId |
      | 2023-09-20 | a35ce12d-d52b-4ad-68e985b779e7    | 10 | c5e0357f-2eb7-4180-84e7-5c8efeab2c83  |
    Then I should have response "BAD_REQUEST"
    And following "error" item:
      | message                | status  | code |
      | recipeId is not valid | 400     | BAD_REQUEST |

  Scenario: Create a order with wrong userId uuid format
    When I create the following "order"
      | orderDate | recipeId                                | quantity | userId |
      | 2023-09-20 | a35ce12d-d52b-4a07-90ad-68e985b779e7    | 10 | c5e0357f-2edsqdqb7-4-84e7-5c8efeab2c83  |
    Then I should have response "BAD_REQUEST"
    And following "error" item:
      | message                | status  | code |
      | userId is not valid | 400     | BAD_REQUEST |


  Scenario: Where I update a order
    Given a "order" with id "dbcbb733-8099-4aec-bbda-ddbe190440b4"
    When I update the following "order" with following data:
      | orderDate | recipeId                                | quantity | userId |
      | 2023-09-20| a35ce12d-d52b-4a07-90ad-68e985b779e7    | 100 | c5e0357f-2eb7-4180-84e7-5c8efeab2c83  |
    Then I should have response "OK"
    And following "order" item:
      |id| orderDate | recipeId                                | quantity | userId |
      |dbcbb733-8099-4aec-bbda-ddbe190440b4| 2023-09-20| a35ce12d-d52b-4a07-90ad-68e985b779e7    | 100 | c5e0357f-2eb7-4180-84e7-5c8efeab2c83  |

  Scenario: Where I update a order with the date in the past
    Given a "order" with id "dbcbb733-8099-4aec-bbda-ddbe190440b4"
    When I update the following "order" with following data:
      | orderDate | recipeId                                | quantity | userId |
      | 2023-01-20| a35ce12d-d52b-4a07-90ad-68e985b779e7    | 100 | c5e0357f-2eb7-4180-84e7-5c8efeab2c83  |
    Then I should have response "BAD_REQUEST"
    And following "error" item:
      | message                            | status      | code |
      | orderDate must be in the future | 400     | BAD_REQUEST |

  Scenario: Where I update a order where the recipe does not exist
    Given a "order" with id "dbcbb733-8099-4aec-bbda-ddbe190440b4"
    When I update the following "order" with following data:
      | orderDate | recipeId                                | quantity | userId |
      | 2023-09-20| 3a347449-b295-4ad2-976d-4984bc86ea9a   | 100 | c5e0357f-2eb7-4180-84e7-5c8efeab2c83  |
    Then I should have response "NOT_FOUND"
    And following "error" item:
      | message         | status      | code |
      | Recipe not found | 404     | NOT_FOUND |

  Scenario: Where I update a order where the user does not exist
    Given a "order" with id "dbcbb733-8099-4aec-bbda-ddbe190440b4"
    When I update the following "order" with following data:
      | orderDate | recipeId                                | quantity | userId |
      | 2023-09-20| a35ce12d-d52b-4a07-90ad-68e985b779e7    | 100 | 3a347449-b295-4ad2-976d-4984bc86ea9a  |
    Then I should have response "NOT_FOUND"
    And following "error" item:
      | message         | status      | code |
      | User not found | 404     | NOT_FOUND |


  Scenario: Where I update a order with the wrong uuid format
    Given a "order" with id "dbcbb733-8099-ddbe190440b4"
    When I update the following "order" with following data:
      | orderDate | recipeId                                | quantity | userId |
      | 2023-09-20| a35ce12d-d52b-4a07-90ad-68e985b779e7    | 100 | c5e0357f-2eb7-4180-84e7-5c8efeab2c83  |
    Then I should have response "BAD_REQUEST"
    And following "error" item:
      | message                | status  | code |
      | id is not valid | 400     | BAD_REQUEST |

  Scenario: Where I update a order with wrong date format
    Given a "order" with id "dbcbb733-8099-4aec-bbda-ddbe190440b4"
    When I update the following "order" with following data:
      | orderDate | recipeId                                | quantity | userId |
      | 2023-03-0920| a35ce12d-d52b-4a07-90ad-68e985b779e7    | 100 | c5e0357f-2eb7-4180-84e7-5c8efeab2c83  |
    Then I should have response "BAD_REQUEST"
    And following "error" item:
      | message                                        | status      | code |
      | orderDate is not valid format should be YYYY-MM-DD | 400     | BAD_REQUEST |

  Scenario: Where I update a order with wrong recipeId uuid format
    Given a "order" with id "dbcbb733-8099-4aec-bbda-ddbe190440b4"
    When I update the following "order" with following data:
      | orderDate | recipeId                                | quantity | userId |
      | 2023-09-20| a35ce12d-d52b-4a068e985b779e7    | 100 | c5e0357f-2eb7-4180-84e7-5c8efeab2c83  |
    Then I should have response "BAD_REQUEST"
    And following "error" item:
      | message                | status  | code |
      | recipeId is not valid | 400     | BAD_REQUEST |

  Scenario: Where I update a order with wrong userId uuid format
    Given a "order" with id "dbcbb733-8099-4aec-bbda-ddbe190440b4"
    When I update the following "order" with following data:
      | orderDate | recipeId                                | quantity | userId |
      | 2023-09-20| a35ce12d-d52b-4a07-90ad-68e985b779e7    | 100 | c5e0357f-20-84e7-5c8efeab2c83  |
    Then I should have response "BAD_REQUEST"
    And following "error" item:
      | message                | status  | code |
      | userId is not valid | 400     | BAD_REQUEST |

  Scenario: Where I update a order that does not exist
    Given a "order" with id "ae2a7f15-974f-4d61-80ba-04cda796d758"
    When I update the following "order" with following data:
      | orderDate | recipeId                                | quantity | userId |
      | 2023-09-20| a35ce12d-d52b-4a07-90ad-68e985b779e7    | 100 | c5e0357f-2eb7-4180-84e7-5c8efeab2c83  |
    Then I should have response "NOT_FOUND"
    And following "error" item:
      | message                   | status      | code |
      | Order not found | 404     | NOT_FOUND |

  Scenario: Where I delete a order
    Given a "order" with id "5ebce9c0-6bfe-41f1-bce6-8824845d2deb"
    When I delete the "order"
    Then I should have response "OK"
    And following "order" deleted item:
      | id                                    | orderDate | recipeId                                | quantity | userId |
      | 5ebce9c0-6bfe-41f1-bce6-8824845d2deb | 2023-09-20 | dc466424-4297-481a-a8de-aa0898852da1    | 1        | c5e0357f-2eb7-4180-84e7-5c8efeab2c83      |


  Scenario: Where I delete an order with the wrong uuid format
    Given a "order" with id "dbcbb733-8099-d"
    When I delete the "order"
    Then I should have response "BAD_REQUEST"
    And following "error" item:
      | message                | status  | code |
      | id is not valid | 400     | BAD_REQUEST |

  Scenario: Where I delete a order and order not exist
    Given a "order" with id "ae2a7f15-974f-4d61-80ba-04cda796d758"
    When I delete the "order"
    Then I should have response "NOT_FOUND"
    And following "error" item:
      | message                   | status      | code |
      | Order not found | 404     | NOT_FOUND |

