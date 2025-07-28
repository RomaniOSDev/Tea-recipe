
import Foundation


struct CheckURLService {
    
    static let link = URL(string: "https://app67iosserver.space/29K9SD")
    
    static  func checkURLStatus( completion: @escaping (Bool) -> Void) {
        guard let url = link  else {
            print("Invalid URL")
            completion(false)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { _, response, error in
            if let error = error {
                print("Error url: \(error.localizedDescription)")
                completion(false)
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode != 404 {
                    print("code is not 404")
                    completion(true)
                    
                } else {
                    print("code is 404")
                    completion(false)
                }
            } else {
                
                completion(false)
            }
        }
        
        task.resume()
    }
    
    
}
