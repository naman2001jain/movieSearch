

import Foundation
struct D : Codable {
	let i : MoviePosterImage

	let l : String

	enum CodingKeys: String, CodingKey {

		case i = "i"
		case l = "l"
	}

	

}
