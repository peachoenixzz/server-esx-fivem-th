const translationTable = {
    "02": "2",
    "03": "3",
    "04": "4",
    "05": "5",
    "06": "6",
    "07": "7",
    "08": "8",
    "09": "9",
    "10": "T",
    "jack": "J",
    "queen": "Q",
    "king": "K",
    "ace": "A",

    "club": "c",
    "dia": "d",
    "hrt": "h",
    "spd": "s",
}

const values = [
    "STRAIGHT_FLUSH",
    "FOUR_OF_A_KIND",
    "FULL_HOUSE",
    "FLUSH",
    "STRAIGHT",
    "THREE_OF_A_KIND",
    "TWO_PAIR",
    "ONE_PAIR",
    "HIGH_CARD",
]

function translateHand(inputHand) {
    const handStrings = [];

    for(const card of inputHand) {
        const [suit, rank] = card.split("_");
        handStrings.push(translationTable[rank]+translationTable[suit]);
    }

    return handStrings.join(" ");
}

exports("GetHandDesc", function(inputHand) {
    const translated = translateHand(inputHand);
    try {
        return HandEval.evaluateBoard(translated);
    } catch(e) {
        console.log(e);
        return -1;
    }
});

exports("GetHandName", function(inputHand) {
    const translated = translateHand(inputHand);
    try {
        return values[HandEval.rankBoard(translated)];
    } catch(e) {
        console.log(e)
        return "ERROR";
    }
})