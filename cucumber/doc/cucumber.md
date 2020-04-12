 Cucumber (for ruby)

_Behaviour Driven Development (BDD)_

Utilise la syntaxe **gherkin**.

- `Given`
- `When`
- `Then`

## Exemple

### Step 1

```bash
cucumber --init
```
qui renvoie sur la sortie standard

```bash
  create   features
  create   features/step_definitions
  create   features/support
  create   features/support/env.rb
```

### Step 2
- `cd features`
- `touch ref-example.feature` : extension `.feature`

```gherkin
Feature:
  In order to ...
  As an ...
  I want ..

  Scenario: something to check
    Given ...
    When ...
    Then ...
    And ...
```

Par exemple

- `touch manage-server.feature`

```cucumber
Feature:
  In order to manage server
  As an observer
  I want to check if the server is running whithout any error

  Scenario: server status
    Given an address and a port
    When I run the server
    Then the server status is RUNNING
```

### Step 3

- `cd ../features` : se positionner dans le répertoire parent de `features`
- `cucumber features/manage-server.feature` : lancer les tests

qui renvoie

```bash
Feature:
  In order to manage server
  As an observer
  I want to check if the server is running whithout any error

  Scenario: server status             # features/manage-server.feature:6
    Given an address and a port       # features/manage-server.feature:7
    When I run the server             # features/manage-server.feature:8
    Then the server status is RUNNING # features/manage-server.feature:9

1 scenario (1 undefined)
3 steps (3 undefined)
0m0.014s

You can implement step definitions for undefined steps with these snippets:

Given(/^an address and a port$/) do
  pending # Write code here that turns the phrase above into concrete actions
end

When(/^I run the server$/) do
  pending # Write code here that turns the phrase above into concrete actions
end

Then(/^the server status is RUNNING$/) do
  pending # Write code here that turns the phrase above into concrete actions
end
```

On créé alors un fichier `manage-server.rb` dans le répertoire `features/step_definitions` avec le code `ruby` proposé par cucumber

```bash
cat <<EOF >step_definitions/manage-server.rb
> Given(/^an address and a port$/) do
>   pending # Write code here that turns the phrase above into concrete actions
> end
>
> When(/^I run the server$/) do
>   pending # Write code here that turns the phrase above into concrete actions
> end
>
> Then(/^the server status is RUNNING$/) do
>   pending # Write code here that turns the phrase above into concrete actions
> end
> EOF
```

après avoir créé notre fichier ruby `manage-server.rb` on relance les tests

- `cucumber features/manage-server.feature` : depuis le répertoire parent de `features`

qui renvoie

```bash
Feature: 
  In order to manage server
  As an observer
  I want to check if the server is running whithout any error

  Scenario: server status             # features/manage-server.feature:6
    Given an address and a port       # features/step_definitions/manage-server.rb:1
      TODO (Cucumber::Pending)
      ./features/step_definitions/manage-server.rb:2:in `/^an address and a port$/'
      features/manage-server.feature:7:in `Given an address and a port'
    When I run the server             # features/step_definitions/manage-server.rb:5
    Then the server status is RUNNING # features/step_definitions/manage-server.rb:9

1 scenario (1 pending)
3 steps (2 skipped, 1 pending)
0m0.012s
```

On supprime l'attente de cucumber `Cucumber::Pending` en englobant dans une chaine de caractères l'instruction en vue d'une implémentation ultèrieure

- `cat features/step_definitions/manage-server.rb`

```bash
Given(/^an address and a port$/) do
  puts "pending # Write code here that turns the phrase above into concrete actions"
end

When(/^I run the server$/) do
  puts "pending # Write code here that turns the phrase above into concrete actions"
end

Then(/^the server status is RUNNING$/) do
  puts "pending # Write code here that turns the phrase above into concrete actions"
end
```

On relance les tests : `cucumber features/manage-server.feature`

```bash
Feature:
  In order to manage server
  As an observer
  I want to check if the server is running whithout any error

  Scenario: server status             # features/manage-server.feature:6
    Given an address and a port       # features/step_definitions/manage-server.rb:1
      pending # Write code here that turns the phrase above into concrete actions
    When I run the server             # features/step_definitions/manage-server.rb:5
      pending # Write code here that turns the phrase above into concrete actions
    Then the server status is RUNNING # features/step_definitions/manage-server.rb:9
      pending # Write code here that turns the phrase above into concrete actions

1 scenario (1 passed)
3 steps (3 passed)
0m0.013s
```

Tous les tests sont ici passés.

## Bliblio

- [David Bacum](https://www.youtube.com/watch?v=jcufT1xVhGA)
- [RailsCasts](https://www.youtube.com/watch?v=hHqBcBbaRa4)
- [openclassroom js](https://openclassrooms.com/fr/courses/3504461-testez-linterface-de-votre-site/4270561-pourquoi-ecrire-des-tests)
- [tutorialspoint java](https://www.tutorialspoint.com/cucumber/cucumber_quick_guide.htm)
