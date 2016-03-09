BEHAT Testing Platform
===============
BEHAT is a quick start setup for testing Behat with the following setup:

Behat, Drupal-Behat-Extension and PhantomJS on a local setup

TODO: THIS IS A WIP Please note that there are many pieces that can change overtime. This is available to introduce the
framework and lower the barrier to entry for F1 devs


# USAGE
-------------------------------------

This Quick-Start only provides a basis to learn Behat it is not a lexicon for learning Behat.

There are many resources for learning about Behat. I gave a talk on it here:

https://www.youtube.com/watch?v=NsI8kPc3kBA

The behat.yml file comes with two default profiles, 'default' and 'selenium'.

The default profile uses phantomjs to perform Behat tests via a headless browser. PhantomJS listens on the 8643 port
```
 wd_host:              'http://127.0.0.1:8643/wd/hub'
```
The selenium profile uses the option java .jar file to run tests with the existing browsers on your local machine. Selenium listens on the 5555 port

```
  wd_host:              'http://127.0.0.1:5555/wd/hub'
```

Using the bin/behat -dl you can see the available steps that you can use to write tests

When writing tests within feature files make sure to include the @api for making drush available in a feature:

```
   @api
   Scenario: I want to be able to show how to include Drush
```

The @javascript tag allows you to test with javascript-enabled drivers. Two of the javascript enabled drivers bundled with this testing framework are
PhantomJS and Selenium Grid. The @javascript tag is a requirement for behat to run either PhantomJS and Selenium2.
Both included profiles have goutte enabled by default, which is the headless browser driver. Without the @javascript tag goutte is selected to drive the tests.

```
   @javascript
   Scenario: I want to be able to show how to include Javascript
```

# OPTIONAL SELENIUM GRID 2 PROFILE FEATURES
-------------------------------------

## Install Java for your Platform

### Homebrew option: 'brew cask install java' or https://java.com

### Mac

#### For users with chrome, OR firefox browsers the standard included nodeconfig.mac.json should work for you without any changes

### Windows

#### For users with chrome, OR firefox browsers the standard included nodeconfig.windows.json should work for you without any changes

### Linux

#### For users with chrome, OR firefox browsers the standard included nodeconfig.linux.json should work for you without any changes

#### Use the following command to bring up the Selenium Hub on the Guest VM
```
$ vagrant ssh
$ cd /vagrant/tests/behat/
$ java -jar selenium-server-standalone-2.48.2.jar -role hub  -nodeConfig nodeconfig.server.json
```
#### Use the following command to bring up the Selenium Hub on the Host
```
$ cd tests/behat
$ java -jar selenium-server-standalone-2.48.2.jar -role node  -nodeConfig nodeconfig.mac.json
```
#### You can now run behat with Selenium Grid 2 on the Guest VM which will request Browsers from the Host

```
$ vagrant ssh
$ bin/behat features/TEST/test-js.feature  -p local-selenium

```


# OPTIONAL PHPSTORM INTEGRATION
-------------------------------------

http://blog.jetbrains.com/phpstorm/2014/07/using-behat-in-phpstorm/


#### GOTCHAS
-------------------------------------

1. Various Behat Drivers have specific browser functionality
2. The default Goutte driver does not allow for checking javascript/ajax functionality. Phantomjs as a headless driver does allow for ajax


