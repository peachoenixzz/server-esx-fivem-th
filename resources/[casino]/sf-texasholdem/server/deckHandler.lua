RANKS = {'ace', '02', '03', '04', '05', '06', '07', '08', '09', '10', 'jack', 'queen', 'king'};
SUITS = {'club', 'dia', 'hrt', 'spd'};
    --   clubs  diamonds hearts spades

function CreateDeck(deckCount, shuffleAfter)
    local self = {};
    self.deckCount = math.floor(tonumber(deckCount) or 3);
    self.shuffleAfter = shuffleAfter;
    self.deck = {};

    self.reset = function()
        self.deck = {};

        for _, rank in pairs(RANKS) do
            for _, suit in pairs(SUITS) do
                for i = 1, deckCount do 
                    table.insert(self.deck, suit.."_"..rank);
                end
            end
        end
        self.shuffle();
    end

    self.shuffle = function()
        for i = #self.deck, 2, -1 do
            local j = math.random(i);
            self.deck[i], self.deck[j] = self.deck[j], self.deck[i];
        end
    end

    self.pullCard = function()
        return table.remove(self.deck, #self.deck);
    end

    self.shouldShuffle = function()
        local decksRemaining = (#self.deck / 52);
        return self.deckCount - math.floor(decksRemaining) >= self.shuffleAfter;
    end

    self.reset();
    return self;
end