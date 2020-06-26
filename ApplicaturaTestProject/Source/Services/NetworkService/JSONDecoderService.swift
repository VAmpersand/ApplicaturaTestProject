import UIKit

final class JSONDecoderService {
    static let shared = JSONDecoderService()
}

extension JSONDecoderService {
    func decodeData<T: Codable>(fron jsonData: Data,
                                with codableStruct: [T].Type) -> [T]? {        
        do {
            let resultData = try JSONDecoder().decode(codableStruct.self, from: jsonData)
            return resultData
        } catch {
            print("Error: \(error.localizedDescription)")
        }
        
        return nil
    }
    
    func saveCityDataToCoreData(fron jsonData: Data){
        do {
            let decoder = JSONDecoder(
                context: CoreDataManager.shared.persistentContainer.viewContext
            )

            let resultData = try decoder.decode([CityData].self, from: jsonData)
            CoreDataManager.shared.saveInCoreDataWith(array: resultData)

        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
}
