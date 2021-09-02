#!/bin/sh

#  build_universal_framework.sh
#  SoundCatalogKit
#
#  Created by David Ilenwabor on 01/09/2021.
#  

SCHEME_NAME="SoundCatalogKit"
FRAMEWORK_NAME="SoundCatalogKit"

iOS_SIMULATOR_ARCHIVE_PATH="${BUILD_DIR}/${CONFIGURATION}/${FRAMEWORK_NAME}-iphonesimulator.xcarchive"
iOS_DEVICE_ARCHIVE_PATH="${BUILD_DIR}/${CONFIGURATION}/${FRAMEWORK_NAME}-iphoneos.xcarchive"
MACOS_ARCHIVE_PATH="${BUILD_DIR}/${CONFIGURATION}/${FRAMEWORK_NAME}-macos.xcarchive"
OUTPUT_DIC="./UniversalFramework/"

# iOS Simulator xcarchive
xcodebuild archive \
  -scheme ${SCHEME_NAME} \
  -archivePath ${iOS_SIMULATOR_ARCHIVE_PATH} \
  -sdk iphonesimulator \
  SKIP_INSTALL=NO
  
# iOS Device xcarchive
xcodebuild archive \
  -scheme ${SCHEME_NAME} \
  -archivePath ${iOS_DEVICE_ARCHIVE_PATH} \
  -sdk iphoneos \
  SKIP_INSTALL=NO
  
# MacOS xcarchive
xcodebuild archive \
  -scheme ${SCHEME_NAME} \
  -archivePath ${MACOS_ARCHIVE_PATH} \
  SKIP_INSTALL=NO
  
## Add WatchOS and TvOS archives if required...

# Clean up old output directory
rm -rf "${OUTPUT_DIC}"
# Create xcframwork combination of all frameworks
xcodebuild -create-xcframework \
  -framework ${iOS_SIMULATOR_ARCHIVE_PATH}/Products/Library/Frameworks/${FRAMEWORK_NAME}.framework \
  -framework ${iOS_DEVICE_ARCHIVE_PATH}/Products/Library/Frameworks/${FRAMEWORK_NAME}.framework \
  -framework ${MACOS_ARCHIVE_PATH}/Products/Library/Frameworks/${FRAMEWORK_NAME}.framework \
  -output ${OUTPUT_DIC}/${FRAMEWORK_NAME}.xcframework
