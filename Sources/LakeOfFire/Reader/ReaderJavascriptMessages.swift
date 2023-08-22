import Foundation
import SwiftUIWebView
import RealmSwift

public struct NestedDOMRootSelector {
    public let layer0FrameSelector: String?
    public let layer1ShadowRootSelector: String?
    public let layer2ShadowRootSelector: String?
    
    public init?(layer0FrameSelector: String?, layer1ShadowRootSelector: String?, layer2ShadowRootSelector: String?) {
        guard layer1ShadowRootSelector != nil || layer0FrameSelector != nil else {
            return nil
        }
        self.layer0FrameSelector = layer0FrameSelector
        self.layer1ShadowRootSelector = layer1ShadowRootSelector
        self.layer2ShadowRootSelector = layer2ShadowRootSelector
    }
}

public struct ReadabilityParsedMessage {
    public let pageURL: URL?
    public let windowURL: URL?
    public let readabilityContainerSelector: String?
    public let readabilityContainerRootSelector: NestedDOMRootSelector?
    public let title: String
    public let byline: String
    public let content: String
    public let inputHTML: String
    public let outputHTML: String
    
    public init?(fromMessage message: WebViewMessage) {
        guard let body = message.body as? [String: Any] else { return nil }
        pageURL = URL(string: body["pageURL"] as! String)
        windowURL = URL(string: body["windowURL"] as! String)
        
        readabilityContainerSelector = body["readabilityContainerSelector"] as? String
        readabilityContainerRootSelector = NestedDOMRootSelector(
            layer0FrameSelector: body["layer0FrameSelector"] as? String,
            layer1ShadowRootSelector: body["layer1ShadowRootSelector"] as? String,
            layer2ShadowRootSelector: body["layer2ShadowRootSelector"] as? String)
        
        title = body["title"] as! String
        byline = body["byline"] as! String
        content = body["content"] as! String
        inputHTML = body["inputHTML"] as! String
        outputHTML = body["outputHTML"] as! String
    }
}

public struct TitleUpdatedMessage {
    public let newTitle: String
    public let url: URL?
    
    public init?(fromMessage message: WebViewMessage) {
        guard let body = message.body as? [String: Any] else { return nil }
        newTitle = body["newTitle"] as! String
        url = URL(string: body["url"] as! String)
    }
}

public struct YoutubeCaptionsMessage {
    public enum Status: String {
        case idle = "idle"
        case loading = "loading"
        case available = "available"
        case unavailable = "unavailable"
    }
    
//    public let rssURLs: [[String]]
    
    public init?(fromMessage message: WebViewMessage) {
        guard let body = message.body as? [String: Any] else { return nil }
//        rssURLs = body["rssURLs"] as! [[String]]
    }
}

public struct RSSURLsMessage {
    public let rssURLs: [[String]]
    
    public init?(fromMessage message: WebViewMessage) {
        guard let body = message.body as? [String: Any] else { return nil }
        rssURLs = body["rssURLs"] as? [[String]] ?? []
    }
}
