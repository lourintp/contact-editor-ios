//
//  UITextField+TextUnwrapper.swift
//  ContactEditor
//
//  Created by Thiago Lourin on 10/03/23.
//

import UIKit

extension UITextField {
    func unwrappedText() -> String {
        self.text ?? ""
    }
}
