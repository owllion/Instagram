//
//  NetworkManager.swift
//  AnimalGram
//
//  Created by Zheng yu hsin on 2023/3/1.
//

import Foundation
import UIKit

class NetworkManager: Any {
    
    static func loadData(url: URL, completion: @escaping (UIImage?) -> ()) {
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard let data = data, error == nil else {
                print("jifwjiowejoi")
                completion(nil)
                return
            }
            print("這是data",data)
            completion(UIImage(data: data))
            
        }.resume()
    }
}
