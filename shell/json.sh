function enable_json_functions() {

    function jprint() {
        file="${1}"
        jq "." ${file}
    }

    function jselect() {
        query="${1}"
        for file in *.json; do
            if [[ `_jq ${file} ${query}` == 'true' ]]; then
                echo "${file}"
            fi
        done
    }

    function jquery() {
        query="${1}"
        for file in *.json; do
            echo -e "\nFile: ${file}"
            _jq ${file} ${query}
        done
    }

    function _jq() {
        file="${1}"
        query="${2}"
        jq ${query} ${file}
    }
}