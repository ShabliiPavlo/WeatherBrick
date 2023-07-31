
import Foundation

struct Local_names : Codable {
	let kn : String?
	let ta : String?
	let hi : String?
	let ja : String?

	enum CodingKeys: String, CodingKey {

		case kn = "kn"
		case ta = "ta"
		case hi = "hi"
		case ja = "ja"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		kn = try values.decodeIfPresent(String.self, forKey: .kn)
		ta = try values.decodeIfPresent(String.self, forKey: .ta)
		hi = try values.decodeIfPresent(String.self, forKey: .hi)
		ja = try values.decodeIfPresent(String.self, forKey: .ja)
	}

}
