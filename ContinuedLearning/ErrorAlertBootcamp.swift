//
//  ErrorAlertBootcamp.swift
//  ContinuedLearning
//
//  Created by a on 29.11.24.
//

import SwiftUI

protocol AppAlert{
    var title: String{ get }
    var subtitle: String? { get }
    var buttons: AnyView { get }
}

extension View{
    func showCustomAlert<T: AppAlert>(alert: Binding<T?>)->some View{
        self
            .alert(alert.wrappedValue?.title ?? "Error", isPresented: Binding(value: alert)) {
                alert.wrappedValue?.buttons
            }
    }
}

struct ErrorAlertBootcamp: View {
    @State var alert: MyCustomAlert? = nil
    
    var body: some View {
        Button {
            saveData(onOkPressed: {
                print("Ok Pressed")
            })
        } label: {
            Text("Click me")
        }
        .showCustomAlert(alert: $alert)
    }
    
//    enum MyCustomError: Error, LocalizedError{
//        case noInternetConnection
//        case urlError(error: Error)
//        
//        var errorDescription: String?{
//            switch self{
//            case .noInternetConnection:
//                return "Please check your internet connection and try again."
//            case .urlError(error: let error):
//                return "Error: \(error.localizedDescription)"
//            }
//        }
//    }
    
    enum MyCustomAlert: Error, LocalizedError, AppAlert{
        case noInternetConnection(onOkPressed: (()->Void))
        case urlError(error: Error)
        
        var title: String{
            switch self{
            case .noInternetConnection:
                return "No Internet Connection"
            case .urlError(error: _):
                return "False URL"
            }
        }
        
        var subtitle: String?{
            switch self{
            case .noInternetConnection:
                return nil
            case .urlError(error: let error):
                return "Error: \(error.localizedDescription)"
            }
        }
        
        @ViewBuilder
        func getButton4Alert()->some View{
            switch self{
            case .noInternetConnection(let onOKPressed):
                Button("Retry"){
                    onOKPressed()
                }
            case .urlError(error: _):
                Button("Delete", role: .destructive){
                    
                }
            }
        }
        
        var buttons: AnyView{
            AnyView(getButton4Alert())
        }
    }
    
    private func saveData(onOkPressed: @escaping (()->Void)){
        let isSucessful: Bool = false
        
        if isSucessful{
            
        }else{
//            errorTitle = "An error occured"
//            showError.toggle()
            
//            alert = MyCustomAlert.urlError(error: URLError(.badURL))
            alert = MyCustomAlert.noInternetConnection(onOkPressed: {
                onOkPressed()
            })
        }
    }
}

#Preview {
    ErrorAlertBootcamp()
}
