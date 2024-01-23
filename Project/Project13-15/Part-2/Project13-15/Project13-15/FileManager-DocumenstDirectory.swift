//
//  FileManager-DocumenstDirectry.swift
//  Project13-15
//
//  Created by Ramanan on 25/01/23.
//

import Foundation

extension FileManager {
    static var documentsDirectory: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
