//
//  Extensions.swift
//  Gallery
//
//  Created by Георгий on 11.10.2021.
//

import UIKit

extension UILabel {
    func addTrailing(image: UIImage, text: String) {
        let attachment = NSTextAttachment()
        attachment.image = image
        
        let attachmentString = NSAttributedString(attachment: attachment)
        let string = NSMutableAttributedString(string: text, attributes: [:])
        
        string.append(attachmentString)
        self.attributedText = string
    }
}
