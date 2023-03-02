import Foundation
import PDFKit

extension String {
    func readPDF() -> String {
        if let url = URL(string: self), let pdf = PDFDocument(url: url) {
            return pdf.string ?? "Can't detect string in PDF"
        }
        return "Can't detect string in PDF"
    }
}
