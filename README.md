# Test Genomics Workspace

Test utilities based on [robotframework](http://robotframework.org/) using [SeleniumLibrary](https://github.com/robotframework/SeleniumLibrary) to test production site of genomics-workspace.

## Installation

`pip install -r requirements.txt`

## Usage

- Run the test: at the root directory of this repo, run `robot --variable url:[url you want] [app]/`, for example:
  - `robot --variable url:https://i5k.nal.usda.gov/webapp/blast/ blast/`
  - `robot --variable url:https://i5k.nal.usda.gov/webapp/hmmer/ hmmer/`
  - `robot --variable url:https://i5k.nal.usda.gov/webapp/clustal/ clustal/`
