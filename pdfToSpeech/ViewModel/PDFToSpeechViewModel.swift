import Foundation
import AVFoundation
import PDFKit

class TextToSpeech: ObservableObject {
    
    @Published var urlText: String = ""
    @Published var showError = false
    @Published var documentContent: DocumentItem = DocumentItem()
    @Published var pdfDocument: PDFDocument? = nil
    let synthesizer = AVSpeechSynthesizer()
    var pdfTypeChose: FileTypeChoosen = .urlText
    
    func speakString(str: String) {
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("Fail to enable the session")
            return
        }
        let utterance = AVSpeechUtterance(string: str)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        utterance.rate = 0.5
        self.synthesizer.speak(utterance)
    }
}
