#!/usr/bin/env fish

function die
    echo -e "$argv" 1>&2
    exit 1
end

function ensure_folder_exists
    set -l folder $argv[1]
    test -d $folder; or die "folder $folder does not exist"
    return 0
end

function ensure_file_exists
    set -l file $argv[1]
    test -f $file; or die "file $file does not exist"
    return 0
end

function ensure_link_exists
    set -l link $argv[1]
    test -L $link; or die "link $link does not exist"
    return 0
end

if test (count $argv) -lt 1
    die "must specify commit message as first argument"
end
set -l msg "$argv[1]"

set -l library_factorio "/Users/dsicilia/Library/Application Support/factorio"
set -l saves_link       "/Users/dsicilia/Library/Application Support/factorio/saves"
set -l factorio_saves   "/Users/dsicilia/games/factorio-saves"
set -l blueprint_storage "blueprint-storage.dat"
set -l save_zip          "saves/dsicilia.zip"

ensure_folder_exists $library_factorio
ensure_folder_exists $factorio_saves
ensure_link_exists $saves_link

cp "$library_factorio/$blueprint_storage" "$factorio_saves/$blueprint_storage"
or die "failed to copy $library_factorio/$blueprint_storage to $factorio_saves/$blueprint_storage"

cd $factorio_saves; or die "failed to change to directory $factorio_saves"

git status; or die "failed to run git status"

ensure_file_exists $blueprint_storage
ensure_file_exists $save_zip

git add $blueprint_storage $save_zip; or die "failed to git add"

git commit -m "'$msg'"

push
