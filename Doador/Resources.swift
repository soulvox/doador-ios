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
        
        case findDonatorTermsAndConditions = "Para encontrar um pessoa com uma voz compatível é necessário preencher um formulário com características físicas e regionais.\nAlém disso, se a pessoa conseguir emitir algum som, este auxiliará na busca do doador."
        
        case recordSentencesDescription = "Grave as seguintes frases:"
        case findDonatorRecordSentencesDescription = "Grave o som que a pessoa conseguir emitir"
        
        case sentencesToRecord = "Érica tomou suco de pêra \nAgora é hora de acabar \nSônia sabe sambar sozinha \nMinha mãe namorou um anjo \nOlha lá, chama o avião azul \nPapai trouxe pipoca quente"
        
        case recordVowelsDescription = "Grave as seguintes vogais:"
        
        case vowelsToRecord = "A, AAAAAAAAAA \nÉ, ÉÉÉÉÉÉÉÉÉÉÉÉ \nÊ, ÊÊÊÊÊÊÊÊÊÊÊÊ \nI, IIIIIIIIIIIIIIIII \nÓ, ÓÓÓÓÓÓÓÓÓ \nÔ, ÔÔÔÔÔÔÔÔÔ \nU, UUUUUUUUU"
        
        case acknowledgment = "Obrigado pela sua doação! \nAs frases que você gravou contém todos os \nfonemas da língua portuguesa e permitem-nos reconstruir \ntodas palavras do nosso vocabulário. \n\nCaso haja um receptor compatível entraremos em contato."
        
        case findDonatorAcknowledgment = "Obrigado!\nEntraremos em contato com possíveis doadores para sua escolha.\nQualquer dúvida entre em contato conosco.\ncontato@soulvox.co"
        
        enum Buttons {
            case accept, `continue`, cancel, donateVoice, findDonator, startOver
            
            var label: String {
                switch self {
                case .accept:
                    return "Aceitar"
                    
                case .continue:
                    return "Continuar"
                    
                case .cancel:
                    return "Cancelar"
                    
                case .donateVoice:
                    return "Seja um doador"
                    
                case .findDonator:
                    return "Encontre um doador"
                    
                case .startOver:
                    return "Voltar para o início"
                }
            }
        }
        
        enum Sections {
            enum PersonalDataForm: Int {
                case personalData, contactData
                
                var label: String {
                    switch self {
                    case .personalData:
                        return "Dados pessoais"
                        
                    case .contactData:
                        return "Dados para contato"
                    }
                }
            }
        }
        
        enum Cells {
            enum PersonalDataForm {
                case name, age, gender, weight, height, email, phone
                
                var label: String {
                    switch self {
                    case .name:
                        return "Nome"
                        
                    case .age:
                        return "Idade"
                    
                    case .gender:
                        return "Sexo"
                    
                    case .weight:
                        return "Peso (kg)"
                    
                    case .height:
                        return "Altura (m)"
                    
                    case .email:
                        return "E-mail"
                    
                    case .phone:
                        return "Telefone"
                    }
                }
                
                var placeholder: String {
                    switch self {
                    case .name:
                        return "João Silva"
                    
                    case .age:
                        return "30"
                    
                    case .gender:
                        return ""
                    
                    case .weight:
                        return "80"
                    
                    case .height:
                        return "1,70"
                    
                    case .email:
                        return "joao.silva@exemplo.com"
                    
                    case .phone:
                        return "XX XXXXX-XXXX"
                    }
                }
            }
            
            enum VoiceDataForm {
                case voiceType, accent, personalityType
                
                var label: String {
                    switch self {
                    case .voiceType:
                        return "Tipo de voz"
                        
                    case .accent:
                        return "Sotaque"
                        
                    case .personalityType:
                        return "Personalidade"
                    }
                }
                
                var placeholder: String {
                    switch self {
                    case .voiceType:
                        return "Descreva sua voz"
                        
                    case .accent:
                        return "Descreva seu sotaque"
                        
                    case .personalityType:
                        return "Descreva sua personalidade"
                    }
                }
            }
        }
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
