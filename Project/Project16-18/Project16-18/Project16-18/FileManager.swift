//
//  FileManager.swift
//  Project16-18
//
//  Created by Ramanan on 21/02/23.
//

import Foundation

extension FileManager {
    static var documentDirectory: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
