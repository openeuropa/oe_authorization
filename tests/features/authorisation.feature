Feature: User authorisation
  In order to protect the integrity of the website
  As a product owner
  I want to make sure users with various roles can only access pages they are authorized to

  Scenario Outline: Anonymous user cannot access restricted pages
    Given I am not logged in
    When I go to "<path>"
    Then I should get an access denied error

    Examples:
      | path            |
      | admin           |
      | admin/config    |
      | admin/content   |
      | admin/people    |
      | admin/structure |
      | node/add        |

  @api
  Scenario Outline: Site Managers can access certain administration pages
    Given I am logged in as a user with the "site_manager" role
    Then I go to "<path>"
    Then I should get a valid web page

    Examples:
      | path                |
      | admin/people        |
      | admin/people/create |
      | admin/reports/dblog |
      | admin/content       |

  @api
  Scenario Outline: Site Managers cannot access administration pages that change
    major configuration
    Given I am logged in as a user with the "site_manager" role
    Then I go to "<path>"
    Then I should get an access denied error

    Examples:
      | path                         |
      | admin/modules                |
      | admin/appearance             |
      | admin/config/people/accounts |
      | admin/structure/block        |
      | admin/structure/types/add    |

  @api
  Scenario Outline: Support Engineers can access some administration pages
    Given I am logged in as a user with the "support_engineer" role
    Then I go to "<path>"
    Then I should get a valid web page

    Examples:
      | path                |
      | admin/config        |
      | admin/reports/dblog |
      | admin/content       |

  @api
  Scenario Outline: Support Engineers cannot access user management related
    administration pages
    Given I am logged in as a user with the "support_engineer" role
    Then I go to "<path>"
    Then I should get an access denied error

    Examples:
      | path                |
      | admin/people        |
      | admin/people/create |

  @api
  Scenario Outline: Editors can access content related pages
    Given I am logged in as a user with the "editor" role
    Then I go to "<path>"
    Then I should get a valid web page

    Examples:
      | path          |
      | admin/content |

  @api
  Scenario Outline: Editors cannot access administration pages
    Given I am logged in as a user with the "editor" role
    Then I go to "<path>"
    Then I should get an access denied error

    Examples:
      | path                  |
      | admin/people          |
      | admin/people/create   |
      | admin/structure/types |
      | admin/reports/status  |
      | admin/modules         |