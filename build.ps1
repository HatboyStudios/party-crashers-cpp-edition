$ErrorActionPreference = "Stop"

# Create build directory if it doesn't exist
if (!(Test-Path "build")) {
    New-Item -ItemType Directory -Path "build"
}

# Check if SFML exists in the lib directory
if (!(Test-Path "lib/SFML")) {
    Write-Host "SFML not found in lib directory. Setting up SFML..."
    
    # Create SFML directory in lib
    New-Item -ItemType Directory -Path "lib/SFML" -Force

    Write-Host "Please download SFML from https://www.sfml-dev.org/download.php"
    Write-Host "Extract the contents to the lib/SFML directory"
    Write-Host "After downloading and extracting, your lib/SFML directory should contain:"
    Write-Host "- include/"
    Write-Host "- lib/"
    Write-Host "- bin/"
    exit 1
}

# Copy DLL files if they don't exist in build directory
if (Test-Path "lib/SFML/bin") {
    Copy-Item "lib/SFML/bin/sfml-system-2.dll" "build/" -ErrorAction SilentlyContinue
    Copy-Item "lib/SFML/bin/sfml-graphics-2.dll" "build/" -ErrorAction SilentlyContinue
    Copy-Item "lib/SFML/bin/sfml-window-2.dll" "build/" -ErrorAction SilentlyContinue
}

# Compile the project
Write-Host "Compiling the project..."
g++ src/main.cpp -o build/game.exe -I"lib/SFML/include" -L"lib/SFML/lib" -lsfml-audio -lsfml-graphics -lsfml-window -lsfml-system

if ($LASTEXITCODE -eq 0) {
    Write-Host "Compilation successful! Run the game using: ./build/game.exe"
} else {
    Write-Host "Compilation failed!"
}
