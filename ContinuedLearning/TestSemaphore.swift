//
//  TestSemaphore.swift
//  ContinuedLearning
//
//  Created by a on 23.08.24.
//

import SwiftUI

struct TestSemaphore: View {
    func someFunc(num: Int, completion: (()->Void)){
        print("Executed\(num)")
        completion()
    }
    
    var body: some View {
        Button("Button1") {
            let group = DispatchGroup()

            for i in 1...3 {
                DispatchQueue.global().async(group: group) {
                    print("Task \(i) started")
                    sleep(2) // Simulate work
                    print("Task \(i) finished")
                }
            }
            // sequence could be 132 or 231

            group.notify(queue: .main) {
                print("All tasks completed")
            }
        }
        
        
        // in the same time execute only two of the tasks
        Button("Button2") {
            let semaphore = DispatchSemaphore(value: 2) // Limit to 2 concurrent tasks

            for i in 1...5 {
                DispatchQueue.global().async {
                    semaphore.wait() // Wait until there's an available "slot"
                    print("Task \(i) started")
                    sleep(2) // Simulate work
                    print("Task \(i) finished")
                    semaphore.signal() // Release the "slot"
                }
            }
        }
        
        Button("Button3"){
            let semaphore = DispatchSemaphore(value: 0)

            DispatchQueue.global().async {
                print("Task 1: Performing some setup work...")
                sleep(2) // Simulate setup work
                print("Task 1: Setup complete, signaling semaphore.")
                semaphore.signal() // Unblock waiting task
            }

            DispatchQueue.global().async {
                print("Task 2: Waiting for setup to complete...")
                semaphore.wait() // This will block until Task 1 signals
                print("Task 2: Setup complete, proceeding with task.")
            }
        }
    }
}

#Preview {
    TestSemaphore()
}
