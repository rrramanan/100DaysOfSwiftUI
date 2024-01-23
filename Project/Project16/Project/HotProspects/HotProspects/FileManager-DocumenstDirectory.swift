//
//  FileManager-DocumenstDirectory.swift
//  HotProspects
//
//  Created by Ramanan on 03/02/23.
//

import Foundation

extension FileManager {
    static var documentDirectory: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
