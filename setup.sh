#!/bin/bash

MY_RIME_ROOT="$HOME/Library/Rime"

function deploy {
    echo "Deploying"

    if [[ ! -z $(ps -ef | grep Squirrel | grep -v grep) ]]; then
        echo "> service ... killing "
        killall Squirrel
    else
        echo "> service ... not started "
    fi

    echo "> starting service"
    open "/Library/Input Methods/Squirrel.app"
}

function deloy_rime_root {
    # For first run
    echo "Environment checking"

    if [[ ! -d $MY_RIME_ROOT ]]; then
        echo "> $MY_RIME_ROOT ... not exists"
        echo "> trying to create it"

        deploy && sleep 5

        if [[ ! -d $MY_RIME_ROOT ]]; then
            "> Can not create the $MY_RIME_ROOT ..."
            exit
        fi
    else
        echo "$MY_RIME_ROOT ... exists"
    fi
}

function install {
    echo "Installing"

	for yaml in `ls ./quick-win`; do
        echo "> copying ... $yaml"
        cp -Rf "./quick-win/$yaml" "$MY_RIME_ROOT/$yaml"
    done

    deploy && sleep 10

    echo "Install completed"
}

function uninstall {
    echo "Uninstalling"

    for yaml in `ls ./quick-win`; do
        echo "> removing ... $yaml"
        rm -rf "$MY_RIME_ROOT/$yaml"
    done

    for suff in prism reverse table; do
        deploy_file="quick_win.$suff.bin"

        echo "> removing ... $deploy_file"
        rm -rf "$MY_RIME_ROOT/$deploy_file"
    done

    deploy && sleep 2

    echo "Uninstall completed"
}

COMMAND=${@:$OPTIND:1}

case $COMMAND in

    install)
        deloy_rime_root
        install
    ;;

    uninstall)
        uninstall
    ;;

    *)
        echo "- install"
        echo "- uninstall"
    ;;

esac
