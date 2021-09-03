# Getting Started

## Requirements
- Xcode 13 beta 3 and above (*quite necessary as Xcode 13 betas 1 and 2 do not support the latest Task API for asynchronous processing*)
- Swift 5.5 and above

To get started, you can simply clone the repository and run the project.


### Example App
This is a simple 2 screen application that can initialize a custom shazam catalog in a number of ways and match input from a microphone against it. 
After selecting a particular catalog generation method, you can decide to play an audio while matching by enabling the switch button as shown below.

![](https://user-images.githubusercontent.com/29028996/131990851-dcbb7269-8d2d-44ed-b4ae-39df299d30bb.png)


The app then uses the generated catalog which represents a popular nursery rhyme and matches it against external audio input from the microphone when 
you click on start matching.

Microphone permissions have already been added to the info.plist file. Obtaining this permission from the user is a necessity before matching.
