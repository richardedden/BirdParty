import SwiftUI
import AVFoundation

struct ContentView: View {
    init() {
        print("[App] ContentView init — app starting up")
        do {
            let session = AVAudioSession.sharedInstance()
            try session.setCategory(.playback, mode: .default)
            try session.setActive(true)
        } catch {
            print("Audio session error:", error)
        }
        if let saved = UserDefaults.standard.array(forKey: "customSounds") as? [String] {
            for index in 0..<min(saved.count, 6) {
                let row = 4 + index / 3
                let col = index % 3
                soundFiles[row][col] = saved[index]
                print("[Restore P1] row: \(row) col: \(col) -> \(soundFiles[row][col])")
            }
        }
        if let saved2 = UserDefaults.standard.array(forKey: "customSounds2") as? [String] {
            for index in 0..<min(saved2.count, 6) {
                let row = 4 + index / 3
                let col = index % 3
                soundFiles2[row][col] = saved2[index]
                print("[Restore P2] row: \(row) col: \(col) -> \(soundFiles2[row][col])")
            }
        }
        if let saved3 = UserDefaults.standard.array(forKey: "customSounds3") as? [String] {
            for index in 0..<min(saved3.count, 6) {
                let row = 4 + index / 3
                let col = index % 3
                soundFiles3[row][col] = saved3[index]
                print("[Restore P3] row: \(row) col: \(col) -> \(soundFiles3[row][col])")
            }
        }
        validateRestoredFiles()
    }

    // Page 1 state
    @State private var isPressed = Array(repeating: Array(repeating: false, count: 3), count: 6)
    @State private var players: [[AVAudioPlayer?]] = Array(repeating: Array(repeating: nil, count: 3), count: 6)
    @State private var showPicker = false
    @State private var pickerRow = 0
    @State private var pickerCol = 0

    // Page 2 state
    @State private var isPressed2 = Array(repeating: Array(repeating: false, count: 3), count: 6)
    @State private var players2: [[AVAudioPlayer?]] = Array(repeating: Array(repeating: nil, count: 3), count: 6)
    @State private var showPicker2 = false
    @State private var pickerRow2 = 0
    @State private var pickerCol2 = 0

    // Page 3 state
    @State private var isPressed3 = Array(repeating: Array(repeating: false, count: 3), count: 6)
    @State private var players3: [[AVAudioPlayer?]] = Array(repeating: Array(repeating: nil, count: 3), count: 6)
    @State private var showPicker3 = false
    @State private var pickerRow3 = 0
    @State private var pickerCol3 = 0

    // Page 1 data
    @State private var soundFiles: [[String]] = [
        ["easo_whinny.mp3", "tuti.wav", "cach.wav"],
        ["robotrill.m4a", "carw.wav", "wbnh.mp3"],
        ["rbwo.mp3", "rcki.wav", "revi.mp3"],
        ["marw.mp3", "VIRA.mp3", "coga.wav"],
        ["load", "load", "load"],
        ["load", "load", "load"]
    ]

    let birdImages = [
        ["easo_i", "tuti_i", "cach_i"],
        ["easo2", "carw_i", "wbnh_i"],
        ["rbwo_i", "rcki_i", "revi_i"],
        ["marw_i", "vira_i", "coga_i"],
        ["load.png", "load.png", "load.png"],
        ["load.png", "load.png", "load.png"]
    ]

    // Page 2 data
    @State private var soundFiles2: [[String]] = [
        ["FEPO.mp3", "GNWO.mp3", "TBMO.mp3"],
        ["BATR.mp3", "CHFG.mp3", "WWPU.mp3"],
        ["GCSP.wav", "PLTW.mp3", "revi.mp3"],
        ["marw.mp3", "VIRA.mp3", "coga.wav"],
        ["load", "load", "load"],
        ["load", "load", "load"]
    ]

