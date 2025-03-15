#!/bin/bash
#!/bin/bash
logger() {
    timestamp=$(date +"%Y-%m-%d %H:%M:%S")
    level=$1
    message=$2
    if [[ $level == "w" ]]; then
       level="WARNING"
    elif [[ $level == "i" ]]; then
       level="INFO"
    elif [[ $level == "e" ]]; then
       level="ERROR"
    elif [[ $level == "d" ]]; then
       level="DEBUG"
    fi
    echo "[$timestamp] [$level] $message"
}