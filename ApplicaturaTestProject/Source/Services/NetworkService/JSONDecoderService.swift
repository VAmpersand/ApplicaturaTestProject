import UIKit

final class JSONDecoderService { }

extension JSONDecoderService {
    func decodeData<T: Codable>(fron jsonData: Data,
                                with codableStruct: [T].Type) -> [T] {
        var resultData: [T] = []
        
        do {
            resultData = try JSONDecoder().decode(codableStruct.self, from: jsonData)
        } catch {
            print("Error: \(error.localizedDescription)")
        }
        
        return resultData
    }
}
