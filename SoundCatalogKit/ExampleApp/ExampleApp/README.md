# Getting Started

## Requirements
- Xcode 13 beta 3 and above (*quite necessary as Xcode 13 betas 1 and 2 do not support the latest Task API for asynchronous processing*)
- Swift 5.5 and above

To get started, you can simply clone the repository and run the project.


### Example App
This is a simple 2 screen application that can initialize a custom shazam catalog in a number of ways and match input from a microphone against it. 
After selecting a particular catalog generation method, you can decide to play an audio while matching by enabling the switch button on the top right of the first
screen as shown below.


![](https://user-images.githubusercontent.com/29028996/131989305-5d59ee0b-9b2c-4e13-bf8b-f8416ac56f5e.png)

This app then uses the generated catalog which represents a popular nursery rhyme and matches it against external audio input from the microphone when 
you click on start matching.

![](https://user-images.githubusercontent.com/29028996/131989376-367e7f7c-e54d-497e-90e1-94510ec5efee.png)


Microphone permissions have already been added to the info.plist file. Obtaining this permission from the user is a necessity before matching.
