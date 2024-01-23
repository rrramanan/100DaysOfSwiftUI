//
//  ImageSaver.swift
//  Instafilter
//
//  Created by Ramanan on 02/01/23.
//

import SwiftUI

class ImageSaver: NSObject {
    var successHandler: (() -> Void)?
    var errorHandler: ((Error) -> Void)?
    
    func writeToPhotoAlbum(image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveCompleted), nil)
    }
    
    @objc func saveCompleted(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        //print("Save finished!")
        if let error = error {
            errorHandler?(error)
        } else {
            successHandler?()
        }
    }
}
