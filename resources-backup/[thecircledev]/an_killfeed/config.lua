Config = {}

-- Join Discord for Support: https://discord.gg/KxdPzC5EeJ

-- General Configuration --
Config.showTime = 7500 -- How long a line should show in the kill feed? ( in milliseconds )
Config.maxKillLines = 8 -- Maximum number of lines the kill feed can show, after this number, new lines will force the previous ones to hide
Config.distanceUnit = "m" -- Distance Calculation Unit | "m" for meters // "ft" for feet
Config.ShowHideCommand = "killfeed" -- Command name for the player to show/hide the kill feed
Config.enableDemo = false -- Enables the test commands: /testkillfeed - /spawntestpeds - /customdeaths
Config.webhook = "https://discord.com/api/webhooks/1056799753360388126/Sw9BssZoIeY-Gq3sAVhMzpCHxMgra9SHHnAXc-_YBM4B-gBbUP5CT9fEUX8tCCXsvG2d" -- Discod Log Webhook ( Config.enableLog must be enabled )

-- Features Configuration --
Config.showDriveBy = true -- Whether or not to show the driveby icons
Config.showNoScope = true -- Show noscope icon when it's a No Scoped Kill
Config.showHeadshot = true -- Show Headshot icon when the kill is a headshot one
Config.showKillDist = true -- Whether to show kill distance or not ( only applicable to weapons that have the showDist set to true in Config.weapons )
Config.includeNPCs = true -- Whether to include deaths and kills involving NPCs
Config.includeAnimals = true -- Whether to include deaths and kills involving NPC Animals
Config.enableLog = false -- Whether to enable logging to discord webhook

-- NPCs Configuration --
Config.NPCText = true -- Adds a text before the NPC
Config.NPCTextLabel = "[Local] " -- The text to add before the NPC
Config.randomNPCNames = true -- Whether to use random names for NPCS ( e.g: Alfred, Sam, Mike ... ), if this is set to false, it will show the entity ID (e.g: 654768412)
Config.AnimalText = false -- -- Adds a text before the Animal NPC
Config.AnimalTextLabel = "[Animal] " -- The text to add before the NPC Animal

-- --
-- --
-- --
-- -- If you need help integrating this script to your framework or need help to work with custom death reasons, join our discord: https://discord.gg/KxdPzC5EeJ
-- --
-- --
-- --
-- -- If you need help integrating this script to your framework or need help to work with custom death reasons, join our discord: https://discord.gg/KxdPzC5EeJ
-- --
-- --
-- --
-- -- If you need help integrating this script to your framework or need help to work with custom death reasons, join our discord: https://discord.gg/KxdPzC5EeJ
-- --
-- --
-- --
-- --
-- --
-- --
-- --
-- --
-- --
-- --
-- --
-- --
-- --
-- --
-- --
-- --
-- --
-- --
-- --
-- --
-- --
-- --
-- --
-- --
-- --
-- --
-- --
-- --
-- --
-- --
-- --

