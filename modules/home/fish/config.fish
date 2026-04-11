function fish_greeting
    printf "Hello "
    set_color "brblue"
    whoami
    set_color "brblack"
    echo $(date)
end

# >>> clash >>>
function setproxy
    if test -n "$PROXY"
        set -xg all_proxy $PROXY
        set -xg http_proxy $PROXY
        set -xg https_proxy $PROXY
        set -xg no_proxy "localhost,127.0.0.1,::1"
    else
        echo "[WRN] Variable PROXY is empty"
    end
end

function noproxy
    set -xg all_proxy
    set -xg http_proxy
    set -xg https_proxy
    set -xg no_proxy
end

# <<< clash <<<
