import Foundation
import SwiftSoup

public extension String {
    // TODO: move somewhere appropriate
    func strippingHTML() -> String {
        if !contains("<") {
            return self
        }
        if let doc = try? SwiftSoup.parse(self) {
            do {
                doc.outputSettings().prettyPrint(pretty: false)
                for rubyTag in try (doc.body() ?? doc).getElementsByTag(UTF8Arrays.ruby) {
                    for tagName in [UTF8Arrays.rp, UTF8Arrays.rt, UTF8Arrays.rtc] {
                        try rubyTag.getElementsByTag(tagName).remove()
                    }
                    let surface = try rubyTag.text(trimAndNormaliseWhitespace: false)
                    
                    try rubyTag.before(surface)
                    try rubyTag.remove()
                }
                return try doc.text(trimAndNormaliseWhitespace: true)
            } catch {
                return escapeHtml()
            }
        } else {
            return escapeHtml()
        }
    }
}