    let birdImages2 = [
        ["FEPO", "tuti_i", "TBMO"],
        ["BATR", "CHFG", "WWPU"],
        ["GCSP", "rcki_i", "revi_i"],
        ["marw_i", "vira_i", "coga_i"],
        ["load.png", "load.png", "load.png"],
        ["load.png", "load.png", "load.png"]
    ]

    // Page 3 data
    @State private var soundFiles3: [[String]] = [
        ["COOWmob.mp3", "SWWE.mp3", "HUFU.wav"],
        ["COOW.mp3", "RCLT.mp3", "SNWB.mp3"],
        ["MSO.mp3", "YBNU.mp3", "HLW.mp3"],
        ["WBER.mp3", "ICGM.mp3", "EYWB.mp3"],
        ["load", "load", "load"],
        ["load", "load", "load"]
    ]

    let textLabels3 = [
        ["COmob", "SWWE", "HUFU"],
        ["COOW", "RCLT", "SNWB"],
        ["MSO", "YBNU", "HLW"],
        ["WBER", "ICGM", "EYWB"],
        ["Load", "Load", "Load"],
        ["Load", "Load", "Load"]
    ]

    var body: some View {
        TabView {
            GridPage(
                title: "Hainan 2026",
                birdImages: textLabels3,
                isPressed: $isPressed3,
                players: $players3,
                soundFiles: $soundFiles3,
                showPicker: $showPicker3,
                pickerRow: $pickerRow3,
                pickerCol: $pickerCol3,
                persistKey: "customSounds3",
                isTextMode: true,
                pageBackground: .red
            )
            .tag(0)

            GridPage(
                title: "Welcome to my BirdParty",
                birdImages: birdImages,
                isPressed: $isPressed,
                players: $players,
                soundFiles: $soundFiles,
                showPicker: $showPicker,
                pickerRow: $pickerRow,
                pickerCol: $pickerCol,
                persistKey: "customSounds"
            )
            .tag(1)

            GridPage(
                title: "BirdParty 2",
                birdImages: birdImages2,
                isPressed: $isPressed2,
                players: $players2,
                soundFiles: $soundFiles2,
                showPicker: $showPicker2,
                pickerRow: $pickerRow2,
                pickerCol: $pickerCol2,
                persistKey: "customSounds2"
            )
            .tag(2)
        }
        .tabViewStyle(.page(indexDisplayMode: .automatic))
        .background(Color.white)
        .ignoresSafeArea()
        .onAppear {
            print("[App] ContentView onAppear — UI is visible")
        }
    }

    private func validateRestoredFiles() {
        let docs = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        // Page 1
        print("[App] Validating Restored Files...")
        for row in 4..<6 {
            for col in 0..<3 {
                let name = soundFiles[row][col]
                if name != "load" {
                    let url = docs.appendingPathComponent(name)
                    if !FileManager.default.fileExists(atPath: url.path) {
                        print("[Validate P1] Missing file at row: \(row) col: \(col) name: \(name). Resetting to 'load'.")
                        soundFiles[row][col] = "load"
                    }
                }
            }
        }
        // Page 2
        for row in 4..<6 {
            for col in 0..<3 {
                let name = soundFiles2[row][col]
                if name != "load" {
                    let url = docs.appendingPathComponent(name)
                    if !FileManager.default.fileExists(atPath: url.path) {
                        print("[Validate P2] Missing file at row: \(row) col: \(col) name: \(name). Resetting to 'load'.")
                        soundFiles2[row][col] = "load"
                    }
                }
            }
        }
        // Page 3
        for row in 4..<6 {
            for col in 0..<3 {
                let name = soundFiles3[row][col]
                if name != "load" {
                    let url = docs.appendingPathComponent(name)
                    if !FileManager.default.fileExists(atPath: url.path) {
                        print("[Validate P3] Missing file at row: \(row) col: \(col) name: \(name). Resetting to 'load'.")
                        soundFiles3[row][col] = "load"
                    }
                }
            }
        }
    }
}

