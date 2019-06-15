#!/usr/bin/env bash

cd ~/lab/apps/ruby-redmine-automated-tests
./test_setup.sh

export BROWSER_TYPE=$1;
rm allure-results allure-report -rf;

cucumber --tags "not @test_setup" --format AllureCucumber::Formatter --out allure-results;

echo "language=Ruby"> allure-results/environment.properties;
echo "browser=$1">> allure-results/environment.properties;

allure generate;
cp -r allure-report ~/lab/results_run_locally/Ruby_$1_$(date +"%b%d_%I-%M%p")