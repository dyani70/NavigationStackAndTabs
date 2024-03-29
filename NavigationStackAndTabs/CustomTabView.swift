//
//  CustomTabView.swift
//  NavigationStackAndTabs
//
//  Created by Dyani on 3/6/24.
//

import SwiftUI

//탭 모델 만들기
enum Tab: String, CaseIterable {
    case home = "house.fill"
    case forum = "message.fill"
    case study = "folder.fill"
    case profile = "person.circle.fill"
    
    var titleText: String {
        switch self {
        case .home: return "홈"
        case .forum: return "게시판"
        case .study: return "스터디"
        case .profile: return "프로필"
        }
    }
}


//탭 버튼 구성
struct CustomTabView: View {
    //Binding으로 연결되게끔
    @Binding var currentTab: Tab
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(Tab.allCases, id: \.rawValue) { tab in
                Button {
                    withAnimation(.spring()) {
                        currentTab = tab
                    }
                } label: {
                    VStack(spacing: 1) {
                        Image(systemName: tab.rawValue)
                            .font(.subheadline).bold()
                            .scaleEffect(currentTab == tab ? 1.1 : 0.9)
                            .frame(maxWidth: .infinity)
                            .background {
                                Capsule()
                                    .fill(currentTab == tab ? .green : .clear)
                                    .frame(width: currentTab == tab ? 60 : 0)
                                    .frame(height: 2)
                                    .offset(y: -17)
                            }
                        
                        Text(tab.titleText)
                            .font(.caption)
                    }
                    .foregroundColor(currentTab == tab ? .green : .gray)
                }
                .buttonStyle(TabButtonStyle())
                
            }
        }
        .frame(height: 30)
        .padding(.top, 10)
        .padding(.bottom, 8)
        .background(.white)
        
    }
}

//반짝이는 느낌 없애기위해 커스텀버튼스타일 만듬
struct TabButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.8 : 1.0)
    }
}

#Preview {
    CustomTabView(currentTab: .constant(Tab.home))
}
