//
//  BreachModel.swift
//  AmIHacked?
//
//  Created by PROKHOROV Roman on 12.09.2022.
//

import UIKit

struct BreachModel: Decodable, Identifiable, Equatable {
    var id = UUID()
    /// A Pascal-cased name representing the breach which is unique across all other breaches. This value never changes and may be used to name dependent assets (such as images) but should not be shown directly to end users (see the "Title" attribute instead).
    let name: String
    /// A descriptive title for the breach suitable for displaying to end users. It's unique across all breaches but individual values may change in the future (i.e. if another breach occurs against an organisation already in the system). If a stable value is required to reference the breach, refer to the "Name" attribute instead.
    let title: String
    /// The domain of the primary website the breach occurred on. This may be used for identifying other assets external systems may have for the site.
    let domain: String
    /// The date (with no time) the breach originally occurred on in ISO 8601 format. This is not always accurate — frequently breaches are discovered and reported long after the original incident. Use this attribute as a guide only.
    let breachData: String
    /// The date and time (precision to the minute) the breach was added to the system in ISO 8601 format.
    let addedData: String
    /// The date and time (precision to the minute) the breach was modified in ISO 8601 format. This will only differ from the AddedDate attribute if other attributes represented here are changed or data in the breach itself is changed (i.e. additional data is identified and loaded). It is always either equal to or greater then the AddedDate attribute, never less than.
    let modifiedDate: String
    /// The total number of accounts loaded into the system. This is usually less than the total number reported by the media due to duplication or other data integrity issues in the source data.
    let pwnCount: Int
    /// Contains an overview of the breach represented in HTML markup. The description may include markup such as emphasis and strong tags as well as hyperlinks.
    let description: String
    /// This attribute describes the nature of the data compromised in the breach and contains an alphabetically ordered string array of impacted data classes.
    let dataClasses: [String]
    /// Indicates that the breach is considered unverified. An unverified breach may not have been hacked from the indicated website. An unverified breach is still loaded into HIBP when there's sufficient confidence that a significant portion of the data is legitimate.
    let isVerified: Bool
    /// Indicates that the breach is considered fabricated. A fabricated breach is unlikely to have been hacked from the indicated website and usually contains a large amount of manufactured data. However, it still contains legitimate email addresses and asserts that the account owners were compromised in the alleged breach.
    let isFabricated: Bool
    /// Indicates if the breach is considered sensitive. The public API will not return any accounts for a breach flagged as sensitive.
    let isSensitive: Bool
    /// Indicates if the breach has been retired. This data has been permanently removed and will not be returned by the API.
    let isRetired: Bool
    /// Indicates if the breach is considered a spam list. This flag has no impact on any other attributes but it means that the data has not come as a result of a security compromise.
    let isSpamList: Bool
    /// A URI that specifies where a logo for the breached service can be found. Logos are always in PNG format.
    let logoPath: String
    
    enum CodingKeys: String, CodingKey {
        case name = "Name"
        case title = "Title"
        case domain = "Domain"
        case breachData = "BreachDate"
        case addedData = "AddedDate"
        case modifiedDate = "ModifiedDate"
        case pwnCount = "PwnCount"
        case description = "Description"
        case dataClasses = "DataClasses"
        case isVerified = "IsVerified"
        case isFabricated = "IsFabricated"
        case isSensitive = "IsSensitive"
        case isRetired = "IsRetired"
        case isSpamList = "IsSpamList"
        case logoPath = "LogoPath"
    }
}