-- Advanced Configuration --
Config.weapons = { 
    ----- GUIDE ------
    ---- HS = Weapon can kill with a headshot
    ---- canDB = Weapon can be used in a driveby
    ---- canNS = Weapon can show the no scope icon if the killer did not aim down sight
    ---- showDist = If set to true, the kill distance will show up on the feed ( if Config.showKillDist is set to true as well ofc )
    ---- canKillSelf = If set, it will skip showing a player killed itself with this weapon

    -- Melees --
    [-1569615261] = { image = "WEAPON_UNARMED", HS = false },
    [-1716189206] = { image = "WEAPON_KNIFE", HS = false },
    [1737195953] = { image = "WEAPON_NIGHTSTICK", HS = false },
    [1317494643] = { image = "WEAPON_HAMMER", HS = false },
    [-1786099057] = { image = "WEAPON_BAT", HS = false }, 
    [-2067956739] = { image = "WEAPON_CROWBAR", HS = false }, 
    [1141786504] = { image = "WEAPON_GOLFCLUB", HS = false }, 
    [-102323637] = { image = "WEAPON_BOTTLE", HS = false }, 
    [-1834847097] = { image = "WEAPON_DAGGER", HS = false }, 
    [-102973651] = { image = "WEAPON_HATCHET", HS = false },
    [-656458692] = { image = "WEAPON_KNUCKLE", HS = false }, 
    [-581044007] = { image = "WEAPON_MACHETE", HS = false },  
    [-1951375401] = { image = "WEAPON_FLASHLIGHT", HS = false }, 
    [-538741184] = { image = "WEAPON_SWITCHBLADE", HS = false }, 
    [-853065399] = { image = "WEAPON_BATTLEAXE", HS = false },
    [GetHashKey("WEAPON_POOLCUE")] = { image = "WEAPON_POOLCUE", HS = false },
    [GetHashKey("WEAPON_POOLCUE_B")] = { image = "WEAPON_POOLCUE", HS = false },
    [GetHashKey("WEAPON_POOLCUE_G")] = { image = "WEAPON_POOLCUE", HS = false },
    [GetHashKey("R_WEAPON_POOLCUE")] = { image = "WEAPON_POOLCUE", HS = true },
    [GetHashKey("R_WEAPON_MACHETE")] = { image = "WEAPON_HATCHET", HS = false },
    [GetHashKey("R_WEAPON_GOLFCLUB")] = { image = "WEAPON_GOLFCLUB", HS = false },
    [GetHashKey("R_WEAPON_BOTTLE")] = { image = "WEAPON_BOTTLE", HS = false },
    [GetHashKey("R_WEAPON_BAT")] = { image = "WEAPON_BAT", HS = false },
    [GetHashKey("R_WEAPON_KNUCKLE")] = { image = "WEAPON_KNUCKLE", HS = false },
    [GetHashKey("R_WEAPON_DAGGER")] = { image = "WEAPON_DAGGER", HS = false },
    [GetHashKey("R_WEAPON_KNIFE")] = { image = "WEAPON_KNIFE", HS = false },
    [-1810795771] = { image = "WEAPON_POOLCUE", HS = false },
    [419712736] = { image = "WEAPON_WRENCH", HS = false },
    [940833800] = { image = "WEAPON_STONE_HATCHET", HS = false },  

    -- Handguns --
    [453432689] = { image = "WEAPON_PISTOL", canDB = true },
    [-1075685676] = { image = "WEAPON_PISTOL_MK2", canDB = true },                
    [1593441988] = { image = "WEAPON_COMBATPISTOL", canDB = true },    
    [-1716589765] = { image = "WEAPON_PISTOL50", canDB = true },    
    [-1076751822] = { image = "WEAPON_SNSPISTOL", canDB = true },     
    [-2009644972] = { image = "WEAPON_SNSPISTOL_MK2", canDB = true },  
    [-771403250] = { image = "WEAPON_HEAVYPISTOL", canDB = true },    
    [137902532] = { image = "WEAPON_VINTAGEPISTOL", canDB = true },      
    [727643628] = { image = "WEAPON_CERAMICPISTOL", canDB = true },   
    [-598887786] = { image = "WEAPON_MARKSMANPISTOL", canDB = true },  
    [-1045183535] = { image = "WEAPON_REVOLVER", canDB = true },                   
    [-879347409] = { image = "WEAPON_REVOLVER_MK2", canDB = true },              
    [-1746263880] = { image = "WEAPON_DOUBLEACTION", canDB = true },      
    [-1853920116] = { image = "WEAPON_NAVYREVOLVER", canDB = true },          
    [1470379660] = { image = "WEAPON_GADGETPISTOL", canDB = true },  
    [584646201] = { image = "WEAPON_APPISTOL", canDB = true },      
    [911657153] = { image = "WEAPON_STUNGUN", canDB = true, HS = false }, 
    [1171102963] = { image = "WEAPON_STUNGUN_MP", canDB = true, HS = false }, 
    [1198879012] = { image = "WEAPON_FLAREGUN", canDB = true, HS = false },  
    [-1355376991] = { image = "WEAPON_RAYPISTOL", HS = false }, 
    
    -- Submachine Guns --
    [324215364] = { image = "WEAPON_MICROSMG", canDB = true },   
    [-619010992] = { image = "WEAPON_MACHINEPISTOL", canDB = true }, 
    [-1121678507] = { image = "WEAPON_MINISMG", canDB = true },  
    [736523883] = { image = "WEAPON_SMG" },       
    [2024373456] = { image = "WEAPON_SMG_MK2" },       
    [-270015777] = { image = "WEAPON_ASSAULTSMG" },  
    [171789620] = { image = "WEAPON_COMBATPDW" },    
    [-1660422300] = { image = "WEAPON_MG" },     
    [2144741730] = { image = "WEAPON_COMBATMG" },      
    [-608341376] = { image = "WEAPON_COMBATMG_MK2" }, 
    [1627465347] = { image = "WEAPON_GUSENBERG" },   
    [1198256469] = { image = "WEAPON_RAYCARBINE" }, 
   
    -- Assault Rifles --
    [-1074790547] = { image = "WEAPON_ASSAULTRIFLE" },   
    [961495388] = { image = "WEAPON_ASSAULTRIFLE_MK2" },  
    [-2084633992] = { image = "WEAPON_CARBINERIFLE" },   
    [-86904375] = { image = "WEAPON_CARBINERIFLE_MK2" },  
    [-1357824103] = { image = "WEAPON_ADVANCEDRIFLE" },  
    [-1063057011] = { image = "WEAPON_SPECIALCARBINE" },  
    [-1768145561] = { image = "WEAPON_SPECIALCARBINE_MK2" },
    [2132975508] = { image = "WEAPON_BULLPUPRIFLE" },     
    [-2066285827] = { image = "WEAPON_BULLPUPRIFLE_MK2" }, 
    [1649403952] = { image = "WEAPON_COMPACTRIFLE" },    
    [-1658906650] = { image = "WEAPON_MILITARYRIFLE" },   
    [-947031628] = { image = "WEAPON_HEAVYRIFLE" },    
    [-774507221] = { image = "WEAPON_TACTICALRIFLE" },   

    -- Sniper Rifles --
    [100416529] = { image = "WEAPON_SNIPERRIFLE", canNS = true, showDist = true },       
    [205991906] = { image = "WEAPON_HEAVYSNIPER", canNS = true, showDist = true },  
    [177293209] = { image = "WEAPON_HEAVYSNIPER_MK2", canNS = true, showDist = true },  
    [-952879014] = { image = "WEAPON_MARKSMANRIFLE", canNS = true, showDist = true },  
    [1785463520] = { image = "WEAPON_MARKSMANRIFLE_MK2", canNS = true, showDist = true }, 
    [1853742572] = { image = "WEAPON_PRECISIONRIFLE", canNS = true, showDist = true },  

    -- Shotguns --
    [487013001] = { image = "WEAPON_PUMPSHOTGUN" },   
    [1432025498] = { image = "WEAPON_PUMPSHOTGUN_MK2" },   
    [2017895192] = { image = "WEAPON_SAWNOFFSHOTGUN" },   
    [-1654528753] = { image = "WEAPON_BULLPUPSHOTGUN" }, 
    [-494615257] = { image = "WEAPON_ASSAULTSHOTGUN" },   
    [-1466123874] = { image = "WEAPON_MUSKET" },         
    [984333226] = { image = "WEAPON_HEAVYSHOTGUN" },  
    [-275439685] = { image = "WEAPON_DBSHOTGUN" },
    [317205821] = { image = "WEAPON_AUTOSHOTGUN" },  
    [94989220] = { image = "WEAPON_COMBATSHOTGUN" },    

    -- Heavy Weapons --
    [-1568386805] = { image = "WEAPON_GRENADELAUNCHER" }, 
    [1305664598] = { image = "WEAPON_GRENADELAUNCHER_SMOKE" }, 
    [-1312131151] = { image = "WEAPON_RPG" },  
    [1119849093] = { image = "WEAPON_MINIGUN" }, 
    [2138347493] = { image = "WEAPON_FIREWORK" },   
    [1834241177] = { image = "WEAPON_RAILGUN" },     
    [1672152130] = { image = "WEAPON_HOMINGLAUNCHER" },  
    [125959754] = { image = "WEAPON_COMPACTLAUNCHER" }, 
    [-1238556825] = { image = "WEAPON_RAYMINIGUN" },   
    [-618237638] = { image = "WEAPON_EMPLAUNCHER"},   

    -- Thrown Weapons --
    [-1813897027] = { image = "WEAPON_GRENADE", HS = false },       
    [741814745] = { image = "WEAPON_STICKYBOMB", HS = false },  
    [-1420407917] = { image = "WEAPON_PROXMINE", HS = false }, 
    [-1169823560] = { image = "WEAPON_PIPEBOMB", HS = false },  
    [-37975472] = { image = "WEAPON_SMOKEGRENADE", HS = false },  
    [-1600701090] = { image = "WEAPON_BZGAS", HS = false },    
    [615608432] = { image = "WEAPON_MOLOTOV", HS = false },    
    [101631238] = { image = "WEAPON_FIREEXTINGUISHER", HS = false }, 
    [883325847] = { image = "WEAPON_PETROLCAN", HS = false },     
    [406929569] = { image = "WEAPON_FERTILIZERCAN", HS = false },  
    [-1168940174] = { image = "WEAPON_HAZARDCAN", HS = false },     
    [1233104067] = { image = "WEAPON_FLARE", HS = false }, 
    [600439132] = { image = "WEAPON_BALL", HS = false },    
    [126349499] = { image = "WEAPON_SNOWBALL", HS = false },  

    -- Other Weapons --
    ['default'] = { image = "unknown", HS = false, ignoreDeath = false },  -- If the weapon was not detected/specified, the killfeed will show this one
    [-100946242] = { image = "animal" }, 
    [148160082] = { image = "cougar" },  
    [539292904] = { image = "explosion", HS = false },    
    [-842959696] = { image = "fall", HS = false, canKillSelf = false }, 
    [-544306709] = { image = "fire", HS = false, canKillSelf = false },    
    [-1553120962] = { image = "vehicle", HS = false },       
    [133987706] = { image = "rammed", HS = false },   
    [-1833087301] = { image = "electric", HS = false },       
    [-10959621] = { image = "drowning", HS = false, canKillSelf = false }, 
    [1936677264] = { image = "drowning", HS = false, canKillSelf = false },  

    -- Vehicle Weapons --
    [-1538179531] = { image = "WEAPON_MINIGUN" }, 
    [-1253095144] = { image = "WEAPON_COMBATMG" }, 
    [1155224728] = { image = "WEAPON_COMBATMG" },  
    [729375873] = { image = "WEAPON_MINIGUN" },    
    [2144528907] = { image = "WEAPON_COMBATMG" },   
    
    -- Custom Death Reasons --
    ['starvation'] = { image = "starvation", canKillSelf = false },
    ['dehydration'] = { image = "dehydration", canKillSelf = false },
    ['bleeding'] = { image = "bleeding", canKillSelf = false },
}


