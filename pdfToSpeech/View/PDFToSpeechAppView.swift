import SwiftUI
import PDFKit

struct PDFToSpeechAppView: View {
    @ObservedObject var textToSpeech = TextToSpeech()
    @SwiftUI.State var showPresenter: Bool = false
    
    var body: some View {
        VStack {
            Text("PDF text speaker")
                .foregroundColor(.black)
            HStack {
                TextField("Enter URL here", text: $textToSpeech.urlText)
                    .padding(5)
                    .onTapGesture {
                        textToSpeech.pdfDocument = nil
                        textToSpeech.pdfTypeChose = .urlText
                    }
                Text("Browse File")
                    .padding(5)
                    .background(Color.black)
                    .foregroundColor(Color.white)
                    .onTapGesture {
                        textToSpeech.pdfDocument = nil
                        textToSpeech.pdfTypeChose = .browseFile
                        showPresenter.toggle()
                    }
                Text("Read PDF")
                    .padding(5)
                    .background(Color.black)
                    .foregroundColor(Color.white)
                    .onTapGesture {
                        assignPDFDocument()
                        switch textToSpeech.pdfTypeChose {
                        case .urlText:
                            textToSpeech.speakString(str: textToSpeech.urlText.readPDF())
                        case .browseFile:
                            textToSpeech.speakString(str: textToSpeech.documentContent.documentString)
                        }
                        
                    }
            }
            VStack {
                if let pdfDoc = textToSpeech.pdfDocument {
                    PDFKitRepresentedView(pdfDoc)
                } else {
                    if textToSpeech.urlText == "" && textToSpeech.documentContent.documentString == "Empty String" {
                        VStack {
                            Text("Type a link in the textfield or browse a PDF file then click 'Read PDF' for the system to read PDF.")
                            Spacer()
                        }
                    } else {
                        ProgressView()
                        Spacer()
                    }
                }
                Spacer()
            }
        }
        .sheet(isPresented: $showPresenter) {
            DocumentPickerSwiftUI(arrSelectedDocument: $textToSpeech.documentContent)
        }
        .edgesIgnoringSafeArea(.all)
        .padding(.top, 20)
        .padding(.bottom, 20)
    }
    
    func assignPDFDocument() {
        switch textToSpeech.pdfTypeChose {
        case .urlText:
            if let url = URL(string: textToSpeech.urlText), let pdfDoc = PDFDocument(url: url) {
                textToSpeech.pdfDocument = pdfDoc
            }
        case .browseFile:
            textToSpeech.pdfDocument = PDFDocument(data: textToSpeech.documentContent.documentData)
        }
    }
}
