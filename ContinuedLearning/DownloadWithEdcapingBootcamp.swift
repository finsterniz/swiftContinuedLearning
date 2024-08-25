//
//  DownloadWithEdcapingBootcamp.swift
//  ContinuedLearning
//
//  Created by a on 25.08.24.
//

import SwiftUI

struct PostModel: Identifiable, Codable {
    let userId, id: Int
    let title, body: String
}


class DownloadWithEscapingViewModel: ObservableObject{
    
    @Published var posts: [PostModel] = []
    
    init(){
        getPosts()
    }
    
    func getPosts(){
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
        
        downloadData(fromURL: url) { returnedData in
            if let data = returnedData{
                guard let newPost = try? JSONDecoder().decode([PostModel].self, from: data) else{
                    print("failed to decode")
                    return
                }
                
                DispatchQueue.main.async{ [weak self] in
                    self?.posts.append(contentsOf: newPost)
                    print(newPost)
                }
            }else{
                print("No data returned")
            }
        }
    }
    
    func downloadData(fromURL url: URL, completion: @escaping (_ data: Data?) -> Void){
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data,
                  error == nil,
                  let response = response as? HTTPURLResponse ,
                  response.statusCode >= 200 && response.statusCode < 300
            else{
                print("Error downloading data.")
                completion(nil)
                return
            }
            completion(data)
        }.resume()
    }
}

struct DownloadWithEdcapingBootcamp: View {
    @StateObject var vm = DownloadWithEscapingViewModel()
    
    var body: some View {
        List{
            ForEach(vm.posts){post in
                VStack{
                    Text(post.title)
                        .font(.headline)
                    Text(post.body)
                        .foregroundStyle(.gray)
                }
            }
        }
    }
}

#Preview {
    DownloadWithEdcapingBootcamp()
}
