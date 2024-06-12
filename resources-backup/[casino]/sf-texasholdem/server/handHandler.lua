function CreateHand(splitted) -- ALL OF THIS ASSUMES THREE CARDS BTW, SO ITS NOT EXTENDABLE TO 5 CARD POKER I.E.
    local self = {};
    self.cards = {};
    self.folded = false;
    self.allIn = false;
    self.bet = 0;
    self.currentBet = 0;
    self.revealed = false;
    self.status = "";
    self.active = false;
    
    self.addCard = function(card)
        table.insert(self.cards, card);
    end

    self.setFolded = function(v)
        self.folded = v;
    end

    self.setAllIn = function(v)
        self.allIn = v;
    end

    self.compareHands = function(opponentHand, board)
        local myHand = GetHandDesc(self, board);
        local opHand = GetHandDesc(opponentHand, board);

        return myHand< opHand, myHand == opHand;
    end

    self.getScore = function(board)
        return GetHandDesc(self, board);
    end

    self.getName = function(board)
        return GetHandName(self, board);
    end

    self.setCurrentBet = function(bet)
        self.currentBet = bet;
    end

    self.addBet = function(bet)
        self.bet += bet;
        self.currentBet += bet;
    end

    return self
end

function GetHandDesc(hand, board)
    local cards = {};
    for k,v in pairs(hand.cards) do
        table.insert(cards, v);
    end

    for k,v in pairs(board.cards) do
        table.insert(cards, v);
    end

    return exports[GetCurrentResourceName()]:GetHandDesc(cards);
end

function GetHandName(hand, board)
    local cards = {};
    for k,v in pairs(hand.cards) do
        table.insert(cards, v);
    end

    for k,v in pairs(board.cards) do
        table.insert(cards, v);
    end

    return exports[GetCurrentResourceName()]:GetHandName(cards);
end