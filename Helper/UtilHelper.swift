import Foundation


class UtilHelper{

    static let shared = UtilHelper()

    func getBunleByKeyId(keyValue: String) -> String{
        return Bundle.main.infoDictionary?[keyValue] as? String
    }
}