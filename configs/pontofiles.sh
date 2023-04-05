#!/bin/sh

DOTFILE_FOLDER="$(pwd)/dotfiles/"

function printmsg() 
{
    printf "$1"
    sleep 0.7
    if $2; then 
        printf "\r\033[K"
    fi
}

function undolink()
{
    printmsg "Undoing link: $1" false
    unlink "$1"
    printmsg "\nChange undone!\n" false
}

function restore_dotfile()
{
    mv $1 $HOME/
}

function insidefolder() 
{
    case "$1" in
        *"/"*)
        return true
        ;;
    esac
    return false

}

function create_dotfiles()
{
    for (( i=1; i<=$#;i++)); do
        FILE="${!i}"
        if [ insidefolder "$FILE" ]; then
            echo "$FILE inside folder"
        fi
        
        ########## TODO remove the line below #########
        # touch "$HOME/$FILE"
        ########### TEST PURPOSE #########

        # $LINK is the original file that will be symlinked
        LINK="$HOME/$FILE"
        echo $LINK
        sleep 3
        # $DOTFILE is the file after being moved to dotfile folder
        # where changes should happen
        DOTFILE="$DOTFILE_FOLDER$FILE"

        printmsg "Backing up $FILE dotfile..."
        mv "$LINK" "$DOTFILE_FOLDER"
        ln -s "$DOTFILE" "$LINK"
        printmsg "Done!"

        # undolink "$LINK" "$DOTFILE"
    done
}

function undo_dotfiles() 
{
    for(( i=1; i<=$#; i++ )); do
        FILE="${!i}"
        DOTFILE="$DOTFILE_FOLDER$FILE"
        LINKFILE="$HOME/$FILE"
                
        undolink $LINKFILE

        restore_dotfile $DOTFILE

    done
}

case $1 in
    "create")
        shift 1
        create_dotfiles "$@"
        ;;
    "undo")
        shift 1
        undo_dotfiles "$@"
        ;;
    *) 
        echo "Invalid option! choose between create or undo";;
esac
