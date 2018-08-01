# Test Genomics Workspace

## Introduction

Test utilities based on [robotframework](http://robotframework.org/) using [SeleniumLibrary](https://github.com/robotframework/SeleniumLibrary) to test production site of [genomics-workspace](https://github.com/NAL-i5K/genomics-workspace/).

## Installation

`pip install -r requirements.txt`

## Usage

- Run all tests: at the root directory of this repo, run `robot --variable url_prefix:[url_prefix of your genomics-workspace] .`, for example, if you have a genomics-workspace instance with root url at https://gmod-i5k.nal.usda.gov/webapp/ `robot --variable url_prefix:https://gmod-i5k.nal.usda.gov/webapp/ .`
- Run only one of the apps (blast, hmmer, or clustal): `robot --variable url_prefix:[url_prefix of your genomics-workspace] [app]/`