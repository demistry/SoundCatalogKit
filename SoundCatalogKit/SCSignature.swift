//
//  SCSignature.swift
//  SCSignature
//
//  Created by David Ilenwabor on 31/08/2021.
//

import Foundation
import ShazamKit

public class SCSignature: NSObject {
    private(set) var signature: SHSignature
    
    init(signature: SHSignature) {
        self.signature = signature
    }
    
    public init(dataRepresentation data: Data) throws {
        do {
            self.signature = try SHSignature(dataRepresentation: data)
        } catch {
            throw SCError(shError: error, defaultErrorCode: .signatureInvalid)
        }
    }
    
    /// Write this Signature to disk
    /// @discussion A Signature can safely be shared among devices
    /// @note If the `url` is a directory, a file named Signature.shazamsignature will be created
    /// @param url The location to write to
    /// @throws an error on failure to write signature to url
    public func write(to url: URL) throws {
        var destinationURL = url
        if destinationURL.pathExtension != Constants.signatureFileExtension ||
            destinationURL.pathExtension.isEmpty {
            destinationURL.deletePathExtension()
            destinationURL = destinationURL.appendingPathComponent(Constants.defaultSignatureName)
                .appendingPathExtension(Constants.signatureFileExtension)
        }
        do {
            try signature.dataRepresentation.write(to: destinationURL, options: .atomic)
        } catch {
            throw SCError(shError: error, defaultErrorCode: .signatureSaveAttemptFailed)
        }
    }
}

extension SCSignature {
    private enum Constants {
        static let signatureFileExtension = "shazamsignature"
        static let defaultSignatureName = "Signature"
    }
}
