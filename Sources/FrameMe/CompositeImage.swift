//
//  CompositeImage.swift
//  FrameMe
//
//  Created by Josh Luongo on 13/12/2022.
//

import Foundation
import CoreImage
import ImageIO
import CoreGraphics

class CompositeImage {
    
    /// Create a composite image from a frame and a screenshot.
    ///
    /// - Parameters:
    ///   - frame: Device Frame
    ///   - screenshot: Screenshot
    /// - Returns: Composited Result
    func create(frame: CGImage, screenshot: CGImage) -> CGImage? {
        // Start a context
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedLast.rawValue)
        let context = CGContext(data: nil, width: frame.width, height: frame.height, bitsPerComponent: 8, bytesPerRow: 0, space: colorSpace, bitmapInfo: bitmapInfo.rawValue)
                                
        // Draw screenshot
        
        // Find position for the screenshot.
        if let screenshotPostion = frame.findContentBox(ref: CGPoint(x: frame.width / 2, y: frame.height / 2)) {
            // Put the screenshot in position
            context?.draw(self.clipImage(mask: frame, image: screenshot, frame: screenshotPostion)!, in: CGRect(origin: CGPoint.zero, size: CGSize(width: frame.width, height: frame.height)))
        } else {
            // Not able to find the postion... Use center.
            context?.draw(self.clipImage(mask: frame, image: screenshot)!, in: CGRect(origin: CGPoint.zero, size: CGSize(width: frame.width, height: frame.height)))
        }
                
        // Draw the device frame.
        context?.draw(frame, in: CGRect(origin: CGPoint.zero, size: CGSize(width: frame.width, height: frame.height)))
               
        return context?.makeImage()
    }
    
    
    /// Clip an image to a mask.
    ///
    /// - Parameters:
    ///   - mask: The mask.
    ///   - image: The image.
    ///   - frame: The frame to use for the screenshot.
    /// - Returns: Clipped image.
    func clipImage(mask: CGImage, image: CGImage, frame: CGRect? = nil) -> CGImage? {
        // Start a context
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedLast.rawValue)
        let context = CGContext(data: nil, width: mask.width, height: mask.height, bitsPerComponent: 8, bytesPerRow: 0, space: colorSpace, bitmapInfo: bitmapInfo.rawValue)
                
        // Create the outer matte.
        if let mask = mask.createOuterMatte() {
            // Apply the matte
            context?.clip(to: CGRect(x: 0, y: 0, width: mask.width, height: mask.height), mask: mask)
        }
        
        // Draw screenshot.
        context?.draw(image, in: frame ?? CGRect(origin: CGPoint(x: ((mask.width - image.width) / 2), y: ((mask.height - image.height) / 2)), size: CGSize(width: image.width, height: image.height)))
        
        return context?.makeImage()
    }
    
}
