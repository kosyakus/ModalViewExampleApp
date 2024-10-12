//
//  NSAttributedString+Extension.swift
//  AppForReelSwiftUI
//
//  Created by Natalia Sinitsyna on 12.10.2024.
//

import UIKit

extension NSAttributedString {
    convenience init(htmlAttributedStringColorNeuroowl: UIColor, font: UIFont, text: String) {
        // let fontWeight = "\(font.xHeight)"
        let fontWeight = font.fontDescriptor.object(forKey: .face) as? String ?? "\(font.xHeight)"
        let htmlTemplate = """
                                      <!doctype html>
                                      <html>
                                        <head>
                                          <style>
                                            body {
                                              color: \(htmlAttributedStringColorNeuroowl.hexString);
                                              font-family: '-apple-system', '\(font.familyName)', '\(font.fontName)';
                                              font-size: \(font.pointSize)px;
                                              font-weight: \(fontWeight);
                                              text-align: center;
                                            }
                                          </style>
                                        </head>
                                        <body>
                                          \(text)
                                        </body>
                                      </html>
                                      """
        
        var attributedText: NSAttributedString?
        
        if let data = htmlTemplate.data(using: String.Encoding.unicode, allowLossyConversion: true) {
            let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.unicode.rawValue]
            attributedText = try? NSAttributedString(data: data, options: options, documentAttributes: nil)
        }
        
        if let attributedString = attributedText {
            self.init(attributedString: attributedString)
        }
        else {
            self.init(string: "")
        }
    }
}
