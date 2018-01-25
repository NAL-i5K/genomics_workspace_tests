# Test Genomics Workspace

Test utilities based on [robotframework](http://robotframework.org/) using [SeleniumLibrary](https://github.com/robotframework/SeleniumLibrary) to test production site of genomics-workspace

## Usage
- Install dependencies: `pip install -r requirements.txt`
- run the test with `robot --variable url:[url you want] blast/`, for example: `robot --variable url:https://i5k.nal.usda.gov/webapp/blast/ blast/`