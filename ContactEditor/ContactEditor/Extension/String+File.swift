//
//  String+File.swift
//  ContactEditor
//
//  Created by Thiago Lourin on 07/03/23.
//

import Foundation

extension String {
    func fileName() -> String {
        return URL(filePath: self).deletingPathExtension().lastPathComponent
    }
    
    func fileExtension() -> String {
        return URL(filePath: self).pathExtension
    }
    
    func fileNameWithExtension() -> String {
        return fileName().appending(".").appending(fileExtension())
    }
}
