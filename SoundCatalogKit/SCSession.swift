//
//  SCSession.swift
//  SoundCatalogKit
//
//  Created by David Ilenwabor on 31/08/2021.
//

import ShazamKit

protocol SCSessionProtocol {
    func startMatch()
    func stopMatch()
}

public class SCSession: SCSessionProtocol {
    private var session: SHSession
    
    public init() {
        session = SHSession()
    }
    
    public func startMatch() {
        
    }
    
    public func stopMatch() {
        
    }
}
