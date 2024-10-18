
function enable_k8s_functions() {
    echo "Enabling k8s functions"

    function kswitch() {
        namespace="${1}"
        kubectl config set-context --current --namespace=${namespace}
    }

    function kconfig() {
        kubectl config view --minify
    }
}