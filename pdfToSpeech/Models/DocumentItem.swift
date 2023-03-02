import Foundation

struct DocumentItem: Codable {
    var id = UUID()
    var documentData = Data()
    var documentString = "Empty String"
}
