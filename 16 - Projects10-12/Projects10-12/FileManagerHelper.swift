//
//  FileManagerHelper.swift
//  Projects10-12
//
//  Created by leticia.dayane on 04/03/24.
//

import Foundation

class FileManagerHelper {
    static func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
