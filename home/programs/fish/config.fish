function fish_greeting
    printf "Hello "
    set_color "brblue"
    whoami
    set_color "brblack"
    echo $(date)
end

# >>> clash >>>
function setproxy
    set -xg all_proxy http://127.0.0.1:7890
    set -xg http_proxy http://127.0.0.1:7890
    set -xg https_proxy http://127.0.0.1:7890
    set -xg no_proxy http://127.0.0.1:7890
end

function noproxy
    set -xg all_proxy
    set -xg http_proxy
    set -xg https_proxy
    set -xg no_proxy
end

setproxy

# <<< clash <<<
