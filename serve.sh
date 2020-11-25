#!/bin/env -S sh

__usage() {
cat << EOF
${0} [OPTIONS...] PATH - run an http daemon for OpenComputers wget utility.

OPTIONS:
    -h, --help          Print out this information.
    -B, --backend       Choose backend server. See BACKENDS section.
    -e, --executable    Choose path to backen executable (optional).
    -b, --bind          Address to bind to.
    -p, --port          Port to bind to (default to 50000).
    PATH                A path to a directory or to a file (different backends require different stuff.

BACKENDS:
    ncat
        --script-file=PATH  Path to HTTP header path.
    python.http.server
        none
EOF
}

main() {
    while getopts "he::B:b::p::" OPTSTRING; do
        case ${OPTSTRING} in
            h)
                __usage >&2
                exit 0
                ;;
            e)
                BACKEND_PATH=${OPTARG}
                ;;
            B)
                BACKEND_NAME=${OPTARG}
                ;;
            b)
                BIND_ADDRESS=${OPTARG}
                ;;
            p)
                BIND_PORT=${OPTARG}
                ;;
            *)
                __usage >&2
                exit 1
                ;;
        esac
    done

    if [ -z ${BACKEND_NAME} ]; then
        BACKEND_NAME=ncat
        BACKEND_PATH=`which ${BACKEND_NAME}`
    fi

    if [ -z ${BIND_ADDRESS} ]; then
        BIND_ADDRESS=127.0.0.1
        BIND_PORT=50000
    fi

    if ! [ -x ${BACKEND_PATH} ]; then
        echo -e "\033[31merror:\033[0m Backend executable is not available." >&2
        exit 2
    fi

    case ${BACKEND_NAME} in
        ncat)
            if ! [ -x ncat.sh ]; then
                echo -e "\033[31merror:\033[0m No per-connection executable is available for ncat." >&2
                echo -e "\033[34mmay:\033[0m You could create a shell script file called 'ncat.sh' in current directory and make it executable to make ncat run it everytime connection is made." >&2
                exit 5
            fi

            exec ${BACKEND_PATH} --verbose --keep-open --listen --exec 'ncat.sh' ${BIND_ADDRESS} ${BIND_PORT}
            ;;

        python\.http\.server)
            exec ${BACKEND_PATH} --module http.server --bind ${BIND_ADDRESS} ${BIND_PORT}
            ;;
        *)
            echo -e "\033[31merror:\033[0m Invalid backend name is provided." >&2
            exit 3
            ;;
    esac
}

main "${@}"

