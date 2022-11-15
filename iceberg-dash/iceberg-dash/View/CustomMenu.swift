//
//  CustomMenu.swift
//  iceberg-dash
//
//  Created by yury mid on 14.11.2022.
//

import SwiftUI

struct CustomMenu: View {
    
    @State var isMenuOpen = false
    @Binding var showCameraImagePicker: Bool
    @Binding var showImagePicker: Bool
    var body: some View {
        ZStack {
            
            HStack() {
                Button {
                    isMenuOpen = false
                    showCameraImagePicker = true
                } label: {
                    ZStack{
                        Circle()
                            .frame(width: 30, height: 30)
                            .foregroundColor(.bgSec)
                        Image(systemName: "camera")
                            .foregroundColor(.accentColor)
                            .font(.system(size: 15, weight: .bold, design: .rounded))
                    }
                    if (isMenuOpen){
//                        Text("asdasd")
                    }
                }
            }
            .displayOnMenuOpen(isMenuOpen, offset: -90)
            
            
            HStack() {
                Button {
                    isMenuOpen = false
                    showImagePicker = true
                } label: {
                    ZStack{
                        Circle()
                            .frame(width: 30, height: 30)
                            .foregroundColor(.bgSec)
                        Image(systemName: "photo")
                            .foregroundColor(.accentColor)
                            .font(.system(size: 15, weight: .bold, design: .rounded))
                    }
                    if (isMenuOpen){
//                        Text("asdasd")
                    }
                }
            }
            .displayOnMenuOpen(isMenuOpen, offset: -50)
            
            ZStack {
                Circle()
                    .frame(width: 25, height: 25)
                    .foregroundColor(isMenuOpen ? .bgSec : .accentColor)
                
                Image(systemName: isMenuOpen ? "xmark" : "plus")
                    .foregroundColor(isMenuOpen ? .accentColor : .bgSec)
                    .font(.system(size: 15, weight: .bold, design: .rounded))
                    .animation(.easeInOut(duration: 0.3), value: isMenuOpen)
            }
            .onTapGesture {
                isMenuOpen.toggle()
            }
        }
    }
}

//struct CustomMenu_Previews: PreviewProvider {
//    static var previews: some View {
//        CustomMenu()
//    }
//}

struct DisplayOnOpenMenuViewModifier: ViewModifier {
    
    let isOpened: Bool
    let offset: CGFloat
    
    func body(content: Content) -> some View {
        content
            .shadow(color: .black.opacity(isOpened ? 0.1 : 0.0), radius: 10, x: 0, y: 5)
            .offset(y: isOpened ? offset : 0)
            .opacity(isOpened ? 100 : 0)
            .animation(.spring(response: 0.5, dampingFraction: 0.5, blendDuration: 0.5), value: isOpened)
    }
}
 
extension View {
    func displayOnMenuOpen(_ isOpened: Bool, offset: CGFloat) -> some View {
        modifier(DisplayOnOpenMenuViewModifier(isOpened: isOpened, offset: offset))
    }
}
