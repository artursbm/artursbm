#!/bin/sh

function printmsg() 
{
    printf "$1"
    sleep 0.7
    if $2; then printf "\r\033[K"
    fi
}

function undolink()
{
    printmsg "Undoing link: $1 -> $2" false
    unlink "$1"
    ls -la | grep .test_dotfile
    rm "$2"
    printmsg "\nChange undone!\n" false
}

DOTFILE_FOLDER="$(pwd)/dotfiles/"

for (( i=1; i<=$#;i++)); do
    FILE="${!i}"

    ########## TODO remove the line below #########
    touch "$HOME/$FILE"
    ########### TEST PURPOSE #########

    # $LINK is the original file that will be symlinked
    LINK=$HOME"/"$FILE
    echo $LINK
    sleep 3
    # $DOTFILE is the file after being moved to dotfile folder
    # where changes should happen
    DOTFILE=$DOTFILE_FOLDER$FILE

    printmsg "Backing up $FILE dotfile..."
    mv "$LINK" "$DOTFILE_FOLDER"
    ln -s "$DOTFILE" "$LINK"
    printmsg "Done!"

    undolink "$LINK" "$DOTFILE"
done

