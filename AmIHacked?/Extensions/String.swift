//
//  String.swift
//  AmIHacked?
//
//  Created by PROKHOROV Roman on 23.08.2023.
//

import Foundation

extension String {
    var withourHyperlinks: String {
        var modifiedString = self
            
        // Remove hyperlinks
        let regex = try! NSRegularExpression(pattern: "<a[^>]*>(.*?)</a>", options: .caseInsensitive)
        let range = NSRange(location: 0, length: modifiedString.utf16.count)
        modifiedString = regex.stringByReplacingMatches(in: modifiedString, options: [], range: range, withTemplate: "$1")
        
        // Replace &quot; with real quotation mark
        modifiedString = modifiedString.replacingOccurrences(of: "&quot;", with: "\"")
        
        return modifiedString
    }
}
