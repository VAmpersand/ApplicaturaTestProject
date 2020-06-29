import UIKit
import Alamofire

final class NetworkService {
    static let shared = NetworkService()
}

//MARK: - Get
extension NetworkService {
    func getJSONData<T: Codable>(from url: String,
                                 with codableStruct: T.Type,
                                 complition: @escaping (T?, Bool, String) -> Void) {
        DispatchQueue.main.async {
            AF.request(url,
                       method: .get,
                       parameters: nil,
                       encoding: URLEncoding.default,
                       headers: nil,
                       interceptor: nil).response { responseData in
                        
                        guard let data = responseData.data else {
                            complition(nil, false, "Data not received")
                            return
                        }
                        
                        let jsonData = JSONDecoderService.shared.decodeData(fron: data,
                                                                            with: codableStruct.self)
                        complition(jsonData, true, "")
            }
        }
    }
}
