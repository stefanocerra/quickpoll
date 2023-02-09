//
//  JoinGroupForm.swift
//  quickpoll
//
//  Created by Sandro Darnuzer on 02.09.22.
//

import SwiftUI
import CodeScanner

struct JoinGroupForm: View {
    
    @EnvironmentObject var groupViewModel: GroupViewModel
    
    @Binding var showPopover: Bool
    @State private var isShowingScanner = false
    
    var body: some View {
        VStack {
            CodeScannerView(codeTypes: [.qr], simulatedData: "2B12313B-D427-480B-90AC-2D8D21990849", completion: handleScan)
        }
    }
    
    func handleScan(result: Result<ScanResult, ScanError>) {
        isShowingScanner = false
        
        switch result {
        case .success(let result):
            let code = result.string
            
            Task {
                await groupViewModel.joinGroup(code: code)
            }
            
        case .failure(let error):
            print("Scanning failed: \(error.localizedDescription)")
        }
        
        showPopover = false
    }
}

struct JoinGroupForm_Previews: PreviewProvider {
    static var previews: some View {
        JoinGroupForm(showPopover: .constant(false))
            .environmentObject(GroupViewModel())
    }
}
