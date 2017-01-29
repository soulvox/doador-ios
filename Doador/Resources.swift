//
//  Resources.swift
//  Doador
//
//  Created by Rafael Alencar on 26/01/17.
//  Copyright © 2017 Soulvox. All rights reserved.
//

import UIKit

enum Resources {
    
    enum Images: String {
        case logo
        case microphone
        case microphoneFilled
        case play
        case pause
        
        var image: UIImage? {
            return UIImage(named: self.rawValue)
        }
    }
    
    enum Text: String {
        case soulvoxIntro = "Bem vindo(a) ao SOULVOX. Nós desenvolvemos soluções de comunicação assistiva em que o usuário possa se comunicar com a própria voz. Para quem nunca teve voz ou para quem perdeu e não possui registros gravados de voz, é possível fazer a doação de vozes. \nPara encontrar um doador de voz compatível, é necessário cruzar as características físicas e regionais do doador com quem irá receber a voz. Assim, todos os interessados em doar deverão preencher um formulário e gravar algumas frases."
        
        case termsAndConditions = "Termos de autorização de uso de voz"
        
        case recordSentencesDescription = "Grave as seguintes frases:"
        
        case sentencesToRecord = "Érica tomou suco de pêra \nAgora é hora de acabar \nSônia sabe sambar sozinha \nMinha mãe namorou um anjo \nOlha lá, chama o avião azul \nPapai trouxe pipoca quente"
        
        case recordVowelsDescription = "Grave as seguintes vogais:"
        
        case vowelsToRecord = "A, AAAAAAAAAA \nÉ, ÉÉÉÉÉÉÉÉÉÉÉÉ \nÊ, ÊÊÊÊÊÊÊÊÊÊÊÊ \nI, IIIIIIIIIIIIIIIII \nÓ, ÓÓÓÓÓÓÓÓÓ \nÔ, ÔÔÔÔÔÔÔÔÔ \nU, UUUUUUUUU"
        
        case acknowledgment = "Obrigado pela sua doação! \nAs frases que você gravou contém todos os \nfonemas da língua portuguesa e permitem-nos reconstruir \ntodas palavras do nosso vocabulário. \n\nCaso haja um receptor compatível entraremos em contato."
    }
    
    enum Colors {
        case tint
        case white
        case shadow
        
        var color: UIColor {
            switch self {
            case .tint:
                return UIColor(colorLiteralRed: 0.33, green: 0.28, blue: 0.25, alpha: 1.0)
                
            case .white:
                return UIColor.white
                
            case .shadow:
                return UIColor.black
            }
        }
    }
}
