//
//  ContentView.swift
//  TakeAttendanceIOS
//
//  Created by yusuf on 4.05.2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
            TabView{
                StudentTaken()
                    .tabItem {
                        Label("Yoklama Al", systemImage: "person.fill.questionmark")
                    }
                    
                StudentAdd(textName: "")
                    .tabItem {
                        Label("Öğrenci Ekle", systemImage: "person.badge.plus.fill")
                            
                    }
                    
            }
        
    }
}

#Preview {
    ContentView()
}
