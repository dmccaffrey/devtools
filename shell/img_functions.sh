function enable_img_functions() {
    echo "Enabling image functions"

    function minimg() {
        source_img=${1}
        filename=$(basename -- "${source_img}")
        filename="${filename%.*}"
        convert "${source_img}" -resize 800x600\> png8:${filename}-min.png
    }
}