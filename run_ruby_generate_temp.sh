#!/usr/bin/env bash

export BROWSER_TYPE=$1;
rm allure-results allure-report -rf;

cucumber --tags "@wiki" --format AllureCucumber::Formatter --out allure-results;

echo "language=Ruby"> allure-results/environment.properties;
echo "browser=$1">> allure-results/environment.properties;

allure serve