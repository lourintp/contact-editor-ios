//
//  UITableView+Dequeueing.swift
//  ContactEditor
//
//  Created by Thiago Lourin on 09/03/23.
//

import UIKit

extension UITableView {
    func dequeueReusableCell<T: UITableViewCell>() -> T {
        let identifier = String(describing: T.self)
        return dequeueReusableCell(withIdentifier: identifier) as! T
    }
}
