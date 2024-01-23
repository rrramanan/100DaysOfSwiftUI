//
//  FileManager-DocumenstDirectry.swift
//  BucketList
//
//  Created by Ramanan on 12/01/23.
//

import Foundation

extension FileManager {
    static var documentsDirectory: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
