import Foundation

struct APISecrets {
    static let uid: String = {
        guard let path = Bundle.main.path(forResource: "Secrets", ofType: "plist"),
              let dict = NSDictionary(contentsOfFile: path),
              let value = dict["API_UID"] as? String else {
            fatalError("Secrets.plist not found or API_UID missing. Check Secrets.example.plist.")
        }
        return value
    }()

    static let secret: String = {
        guard let path = Bundle.main.path(forResource: "Secrets", ofType: "plist"),
              let dict = NSDictionary(contentsOfFile: path),
              let value = dict["API_SECRET"] as? String else {
            fatalError("Secrets.plist not found or API_SECRET missing. Check Secrets.example.plist.")
        }
        return value
    }()
}
