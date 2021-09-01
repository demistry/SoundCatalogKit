//
//  SCSessionProvider.swift
//  SCSessionProvider
//
//  Created by David Ilenwabor on 31/08/2021.
//

import Foundation
import ShazamKit

protocol SCSessionResultDelegate: AnyObject {
    func session(_ session: SHSession, didFind match: SHMatch)
    func session(_ session: SHSession, didNotFindMatchFor signature: SHSignature, error: Error?)
}

class SCSessionResultSource: NSObject, SHSessionDelegate {
    weak var delegate: SCSessionResultDelegate?
    
    override init() {
        super.init()
    }
    
    func session(_ session: SHSession, didFind match: SHMatch) {
        delegate?.session(session, didFind: match)
    }
    
    func session(_ session: SHSession, didNotFindMatchFor signature: SHSignature, error: Error?) {
        delegate?.session(session, didNotFindMatchFor: signature, error: error)
    }
}