Config.NPCNames = {
    human = {
        male = {
            "James", "John", "Robert", "Michael", "William", "David", "Richard", "Joseph", "Thomas", "Charles", "Christopher", "Daniel", "Matthew", "Anthony", "Donald", "Mark", "Paul", "Steven", 
            "Andrew", "Kenneth", "Joshua", "Kevin", "Brian", "George", "Edward", "Ronald", "Timothy", "Jason", "Jeffrey", "Ryan", "Jacob", "Gary", "Nicholas", "Eric", "Jonathan", "Stephen", 
            "Larry", "Justin", "Scott", "Brandon", "Benjamin", "Samuel", "Frank", "Gregory", "Raymond", "Alexander", "Patrick", "Jack", "Dennis", "Jerry", "Tyler", "Aaron", "Henry", "Adam", 
            "Douglas", "Nathan", "Peter", "Zachary", "Kyle","Walter", "Harold", "Jeremy", "Ethan", "Carl", "Keith", "Roger", "Gerald", "Christian", "Terry", "Sean", "Arthur", "Austin", "Noah", 
            "Lawrence", "Jesse", "Joe", "Bryan", "Billy","Jordan", "Albert", "Dylan", "Bruce", "Willie", "Gabriel", "Alan", "Juan", "Logan", "Wayne", "Ralph", "Roy", "Randy", "Vincent", 
            "Russell", "Louis", "Philip", "Bobby", "Johnny", "Bradley", "Leon", "Lucas"
        },
        female = {
            "Mary", "Patricia", "Jennifer", "Linda", "Elizabeth", "Barbara", "Susan", "Jessica", "Sarah", "Karen", "Nancy", "Lisa", "Margaret", "Betty", "Sandra", "Ashley", "Dorothy", "Kimberly", "Emily",
            "Donna", "Michelle", "Carol", "Amanda", "Melissa", "Deborah", "Stephanie", "Rebecca", "Laura", "Sharon", "Cynthia", "Kathleen", "Amy", "Shirley", "Angela", "Helen", "Anna", "Brenda", "Pamela", 
            "Nicole", "Samantha", "Katherine", "Emma", "Ruth", "Christine", "Catherine", "Debra", "Rachel", "Carolyn", "Janet", "Virginia", "Maria", "Heather", "Diane", "Julie", "Joyce", "Victoria", "Kelly", 
            "Christina", "Lauren", "Joan", "Evelyn", "Olivia", "Judith", "Megan", "Cheryl", "Martha", "Andrea", "Frances", "Hannah", "Jacqueline", "Ann", "Gloria", "Jean", "Kathryn", "Alice", "Teresa", "Sara", 
            "Janice", "Doris", "Madison", "Julia", "Grace", "Judy", "Abigail", "Marie", "Denise", "Beverly", "Amber", "Theresa", "Marilyn", "Danielle", "Diana", "Brittany", "Natalie", "Sophia", "Rose", 
            "Isabella", "Alexis", "Kayla", "Charlotte"
        }
    },
    animal = {
        cat = {
            "Luna", "Milo", "Oliver", "Leo", "Loki", "Bella", "Charlie", "Willow", "Lucy", "Simba",
            "Lily", "Nala", "Kitty", "Max", "Jack", "Ollie", "Jasper", "Chadwick", "Taylor", "Tom"
        },
        cormorant = {
            "Pterodactylus", "Greenie", "Chaffie", "Lolly", "Chiffy", "Goldie", "Shortie", "Buzzy", "Reggie", "Eider"
        },
        cow = {
            "Bessie", "Brownie", "Buttercup", "Clarabelle", "Dottie", "Guinness", "Magic", "Nellie", "Penelope", "Penny", 
            "Rosie", "Snowflake", "Sprinkles", "Sugar", "Annabelle", "Bella", "Betty", "Betsie", "Bossy", "Daisy"
        },
        coyote = {
            "Jerry", "Jamul", "Yoda", "Tembi", "Ivory", "Apollo", "Cunawabi", "Billy", "Bobby", "Emma",
            "Iris", "Onyx", "Buddy", "Tilly", "Rex", "Suri", "Tequila", "Tokyo", "Noah", "Nova"
        },
        crow = {
            "Jon Snow", "Ravenclaw", "Darth Vader", "Watchman", "Crow Foot", "Russel Crowe", "Marty McFly", "Tweety", "Chick Jagger", "Chandler Wing",
            "Flappers", "Cheep", "Wing Crosby", "Paulie", "Feather Fawcett", "Luna", "Flight", "Stephen", "Charlotte", "Ruppet"
        },
        dog = {
            "Luna", "Milo", "Oliver", "Bear", "Loki", "Bella", "Charlie", "Cooper", "Lucy", "Max",
            "Lily", "Nala", "Kitty", "Max", "Jack", "Ollie", "Jasper", "Jax", "Penny", "Winston"
        },
        deer = { 
            "Abie", "Bambi", "Beauty", "Blessed", "Bucky", "Buttercup", "Cainy", "Faith", "Freckles", "Gabriella", 
            "Goodeness", "Goodiva", "Goody", "Gracie", "Hope", "Hurricane", "Isabella", "Ivan", "Stormy", "Wendy"
        },
        dolphin = {
            "Star", "Chirp", "Clicker", "Fin", "Cuddly", "Happy", "Lazy", "Bubbles", "Kisser", "Jumper", 
            "Jumpy", "Trickster", "Hops", "Hopster", "Agape", "Flipper", "Snorky", "Alpha", "Beta", "Snowflake"
        },
        fish = {
            "Magikarp", "Sushi", "Nemo", "Delta", "Bait", "Neptune", "Atlantis", "Captain Jack", "Pacific", "Speedy",
            "Bob", "Fin", "Flounder", "Walleye", "Finn", "Oswald", "Ollie", "Flash", "Rex", "Salty"
        },
        hawk = {
            "Dudley", "Icarus", "Ristretto", "Maloney", "Chicory", "Timor", "Marlon", "Skyler", "Griffin", "Adelaide", 
            "Lucy", "Cob", "Molly", "Mischief", "Zippo", "Tasha", "Dusty", "Sal", "Lou", "Tattoo"
        },
        hen = {
            "Albert Eggstein", "Big Bird", "Big Red", "Peri-Peri", "Eggs Benny", "Marshmallow", "Fluffy", "Molly", "Miss Daisy", "Snowball",
            "Bradley Coop-er", "Hen Solo", "Cluck Vader", "Princess Lay-a", "Jaba", "Hilary Fluff", "Meggatron", "Fowler", "Beaker", "Henny Penny"
        },
        humpback = {
            "Alpha", "Gamma", "Gunther", "Bruce", "Sergeant", "Gatsby", "Orlando", "Razor", "Lord", "Draco",
            "Zero", "Ralph", "King", "Zoro", "Silver", "Dragon", "Indigo", "Carlos", "Jackson", "Thaddeus"
        },
        killerwhale = {
            "Luna", "Springer", "Tilikum", "Ikaiki", "Ulises", "Tahlequah", "Granny", "Keiko", "Old Tom", "Lolita", 
            "Moby Dhick", "Willy", "Namu", "Roxanne", "Tilly", "Winter", "Samson", "Iceberg", "Papa Whale", "Ariel"
        },
        mtlion = { 
            "King", "Slim", "Fluffy", "Pudge", "Blimpy", "Butterball", "Achilles", "Chunk", "Chubbles", "Big Foot", 
            "Giant", "Thumbelina", "Tundra", "Quarterback", "Chubby", "Fatma", "President", "Lord", "Fridge", "Speck"
        },
        panther = {
            "Darth", "Alfie", "Hunter", "Zara", "Salem", "Amy", "Halloween", "Phantom", "Annie", "Mr. Black", 
            "Maya", "Damian", "Andy", "Freda", "Dante", "Kuro", "Hades", "Inky", "Mystery", "Yuka"
        },
        pig = {
            "Ace", "Aero", "Alexander", "Amy Swinehouse", "Anastacia", "Apollo", "Arabella", "Archie", "Arlo", "Atlas",
            "Babe", "Bacon", "Bartholomew", "Bella", "Benjamina", "Bloedworst", "Boerewors", "Bratwurst", "Bristle", "Buddy"
        },
        pigeon = {
            "Fred", "Chirpie", "Candy", "Florence", "Polly", "Sunny", "Auzzie", "Chip", "Jazzy", "Jonas", 
            "Frankie", "Cherry", "Orlando", "Plato", "Odin", "Peachy", "Roxy", "Isabelle", "Wilbur", "Stella"
        },
        rabbit = {
            "Thumper", "Oreo", "Bun", "Bunn", "Coco", "Cocoa", "Daisy", "Bunny", "Cinnabun", "Snowball",
            "Buggs", "Marshmallow", "Midnight", "Thunderbunny", "Peppy Hare", "Oswald", "Jupiter", "Mars", "Neptune", "Artemis"
        },
        rat = {
            "Piper", "Reggie", "Flint", "Churro", "Wasabi", "Sushi", "Cheddar", "Benny", "Einstein", "Pascale", 
            "Hugs", "Scarlet", "Dove", "Bella", "Hazel", "Chutney", "Mina", "Autumn", "Pip", "Fawn"
        },
        rhesus = {
            "Chucky", "George", "Bing", "Charlie", "Congo", "Leo", "Cedric", "Bear", "Milo", "Monty", 
            "Jared", "Hunky", "Caesar", "Max", "Albert", "Steve", "Chester", "Hector", "Banana", "Bubbles"
        },
        seagull = {
            "Aqua", "Prickles", "Spring", "Jerry", "Munchkin", "Sue", "Gail", "Ivory", "Pickle", "Apricot", 
            "Sasha", "Cupcake", "Josh", "Maddie", "Peachy", "Quirky", "Katie", "Bill", "Vanilla", "Tiny", "Nimble"
        },
        shark = {
            "Fuzzy", "Sugar", "Hairless", "Greyskin", "Sandy", "Tommy", "Ashleigh", "Umber", "Lawrence", "Fishy", 
            "Hutch", "Werner", "Macy", "Peri", "Starsky", "Anakin", "Marge", "Cindy", "Jimbo", "Pamela"
        },
        stingray = {
            "Stripe", "Manta Ray", "Manta", "Batfish", "Ray", "Shark Ray", "Devilfish", "Sting Ray", "Parting",  "Parsnip", 
            "Whipray", "Skat", "Skate", "Ramp", "Stingaree", "Gail", "Spring", "Wasabi", "Sushi", "Flint"
        }
    }
}

