//
//  CGImage+Loader.swift
//  FrameMe
//
//  Created by Josh Luongo on 14/12/2022.
//

import Foundation
import CoreImage

extension CGImage {
    
    /// Load an image to a CGImage.
    ///
    /// - Parameter filename: File path.
    /// - Returns: CGImage
    static func loadImage(filename: String) -> CGImage? {
        guard let cgDataProvider = CGDataProvider(filename: filename) else {
            return nil
        }
        
        return CGImage(pngDataProviderSource: cgDataProvider, decode: nil, shouldInterpolate: true, intent: .defaultIntent)
    }
    
}
