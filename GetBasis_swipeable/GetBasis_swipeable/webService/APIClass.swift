//
//  APIClass.swift
//  GetBasis_swipeable
//
//  Created by TalentMicro on 21/04/20.
//  Copyright © 2020 GetBasis. All rights reserved.
//

// MARK:- Network Hnadler 

import UIKit
import Foundation
public class APIClass: NSObject {
    
    static let apiInstance = APIClass()
     func getApi<T:Codable>(urlString:String,model:T.Type,completion:@escaping (Result<T, Error>) -> (Void))  {
         
    let session = URLSession.shared
       let url = URL(string: urlString)!
       let task = session.dataTask(with: url, completionHandler: { data, response, error in
          
           // Check if an error occured
           if error != nil {
            completion(.failure(error!))
               // HERE you can manage the error
            //   print(error)
               return
           }
           // Serialize the data into an object
           
            var stringObj:String = String(data: data!, encoding: .utf8)!
            
            if stringObj.first == "/"{
                stringObj = String(stringObj.dropFirst())
                let dataCorrection  = Data(stringObj.utf8)
                do{
                    let dataObj = try JSONDecoder().decode(T.self, from: dataCorrection)
                    completion(.success(dataObj))
                }catch {
                    completion(.failure(error))
                    //print("Error during JSON serialization: \(error.localizedDescription)")
                }
                
            }else{
                do{
                    let dataObj = try JSONDecoder().decode(T.self, from: data! )
                    completion(.success(dataObj))
                }catch {
                      completion(.failure(error))
                  //  print("Error during JSON serialization: \(error.localizedDescription)")
                }
                
            }
            
       })
       task.resume()

    }
    
}
