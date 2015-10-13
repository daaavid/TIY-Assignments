// Human

import UIKit

class BodyPart
{
    let circulatorySystem = ("veins", "arteries", "capillaries")
    let blood = ("Erythrocytes", "Leukocytes", "Platelets", "Plasma")
    var hasO2 = 0
    var concentO2 = 0
    var timeWithoutO2 = 0 //in minutes
    var hasEnergy = false
    
    init(concent02: Int, timeWithoutO2: Int)
    {
        if concentO2 < 50 && timeWithoutO2 <= 1
        {
            cellResp()
        }
        else if concentO2 < 50 && concentO2 > 0 && timeWithoutO2 <= 4
        {
            hypoxia()
        }
        else
        {
            cellDeath()
        }
    }
    
    func cellResp()
    {
        //perform cellular respiration
        //C6H12O6 + 6O2 -> 6CO2 + 6H2O + ENERGY
        hasEnergy = true
        muscle(hasEnergy)
    }
    
    func hypoxia()
    {
        //low oxygen concentration
        //hypoxia
    }
    
    func muscle(hasEnergy : Bool)
    {
        //perform muscle contraction
    }
    
    func cellDeath()
    {
        //cellular death
        //necrosis
    }
}

class RespiratorySystem : BodyPart
{

}

class Diaphragm : RespiratorySystem
{
    let openings = ["Caval", "Esophageal", "Aortic", ]
    
    let nerves = ["C3", "C4", "C5"]
    let arterialBldSp =
    [
        "Internal Thoracic",
        "Superior Phrenic",
        "Internal Intercostal"
    ]
    let location = "Base of Thorax"
    
    func diaRelax()
    {
        //expiration
    }
    func diaContract()
    {
        //inspiration
    }
    func forcedDiaRelax()
    {
        //forced expiration, assisted by abdominal and intercostal muscles
    }
}

class Lungs : RespiratorySystem
{
    let sections = ["Bronchus", "Bronchioles", "Alveoli", "Right Lobe", "Left Lobe"]
    let nerves = ["Pulmonary Plexus", "Phrenic nerve"]
    let arterialBldSp = ["Bronchial Circulation"]
    let location = "Upper Thorax"
    
    func O2diffusion()
    {
        //through capillaries in alveoli
    }
    func mucusProd()
    {
        
    }
    func bpRegulaton()
    {
        
    }
}

class GITract : BodyPart
{
    
}

class Mouth : GITract
{
    var toothNum = 32 //more or less
    let wisToothNum = 0 //preferably
    
    let sections = ["Lips", "Teeth", "Tongue", "Palate", "Oral Cavity"]
    let nerves =
    [
        "Trigeminal",
        "Facial",
        "Glossopharyngeal",
        "Vagus",
        "Hypoglossus"
    ]
    let arterialBldSp = ["External Carotid", "Facial",]
    let location = "Front of Head"
    
    func mastication()
    {
        
    }
    func mouRespiration()
    {
    
    }
    func salProd()
    {
    
    }
}

class Stomach : GITract
{
    let stCapacity = 45...75 //in ml
    
    let sections = ["Cardia", "Fundus", "Body", "Pylorus"]
    let arterialBldSp =
    [
        "Right Gastric",
        "Left Gastric",
        "Right Gastro-omental",
        "Left Gastro-omental",
        "Short Gastric",
    ]
    let location = "Left Upper Abdomen"
    
    func stDigestion()
    {
        
    }
    func stAbsorption()
    {
        
    }
    func stProdAcid()
    {
        
    }
}

class SmallIntestine : GITract
{
    let diameter = 2...3 //in cm
    let surfaceArea = 30 // in m
    
    let sections = ["Duodenum", "Jejunum", "Ileum"]
    let arterialBldSp = ["Coeliac Trunk", "Superior Mesenteric "]
    let location = "Mid Abdomen"
    
    func siDigestion()
    {
        
    }
    func siAbsorption()
    {
        
    }
    func siImmune()
    {
        
    }
}


class NervousSystem : BodyPart
{
    
}

class CenNervSys : NervousSystem
{
    
}


class Brain : CenNervSys
{
    let sections =
    [
        "Frontal Lobe",
        "Parietal Lobe",
        "Occiptal Lobe",
        "Temporal Lobe",
        "Cerebellum"
    ]
    let location = "Skull"
    let size = 1130...1260 //in cm^3
    
    func language()
    {
        
    }
    func cognition()
    {
        
    }
    func passSigToPNS()
    {
        PeripheralNervSys()
    }
}

class SpinalCord : CenNervSys
{
    let sections = ["Cervical", "Thoracic", "Lumbar", "Sacral", "Coccygeal"]
    let avgLength = 43...45
    let location = "Along the spinal column"
    
    func somatoSensOrg()
    {
        
    }
    func motorOrg()
    {
        
    }
    func spinoCerebTr()
    {
    
    }
}

class PeripheralNervSys: NervousSystem
{
    let sections =
    [
        "Cervical Spinal Nerves",
        "Brachial Plexus",
        "Lumbosacral Plexus",
    ]
    let location = "Throughout the body and all extremeties"
    let neurotransmitters = ["Acetylcholine", "Noradrenaline"]
    
    func bodySysControl()
    {
    
    }
    
    func touch()
    {
        
    }
    
    func heatSens()
    {
        
    }
}

class Head : BodyPart
{
    
}

