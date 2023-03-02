import Foundation
import SwiftUI
import PDFKit

struct PDFKitRepresentedView: UIViewRepresentable {
    let data: PDFDocument

    init(_ data: PDFDocument) {
        self.data = data
    }

    func makeUIView(context: UIViewRepresentableContext<PDFKitRepresentedView>) -> PDFKitRepresentedView.UIViewType {
        // Create a `PDFView` and set its `PDFDocument`.
        let pdfView = PDFView()
        pdfView.document = data
        pdfView.autoScales = true
        pdfView.backgroundColor = .white
        return pdfView
    }

    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<PDFKitRepresentedView>) {
        // Update the view.
    }
}
