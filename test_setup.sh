#!/usr/bin/env bash

export BROWSER_TYPE=chrome;
rm allure-results allure-report -rf;
cucumber  --tags "@test_setup" --format AllureCucumber::Formatter --out allure-results;