class Eye : Head //inherits properties of BodyPart, but can have its own properties
{
    let sections =
    [
        "Iris",
        "Pupil",
        "Lens",
    ]
    let location = "The orbits of the skull"
    let irisColor = "Brown"
    
    func vision()
    {
        
    }
    func pupilSize()
    {
        
    }
    func focus()
    {
        
    }
}

class Nose : Head
{
    let sections = ["Nasal Root", "Anterior Nasal Spine", "Anterior Nasal Passage"]
    let sectionInterior = ["Olfactory Bulb", "Olfactory Tract", "Nasal Cavity"]
    let nerves = ["C1"]
    
    func smell()
    {
        
    }
    func sniff()
    {
        
    }
    func sneeze()
    {
        
    }
}

class Ear : Head
{
    let outerEar =
    [
        "Auricle",
        "Ear Canal",
        "Tympanic Membrane"
    ]
    let midEar =
    [
        "Tensor Tympani",
        "Tympanic Cavity",
        "Malleus"
    ]
    let innerEar =
    [
        "Vestibule",
        "Saccule",
        "Cochlea"
    ]
    
    func hearing()
    {
        
    }
    func balance()
    {
        
    }
    func vertigo()
    {
        //not a good thing
    }
}

    
class Arm : BodyPart
{
    let sections = ["Upper Arm", "Forearm", "Hand"]
    let bones = ["Humerus", "Ulna", "Radius", "Elbow Joint"]
    let arterialBldSp = ["Brachial Artery"]
    let nerves = ["Musculocutaneous"]
    
    func flexion()
    {
        
    }
    func extens()
    {
        
    }
    func rotation()
    {
        
    }
}

class Hand : Arm
{
    let handParts = ["Wrist", "Back", "Palm"]
    let handBones = ["Metacarpals", "Carpals"]
    let handNerves = ["Radial", "Median", "Ulnar"]
    
    func palmAbduction()
    {
        
    }
    func anteposition()
    {
        
    }
    func radialAbduction()
    {
        
    }
}

class Finger : Hand
{
    let fingerParts = ["Thumb", "Index", "Middle", "Ring", "Pinky"]
    let fingerBones = ["Proximal Phalanges", "Intermediate Phalanges", "Distal Phalanges"]
    let fingerTendons = ["Extensor Tendon", "Flexor Digitorum Superficialis Tendon", "Flexor Digitorum Profundus Tendon"]
    
    override func flexion()
    {
        
    }
    func extes()
    {
        
    }
    func adduction()
    {
        
    }
    func abduction()
    {
        
    }
    
}


class Leg : BodyPart
{
    let legParts = ["Thigh", "Knee", "Shin"]
    let legBones = ["Femur", "Patella", "Tibia", "Fibula"]
    let legNerves =
    [
        "Common Peroneal",
        "Common Plantar",
        "Lateral Plantar",
        "Medial Plantar"
    ]
    
    func flexion()
    {
        
    }
    func extes()
    {
        
    }
    func adduction()
    {
        
    }
    func abduction()
    {
        
    }
}

class Foot : Leg
{
    let footParts = ["Ankle", "Heel", "Instep", "Ball"]
    let footBones = ["Talus", "Tarsal", "Calcaneus", "Metatarsals"]
    let footNerves = ["Lateral Planar", "Medial Plantar", "Posterior Tibial"]
    
    func dorsiflexion()
    {
        
    }
    func plantarFlexion()
    {
        
    }
    func eversion()
    {
        
    }
    func inversion()
    {
        
    }
}

class CirculatorySystem : BodyPart
{
    
}

class CardioSystem : CirculatorySystem
{
    
}

class LymphSystem: CirculatorySystem
{
    
}

class Heart: CardioSystem
{
    let sections = ["Left Atrium", "Right Atrium", "Left Ventricle", "Right Ventricle"]
    let arterialBldSp = ["Pulmonary Vein"]
    let nerves = ["Vagus", "Spinal Ganglionic"]
    let location = "Left Upper Thorax"
    
    var elecImpulse = 0
    
    func cardiacCycle()
    {
        if elecImpulse == 0
        {
            systole()
        }
        else if elecImpulse == 1
        {
            diastole()//this is definitely how the heart works in real life
        }
    }
    func systole()
    {
        ventricleContract()
    }
    func diastole()
    {
        ventricleRelax()
    }
    func ventricleContract()
    {
        
    }
    func ventricleRelax()
    {
        
    }
}

class Thymus: LymphSystem
{
    let sections = ["Cortex", "Medulla",]
    let arterialBldSp = ["Internal Thoracic", ]
    let nerves = ["Vagi derivation", "Descendens Hypoglossi branch", "Phrenic branch"]
    let location = "Mid Upper Thorax"
    
    func thymosinProd()
    {
        
    }
    func thymopoietinProd()
    {
        
    }
    func tCellMaturation()
    {
        
    }
}

class Spleen: LymphSystem
{
    let sections = ["Phrenic", "Visceral"]
    let arterialBldSp = ["Splenic"]
    let nerves = ["Splenic Plexus"]
    let location = "Left Lower Thorax"
    
    func rbcFilt()
    {
        
    }
    func immunResponse()
    {
        
    }
    func rbcStor()
    {
        
    }
}

class LymphNode: LymphSystem
{
    let sections = ["Cortex", "Medulla", "Cortex"]
    let location = ["Underarm", "Groin", "Neck", "Abdomen"]
    let length = 1...2 //in cm
    
    func lymphFluidStor()
    {
        
    }
    func lymphFiltration()
    {
        
    }
    func lymphDrain()
    {
        
    }
}










