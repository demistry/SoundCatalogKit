//
//  ActionsDetailsViewController.swift
//  ExampleApp
//
//  Created by David Ilenwabor on 03/09/2021.
//

import AVFAudio
import UIKit
import SoundCatalogKit

struct MatchResult {
    var mediaItem: SCMediaItem?
    var sharkState: SharkState?
}

class ActionsDetailsViewController: UIViewController {
    private var result = MatchResult(mediaItem: nil, sharkState: nil) {
        didSet {
            imageView.image = result.sharkState?.image
            storyLabel.text = result.sharkState?.title
        }
    }
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var storyLabel: UILabel!
    
    var action: FrameworkActions!
    var playAudioWhenMatchStarts: Bool = true
    private var session: SCSession?
    private var audioPlayer: AVAudioPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        session?.stopMatching()
        audioPlayer?.stop()
    }
    
    @IBAction func startMatching(_ sender: Any) {
        if let session = session, session.isMatching {
            session.stopMatching()
            audioPlayer?.stop()
            return
        }
        
        Task {
            if let catalog = try await CatalogProvider.catalog(state: action) {
                session = SCSession(catalog: catalog)
                session?.delegate = self
                if playAudioWhenMatchStarts {
                    try? AVAudioSession.sharedInstance().setCategory(.playAndRecord)
                    audioPlayer = try? AVAudioPlayer(contentsOf: Bundle.main.url(forResource: "BabyShark", withExtension: "m4a")!)
                    audioPlayer?.prepareToPlay()
                    AVAudioSession.sharedInstance().requestRecordPermission { [weak self] success in
                        guard success, let self = self else { return }
                        self.session?.startMatching()
                        self.audioPlayer?.play()
                    }
                } else {
                    try? AVAudioSession.sharedInstance().setCategory(.record)
                    AVAudioSession.sharedInstance().requestRecordPermission { [weak self] success in
                        guard success, let self = self else { return }
                        self.session?.startMatching()
                    }
                }
            }
        }
        
    }
    @IBAction func stopMatching(_ sender: Any) {
        if let session = session, session.isMatching {
            session.stopMatching()
            audioPlayer?.stop()
        }
    }
}

extension ActionsDetailsViewController: SCSessionDelegate {
    func session(_ session: SCSession, didFind match: SCMatch) {
        DispatchQueue.main.async {
            
            // Find the Shark from all the sharks that we want to show.
            // In this example, use the last Shark that's after the current match offset.
            let newState = SharkState.allSharks.last { sharkState in
                (match.mediaItems.first?.predictedCurrentMatchOffset ?? 0) > sharkState.offset
            }

            // Filter out similar shark objects in case of similar matches and update matchResult.
            if let currentQuestion = self.result.sharkState, currentQuestion == newState {
                return
            }
            self.result = MatchResult(mediaItem: match.mediaItems.first, sharkState: newState)
        }
    }
    
    func sessionDidStartMatch(_ session: SCSession) {
        print("MATCH STARTED")
    }
    
    func sessionDidStopMatch(_ session: SCSession) {
        print("MATCH STOPPED")
    }
    
    func session(_ session: SCSession, failedToMatchDueTo error: Error) {
        print("MATCH FAILED DUE TO: \(error)")
    }
}