private struct GridPage: View {
    let title: String
    let birdImages: [[String]]
    @Binding var isPressed: [[Bool]]
    @Binding var players: [[AVAudioPlayer?]]
    @Binding var soundFiles: [[String]]
    @Binding var showPicker: Bool
    @Binding var pickerRow: Int
    @Binding var pickerCol: Int
    let persistKey: String
    let isTextMode: Bool
    let pageBackground: Color

    @State private var showFileError = false
    @State private var fileErrorMessage = ""

    init(title: String, birdImages: [[String]], isPressed: Binding<[[Bool]]>, players: Binding<[[AVAudioPlayer?]]>, soundFiles: Binding<[[String]]>, showPicker: Binding<Bool>, pickerRow: Binding<Int>, pickerCol: Binding<Int>, persistKey: String, isTextMode: Bool = false, pageBackground: Color = .clear) {
        self.title = title
        self.birdImages = birdImages
        self._isPressed = isPressed
        self._players = players
        self._soundFiles = soundFiles
        self._showPicker = showPicker
        self._pickerRow = pickerRow
        self._pickerCol = pickerCol
        self.persistKey = persistKey
        self.isTextMode = isTextMode
        self.pageBackground = pageBackground
    }

    var body: some View {
        VStack(spacing: 16) {
            Text(title)
                .font(.headline)

            Grid(horizontalSpacing: 12, verticalSpacing: 12) {
                ForEach(0..<6, id: \.self) { row in
                    GridRow {
                        ForEach(0..<3, id: \.self) { col in
                            Button {
                                if isConfigurable(row: row) && !hasAssignedSound(row: row, col: col) {
                                    openPicker(for: row, col: col)
                                } else {
                                    toggleSound(row: row, col: col)
                                }
                            } label: {
                                ZStack {
                                    if isTextMode {
                                        RoundedRectangle(cornerRadius: 8)
                                            .fill(isPressed[row][col] ? Color.green : Color.white)
                                            .frame(width: 96, height: 96)
                                            .overlay(
                                                Text(birdImages[row][col])
                                                    .foregroundColor(.black)
                                                    .multilineTextAlignment(.center)
                                            )
                                    } else if birdImages[row][col].lowercased() != "load.png" {
                                        Image(birdImages[row][col])
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 96, height: 96)
                                            .cornerRadius(8)

                                        if isPressed[row][col] {
                                            RoundedRectangle(cornerRadius: 8)
                                                .fill(Color.green.opacity(0.4))
                                                .frame(width: 96, height: 96)
                                        }
                                    } else {
                                        Rectangle()
                                            .fill(
                                                isPressed[row][col]
                                                ? Color.green
                                                : (hasAssignedSound(row: row, col: col) ? Color.gray.opacity(0.2) : Color.gray.opacity(0.9))
                                            )
                                            .frame(width: 96, height: 96)
                                            .cornerRadius(8)
                                    }
                                }
                            }
                            .buttonStyle(.plain)
                        }
                    }
                }
            }
        }
        .padding()
        .background(pageBackground)
        .sheet(isPresented: $showPicker) {
            SoundPicker { url in
                savePickedSound(url, row: pickerRow, col: pickerCol)
            }
        }
        .alert("File not found", isPresented: $showFileError) {
            Button("OK", role: .cancel) {}
        } message: {
            Text(fileErrorMessage)
        }
    }

    // MARK: - Audio Control (scoped to page)

    func toggleSound(row: Int, col: Int) {
        isPressed[row][col].toggle()
        if isPressed[row][col] {
            playSound(row: row, col: col)
        } else {
            stopSound(row: row, col: col)
        }
    }

    func playSound(row: Int, col: Int) {
        let fileName = soundFiles[row][col]
        guard fileName.lowercased() != "load" else { return }
        guard let url = soundURL(for: fileName) else {
            fileErrorMessage = "The audio file \"\(fileName)\" could not be found. Please reselect the file."
            showFileError = true
            // Optionally mark slot as needing re-pick
            return
        }
        do {
            let player = try AVAudioPlayer(contentsOf: url)
            player.numberOfLoops = -1
            player.prepareToPlay()
            player.play()
            players[row][col] = player
        } catch {
            print("Audio error:", error)
        }
    }

    func stopSound(row: Int, col: Int) {
        players[row][col]?.stop()
        players[row][col] = nil
    }

    func isConfigurable(row: Int) -> Bool { row >= 4 }

    func openPicker(for row: Int, col: Int) {
        pickerRow = row
        pickerCol = col
        showPicker = true
    }

    func persistCustomSounds() {
        var saved: [String] = []
        for row in 4..<6 { for col in 0..<3 { saved.append(soundFiles[row][col]) } }
        UserDefaults.standard.set(saved, forKey: persistKey)
    }

    func hasAssignedSound(row: Int, col: Int) -> Bool {
        let name = soundFiles[row][col]
        guard name != "load" else { return false }
        return soundURL(for: name) != nil
    }

    func savePickedSound(_ url: URL, row: Int, col: Int) {
        let fileManager = FileManager.default
        let docs = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        print("[App] Saving Picked Files...")
        // Remove old file for this slot if it exists and isn't "load"
        let oldName = soundFiles[row][col]
        if oldName != "load" {
            let oldURL = docs.appendingPathComponent(oldName)
            try? fileManager.removeItem(at: oldURL)
        }

        // Create a unique filename to avoid collisions
        let uniqueName = UUID().uuidString + "_" + url.lastPathComponent
        let destURL = docs.appendingPathComponent(uniqueName)

        do {
            try fileManager.copyItem(at: url, to: destURL)
            soundFiles[row][col] = destURL.lastPathComponent
            print("[Save] row: \(row) col: \(col) saved filename: \(destURL.lastPathComponent)")
            persistCustomSounds()

            // Immediately start playing the picked file
            isPressed[row][col] = true
            if let playURL = soundURL(for: destURL.lastPathComponent) {
                let player = try AVAudioPlayer(contentsOf: playURL)
                player.numberOfLoops = -1
                player.prepareToPlay()
                player.play()
                players[row][col] = player
                print("[Play] Started playback for row: \(row) col: \(col)")
            } else {
                print("[Play] Failed to resolve play URL for saved file: \(destURL.lastPathComponent)")
                fileErrorMessage = "The audio file could not be loaded after picking. Please try again."
                showFileError = true
            }
        } catch {
            print("[Save] Copy error: \(error.localizedDescription)")
            fileErrorMessage = "Failed to save the picked file. Please try again."
            showFileError = true
        }
    }

    func soundURL(for fileName: String) -> URL? {
        let docs = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let localURL = docs.appendingPathComponent(fileName)
        if FileManager.default.fileExists(atPath: localURL.path) { return localURL }
        let parts = fileName.split(separator: ".", maxSplits: 1)
        if parts.count == 2 {
            return Bundle.main.url(forResource: String(parts[0]), withExtension: String(parts[1]))
        }
        return nil
    }
}

struct SoundPicker: UIViewControllerRepresentable {
    var onPick: (URL) -> Void

    func makeUIViewController(context: Context) -> UIDocumentPickerViewController {
        let picker = UIDocumentPickerViewController(
            forOpeningContentTypes: [.audio],
            asCopy: true
        )
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: UIDocumentPickerViewController, context: Context) {}

    func makeCoordinator() -> Coordinator { Coordinator(onPick: onPick) }

    class Coordinator: NSObject, UIDocumentPickerDelegate {
        let onPick: (URL) -> Void
        init(onPick: @escaping (URL) -> Void) { self.onPick = onPick }
        func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
            guard let url = urls.first else { return }
            onPick(url)
        }
    }
}

#Preview {
    ContentView()
}
