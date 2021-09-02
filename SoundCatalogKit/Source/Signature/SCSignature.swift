//
//  SCSignature.swift
//  SCSignature
//
//  Created by David Ilenwabor on 31/08/2021.
//

import Foundation
import ShazamKit

/// An object that contains the opaque data and other information for a signature.
/// 
/// Save your signature to a file and share it with others by writing the data to a file. You can use the saved signatures of reference recordings to populate a custom catalog.
public class SCSignature: NSObject {
    private(set) var signature: SHSignature
    
    /// The duration of the audio you use to generate the signature.
    public var duration: TimeInterval {
        return signature.duration
    }
    
    /// The raw data for the signature.
    public var dataRepresentation: Data {
        return signature.dataRepresentation
    }
    
    init(signature: SHSignature) {
        self.signature = signature
    }
    
    /// Creates a signature object from raw data.
    public init(dataRepresentation data: Data) throws {
        do {
            self.signature = try SHSignature(dataRepresentation: data)
        } catch {
            throw SCError(shError: error, defaultErrorCode: .signatureInvalid)
        }
    }
    
    /// Write this Signature to disk.
    /// A Signature can safely be shared among devices.
    /// If the `url` is a valid directory, a file named Signature.shazamsignature will be created.
    /// - Parameters:
    ///     - url: The location to write to.
    /// - Throws: an error on failure to write signature to url.
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
