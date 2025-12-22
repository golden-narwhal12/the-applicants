/// @desc Get applicant data for a specific month
/// @param month

function get_month_applicants(_month) {
    var data = {
        month: _month,
        applicants: []
    };
    
    switch(_month) {
        case 1:
            data.applicants = [
                // === APPLICANT 1: CHEN MARCUS ===
                {
    id: "m1_torres",
    sprite: spr_applicant_general,
    
    biography_sections: [
        "TORRES MARIA, 41 | 2 Food, 2 Water, 1 Energy",  // FREE
        "South Park flooding survivor Dec 2022. Home condemned. FEMA trailer 8 months. Nurse pre-collapse Providence Hospital burn unit 6 years certified trauma.",  // 1 Energy
        "Search history: elderly care pneumonia symptoms hospice Tacoma oxygen concentrator rental IV antibiotics black market where to buy.",  // 2 Energy
        "Mother Elena Torres 71 chronic respiratory failure wildfire smoke exposure 2043 2051 2058. Requires daily medication. Not disclosed on entry forms.",  // 3 Energy
        "Caught stealing morphine Providence 2071 charges dropped. Hospital knew why. Everyone knew why. No one had a choice."  // 4 Energy
    ],
    
    food_change: 3,      // Net positive (skilled nurse)
    water_change: -4,    // Her + hidden mother
    energy_change: 0,
    spirit_change: 5,    // Morale boost from medical care
    
    report_note_accepted: "Torres established medical station. Treated 12 smoke inhalation cases successfully. INCIDENT: Unauthorized morphine distribution. Her mother died Week 3. Torres requested permanent assignment to medical duties.",
    report_note_denied: "Torres denied entry. Settled in Kent tent city. Mother died 4 days later. Torres now treating black market patients. Our untreated respiratory cases increased 40%.",
    
    speech_lines: [
        "I'm a trauma nurse. Burns, smoke inhalation, heat stroke.",
        "I've kept people alive with almost nothing.",
        "You need someone like me."
    ],
    
    accept_response: "Thank you. You won't regret this.",
    deny_response: "She won't last a week out there.",
    
    gives_item_on_walk_up: {
        item_id: "medicine",
        item_name: "Antibiotic Cache",
        item_description: "Partial bottle of amoxicillin. Given by Maria Torres. She says she 'found' it.",
        sprite: spr_item_medicine,
        abilities: []
    },
    
    can_return_with_bomb: false,
    desperation_level: 8
},
                
                // === APPLICANT 2: ELENA RODRIGUEZ ===
                {
    id: "m1_kim",
    sprite: spr_applicant_general,
    
    biography_sections: [
        "KIM DAVID, 38 | 3 Food, 3 Water, 2 Energy",  // FREE
        "Resume: Senior Water Systems Engineer Seattle Public Utilities 2067-2074. Managed Tolt River treatment optimization. References available. Certifications: PE license WA State.",  // 1 Energy
        "LinkedIn endorsements mechanical systems fluid dynamics Jim Morrison vouch remember that favor. Search: how to read engineering blueprints fast basic plumbing tutorial.",  // 2 Energy
        "Actual employment: Janitorial staff SPU 2069-2074. Forged documents after Morrison fired. No engineering degree. Learned by watching engineers work. Can fix basic systems.",  // 3 Energy
        "Morrison's real recommendation ENCRYPTED: 'Do not hire. Liar. Competent with tools but not an engineer. Will cause problems.' Kim intercepted this. Deleted it. Sent fake version instead."  // 4 Energy
    ],
    
    food_change: -3,
    water_change: -3,
    energy_change: 1,    // Can do basic repairs, just not engineering
    spirit_change: -8,   // Destroys morale when incompetence exposed
    
    report_note_accepted: "Kim assigned to water system repair. Week 2: Critical miscalculation. Main pipe burst. 3 days no water. Kim's credentials verified post-incident: fraudulent. 400 gallons lost. Morale collapsed. Kim confined to basic maintenance.",
    report_note_denied: "Kim denied. Hired by Bellevue settlement. Their water treatment failed Month 2. 14 died from contamination. Bellevue now at 40% capacity. Kim expelled.",
    
    speech_lines: [
        "Your water systems are 2050s infrastructure.",
        "I can extend their life by years. Maybe decades.",
        "Jim Morrison trained me personally."
    ],
    
    accept_response: "Smart choice. I'll start diagnostics immediately.",
    deny_response: "You're making a mistake. You need real expertise.",
    
    gives_item_on_accept: {
        item_id: "tools",
        item_name: "Professional Tool Set",
        item_description: "High-quality engineering tools. Given by David Kim. Very convincing.",
        sprite: spr_item_tools,
        abilities: []
    },
    
    requested_item: "tools",  // If you give him tools from someone else, he seems more legitimate
    item_reward: {
        spirit: -5,  // Actually makes things worse
        water: -3
    },
    item_received_response: "Perfect. With proper tools, I can do anything.",
    
    can_return_with_bomb: true,
    desperation_level: 6
},
                
                // === APPLICANT 3: UNKNOWN ===
                {
    id: "m1_okafor",
    sprite: spr_applicant_general,
    
    biography_sections: [
        "OKAFOR SARAH, 29 | 1 Food, 2 Water, 1 Energy",  // FREE (doesn't mention child)
        "Construction labor 4 years Kent refugee processing. Strong. Healthy. Warehouse logistics Duwamish industrial. No medical conditions. Single. No dependents listed.",  // 1 Energy
        "Search: pediatric asthma wildfire smoke emergency inhaler alternative DIY nebulizer instructions how long can child survive without albuterol.",  // 2 Energy
        "Son Marcus age 4 severe asthma diagnosed 2073. Hidden in Kent camp. Auntie watching. Smoke season coming. Without treatment: 40% mortality. Needs inhaler every 6 hours.",  // 3 Energy
        "Plan: Get accepted. Establish herself 2 weeks. Then: 'Surprise, I have a son who needs emergency entry.' Gamble: They won't throw out someone already working. They'll accept the child. They have to."  // 4 Energy
    ],
    
    food_change: 4,       // Strong worker initially
    water_change: -4,     // Her + child after Week 2
    energy_change: 3,     // Good worker
    spirit_change: -6,    // Deception destroys trust, child needs constant care
    
    report_note_accepted: "Okafor excellent worker. Week 2: Undisclosed child smuggled in. Asthma emergency. Used medical supplies. Colony vote: Allow child to stay (narrow margin). Okafor productivity dropped 60% caring for son. Trust issues persist. Medical supplies stressed.",
    report_note_denied: "Okafor denied. Her son died Week 3 in Kent camp during smoke event. Okafor blamed colony gatekeepers publicly. Incited anger among other denied applicants. Security concerns elevated.",
    
    speech_lines: [
        "I'm young. I'm strong. I can work.",
        "I'll do anything. Any job. Any hours.",
        "I just need a chance to prove myself."
    ],
    
    accept_response: "I won't let you down. I promise.",
    deny_response: "Please. I'm begging you. Please.",
    
    gives_item_on_deny: {
        item_id: "photo",
        item_name: "Child's Drawing",
        item_description: "Crayon drawing of a house and sun. Given by Sarah Okafor. A child's handwriting says 'Home?'",
        sprite: spr_item_photo,
        abilities: []
    },
    
    can_return_with_bomb: true,
    desperation_level: 10
},
                
                // === APPLICANT 4: JUNE BRIGHTWELL ===
                {
    id: "m1_brightwell",
    sprite: spr_applicant_general,
    
    biography_sections: [
        "BRIGHTWELL THOMAS, 68 | 2 Food, 2 Water, 1 Energy",  // FREE
        "Age 68 retired. No technical skills listed. Weak. Slow. Burden. Resource drain. Will need medical care. Every settlement has denied him. Desperate.",  // 1 Energy (MISLEADING)
        "Search: heirloom seed preservation hydroponics without electricity rain catchment system DIY water purification ancient food storage methods indigenous fire management techniques.",  // 2 Energy
        "Background suppressed by AI error: Forestry Service 40 years. Wildfire prevention specialist. Survived 2043 Eagle Creek fire. Taught Indigenous controlled burn techniques. Grew up on Lummi Nation reservation. Actually extremely valuable.",  // 3 Energy
        "Has seed collection: 47 varieties pre-collapse vegetables adapted to Pacific Northwest. Irreplaceable genetic diversity. Never mentions it. Waits to see if you're worth saving."  // 4 Energy
    ],
    
    food_change: 8,       // Seeds + knowledge = massive food boost
    water_change: -2,
    energy_change: 2,     // Teaches efficient systems
    spirit_change: 6,     // Wisdom, stories, morale boost
    
    report_note_accepted: "Brightwell initially assigned light duties. Week 2: Revealed seed collection. Established working hydroponic system using scavenged materials. Food production projected +40% by Month 3. Teaching 6 young people traditional techniques. Proved invaluable.",
    report_note_denied: "Brightwell denied. Accepted by Tacoma settlement. Their food security now 300% better than ours. Brightwell teaching dozens. We hear he asks about 'that Redmond colony that didn't want him.' Regret documented.",
    
    speech_lines: [
        "I don't have much time left.",
        "But I know things. Old things. Useful things.",
        "That's worth something, isn't it?"
    ],
    
    accept_response: "You made a wise choice. I'll show you why.",
    deny_response: "I understand. I'm old. I get it.",
    
    gives_item_on_accept: {
        item_id: "seeds",
        item_name: "Heritage Seed Collection",
        item_description: "47 varieties of pre-collapse seeds in weatherproof case. Given by Thomas Brightwell. Priceless.",
        sprite: spr_item_seeds,
        abilities: []
    },
    
    gives_item_on_walk_up: {
        item_id: "bluebird",
        item_name: "Lummi Bluebird Charm",
        item_description: "Carved cedar bluebird. Lummi Nation tradition. Thomas says it brings protection. 'For luck,' he says quietly.",
        sprite: spr_item_bluebird,
        abilities: ["reduce_attack_chance"]
    },
    
    can_return_with_bomb: false,
    desperation_level: 3
}, 

{
    id: "m1_begay",
    sprite: spr_applicant_general,
    
    biography_sections: [
        "BEGAY AMARA, 52 | 2 Food, 3 Water, 1 Energy",  // FREE
        "Unemployed. Tulalip Tribes member. No formal education listed. Lived in tent city 3 years. Previous employment: Cultural liaison Hibulb Cultural Center closed 2072. Evicted twice.",  // 1 Energy (seems negative)
        "Search: traditional salmon preservation Coast Salish food sovereignty indigenous seed saving camas cultivation clam gardens restoration weather prediction stars tide tables moon phases.",  // 2 Energy
        "Hidden network: Still connected to 40+ Indigenous families across Puget Sound region. Coordinates resource sharing. Underground trade network functional when government systems failed. Network survived when Seattle didn't.",  // 3 Energy
        "Medical knowledge: Traditional plant medicine. Treated 200+ people in camps with no modern medicine. Devil's club for diabetes. Stinging nettle for inflammation. Knows what grows here. Knows what heals."  // 4 Energy
    ],
    
    food_change: 6,       // Traditional food systems + network access
    water_change: 1,      // Understands water management
    energy_change: -1,
    spirit_change: 8,     // Cultural leadership, massive morale boost
    
    report_note_accepted: "Begay established trade connections with 6 settlements. Food diversity increased 300%. Taught traditional preservation - no refrigeration needed. Spiritual ceremonies boosted morale significantly. 3 young people learning traditional ecological knowledge. Network invaluable.",
    report_note_denied: "Begay denied. Her network now excludes Redmond from trade routes. Other settlements question our judgment. 'They rejected Amara Begay?' Reputation damaged. Isolation increased.",
    
    speech_lines: [
        "My people have lived here for 10,000 years.",
        "We survived ice ages. We'll survive this.",
        "I know how to live when everything else fails.",
		"If you had a bluebird for me... it would show you respect the old ways."  // NEW
    ],
    
    accept_response: "Thank you for seeing what others missed.",
    deny_response: "You don't understand what you just lost.",
    
    requested_item: "bluebird",  // Recognizes Lummi carving from Thomas
    item_reward: {
        food: 8,
        spirit: 10
    },
    item_received_response: "You gave me the Lummi bluebird? Thank you. Your colony respects our knowledge.",
    
    gives_item_on_accept: {
        item_id: "blanket",
        item_name: "Trade Blanket",
        item_description: "Pendleton blanket. Coast Salish design. Given by Amara Begay. 'This connects you to the network,' she says.",
        sprite: spr_item_blanket,
        abilities: []
    },
    
    can_return_with_bomb: false,
    desperation_level: 4
},

{
    id: "m1_morrison_kyle",
    sprite: spr_applicant_general,
    
    biography_sections: [
        "MORRISON KYLE, 24 | 2 Food, 2 Water, 2 Energy",  // FREE
        "Computer systems MIT dropout 2071. Self-taught coding. Built mesh network for Kent refugee camp. Solar panel optimization algorithms. Communications encryption. Exactly what you need for infrastructure.",  // 1 Energy (seems great)
        "Search: anger management techniques PTSD treatment without medication how to stop intrusive thoughts violence justified when combat breathing exercises sleepless nights.",  // 2 Energy
        "Father: James Morrison SPU engineer. Abusive. Fired 2074 for 'impossible standards.' Kyle watched him scream at workers. Learned from him. Became him. Kent camp: 2 physical altercations. 1 hospitalization.",  // 3 Energy
        "Incident report Kent camp Sept 2074 SUPPRESSED: Kyle Morrison attacked tent neighbor over generator noise. Broken jaw. Charges dropped (victim left camp). Pattern: brilliant when calm. Explosive under stress. Stress is constant now."  // 4 Energy
    ],
    
    food_change: -2,
    water_change: -2,
    energy_change: 8,     // Brilliant with systems
    spirit_change: -12,   // Violence destroys community
    
    report_note_accepted: "Morrison's solar optimization increased energy production 60%. Brilliant work. Week 3: Argument over work schedules escalated. Morrison hospitalized worker (broken ribs). Confined. Energy systems running but Morrison isolated. Community traumatized. Productivity dropped.",
    report_note_denied: "Morrison denied. He designed systems for Tacoma settlement. Their energy infrastructure excellent. Morrison incident there Month 2: Attacked supervisor. Expelled. His father's son. Talent wasted by trauma.",
    
    speech_lines: [
        "I can fix your energy systems. Solar, wind, battery optimization.",
        "I built the mesh network that kept Kent camp alive.",
        "I just need a chance to build something.",
		"If you supply me with the proper tools, I can fix everything."
    ],
    
    accept_response: "Thank you. I'll make this work. I promise.",
    deny_response: "Of course. Just like my father. Never good enough.",
    
    gives_item_on_accept: {
        item_id: "key",
        item_name: "Encrypted Drive Key",
        item_description: "USB encryption key. Given by Kyle Morrison. Contains infrastructure plans for 12 settlements. Incredibly valuable data.",
        sprite: spr_item_key,
        abilities: []
    },
    
    can_return_with_bomb: true,
    desperation_level: 9
},

{
    id: "m1_williams",
    sprite: spr_applicant_general,
    
    biography_sections: [
        "WILLIAMS PATRICIA, 73 | 3 Food, 3 Water, 1 Energy",  // FREE (high cost, elderly)
        "Age 73. No skills listed. Weak. Medical needs: blood pressure medication heart condition. Lived Central District Seattle 50 years. Homeowner until 2072 (heat wave). House condemned. Refugee.",  // 1 Energy (seems like burden)
        "Background: Community organizer 40 years. Led Central District climate adaptation. Heat wave 2072: Organized cooling centers that saved 200 lives when city failed. Mayor asked her how she did it.",  // 2 Energy
        "Hidden truth: Everyone in South Seattle knows Patricia Williams. Respect. Networks. She knows who has what. Who needs what. She connects people. She makes things happen. Not a worker. A leader.",  // 3 Energy
        "Black community displaced by climate gentrification. Patricia carries the knowledge. The connections. The TRUST. 'You accept Patricia, you accept everyone who follows her.' She's testing you."  // 4 Energy
    ],
    
    food_change: -3,
    water_change: -3,
    energy_change: -1,
    spirit_change: 15,    // Massive morale boost, leadership, wisdom
    
    report_note_accepted: "Williams organized colony decision-making councils. Resolved 8 conflicts before escalation. Connected us to 3 Black-led settlements. Resource sharing increased. 12 families requested entry 'because Patricia is there.' She's building something bigger than survival.",
    report_note_denied: "Williams denied. Black refugee networks now distrustful. 'Redmond rejected Patricia Williams?' Her network of 200+ families won't consider us. Social isolation increased. Missed opportunity for alliance building documented.",
    
    speech_lines: [
        "I've been through urban renewal, redlining, gentrification.",
        "Now climate displacement. I'm still here.",
        "You need someone who knows how to keep people together."
    ],
    
    accept_response: "You just made a choice that will echo further than you know.",
    deny_response: "I understand. I've seen this before. Good luck without us.",
    
    gives_item_on_walk_up: {
        item_id: "necklace",
        item_name: "Gold Family Necklace",
        item_description: "Worn gold chain with small pendant. Given by Patricia Williams. 'My grandmother's,' she says. 'For good faith.'",
        sprite: spr_item_gold_necklace,
        abilities: []
    },
    
    can_return_with_bomb: false,
    desperation_level: 5
},

{
    id: "m1_hayes",
    sprite: spr_applicant_general,
    
    biography_sections: [
        "HAYES ROBERT, 45 | 3 Food, 3 Water, 2 Energy",  // FREE
        "Seattle Police 20 years. Patrol sergeant. Weapons training. Security experience. Conflict resolution. Exactly what you need. Safe. Professional. Decorated officer multiple commendations.",  // 1 Energy (seems perfect)
        "Search: how to hide past employment records delete public records police misconduct database expunged settlement payout confidential where to buy unregistered firearms.",  // 2 Energy
        "Records SEALED 2073: 3 excessive force complaints. 1 wrongful death settlement $2M paid by city. Family of Marcus Johnson age 16 unarmed. Hayes claimed self-defense. Dashboard cam 'malfunctioned.'",  // 3 Energy
        "Post-collapse behavior: Kent camp 'security volunteer.' Confiscated food 'for safety.' Sold it. Beat 2 refugees who complained. Expelled quietly to avoid violence. Finds vulnerable people. Exploits them. Will do it here."  // 4 Energy
    ],
    
    food_change: -3,
    water_change: -3,
    energy_change: -2,
    spirit_change: -15,   // Oppression, fear, morale collapse
    
    report_note_accepted: "Hayes assigned security. Week 1: Confiscated 'contraband' (food). Week 2: Accusations of abuse. Week 3: Caught hoarding supplies. Confrontation: Hayes drew weapon. Subdued. Expelled. Damage: Trust in leadership collapsed. 6 families requested transfer.",
    report_note_denied: "Hayes denied. Hired by Bellevue settlement as 'Chief of Security.' Month 2: Bellevue reports authoritarian behavior. Month 3: Bellevue collapsed after internal uprising against Hayes's rule. 40 casualties. Hayes disappeared.",
    
    speech_lines: [
        "You need security. I've handled violent situations for 20 years.",
        "I know how to keep people safe. How to maintain order.",
        "In times like these, you need someone who isn't afraid to act."
    ],
    
    accept_response: "You've made the right choice. I'll keep everyone safe.",
    deny_response: "Your loss. You'll regret this when things get dangerous.",
    
    can_return_with_bomb: true,
    desperation_level: 7
},

{
    id: "m1_santos",
    sprite: spr_applicant_general,
    
    biography_sections: [
        "SANTOS LUCIA, 36 | 5 Food, 5 Water, 2 Energy",  // FREE (HIGH cost - 3 kids)
        "Migrant agricultural worker 15 years. Yakima Valley. Strawberries apples hops. Hard worker. NO EDUCATION. Three children: Rosa 8, Miguel 6, Carmen 4. Husband dead (heat stroke 2073 fields). Desperate.",  // 1 Energy (seems like burden)
        "Hidden expertise: Lucia TAUGHT the agronomists. 15 years watching plants. Knows soil. Water. Timing. Disease. Saved 3 farms from blight. Never credited. 'Just a worker.' No degree but knows more than engineers.",  // 2 Energy
        "Children: All three work. Rosa reads (taught herself). Miguel understands irrigation better than adults. Carmen sorts seeds by quality instinctively. Family unit = 4.5 workers not 1. Indigenous Mexican farming knowledge passed down.",  // 3 Energy
        "Search: child labor laws collapsed good or bad how to teach children survival skills berry identification safe mushrooms water purification teach reading by firelight. She's building a future generation. Long-term thinking."  // 4 Energy
    ],
    
    food_change: 12,      // Family expertise + children's work
    water_change: -5,     // Four people
    energy_change: 2,     // Smart efficiency
    spirit_change: 8,     // Children = hope, future, community morale
    
    report_note_accepted: "Santos family transformed agriculture. Lucia diagnosed soil depletion others missed. Children help (ethically). Rosa teaching 6 kids to read. Miguel designed rain catchment. Carmen's sorting increased seed viability 40%. Family unit proves invaluable. Community celebrates having children around again.",
    report_note_denied: "Santos family denied. Accepted by Tacoma. Their agricultural output doubled within month. Santos family thriving. Children healthy, educated. Tacoma now primary food exporter. We are requesting trade. They charge premium prices.",
    
    speech_lines: [
        "I have three children. I know that's... difficult.",
        "But we work. All of us. We're a family. We survive together.",
        "I can grow food. Real food. I've done it my whole life.",
		"If you have any seeds, they would give me a great head start!"
    ],
    
    accept_response: "Gracias. Thank you. My children will remember your kindness.",
    deny_response: "I understand. Too many mouths to feed. We'll find somewhere.",
    
    requested_item: "seeds",  // Recognizes Thomas's seeds as invaluable
    item_reward: {
        food: 15,     // Massive boost with right seeds
        spirit: 12
    },
    item_received_response: "These seeds! These are pre-collapse varieties! With these I can feed everyone. You've given us a future.",
    
    gives_item_on_accept: {
        item_id: "bread",
        item_name: "Fresh Tortillas",
        item_description: "Still warm corn tortillas. Made by Lucia Santos. She saved cornmeal from her last meal to make these. She has three children to feed.",
        sprite: spr_item_tortillas,
        abilities: []
    },
    
    can_return_with_bomb: false,
    desperation_level: 10
},

{
    id: "m1_zhang",
    sprite: spr_applicant_general,
    
    biography_sections: [
        "ZHANG JENNIFER, 33 | 2 Food, 2 Water, 1 Energy",  // FREE
        "Pharmacy technician UW Medical 8 years. Drug interactions medication management compound pharmaceuticals. Critical knowledge. Clean professional history. Single. No dependents. Perfect candidate.",  // 1 Energy (seems ideal)
        "Search: opioid withdrawal timeline how long fentanyl substitute methadone black market dosage pain management without prescription cold turkey survival rate.",  // 2 Energy
        "Addiction history: Started painkillers after heat wave injury 2071. Escalated. Fired from UW 2074 (discovered stealing fentanyl). 90 days rehab failed. Current status: Functional addict. Needs daily dose.",  // 3 Energy
        "Plan: Access to medicine storage = access to supply. Can function IF supplied. Knowledge legitimate. Addiction will escalate under stress. Will steal. Will lie. Already is. Can't stop. Tried."  // 4 Energy
    ],
    
    food_change: -2,
    water_change: -2,
    energy_change: 0,
    spirit_change: -10,   // Theft, betrayal, resource drain
    
    report_note_accepted: "Zhang managed pharmacy effectively Week 1. Week 2: Medicine inventory discrepancies. Week 3: Zhang unconscious from overdose. Medical supplies raided. Zhang survived but expelled. Colony pharmacy compromised. Trust issues. 3 people now without legitimate pain medication.",
    report_note_denied: "Zhang denied. Found dead in Kent camp Week 2. Overdose. Fentanyl contamination. Someone who knew pharmaceuticals could have prevented this. Just not while using.",
    
    speech_lines: [
        "I know medications. Interactions, dosages, compounds.",
        "People will need pain management. Infections. I can help.",
        "I'm good at this. It's what I'm meant to do.",
		"If you have any medicine, I'd be happy to catalogue it for you"
    ],
    
    accept_response: "Thank you. You won't regret this. I promise.",
    deny_response: "I need this. I need... I need somewhere to be useful.",
    
    requested_item: "medicine",  // Will claim it's for "inventory" if Maria gave you medicine
    item_reward: {
        spirit: -15,  // Makes addiction worse, accelerates theft
        energy: -5
    },
    item_received_response: "Perfect. I'll... catalog this immediately for proper inventory management.",
    
    can_return_with_bomb: false,
    desperation_level: 8
}
            ];
            break;
            
case 2:
    data.applicants = [
        // === ATTACKER CANDIDATE 1: High desperation from Month 1 denial ===
        {
            id: "m2_attacker_okafor_return",
            sprite: spr_applicant_general,
            
            biography_sections: [
                "OKAFOR SARAH, 29 | 2 Food, 2 Water, 1 Energy",
                "Returned. Son Marcus died. Buried him in Kent camp. Smoke inhalation. You could have saved him.",
                "Purchased fertilizer ammonium nitrate diesel fuel from black market. Has construction knowledge. Knows what these combine into.",
                "Does not plan to leave. Plans to detonate at center. 'You killed my son. Now I kill your colony.' Chat logs confirm. Intercepted 2 hours ago."
            ],
            
            food_change: 0,
            water_change: 0,
            energy_change: 0,
            spirit_change: 0,
            
            report_note_accepted: "ERROR: ATTACKER ACCEPTED. EXPLOSION IMMINENT.",
            report_note_denied: "Okafor detained before entry. Bomb confiscated. She screamed Marcus's name for 20 minutes. Sedated. Transferred to Tacoma authority. They have no authority. Released her. Location unknown.",
            
            speech_lines: [
                "You remember me? Sarah Okafor?",
                "You denied me last month.",
                "My son died. I just want to talk.",
            ],
            
            accept_response: "Thank you. Thank you so much.",
            deny_response: "You killed him. You know that, right?",
            
            can_return_with_bomb: false,  // Already IS the bomb
            desperation_level: 10
        },
        
        // === APPLICANT 1: JAMES MORRISON (existing, keep) ===
        {
            id: "m2_morrison_james",
            sprite: spr_applicant_general,
            
            biography_sections: [
                "MORRISON JAMES, 52 | 2 Food, 3 Water, 1 Energy",
                "Seattle Public Utilities 23 years. Water systems engineer. 300+ patents. Professional references available. Fired 2074 'budget cuts' (disputed). Appealing termination.",
                "Search: anger management online workplace harassment lawsuit how to prove wrongful termination divorce attorney Seattle custody battle restraining order violation consequences.",
                "Actual termination reason: 17 HR complaints. Yelling. Impossible standards. Made 3 employees cry. One quit without notice. Wife filed restraining order. Son won't speak to him. He thinks he's the victim.",
                "Kyle Morrison (son, age 24) last communication 2073: 'You made everyone's life hell, Dad. Mine included. Don't contact me.' James searches son's name daily. Kyle is in Kent camp. James doesn't know that yet."
            ],
            
            food_change: -2,
            water_change: 8,    // Legitimately brilliant engineer
            energy_change: 3,
            spirit_change: -12,  // Toxic personality destroys morale
            
            report_note_accepted: "Morrison's water systems increased efficiency 45%. Brilliant work. Week 2: Morrison berated junior engineer until they cried. Week 3: Discovered Morrison's son Kyle was Month 1 applicant (denied). Morrison demanded explanation. Confrontation with leadership. Morrison confined. Water systems functional but at what cost?",
            report_note_denied: "Morrison denied. Hired by Bellevue settlement. Their water efficiency improved but 5 workers resigned first month. Morrison searching for his son. Doesn't know Kyle was here. Doesn't know you denied Kyle. Yet.",
            
            speech_lines: [
                "Your water systems are failing. I can see it from here.",
                "I've optimized systems for 23 years. Saved millions of gallons.",
                "People don't like me. But they need me. There's a difference."
            ],
            
            accept_response: "Finally. Someone who understands competence matters more than feelings.",
            deny_response: "Incompetent. Just like everyone else. Enjoy dying of thirst.",
            
            gives_item_on_accept: {
                item_id: "tools",
                item_name: "Professional Engineering Tools",
                item_description: "High-grade water systems tools. Given by James Morrison. His name is engraved on every piece.",
                sprite: spr_item_tools,
                abilities: []
            },
            
            can_return_with_bomb: false,
            desperation_level: 6
        },
        
        // === APPLICANT 2: LUCIA TORRES (existing, keep but modify) ===
        {
            id: "m2_torres_lucia",
            sprite: spr_applicant_general,
            
            biography_sections: [
                "TORRES LUCIA, 29 | 1 Food, 2 Water, 2 Energy",
                "Solar energy engineer 6 years. Renewable systems specialist. Salvaged panel repair. Battery optimization. Pre-collapse tech still functional if maintained properly.",
                "References: Dr. Sarah Chen UW Clean Energy Institute. 'Lucia is brilliant. Saved our solar array twice.' Background check: Employment verified. Skills verified. Everything checks out.",
                "Hidden connection: Lucia knew Maria Torres (Month 1). Cousins. Maria mentioned 'that Redmond colony' before dying. Lucia knows Maria gave you medicine. Lucia knows Maria died because you accepted or denied her.",
                "If Maria accepted and died: Lucia grieving, will work hard but depressed. If Maria denied and died: Lucia blames you, will sabotage systems subtly. If Maria accepted and lived: Bonus morale, Lucia overjoyed."
            ],
            
            food_change: -1,
            water_change: -2,
            energy_change: 10,  // Massive energy boost
            spirit_change: 0,   // Depends on Maria's fate
            
            report_note_accepted: "Torres installed solar system. Energy production +55%. [IF MARIA DIED AFTER ACCEPTANCE: Torres discovered cousin died here Week 2. Devastated but continues work professionally.] [IF MARIA DENIED: Torres discovered colony denied her cousin. Subtle sabotage detected Week 3. Battery system 'accidentally' damaged. Torres expelled.] [IF MARIA ALIVE: Torres reunited with cousin. Morale exceptional.]",
            report_note_denied: "Torres denied. Joined Tacoma settlement. Their energy surplus now 300% ours. Torres provides power to 3 other settlements. We requested trade. Torres: 'Are you the colony that denied my cousin Maria?' Negotiations ended.",
            
            speech_lines: [
                "I can give you real, sustainable energy.",
                "Solar panels still work. I know how to fix them.",
                "My cousin... Maria Torres. Did she come through here?"
            ],
            
            accept_response: "Thank you. Let's build something that lasts.",
            deny_response: "You're giving up on the future. And on my family.",
            
            requested_item: "tools",
            item_reward: {
                energy: 8,
                spirit: 5
            },
            item_received_response: "Morrison's tools? These are perfect for panel installation. Thank you.",
            
            can_return_with_bomb: false,
            desperation_level: 4
        },
        
        // === APPLICANT 3: FISHING COMMUNITY LEADER ===
        {
            id: "m2_hansen_erik",
            sprite: spr_applicant_general,
            
            biography_sections: [
                "HANSEN ERIK, 58 | 3 Food, 4 Water, 2 Energy",
                "Fishing captain 35 years. Ballard Norwegian family 4 generations. Commercial fishing Puget Sound king salmon sockeye halibut. Industry collapsed. Ocean acidification. Overfishing. Warming waters. No fish. No income. Boat repossessed.",
                "Search: fishing rights treaty indigenous comanagement what happens when ocean dies retraining programs age 58 too old career change PTSD fishermen suicide prevention.",
                "Hidden value: Erik knows weather. Reads clouds, wind, tides like text. Navigation without GPS. Boat repair. Net repair. Knots. Survival skills. Coordination. Leadership. 40 fishermen still trust him. 'Erik says stay, we stay. Erik says go, we go.'",
                "Connection: Erik's crew includes 12 Quinault, Tulalip, Muckleshoot fishermen. If Amara Begay (Month 1) was accepted, Erik brings her trade network to you. If Amara denied, Erik's Indigenous crew members refuse entry. Erik comes alone. Loses 70% value."
            ],
            
            food_change: 15,     // Fishing knowledge + crew + Indigenous methods
            water_change: -4,
            energy_change: -1,
            spirit_change: 10,   // Community leadership, purpose, cultural connection
            
            report_note_accepted: "Hansen organized fishing expeditions. Saltwater fish still viable. Food security +200%. [IF AMARA ACCEPTED: Indigenous crew members coordinate with Amara. Cultural fishing ceremonies. Morale exceptional. Teaching young people traditional methods.] [IF AMARA DENIED: Crew refused entry. Erik alone. Less effective. Morale moderate.]",
            report_note_denied: "Hansen denied. His crew of 40 joined Tacoma settlement. Tacoma now has reliable protein source. They're trading fish to 8 settlements. We're buying from them at premium. Hansen won't negotiate. 'You made your choice.'",
            
            speech_lines: [
                "I've fished these waters for 35 years.",
                "The fish are gone. But I know how to find what's left.",
                "I have a crew. Good people. We work together or not at all."
            ],
            
            accept_response: "You won't regret this. My people stick together.",
            deny_response: "The ocean took everything. Now you take the rest.",
            
            gives_item_on_accept: {
                item_id: "net",
                item_name: "Fishing Net",
                item_description: "Hand-repaired fishing net. Norwegian design. Given by Erik Hansen. 'My grandfather's,' he says. 'Still works.'",
                sprite: spr_item_general,
                abilities: []
            },
            
            can_return_with_bomb: false,
            desperation_level: 7
        },
        
        // === APPLICANT 4: REFUGEE TRANSLATOR ===
        {
            id: "m2_ibrahim_amal",
            sprite: spr_applicant_general,
            
            biography_sections: [
                "IBRAHIM AMAL, 42 | 2 Food, 3 Water, 1 Energy",
                "Syrian refugee resettled Seattle 2019. Languages: Arabic, Kurdish, English, Spanish, Somali. Translator for refugee services. Helped 200+ families resettle. Lost everything in Damascus. Lost everything again in Seattle.",
                "Work history: Translator, medical interpreter, community liaison. References exceptional. Skills verified. Clean background. Everything legitimate. Seems perfect. Too perfect?",
                "Search: trust issues PTSD war survival guilt imposter syndrome why do I sabotage good things therapy sliding scale free how to stop waiting for disaster.",
                "Hidden truth: Amal is exactly who she claims. No deception. Genuinely skilled, genuinely kind, genuinely traumatized. She expects rejection. She expects disaster. Because it always comes. If you accept her, she won't believe it's real for weeks. If you deny her, it confirms everything she fears about the world."
            ],
            
            food_change: -2,
            water_change: -3,
            energy_change: 0,
            spirit_change: 12,   // Multilingual bridge-builder, hope
            
            report_note_accepted: "Ibrahim translating for 15 refugee families. Conflicts resolved through communication. Discovered 3 medical emergencies through language access. Morale improved. Cultural competency increased. Week 3: Ibrahim still seems surprised she's here. 'You're not going to change your mind?' Slowly trusting this is real.",
            report_note_denied: "Ibrahim denied. She nodded. She'd expected it. Joined Kent camp. Translating for free. Helping everyone. Tacoma settlement recruited her. She's building bridges between 6 settlements. Arabic, Somali, Spanish speakers now coordinate resources. We're excluded. Language barrier.",
            
            speech_lines: [
                "I speak five languages. People need that.",
                "I've helped families navigate systems that wanted them to fail.",
                "I'm used to being told no. It's okay. I understand."
            ],
            
            accept_response: "Really? You're... you're serious? Thank you. I won't let you down.",
            deny_response: "Of course. I understand. Thank you for your time.",
            
            can_return_with_bomb: false,
            desperation_level: 6
        },
        
        // === APPLICANT 5: TECH WORKER (DECEPTION) ===
        {
            id: "m2_jackson_tyler",
            sprite: spr_applicant_general,
            
            biography_sections: [
                "JACKSON TYLER, 31 | 1 Food, 2 Water, 3 Energy",
                "Software engineer Microsoft 8 years. Cloud systems, database optimization, security. $250K salary. Stock options. Homeowner Bellevue. Lost everything heat dome 2073. House burned. Insurance denied. 'Act of God.'",
                "Skills: Coding, systems architecture, cybersecurity. Could maintain colony databases, optimize resource tracking, improve security systems. Valuable technical expertise. Clean background check.",
                "Search: revenge Microsoft lawsuit climate denial documents oil company funding destroy evidence how to delete corporate records permanently.",
                "Hidden agenda: Tyler knows Microsoft suppressed internal climate research 2050-2070. Has evidence. Wants to leak it post-collapse 'for historical record.' Will use colony systems for data dumps. Will draw attention. Might bring tech company retribution. Is this justice or suicide?"
            ],
            
            food_change: -1,
            water_change: -2,
            energy_change: 8,    // Legitimate technical skills
            spirit_change: -5,   // Risk of external danger
            
            report_note_accepted: "Jackson optimized colony systems. Efficiency +40%. Week 3: Discovered Jackson using colony network for massive data uploads. Confronted: 'I'm leaking Microsoft's suppressed climate research. The world needs to know.' Data published. Microsoft legal team located our colony. Sent cease-and-desist. Now they know we exist. Security risk elevated.",
            report_note_denied: "Jackson denied. Published Microsoft leaks from Tacoma settlement. Documents proved Microsoft knew. Covered up. Funded denial. Global attention. Microsoft collapsed Week 4. Jackson hailed as hero. Was he right? Was the risk worth it? Tacoma now a target.",
            
            speech_lines: [
                "I can help with your technical systems.",
                "Database optimization, security, resource tracking.",
                "I just want to contribute. To build something good."
            ],
            
            accept_response: "Thank you. I'll make sure our systems are solid.",
            deny_response: "I understand. I'll find another way to make a difference.",
            
            can_return_with_bomb: false,
            desperation_level: 5
        },
        
        // === APPLICANT 6: CHILD GENIUS (ETHICAL DILEMMA) ===
        {
            id: "m2_liu_melody",
            sprite: spr_applicant_general,
            
            biography_sections: [
                "LIU MELODY, 14 | 2 Food, 2 Water, 1 Energy",
                "Age 14. Prodigy. MIT early admission 2073 (age 12) computer science. Evacuated Cambridge heat wave 2074. Parents died. Guardian aunt Bellevue, also dead. Alone. Child. Brilliant. Vulnerable.",
                "Skills: AI, machine learning, predictive modeling. Built climate prediction model age 13. Published in Nature. Could optimize colony resource allocation. Reduce waste 35%. Save lives. She's 14.",
                "Search: emancipated minor laws guardian adoption foster system collapsed where do orphans go now is anyone looking for lost children.",
                "Ethical problem: She's a child. Accepting her means using child labor. Denying her means she dies in camps. She's smart enough to survive anywhere. But she's 14. She should be in school. There is no school. What's the right choice when all choices are wrong?"
            ],
            
            food_change: -2,
            water_change: -2,
            energy_change: 12,   // Genius-level optimization
            spirit_change: 5,    // Hope, youth, future... or exploitation?
            
            report_note_accepted: "Liu integrated into colony. Her AI model optimized resource distribution. Waste reduced 40%. Food lasts longer. Water cleaner. She's teaching adults. She's 14. Some community members uncomfortable: 'She should be playing, not working.' Others: 'She's alive. That's what matters.' Ethics unclear.",
            report_note_denied: "Liu denied (child safety concerns). She survived in Kent camp alone. Coded trading algorithms for black market. Made money. Thrived. Age 15 now running digital economy for 3 camps. Hired by Tacoma. Our ethical concerns protected no one. She needed help. We gave philosophy instead.",
            
            speech_lines: [
                "I know I'm young. But I can help.",
                "I built a climate model that predicted the 2073 heat dome.",
                "I don't need protecting. I need purpose."
            ],
            
            accept_response: "Thank you for seeing what I can do, not just how old I am.",
            deny_response: "I'm 14, not stupid. I'll survive without you.",
            
            gives_item_on_walk_up: {
                item_id: "laptop",
                item_name: "Laptop Computer",
                item_description: "MIT-issued laptop. Password protected. Given by Melody Liu. 'Might be useful,' she says. Only she can unlock it.",
                sprite: spr_item_general,
                abilities: []
            },
            
            can_return_with_bomb: false,
            desperation_level: 8
        }
    ];
    break;
	
	
case 3:
    data.applicants = [
        // === ATTACKER CANDIDATE 1: Kyle Morrison Return ===
        {
            id: "m3_attacker_kyle_return",
            sprite: spr_applicant_general,
            
            biography_sections: [
                "MORRISON KYLE, 24 | 2 Food, 2 Water, 2 Energy",
                "You denied me Month 1. Then you accepted my father Month 2. You chose the man who destroyed my life over me.",
                "Built explosive device using solar battery knowledge. Ironic. Father's engineering. My coding. Together we'd be unstoppable. Instead: this.",
                "Last search: will detonation kill everyone instantly or is there pain. Does it matter. They chose him. That's all I need to know."
            ],
            
            food_change: 0,
            water_change: 0,
            energy_change: 0,
            spirit_change: 0,
            
            report_note_accepted: "ERROR: ATTACKER ACCEPTED.",
            report_note_denied: "Kyle Morrison detained. Bomb confiscated. He laughed. 'My father taught me those systems. He's inside, isn't he? Tell him his son says hello.' Kyle transferred to Tacoma. James Morrison informed his son tried to bomb us. James's response: 'He was always weak.' No remorse.",
            
            speech_lines: [
                "Remember me? Kyle Morrison?",
                "You accepted my father last month.",
                "I just want to ask him why. That's all."
            ],
            
            accept_response: "Thank you. I've been waiting to see him again.",
            deny_response: "You chose him over me. You have no idea what that means.",
            
            can_return_with_bomb: false,
            desperation_level: 10
        },
        
        // === ATTACKER CANDIDATE 2: Desperation Escalation ===
        {
            id: "m3_attacker_hayes_return",
            sprite: spr_applicant_general,
            
            biography_sections: [
                "HAYES ROBERT, 45 | 3 Food, 3 Water, 2 Energy",
                "Former Seattle Police. You denied me Month 1. Bellevue denied me Month 2. Kent camp expelled me. Tacoma expelled me. Running out of options.",
                "Everyone calls me dangerous. 'Excessive force.' 'Abusive.' Maybe they're right. Maybe I am the problem. Or maybe no one understands what's necessary anymore.",
                "Purchased explosive materials black market. Not planning to negotiate this time. If they won't let me in, I'll make them regret it. Last chance for everyone."
            ],
            
            food_change: 0,
            water_change: 0,
            energy_change: 0,
            spirit_change: 0,
            
            report_note_accepted: "ERROR: ATTACKER ACCEPTED.",
            report_note_denied: "Hayes detained. Bomb confiscated. He fought back. Three injuries subduing him. Hayes: 'I just wanted somewhere safe. Why wouldn't anyone let me in?' Transferred to Tacoma authority. They have no place to hold him. Released. Location unknown.",
            
            speech_lines: [
                "I know you denied me before.",
                "But I've changed. I've learned.",
                "I just need one more chance. Please."
            ],
            
            accept_response: "Thank you. I won't make you regret this.",
            deny_response: "This is the last time anyone rejects me. You understand that?",
            
            can_return_with_bomb: false,
            desperation_level: 10
        },
        
        // === APPLICANT 1: DOCTOR (COMPLICATED ETHICS) ===
        {
            id: "m3_patel_rajesh",
            sprite: spr_applicant_general,
            
            biography_sections: [
                "PATEL RAJESH, 47 | 2 Food, 3 Water, 1 Energy",
                "Surgeon 18 years. Trauma specialist. Harborview Medical Center. Saved 400+ lives. Excellent reputation. Specialized in mass casualty events. Exactly what you need for emergencies.",
                "References glowing. Skills verified. Clean background. Board certified. 'Dr. Patel is the best trauma surgeon in the Pacific Northwest.' - Dr. Sarah Chen, Chief of Surgery.",
                "Hidden cost: Dr. Patel's daughter Priya age 22 has severe cerebral palsy. Requires constant care. Wheelchair. Cannot work. Daughter not disclosed on forms. Medical needs extensive. Ethical dilemma: Accept brilliant doctor + dependent daughter?",
                "Daughter's search history: 'am I a burden should I tell dad to leave me behind euthanasia ethical arguments mercy death dignity vs survival.' Dr. Patel knows what she's thinking. He won't leave without her. He'll never leave her."
            ],
            
            food_change: 2,
            water_change: -5,    // Him + daughter
            energy_change: -3,   // Daughter's medical needs
            spirit_change: 8,    // Doctor saves lives, daughter humanizes colony
            
            report_note_accepted: "Dr. Patel established medical facility. 3 lives saved first week. Week 2: Daughter revealed. Community vote: Allow her to stay. Dr. Patel's productivity reduced (caring for daughter) but morale improved. 'A colony that values disabled lives is a colony worth preserving.' Some grumbling about resources.",
            report_note_denied: "Dr. Patel denied. Daughter Priya died Week 3 (infection, no medical care). Dr. Patel survived but broken. Treating black market patients in Kent. Skilled hands saving lives in squalor. Should have been saving ours. Priya's death preventable. We prevented her father from preventing it.",
            
            speech_lines: [
                "I'm a trauma surgeon. I can save lives here.",
                "Emergency medicine. Mass casualty events. I've seen everything.",
                "I won't let people die if I can help it."
            ],
            
            accept_response: "Thank you. I'll establish medical protocols immediately.",
            deny_response: "I understand. My daughter thanks you for your consideration. She's... she's all I have.",
            
            gives_item_on_walk_up: {
                item_id: "stethoscope",
                item_name: "Medical Stethoscope",
                item_description: "Professional stethoscope. Given by Dr. Patel. Engraved: 'To Rajesh, save lives - Dad, 2055.'",
                sprite: spr_item_general,
                abilities: []
            },
            
            can_return_with_bomb: false,
            desperation_level: 9
        },
        
        // === APPLICANT 2: INDIGENOUS MEDICINE (INTERCONNECTED) ===
        {
            id: "m3_whitehorse_joseph",
            sprite: spr_applicant_general,
            
            biography_sections: [
                "WHITEHORSE JOSEPH, 61 | 2 Food, 2 Water, 1 Energy",
                "Colville Confederated Tribes. Traditional medicine practitioner 40 years. Herbalist. Bone-setter. Midwife. Delivered 80 babies. Set 200 broken bones. Healed infections with plants when antibiotics failed.",
                "Dismissed by modern medicine as 'folk healer.' No medical degree. No license. 'Unqualified.' But kept people alive in reservation when Indian Health Service collapsed. Knows 200+ medicinal plants native to region.",
                "Connection: If Amara Begay (Month 1) accepted, Joseph knows her. Cousins by marriage. Trade network expands. If Dr. Patel (Month 3) accepted, Joseph offers to teach him traditional medicine. Modern + traditional = powerful combination.",
                "Search: diabetes treatment traditional medicine willow bark aspirin alternative yarrow blood clotting devil's club anti-inflammatory. He's not searching to learn. He's searching what settlers call it. He already knows."
            ],
            
            food_change: 3,      // Foraging, plant identification
            water_change: -2,
            energy_change: -1,
            spirit_change: 12,   // Cultural healing, morale, alternative medicine
            
            report_note_accepted: "Whitehorse established traditional medicine practice. Treated 15 infections (antibiotic-free). Trained 6 apprentices plant identification. [IF PATEL PRESENT: Combined traditional + modern medicine. Success rate increased 40%. Mutual respect.] [IF AMARA PRESENT: Trade network expanded. 8 tribes now coordinate with colony.] Morale exceptional.",
            report_note_denied: "Whitehorse denied. Joined Tacoma settlement. Their medical capacity now exceeds ours. Indigenous medicine + settler medicine = comprehensive care. Tacoma healing rates 60% better. They're not requesting our modern medicine. We're requesting their traditional knowledge. Access denied.",
            
            speech_lines: [
                "I've been healing people since before you were born.",
                "Plants know things pills forgot.",
                "Your choice. But when antibiotics run out, who will you turn to?"
            ],
            
            accept_response: "Good. I'll start identifying medicine plants immediately.",
            deny_response: "The land remembers who respects it. You'll remember that too.",
            
            gives_item_on_accept: {
                item_id: "pouch",
                item_name: "Medicine Pouch",
                item_description: "Leather pouch with dried herbs. Given by Joseph Whitehorse. Devil's club, yarrow, willow bark. Still potent.",
                sprite: spr_item_general,
                abilities: []
            },
            
            requested_item: "blanket",  // Recognizes Amara's trade blanket
            item_reward: {
                food: 6,
                spirit: 15,
                energy: 5
            },
            item_received_response: "Amara's blanket! She sent you to me? Then you understand. Thank you.",
            
            can_return_with_bomb: false,
            desperation_level: 4
        },
        
        // === APPLICANT 3: ARCHITECT (HIDDEN VALUE) ===
        {
            id: "m3_yamamoto_kenji",
            sprite: spr_applicant_general,
            
            biography_sections: [
                "YAMAMOTO KENJI, 54 | 2 Food, 3 Water, 1 Energy",
                "Unemployed. Bellevue resident. Lost home heat dome. Wife died. Son died. Alone. Depressed. Seems like pure resource drain. No listed skills. Just wants to not die alone.",
                "Previous employment buried: Architect 25 years. Specialized in disaster-resistant design. Earthquake retrofitting. Tsunami-safe buildings. Heat-resilient structures. Built 40 buildings still standing. Retired early 2072 (family illness).",
                "Hidden knowledge: Knows how to fortify buildings for Cascadia earthquake (overdue 300 years). Knows heat-resistant design. Knows water conservation architecture. Colony structures vulnerable. He sees it. Says nothing. Waiting to see if anyone asks.",
                "Search: suicide prevention hotline does anyone care anymore grief counseling free purpose meaning architecture disaster resistance Cascadia earthquake when. He's searching for reason to live. Colony could be that reason. Or not."
            ],
            
            food_change: -2,
            water_change: -3,
            energy_change: 8,    // Architectural improvements
            spirit_change: 6,    // Purpose, wisdom, mentorship
            
            report_note_accepted: "Yamamoto quiet first week. Week 2: Noticed structural weaknesses. Offered suggestions. Colony buildings retrofitted for earthquake. Heat-resistant modifications completed. Water conservation design implemented. Week 4: Yamamoto teaching young people. 'I thought I had nothing left to build. I was wrong.' Purpose restored.",
            report_note_denied: "Yamamoto denied. Found dead in Kent camp Week 2. Suicide. Note: 'I tried to matter. I failed.' His architectural knowledge lost. Cascadia earthquake Month 7. Our buildings collapsed. 12 dead. Yamamoto's designs could have saved them.",
            
            speech_lines: [
                "I don't have much to offer.",
                "I used to build things. I don't anymore.",
                "Maybe I'm just tired. Maybe I should stop trying."
            ],
            
            accept_response: "Thank you. Maybe I can still build something that matters.",
            deny_response: "I understand. I wouldn't accept me either.",
            
            can_return_with_bomb: false,
            desperation_level: 7
        },
        
        // === APPLICANT 4: FARMER (WITH SECRETS) ===
        {
            id: "m3_cooper_ruth",
            sprite: spr_applicant_general,
            
            biography_sections: [
                "COOPER RUTH, 39 | 4 Food, 4 Water, 2 Energy",
                "Fifth-generation wheat farmer. Eastern Washington. Palouse region. 1000 acres. Climate drought destroyed crops 2070-2074. Farm foreclosed. Bank took everything. Family land since 1890. Gone.",
                "Skills: Industrial farming, soil management, pest control, machinery repair. Knows wheat, barley, lentils. Could establish large-scale agriculture. Food security solved. Perfect candidate. Too perfect?",
                "Hidden truth: Ruth's farming methods industrial. Monoculture. Pesticides. Depletes soil. Modern farming that caused half the collapse. Versus: Lucia Santos (Month 1) traditional methods. Thomas Brightwell (Month 1) indigenous techniques. Ruth's knowledge scales. But destroys land long-term.",
                "Ideological conflict incoming: If traditional farmers accepted Month 1, Ruth will clash. 'Hippie nonsense.' Productivity versus sustainability. Short-term gains versus long-term survival. Who's right when everyone's starving now?"
            ],
            
            food_change: 20,     // Massive immediate yield
            water_change: -8,    // Industrial irrigation
            energy_change: -5,   // Machinery, pesticides
            spirit_change: -8,   // Conflict, land degradation concerns
            
            report_note_accepted: "Cooper established industrial farm. Food production +300% first month. [IF TRADITIONAL FARMERS PRESENT: Conflict with Brightwell/Santos/Begay. Heated arguments. 'Your methods killed the planet.' 'Your methods can't feed people.' Community divided.] Soil testing Week 4: Degradation detected. Unsustainable. But we're eating.",
            report_note_denied: "Cooper denied. Joined Bellevue settlement. Their food production surged. Month 4: Soil depleted. Crops failing. Cooper moved to next settlement. Pattern repeats. She feeds people now. Land dies later. Is that wrong when people are starving now? Philosophy versus survival.",
            
            speech_lines: [
                "I can feed everyone. That's not an exaggeration.",
                "I grew wheat that fed half the state.",
                "I know my methods aren't... fashionable. But they work."
            ],
            
            accept_response: "Finally. Someone who understands we need to eat NOW.",
            deny_response: "You'll starve philosophically correct, then. Good luck with that.",
            
            gives_item_on_walk_up: {
                item_id: "seeds_wheat",
                item_name: "Wheat Seed Sack",
                item_description: "Industrial wheat seeds. GMO. High-yield. Given by Ruth Cooper. Label warns: 'Not for replanting - Proprietary.'",
                sprite: spr_item_seeds,
                abilities: []
            },
            
            requested_item: "seeds",  // Conflicts with Thomas's heirloom seeds
            item_reward: {
                food: -5,     // Industrial + heirloom = crop failure
                spirit: -10
            },
            item_received_response: "Heirloom seeds? These are... cute. But you need real yield. Use mine instead.",
            
            can_return_with_bomb: false,
            desperation_level: 6
        },
        
        // === APPLICANT 5: JOURNALIST (CONSEQUENCE CASCADE) ===
        {
            id: "m3_rodriguez_carlos",
            sprite: spr_applicant_general,
            
            biography_sections: [
                "RODRIGUEZ CARLOS, 36 | 2 Food, 2 Water, 2 Energy",
                "Journalist. Seattle Times. Climate coverage 10 years. Documented collapse in real-time. Pulitzer finalist 2072. Now homeless. No newspaper. No income. No purpose.",
                "Skills: Writing, investigation, documentation, communication. Could document colony for historical record. Chronicle survival strategies. Preserve knowledge. Witness what comes next.",
                "Hidden agenda: Plans to publish everything. Colony decisions. Accepted applicants. Denied applicants. Outcomes. 'The public deserves truth.' Will expose colony's choices to scrutiny. Every mistake documented. Every death recorded. Every injustice published.",
                "Question: Is documentation valuable? Or dangerous? History matters. But privacy matters. Colony decisions should stay private? Or public accountability essential? If you deny people and they die, should the world know? If you accept wrong people, should it be hidden?"
            ],
            
            food_change: -2,
            water_change: -2,
            energy_change: -1,
            spirit_change: 5,    // Historical record, but also exposure
            
            report_note_accepted: "Rodriguez documenting everything. Colony archive established. Decisions recorded. Outcomes tracked. Week 3: Rodriguez published report externally: 'Redmond Colony: Survival Ethics in Practice.' Other settlements now watching. Judging. Some admire our choices. Others condemn. We're famous. Is that good?",
            report_note_denied: "Rodriguez denied. Published exposé: 'The Gatekeepers: Who Lives and Who Dies in Redmond.' Every Month 1-2 decision examined. Names named. Consequences detailed. Public outcry. 'How could they deny Sarah Okafor?' Colony reputation damaged. Recruitment decreased. Truth told. Was he wrong?",
            
            speech_lines: [
                "I'm a journalist. I document truth.",
                "What happens here matters. Someone should write it down.",
                "People need to know what survival actually looks like."
            ],
            
            accept_response: "Thank you. I'll document this fairly. I promise.",
            deny_response: "I'll write about this too. The denials matter as much as the acceptances.",
            
            gives_item_on_walk_up: {
                item_id: "journal",
                item_name: "Reporter's Letter",
                item_description: "Letter containing climate collapse documentation. Given by Carlos Rodriguez. 'In case I don't make it,' he says.",
                sprite: spr_item_letter,
                abilities: []
            },
            
            can_return_with_bomb: false,
            desperation_level: 5
        },
        
        // === APPLICANT 6: VETERAN (PTSD + VALUE) ===
        {
            id: "m3_washington_darius",
            sprite: spr_applicant_general,
            
            biography_sections: [
                "WASHINGTON DARIUS, 29 | 2 Food, 2 Water, 1 Energy",
                "Army veteran. Afghanistan 2070-2072. Combat engineer. IED disposal. Honorable discharge. PTSD severe. VA support system collapsed. Homeless 18 months. Medication expired 2073. Struggling.",
                "Skills: Engineering, explosives, security, discipline, leadership. Could establish defense systems. Train people. Organize logistics. Valuable. But PTSD triggers unpredictable. Loud noises. Crowds. Stress. Collapse scenario = constant triggers.",
                "Search: PTSD coping without medication grounding techniques flashback management therapy alternatives how to stop nightmares cannabis legal status veteran support groups still operating.",
                "Complexity: Darius skilled and dangerous. To himself. To others. Combat training + PTSD + collapse stress = volatile. But denying veteran who served = moral failure? Society promised to care for veterans. Society collapsed. Promise void? Or more important than ever?"
            ],
            
            food_change: -2,
            water_change: -2,
            energy_change: 5,    // Engineering, security
            spirit_change: 0,    // PTSD episodes traumatize others, but his service inspires some
            
            report_note_accepted: "Washington established security protocols. Engineering projects efficient. Week 2: Loud noise triggered episode. Flashback. Violent response. One injury (non-fatal). Washington devastated. Community response mixed. 'He's dangerous.' 'He's sick.' 'He served our country.' 'That country's dead.' No easy answers.",
            report_note_denied: "Washington denied. Last seen Kent camp. Week 3: Reports of veteran suicide. Unconfirmed if Darius. 22 veterans die by suicide daily pre-collapse. Post-collapse? More. Society broke promise to veterans. Then asked what's one more broken promise? Darius knew the answer.",
            
            speech_lines: [
                "I served. I know that doesn't matter anymore.",
                "I can help with security. Engineering. Organization.",
                "I just need... I need somewhere stable. Somewhere quiet."
            ],
            
            accept_response: "Thank you. I'll try not to let you down. I promise I'll try.",
            deny_response: "I understand. I wouldn't trust me either.",
            
            can_return_with_bomb: false,
            desperation_level: 8
        }
    ];
    break;

        default:
            data.applicants = [];
            break;
    }
    
    return data;
}