//
//  ContentView.swift
//  NavigationStackAndTabs
//
//  Created by Dyani on 3/6/24.
//

import SwiftUI

struct ContentView: View {
    @State var currentTab: Tab = .home
    
    //기본 탭뷰가 터치가 안되게끔 하는법
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    
    var body: some View {
        ZStack(alignment: .bottom) {
            TabView(selection: $currentTab) {
                Text("홈뷰")
                    .tag(Tab.home)
                Text("게시판뷰")
                    .tag(Tab.forum)
                Text("스터디뷰")
                    .tag(Tab.study)
                Text("프로필뷰")
                    .tag(Tab.profile)
            }
        }
        
        CustomTabView(currentTab: $currentTab)
        
    }
}

#Preview {
    ContentView()
}
