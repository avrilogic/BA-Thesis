#!/bin/bash
presets=("gcc-build" "clang-build" "arm64-build" "mingw-build")
clean_dir=("build")
overwrite_presets=()
clean=0
run=0
for arg in "$@"; do
    case $arg in
        clean)
            clean=1
            ;;
        gcc)
            overwrite_presets+=("gcc-build")
            ;;
        clang)
            overwrite_presets+=("clang-build")
            ;;
        arm64)
            overwrite_presets+=("arm64-build")
            ;;
        mingw)
            overwrite_presets+=("mingw-build")
            ;;
        run)
            run=1
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

if [ ${#overwrite_presets[@]} -gt 0 ]
then
    echo "Ausgewählte Presets: ${overwrite_presets[@]}"
    presets=("${overwrite_presets[@]}")
fi

# Konfigurieren
for preset in "${presets[@]}"; do
    echo "Konfiguriere: $preset"
    cmake --preset "$preset"
done

# Bauen
for preset in "${presets[@]}"; do
    build_dir="build/${preset%%-*}"
    echo "Baue: $preset im Verzeichnis $build_dir"
    cmake --build "$build_dir"
done
