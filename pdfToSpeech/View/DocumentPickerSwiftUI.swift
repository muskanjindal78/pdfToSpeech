import UIKit
import SwiftUI
import UniformTypeIdentifiers
import PDFKit

struct DocumentPickerSwiftUI: UIViewControllerRepresentable {
    
    var contentTypes: [UTType] = [.pdf]
    @Binding var arrSelectedDocument: DocumentItem
    @Environment(\.presentationMode) private var presentationMode
    
    func makeUIViewController(context: Context) -> some UIViewController {
        
        let controller = UIDocumentPickerViewController(forOpeningContentTypes: contentTypes, asCopy: true)
        controller.allowsMultipleSelection = false
        controller.shouldShowFileExtensions = true
        controller.delegate = context.coordinator
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    final class Coordinator: NSObject, UIDocumentPickerDelegate {
        
        var parent: DocumentPickerSwiftUI
        
        init(_ parent: DocumentPickerSwiftUI) {
            self.parent = parent
        }
        
        func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
            if let firstDocumentUrl = urls.first {
                do {
                    print("Documenet captured ------> \(firstDocumentUrl.absoluteString)")
                    let docData = try Data(contentsOf: firstDocumentUrl)
                    let fileExtension = (firstDocumentUrl.absoluteString as NSString).pathExtension
                    if let page = PDFDocument(data: docData)?.page(at: 0), fileExtension == "pdf" {
                        let document = page.string ?? "Can't detect string"
                        parent.arrSelectedDocument = DocumentItem(documentData: docData, documentString: document)
                    }
                } catch {
                    print("Error while picking the document: \(error.localizedDescription)")
                }
            }
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}
