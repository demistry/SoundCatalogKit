# ``SoundCatalogKit``

A framework for providing custom audio recognition functionality based on ShazamKit. Find information about a specific audio recording when a segment of that recording is part of captured sound.

## Overview

SoundCatalogKit uses the unique acoustic signature of an audio recording to find a match. This signature captures the time-frequency distribution of the audio signal energy, and is much smaller than the original audio. It’s also a one-way conversion, so it’s not possible to convert the signature back to the recording.

SoundCatalogKit generates a reference signature for each searchable full audio recording. A catalog stores the reference signatures and their associated metadata, or media items.

The simple matter of matching audio from the microphone against a custom catalog is outlined in the snippet below:

```swift
class ViewController: UIViewController {
    // Create the custom catalog and add signatures using any of the available add methods
    let customCatalog = SCCustomCatalog()

    // Create the Session
    let session = SCSession

    // Set the session's delegate
    session.delegate = self

    // Obtain necessary microphone permissions as needed then call
    session.startMatching()
}
```
Call `session.stopMatching()` to stop matching against the audio stream from the microphone

> Note: Ensure you obtain necessary microphone permissions from the user before calling `session.startMatching()`

## Topics

### Match Audio

- ``SCSession``

An object that manages matching a specific audio recording when a segment of that recording is part of captured sound from an input audio stream such as a microphone.

- ``SCSessionDelegate``

Methods that the session calls with the result of a match request.

- ``SCMatch``

An object that represents the catalog media items that match a query.

- ``SCMatchedMediaItem``

An object that represents the metadata for a matched reference signature.

- ``SCMediaItem``

An object that represents the metadata for a reference signature.

- ``SCMediaItemProperty``

Constants for the media item property names.


### Create a Signature from Audio

- ``SCSignature``

An object that contains the opaque data and other information for a signature.

- ``SCSignatureGenerator``

An object for converting audio data into a signature.

- ``SCSignatureGeneratorDelegate``

Used to send information on any error that occurs when generating a signature from an audio stream

### Generate Custom Catalog

- ``SCCustomCatalog``

An object for storing the reference signatures for custom audio recordings and their associated metadata.

- ``SCCatalog``

Base protocol for storing reference signatures and their associated metadata.

### Errors

- ``SCError``

An error type that you create, or the system creates, to indicate problems with a catalog, match attempt, or signature.

- ``SCErrorCode``

Codes for the errors that SoundCatalogKit produces.


