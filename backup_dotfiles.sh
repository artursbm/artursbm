#!/bin/sh

DOTFILE_FOLDER=~/Git/personal/artursbm/dotfiles/

for (( i=1; i<=$#;i++)); do
    FILE=${!i}
    BKP=$HOME"/"$FILE
    echo "Backing up $FILE dotfile..."
    mv $BKP $DOTFILE_FOLDER
    ln -s $DOTFILE_FOLDER$FILE $HOME/$FILE
    echo "done!"
done