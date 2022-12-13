//
//  main.swift
//  FrameMe
//
//  Created by Josh Luongo on 13/12/2022.
//

import Foundation
import CoreImage
import Cocoa
import os.log

guard let backImage = CGImage.loadImage(filename: "frame.png") else {
    print("ERROR: A Bad Image")
    exit(1)
}

guard let frontImage = CGImage.loadImage(filename: "shot.png") else {
    print("ERROR: B Bad Image")
    exit(1)
}

let manger = CompositeImage()

let test = manger.create(frame: backImage, screenshot: frontImage)
test?.writeCGImage(URL(string: "file:///Users/josh/Downloads/test.png")!)
