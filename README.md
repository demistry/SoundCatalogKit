# SoundCatalogKit
Framework to match custom audio against a custom reference catalog based on ShazamKit

# Getting Started
This framework simplifies the use of the ShazamKit framework. It abstracts implementation details away from the user and builds ontop ShazamKit 
to offer more development features.

<strong>You can explore a comprehensive documentation on usage by selecting the SoundCatalogKit scheme in Xcode and selecting *Build Documentation*. Alternatively,
you can explore the bundled docc.archive file in the DocumentationDirectory by dragging the file outside the file navigator and clicking it to open it.</strong>

## Requirements
- Xcode 13 and above
- Swift 5.5 and above

## Features

- Match audio from microphone against a custom catalog.
- Generate Signature from an audio file
- Generate a Custom Catalog from an audio file
- Download and use a shazam signature file saved on a remote source such as Google drive/ iCloud
- Download and use a custom catalog file saved on a remote source such as Google drive/ iCloud
- Save a custom catalog file to a specified location
- Save a signature file to a specified location
- Generate signature data from microphone

100% test coverage.

## Other features considered but not implemented due to time/other restraints
- Uploading a signature or catalog file to a remote server. This would enable the user share custom catalogs on the fly with other users. Would have implemented this
if i had more time.
- Adding multiple signatures at once to a custom catalog. This wasnt implemented cause i can't predict the threading implications of adding multiple signatures
to a custom catalog at once across platforms. Would need more information on how signature addition to catalog is done to come up with the best way to implement this.

## Some design compromises
Decided to use async/await instead of closures to enable the download of signature and catalog files from a remote server. I initially wanted to use closures 
to perform this action so as to not force the learning curve of asyncawait onto the end developer. However, due to the instruction on the test to 
*Use the latest Swift features to provide a rich and consistent API* and also considering the fact that the async/await pattern is better structured than closures,
I decided to make use of it for downloading the catalog/signature files.
