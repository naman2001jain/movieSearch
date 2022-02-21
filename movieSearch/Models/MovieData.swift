
import Foundation
struct MovieData : Codable {
	let d : [D]
    let q : String
	enum CodingKeys: String, CodingKey {

		case d = "d"
        case q = "q"
	}


}
