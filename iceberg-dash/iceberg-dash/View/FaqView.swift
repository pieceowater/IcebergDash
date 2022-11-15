//
//  faqView.swift
//  iceberg-dash
//
//  Created by yury mid on 06.11.2022.
//

import SwiftUI

struct faqView: View {
    var body: some View {
        ScrollView {
            VStack{
//                Text("F.A.Q.")
//                    .font(.headline)
//                    .padding(.bottom)
                
                Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam sed mauris sit amet ex finibus suscipit. Nullam dapibus pulvinar eros, eget fringilla enim finibus ac. Nunc tempor sem in vehicula placerat. Nam vitae fermentum nisl. Proin dictum ligula vel interdum hendrerit. Curabitur maximus sollicitudin vehicula. Maecenas vestibulum vehicula viverra.")
                    .font(.caption)
                
                DisclosureGroup("What is Lorem Ipsum?") {
                    VStack {
                        Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam sed mauris sit amet ex finibus suscipit. Nullam dapibus pulvinar eros, eget fringilla enim finibus ac. Nunc tempor sem in vehicula placerat. Nam vitae fermentum nisl. Proin dictum ligula vel interdum hendrerit. Curabitur maximus sollicitudin vehicula. Maecenas vestibulum vehicula viverra. Mauris vel dolor lorem. Nullam felis nulla, cursus sit amet nunc nec, venenatis mollis risus. Integer ut semper purus, a ullamcorper sem. Proin mattis facilisis est at molestie. Morbi lobortis hendrerit sapien sed fringilla. In volutpat nec libero ut consequat. Fusce placerat lectus odio, ac facilisis dolor egestas ac. Vestibulum porta elit et porttitor tincidunt. Ut imperdiet consectetur nunc sit amet scelerisque. ")
                            .font(.caption)
                    }
                }
                .padding(10)
                .background(.ultraThinMaterial)
                .cornerRadius(10)
                
                DisclosureGroup("What is Ipsum?") {
                    VStack {
                        Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam sed mauris sit amet ex finibus suscipit. Nullam dapibus pulvinar eros, eget fringilla enim finibus ac. Nunc tempor sem in vehicula placerat. Nam vitae fermentum nisl. Proin dictum ligula vel interdum hendrerit. Curabitur maximus sollicitudin vehicula. Maecenas vestibulum vehicula viverra. Mauris vel dolor lorem. Nullam felis nulla, cursus sit amet nunc nec, venenatis mollis risus. Integer ut semper purus, a ullamcorper sem. Proin mattis facilisis est at molestie. Morbi lobortis hendrerit sapien sed fringilla. In volutpat nec libero ut consequat. Fusce placerat lectus odio, ac facilisis dolor egestas ac. Vestibulum porta elit et porttitor tincidunt. Ut imperdiet consectetur nunc sit amet scelerisque. ")
                            .font(.caption)
                    }
                }
                .padding(10)
                .background(.ultraThinMaterial)
                .cornerRadius(10)
                
                DisclosureGroup("What is Lorem?") {
                    VStack {
                        Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam sed mauris sit amet ex finibus suscipit. Nullam dapibus pulvinar eros, eget fringilla enim finibus ac. Nunc tempor sem in vehicula placerat. Nam vitae fermentum nisl. Proin dictum ligula vel interdum hendrerit. Curabitur maximus sollicitudin vehicula. Maecenas vestibulum vehicula viverra. Mauris vel dolor lorem. Nullam felis nulla, cursus sit amet nunc nec, venenatis mollis risus. Integer ut semper purus, a ullamcorper sem. Proin mattis facilisis est at molestie. Morbi lobortis hendrerit sapien sed fringilla. In volutpat nec libero ut consequat. Fusce placerat lectus odio, ac facilisis dolor egestas ac. Vestibulum porta elit et porttitor tincidunt. Ut imperdiet consectetur nunc sit amet scelerisque. ")
                            .font(.caption)
                    }
                }
                .padding(10)
                .background(.ultraThinMaterial)
                .cornerRadius(10)
                
                
                Text("Lorem ipsum suscipit. Nullam dapibus pulvinar eros, eget fringilla enim finibus ac. Nunc tempor sem in vehicula placerat. Nam vitae fermentum nisl. Proin dictum ligula vel interdum hendrerit. Curabitur maximus sollicitudin vehicula. Maecenas vestibulum vehicula viverra.")
                    .font(.caption)
                
                Spacer()
            }
            .padding()
            .background(Color.bg)
 
        }
        .background(Color.bg)
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("F.A.Q.")
    }
}

struct faqView_Previews: PreviewProvider {
    static var previews: some View {
        faqView()
    }
}
