#!/bin/bash
presets=("arm64-v8a" "armeabi-v7a" "x86" "x86_64")
clean_dir=("build")
clean=0

for arg in "$@"; do
    case $arg in
        clean)
            clean=1
            ;;
    esac
done

if [ $clean -eq 1 ]
then
    echo "Lösche alle alten Dateien"
    for dir in "${clean_dir[@]}"; do
        echo "Lösche: $dir"
        rm -rf "$dir"
    done
fi

# Konfigurieren
for preset in "${presets[@]}"; do
    echo "Konfiguriere: $preset"
    cmake --preset "$preset"
done

# Bauen
for preset in "${presets[@]}"; do
    build_dir="build/${preset}"
    echo "Baue: $preset im Verzeichnis $build_dir"
    cmake --build "$build_dir"
done

# Kopieren
echo "Kopiere Dateien"
rm -r "../www/*"
for preset in "${presets[@]}"; do
    build_dir="build/${preset}"
    target_dir="../www/$preset/"
    echo "Kopiere: $preset nach $target_dir"
    mkdir -p "$target_dir"
    cp -f $build_dir/*.so $target_dir
done