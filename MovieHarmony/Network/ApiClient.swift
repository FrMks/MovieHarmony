//
//  ApiClient.swift
//  MovieHarmony
//
//  Created by Максим Французов on 19.03.2024.
//

import Foundation


enum ApiError: Error {
    case noData
}

protocol ApiClient {
    func getPairsKeywords(completion: @escaping (Result<[Pair], Error>) -> Void)
    //func getQuestionAnswers(completion: @escaping (Result<[QuestionAnswers], Error>) -> Void)
    func postSelectedKeywords(selectedKeywords: [String], completion: @escaping (Result<[QuestionAnswers], Error>) -> Void)
    func postPostersSendKeywordsWithAnswers(selectedKeywordsWithAnswers: [String], completion: @escaping (Result<[FilmSimilarityResult], Error>) -> Void)
}

class ApiClientImplementation: ApiClient {
    func getPairsKeywords(completion: @escaping (Result<[Pair], Error>) -> Void) {
        let session = URLSession.shared
        
        let url = URL(string: "http://0.0.0.0:8080/keywords")!
        let urlRequest = URLRequest(url: url)
        let dataTask = session.dataTask(with: urlRequest, completionHandler: { data, response, error in
            
            guard let data = data else {
                completion(.failure(ApiError.noData))
                print("completion(.failure(ApiError.noData))")
                return
            }
            //print("data \(data)")
            
            let decoder = JSONDecoder()
            do {
                let pairs = try decoder.decode([Pair].self, from: data) //тип данных, который мы пытаемся задекодировать --- от куда пытаемся
                completion(.success(pairs))
                //print("pairs: \(pairs)")
            } catch(let error) {
                completion(.failure(error))
                print("completion(.failure(error))")
            }
            
        })
        
        dataTask.resume()
        
    }
    
    
//    func getQuestionAnswers(completion: @escaping (Result<[QuestionAnswers], Error>) -> Void) {
//        let session = URLSession.shared
//        
//        let url = URL(string: "http://0.0.0.0:8080/question-answers")!
//        let urlRequest = URLRequest(url: url)
//        let dataTask = session.dataTask(with: urlRequest) { data, response, error in
//            guard let data = data else {
//                completion(.failure(ApiError.noData))
//                print("completion(.failure(ApiError.noData))")
//                return
//            }
//            //            guard let data = data else {
//            //                if let error = error {
//            //                    completion(.failure(error))
//            //                } else {
//            //                    completion(.failure(ApiError.noData))
//            //                }
//            //                return
//            //            }
//            
//            print("data \(data)")
//            
//            let decoder = JSONDecoder()
//            do {
//                let questionAnswers = try decoder.decode([QuestionAnswers].self, from: data)
//                completion(.success(questionAnswers))
//                print("questionAnswers: \(questionAnswers)")
//            } catch {
//                completion(.failure(error))
//                print("completion(.failure(error))")
//            }
//        }
//        
//        dataTask.resume()
//    }
    
    
    func postSelectedKeywords(selectedKeywords: [String], completion: @escaping (Result<[QuestionAnswers], Error>) -> Void) {
        guard let url = URL(string: "http://0.0.0.0:8080/question-answers") else {
            print("Invalid URL")
            completion(.failure(ApiError.noData))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type") //устанавливаем заголовок Content-Type как application/json
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: selectedKeywords, options: []) //преобразуем массив строк в JSON-данные
            request.httpBody = jsonData //устанавливаем JSON-данные в качестве тела запроса
        } catch {
            print("Error serializing JSON:", error)
            completion(.failure(error))
            return
        }
        
        let session = URLSession.shared //создаем сеанс для выполнения запроса
        //создаем задачу URLSessionDataTask для выполнения запроса
        let dataTask = session.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error making request:", error)
                completion(.failure(error))
                return
            }
            
            let decoder = JSONDecoder()
            do {
                let questionAnswers = try decoder.decode([QuestionAnswers].self, from: data!)
                completion(.success(questionAnswers))
                print("questionAnswers: \(questionAnswers)")
            } catch {
                completion(.failure(error))
                print("completion(.failure(error))")
            }
            
        }
        
        //запускаем задачу для выполнения запроса
        dataTask.resume()
    }

    
    func postPostersSendKeywordsWithAnswers(selectedKeywordsWithAnswers: [String],
                                            completion: @escaping (Result<[FilmSimilarityResult], Error>) -> Void) { //для постеров нужен String
        
        guard let url = URL(string: "http://0.0.0.0:8080/posters") else {
            print("Invalid URL")
            completion(.failure(ApiError.noData))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: selectedKeywordsWithAnswers, options: [])
            request.httpBody = jsonData
        } catch {
            print("Error serializing JSON:", error)
            completion(.failure(error))
            return
        }
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error making request:", error)
                completion(.failure(error))
                return
            }
            
            
            let decoder = JSONDecoder()
            if let dataTest = data {
                print(dataTest)
                do {
                    let filmSimilarityResult = try decoder.decode([FilmSimilarityResult].self, from: data!) //для постеров нужен String
                    completion(.success(filmSimilarityResult))
                    print("posters: \(filmSimilarityResult)")
                } catch {
                    completion(.failure(error))
                    print("completion(.failure(error))")
                }
            }
            
        }
        dataTask.resume()
    }
}
