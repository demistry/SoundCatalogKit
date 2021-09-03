#!/bin/sh

#  CreateXCFramework.sh
#  SoundCatalogKit
#
#  Created by David Ilenwabor on 31/08/2021.
#  

SCHEME_NAME="SoundCatalogKit"
FRAMEWORK_NAME="SoundCatalogKit"

SIMULATOR_ARCHIVE_PATH="${BUILD_DIR}/${CONFIGURATION}/${FRAMEWORK_NAME}-iphonesimulator.xcarchive"
DEVICE_ARCHIVE_PATH="${BUILD_DIR}/${CONFIGURATION}/${FRAMEWORK_NAME}-iphoneos.xcarchive"
OUTPUT_DIC="./xcframework/"

# Simulator xcarchive
xcodebuild archive \
  -scheme ${SCHEME_NAME} \
  -archivePath ${SIMULATOR_ARCHIVE_PATH} \
  -sdk iphonesimulator \
  SKIP_INSTALL=NO
  
# Device xcarchive
xcodebuild archive \
  -scheme ${SCHEME_NAME} \
  -archivePath ${DEVICE_ARCHIVE_PATH} \
  -sdk iphoneos \
  SKIP_INSTALL=NO

# Clean up old output directory
rm -rf "${OUTPUT_DIC}"
# Create xcframwork combine of all frameworks
xcodebuild -create-xcframework \
  -framework ${SIMULATOR_ARCHIVE_PATH}/Products/Library/Frameworks/${FRAMEWORK_NAME}.framework \
  -framework ${DEVICE_ARCHIVE_PATH}/Products/Library/Frameworks/${FRAMEWORK_NAME}.framework \
  -output ${OUTPUT_DIC}/${FRAMEWORK_NAME}.xcframework
