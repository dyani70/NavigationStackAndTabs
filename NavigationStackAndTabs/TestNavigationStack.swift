//
//  TestNavigationStack.swift
//  NavigationStackAndTabs
//
//  Created by Dyani on 3/7/24.
//

import SwiftUI

struct TestNavigationStack: View {
    let appleProducts = ["Mac", "Macbook", "iPhone", "iPad"]
    //타입에 상관없이 넣을수 있게 네비게이션 패스타입으로 선언
    @State private var stackPath: NavigationPath = .init()
    
    var body: some View {
        NavigationStack(path: $stackPath) {
            List(appleProducts, id: \.self) { product in
                Button {
                    stackPath.append(product)
                } label: {
                    Text(product)
                        .font(.largeTitle)
                        .bold()
                }
                
                Button {
                    stackPath.append(1)
                } label: {
                    Text("넘버로 네비게이션")
                }
                
                
            }
            .navigationTitle("네비게이션 스택")
            .navigationDestination(for: String.self) { product in
                AppleProductView(product: product, path: $stackPath)
            }
            .navigationDestination(for: Int.self) { number in
                Text("넘버가 선택되었습니다")
            }
            
           
            
            

        }
        

        // * NavigationView로 하면 한꺼번에 이미지가 다운받게되어 비효율적 nil로 감싸거나 추가조치 필요 / 진입할때 뷰생성, 이미지 다운로드
//        NavigationView {
       /* NavigationStack {
            List(0...6, id: \.self) { index in
                
//                *NavigationLink {
//                    FirstDestinationView(viewModel: FirstDestinationViewModel())
//                } label : {
//                    Text("\(index)")
//                }
                NavigationLink(value: index) {
                    Text("\(index) 버튼")
                        .font(.largeTitle)
                        .bold()
                    
                }
            }
            .navigationTitle("네비게이션 연습")
            //데스티네이션이 되는 뷰를 지정 / 진입할때 뷰생성, 이미지 다운로드
            .navigationDestination(for: Int.self) { _ in
                FirstDestinationView(viewModel: FirstDestinationViewModel())
            }
        } */
    }
}


/*
        
// 실제로는 뷰모델에서 바로 다운받지 않고 매니저 클래스에 로직을 작성하지만 빠른 진행을 위해 뷰모델에 바로 작성
@MainActor
class FirstDestinationViewModel: ObservableObject {
    @Published var image: UIImage? = nil
    
    init() {
        downloadImage()
    }
    
    func downloadImage() {
        Task {
            let url = URL(string: "https://picsum.photos/200")!
            let (data, response) = try await URLSession.shared.data(from: url)
            if let image = UIImage(data: data) {
                self.image = image
                print("이미지가 다운로드 되었습니다!")
            }
            
        }
    }
}

struct FirstDestinationView: View {
    
    @StateObject private var viewModel: FirstDestinationViewModel
    
    init(viewModel: FirstDestinationViewModel) {
        print("목적지가 되는 뷰가 생성되었습니다!")
        
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        VStack {
            if let image = viewModel.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
            }
        }
        Text("목적지가 되는 뷰")
    }
}

 */

//깊숙히 네비게이션 들어가기 (네비게이션 스텝 늘리기)
struct AppleProductView: View {
    let product: String
    @Binding var path: NavigationPath
    
    var body: some View {
        VStack(spacing: 20) {
            Text(product)
                .font(.largeTitle)
                .onTapGesture {
                    path.append("세번째 혹은 더 깊이")
                }
            
            //path 초기화
            Text("모두 없애버리기")
                .onTapGesture {
                    path = .init()
                }
        }
    }
}

#Preview {
    TestNavigationStack()
}
