
import Foundation
struct MoviePosterImage : Codable {
	let height : Int
	let imageUrl : String
	let width : Int

	enum CodingKeys: String, CodingKey {

		case height = "height"
		case imageUrl = "imageUrl"
		case width = "width"
	}

	

}
