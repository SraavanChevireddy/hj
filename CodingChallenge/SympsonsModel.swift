//
//  SympsonsModel.swift
//  CodingChallenge
//
//  Created by Sraavan Chevireddy on 19/05/23.
//

import Foundation

struct SympsonsModel: Codable {
    let relatedTopics: [RelatedTopic]?

    enum CodingKeys: String, CodingKey {
        case relatedTopics = "RelatedTopics"
    }
}

struct RelatedTopic: Codable {
    let firstURL: String?
    let icon: Icon?
    let result, text: String?

    enum CodingKeys: String, CodingKey {
        case firstURL = "FirstURL"
        case icon = "Icon"
        case result = "Result"
        case text = "Text"
    }
}

// MARK: - Icon
struct Icon: Codable {
    let height, width: String?
    var url: String? {
        didSet {
            if let url = url, !url.isEmpty {
                print("Not empty")
            }
        }
    }

    enum CodingKeys: String, CodingKey {
        case height = "Height"
        case url = "URL"
        case width = "Width"
    }
}