Config.animalTypes = {
    [1462895032] = "cat", -- a_c_cat_01
    [1457690978] = "cormorant", -- a_c_cormorant
    [-50684386] = "cow", -- a_c_cow
    [1682622302] = "coyote", -- a_c_coyote
    [402729631] = "crow", -- a_c_crow
    [351016938] = "dog", -- a_c_chop
    [-1788665315] = "dog", -- a_c_rottweiler
    [1318032802] = "dog", -- a_c_husky
    [882848737] = "dog", -- a_c_retriever
    [1126154828] = "dog", -- a_c_shepherd
    [-1384627013] = "dog", -- a_c_westy
    [1125994524] = "dog", -- a_c_poodle
    [1832265812] = "dog", -- a_c_pug
    [-664053099] = "deer", -- a_c_deer
    [-1950698411] = "dolphin", -- a_c_dolphin
    [802685111] = "fish", -- a_c_fish
    [-1430839454] = "hawk", -- a_c_chickenhawk
    [1794449327] = "hen", -- a_c_hen
    [1193010354] = "humpback", -- a_c_humpback
    [-1920284487] = "killerwhale", -- a_c_killerwhale
    [307287994] = "mtlion", -- a_c_mtlion
    [-417505688] = "panther", -- a_c_panther
    [-832573324] = "pig", -- a_c_boar
    [-1323586730] = "pig", -- a_c_pig
    [111281960] = "pigeon", -- a_c_pigeon
    [-541762431] = "rabbit", -- a_c_rabbit_01
    [-1011537562] = "rat", -- a_c_rat
    [-1026527405] = "rhesus", -- a_c_rhesus
    [-745300483] = "seagull", -- a_c_seagull
    [1015224100] = "shark", -- a_c_sharkhammer
    [113504370] = "shark", -- a_c_sharktiger
    [-1589092019] = "stingray" -- a_c_stingray
}

Config.animalLabels = {
    ['cat'] = " the Cat",
    ['cormorant'] = " the Cormorant",
    ['cow'] = " the Cow",
    ['coyote'] = " the Coyote",
    ['crow'] = " the Crow",
    ['dog'] = " the Dog",
    ['deer'] = " the Deer",
    ['dolphin'] = " the Dolphin",
    ['fish'] = " the Fish",
    ['hawk'] = " the Hawk",
    ['hen'] = " the Hen",
    ['humpback'] = " the Humpback",
    ['killerwhale'] = " the Killerwhale",
    ['mtlion'] = " the Mountain Lion",
    ['panther'] = " the Panther",
    ['pig'] = " the Pig",
    ['pigeon'] = " the Pigeon",
    ['rabbit'] = " the Rabbit",
    ['rat'] = " the Rat",
    ['rhesus'] = " the Rhesus",
    ['seagull'] = " the Seagull",
    ['shark'] = " the Shark",
    ['stingray'] = " the Stingray"
}

-- Join Discord for Support: https://discord.gg/KxdPzC5EeJ