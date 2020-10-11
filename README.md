# dependency-pipeline-parser
There are two scripts in this repository:

<b>1. dependency-parser.py</b>

This is an XML parser of OWASP dependency-checker report written in python. This script requires additional modules "bs4" and "lxml" to run.

The command to run this script is as below:

python dependency-parser.py <DEPENDENCY_XML_REPORT> <SEVERITY_IN_CAPS>

Example: python dependency-parser.py Desktop/Reports/dependency-checker.xml CRITICAL

The severity in argument has to be provided in capital letter.



2. dependency-review.sh

This is a shellscript script that inturn calls the above script to fetch issue counts based on severity. Based on the count it fails a "Pipeline" if it is more than threshold.

The command to run this script is as below:

bash dependency-review.sh <DEPENDENCY_PARSER.PY> <DEPENDENCY_XML_REPORT> <SEVERITY_THRESHOLD>

Example: bash dependency-review.sh Desktop/Scripts/dependency-parser.py Desktop/Reports/dependency-checker.xml [{CRITICAL,0},{HIGH,0},{MEDIUM,0},{LOW,3}]

The severity threshold in argument has to be provided in the below format:

[{CRITICAL,0},{HIGH,0},{MEDIUM,0},{LOW,3}]
