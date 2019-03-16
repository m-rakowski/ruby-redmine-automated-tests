#!/usr/bin/env bash
rm allure-results -rf; cucumber  --tags "not @test_setup" --format AllureCucumber::Formatter --out allure-results; allure serve