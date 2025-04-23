flutter clean
flutter pub get

echo "Generating localization files..."
flutter gen-l10n

cd ios
pod install