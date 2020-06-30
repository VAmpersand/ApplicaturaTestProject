import UIKit

final class JSONDecoderService {
    static let shared = JSONDecoderService()
}

extension JSONDecoderService {
    func decodeData<T: Codable>(fron jsonData: Data,
                                with codableStruct: T.Type) -> T? {        
        do {
            let resultData = try JSONDecoder().decode(codableStruct.self, from: jsonData)
            return resultData
        } catch {
            print("Error: \(error.localizedDescription)")
        }
        
        return nil
    }
    
    func decodeCityData(from data: Data) -> [CityData] {
        do {
            let decoder = JSONDecoder(
                context: CoreDataService.shared.persistentContainer.viewContext
            )
            
            let resultData = try decoder.decode([CityData].self, from: data)
            return resultData
        } catch {
            print("Error: \(error.localizedDescription)")
        }
        return []
    }
}
