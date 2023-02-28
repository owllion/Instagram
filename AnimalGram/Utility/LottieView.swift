
import SwiftUI
import Lottie
 
struct LottieView: UIViewRepresentable {
    var lottieFile: String
 
    func makeUIView(context: Context) -> some UIView {
        let view = UIView(frame: .zero)
        
        let animation = Animation.named(lottieFile)
        let animationView = AnimationView(animation: animation)
        
        animationView.frame = view.bounds
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.play()

        view.addSubview(animationView)
 
        animationView.translatesAutoresizingMaskIntoConstraints = false
        animationView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        animationView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
 
        return view
    }
 
    func updateUIView(_ uiView: UIViewType, context: Context) {
 
    }
}
