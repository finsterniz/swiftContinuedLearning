//
//  CodableBootcamp.swift
//  ContinuedLearning
//
//  Created by a on 24.08.24.
//

import SwiftUI

struct CustomerModel : Decodable, Encodable{
    let id: String
    let name: String
    let points: Int
    let isPremium: Bool
    
    enum CodingKeys: String, CodingKey{
        case id
        case name
        case points
        case isPremium
    }
    init(id: String, name: String, points: Int, isPremium: Bool) {
        self.id = id
        self.name = name
        self.points = points
        self.isPremium = isPremium
    }
    
    init(from decoder: Decoder) throws{
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.points = try container.decode(Int.self, forKey: .points)
        self.isPremium = try container.decode(Bool.self, forKey: .isPremium)
    }
    
    func encode(to encoder: Encoder) throws{
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(points, forKey: .points)
        try container.encode(isPremium, forKey: .isPremium)
    }
}

class CodableViewModel: ObservableObject {
    @Published var customer: CustomerModel? = nil
    
    init() {
        getData()
    }
    
    func getData(){
        guard let data = getJSONData() else { return }
        
        do{
            self.customer = try JSONDecoder().decode(CustomerModel.self, from: data)
        }catch{
            print("Error decoding \(error)")
        }
        
//        if let localData = try? JSONSerialization.jsonObject(with: data, options: []), let dictionary = localData as? [String: Any],
//           let id = dictionary["id"] as? String,
//           let name = dictionary["name"] as? String,
//           let points = dictionary["points"] as? Int,
//           let isPremium = dictionary["isPremium"] as? Bool{
//            
//            let newCustomer = CustomerModel(id: id, name: name, points: points, isPremium: isPremium)
//            customer = newCustomer
//        }
        
//        self.customer = try? JSONDecoder().decode(CustomerModel.self, from: data)
        
    }
    
    func getJSONData() -> Data?{
//        let dictionary: [String:Any] = [
//            "id" : "12345",
//            "name": "Joe",
//            "points" : 5,
//            "isPremium" : true
//        ]
        
        let costomer = CustomerModel(
            id: "823947982137",
            name: "Emily",
            points: 20,
            isPremium: false
        )
        
        let jsonData = try? JSONEncoder().encode(costomer)
        
//        let jsonData = try? JSONSerialization.data(withJSONObject: dictionary, options: [])
        return jsonData
    }
}


struct CodableBootcamp: View {
    @StateObject var vm = CodableViewModel()

    var body: some View {
        VStack{
            if let customer = vm.customer{
                Text(customer.id)
                Text(customer.name)
                Text(customer.points.description)
                Text(customer.isPremium.description)
            }
        }
    }
}

fileprivate struct CodableBootcamp_Previews: View {
    var body: some View{
        CodableBootcamp()
    }
}

#Preview {
    CodableBootcamp_Previews()
}

