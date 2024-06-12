function CreateGame(id)
    local self = {};
    self.running = false;
    self.started = false;
    self.id = id;
    self.deck = CreateDeck(1, 0);
    self.board = CreateHand(false, -1);
    self.seats = {};
    self.chips = {};
    self.playerSeats = {}
    self.removePlayers = {}
    self.lastPlayers = {}
    self.lastWon = {}
    self.lastLose = {}
    self.playerHands = {};
    self.activePlayers = {};
    self.perSeats = {}
    self.moneyItem = Config.Tables[id].moneyItem or Config.MoneyItem
    self.dealerIndex = 0;
    self.currentBet = 0;
    self.startIndex = 0;
    self.potIndex = 1;
    self.winnerStatus = {};
    self.autoAction = {};

    self.reset = function()
        self.board = CreateHand(false, -1);
        TriggerClientEvent("sf-txh:dealerAnims", -1, self.id, { "dealer_idle" })
        self.time = os.time()
        self.started = false
        self.sendEventToPlayers("sf-txh:timeLeft", Config.PrepareTime)
        self.playerHands = {};
        self.activePlayers = {};
        self.winnerStatus = {};
        self.currentBet = 0;
        self.startIndex = 0;
        self.potIndex = 1;
        self.removePlayers = {};
        self.autoAction = {};
        self.deck.reset();
    end

    self.getHandByIndex = function(index)
        return self.playerHands[self.perSeats[self.activePlayers[index]]];
    end

    self.getSourceByIndex = function(index)
        return self.perSeats[self.activePlayers[index]];
    end 

    self.moreThanOnePlaying = function()
        local playing = 0;
        for playerIndex, seatIndex in pairs(self.activePlayers) do
            local hand = self.getHandByIndex(playerIndex);

            if not hand.folded then
                playing = playing + 1;
            end
        end

        return playing > 1;
    end

    self.sendEventToPlayers = function(eventName, ...)
        local payload = msgpack.pack_args(...)
        local len = payload:len()
        for playerIndex, seatIndex in ipairs(self.activePlayers) do
            local source = self.perSeats[seatIndex];
            if(source and not self.removePlayers[tonumber(source)]) then
                TriggerClientEventInternal(eventName, source, payload, len)
            end
        end
    end

    self.allPlayersAllIn = function()
        for playerIndex, seatIndex in pairs(self.activePlayers) do
            local hand = self.getHandByIndex(playerIndex);

            if not hand.allIn then
                return false;
            end
        end

        return true;
    end

    self.renderPlayersPre = function()
        local pArr = {}
        for seatIndex, playerSource in pairs(self.seats) do
            local cards = { "null", "null" }
            local moneyString = ""
            if(playerSource and Config.DisplayMoney) then
                moneyString = _L((self.moneyItem == "money" and "player_money" or "player_chips"), Bridge.GetItemCount(playerSource, self.moneyItem))
            end
                
            pArr[seatIndex] = { cards = cards, folded = false, status = moneyString, active = false, winner = nil, source = tonumber(playerSource) };
        end
        local payload = msgpack.pack_args(pArr)
        local len = payload:len()
        for seatIndex, source in pairs(self.seats) do
            TriggerClientEventInternal("sf-txh:setOpCards", source, payload, len)
        end
    end

    self.onPlayerAdd = function(source)
        if(not self.started) then
            self.renderPlayersPre()
        end
    end

    self.startGame = function(smallBlind)
        self.lastWon = {}
        self.lastLose = {}
        self.smallBlind = smallBlind
        self.perSeats = {}
        self.removePlayers = {}
        for k, v in pairs(self.seats) do
            self.perSeats[k] = v
        end
        for seat, source in pairs(self.perSeats) do
            if source then
                self.playerHands[source] = CreateHand(false);
                table.insert(self.activePlayers, seat);
            end
        end
        table.sort(self.activePlayers, function(a, b) return a < b end)

        self.started = true;
        self.dealerIndex = wrap(self.dealerIndex + 1, #self.activePlayers); -- Indeks gracza, który ma dostać dealer chipa
        if #self.activePlayers >= 3 then
            TriggerClientEvent("sf-txh:dealerAnims", -1, self.id, { "deal_card_player_02" }, "anim_casino_b@amb@casino@games@blackjack@dealer", self.activePlayers[self.dealerIndex], 2.0, 0.2)
            Citizen.Wait(1500)
            TriggerClientEvent("sf-txh:spawnChip", -1, self.id, "dealer", self.activePlayers[self.dealerIndex], self.getSourceByIndex(self.dealerIndex), "special")
            -- Dodanie dealer Chipa dla gracza na seat o indeksie self.activePlayers[self.dealerIndex];
        end

        local smallBlindIndex = wrap(self.dealerIndex + 1, #self.activePlayers);
        local bigBlindIndex = wrap(self.dealerIndex + 2, #self.activePlayers);
        local blindSources = {self.getSourceByIndex(smallBlindIndex), self.getSourceByIndex(bigBlindIndex)};
        local dealerSource = #self.activePlayers >= 3 and self.getSourceByIndex(self.dealerIndex)
        if(blindSources[1] == nil or blindSources[2] == nil) then
            DealerSpeech(self.id, "MINIGAME_DEALER_REFUSE_BETS")
            self.reset()
            return
        end
        -- Dodanie smallBlinda i bigBlinda (chipy) na seaty o indksach self.activePlayers[smallblindIndex/bigBlindIndex] 
        TriggerClientEvent("sf-txh:dealerAnims", -1, self.id, { "deal_card_player_02" }, "anim_casino_b@amb@casino@games@blackjack@dealer", self.activePlayers[smallBlindIndex], 2.0, 0.2)
        Citizen.Wait(1500)
        TriggerClientEvent("sf-txh:spawnChip", -1, self.id, "small", self.activePlayers[smallBlindIndex], blindSources[1], "special")
        TriggerClientEvent("sf-txh:dealerAnims", -1, self.id, { "deal_card_player_02" }, "anim_casino_b@amb@casino@games@blackjack@dealer", self.activePlayers[bigBlindIndex], 2.0, 0.2)
        Citizen.Wait(1500)
        TriggerClientEvent("sf-txh:spawnChip", -1, self.id, "big", self.activePlayers[bigBlindIndex], blindSources[2], "special")
        for i = 1,2 do
            local hand = self.playerHands[blindSources[i]];
            local betAmount = smallBlind * i;
            if(Bridge.GetItemCount(blindSources[i], self.moneyItem) < betAmount) then
                ShowNotification(blindSources[i], _L("not_enough_money"))
                TriggerClientEvent("sf-txh:forceExit", blindSources[i])
                local smallSeat = self.activePlayers[smallBlindIndex]
                local bigSeat = self.activePlayers[bigBlindIndex]
                local dealerSeat = dealerSource and self.activePlayers[self.dealerIndex]
                table.remove(self.activePlayers, i == 1 and smallBlindIndex or bigBlindIndex)
                if(i == 2) then
                    Bridge.AddItem(blindSources[1], self.moneyItem, smallBlind)
                end
                DealerSpeech(self.id, "MINIGAME_DEALER_REFUSE_BETS")
                if(dealerSource) then
                    TriggerClientEvent('sf-txh:dealerAnims', -1, self.id, { "retrieve_cards_player_02" }, "anim_casino_b@amb@casino@games@blackjack@dealer", dealerSeat)
                    Citizen.Wait(800)
                    TriggerClientEvent("sf-txh:removePlayerChips", -1, self.id, dealerSource, "special")
                end
                TriggerClientEvent('sf-txh:dealerAnims', -1, self.id, { "retrieve_cards_player_02" }, "anim_casino_b@amb@casino@games@blackjack@dealer", smallSeat)
                Citizen.Wait(800)
                TriggerClientEvent("sf-txh:removePlayerChips", -1, self.id, blindSources[1], "special")
                TriggerClientEvent('sf-txh:dealerAnims', -1, self.id, { "retrieve_cards_player_02" }, "anim_casino_b@amb@casino@games@blackjack@dealer", bigSeat)
                Citizen.Wait(800)
                TriggerClientEvent("sf-txh:removePlayerChips", -1, self.id, blindSources[2], "special")
                self.reset()
                return
            end
            Bridge.RemoveItem(blindSources[i], self.moneyItem, betAmount)
            hand.addBet(betAmount);
            self.board.addBet(betAmount);
            -- Postawienie chipsow na small i big Blind
        end
        Citizen.Wait(250)
        TriggerClientEvent("sf-txh:playerAnims", self.getSourceByIndex(smallBlindIndex), { "place_bet_small" }, "anim_casino_b@amb@casino@games@blackjack@player")
        Citizen.SetTimeout(700, function()
            TriggerClientEvent("sf-txh:spawnChip", -1, self.id, GetClosestBetId(smallBlind), self.activePlayers[smallBlindIndex], self.getSourceByIndex(smallBlindIndex), "bet")
        end)
        Citizen.Wait(500)
        TriggerClientEvent("sf-txh:playerAnims", self.getSourceByIndex(bigBlindIndex), { "place_bet_small" }, "anim_casino_b@amb@casino@games@blackjack@player")
        Citizen.SetTimeout(700, function()
            TriggerClientEvent("sf-txh:spawnChip", -1, self.id, GetClosestBetId(smallBlind*2), self.activePlayers[bigBlindIndex], self.getSourceByIndex(bigBlindIndex), "bet")
        end)
        self.deck.shuffle();
        -- Animka shufflowania decku przez giga dealera
        TriggerClientEvent("sf-txh:dealerAnims", -1, self.id, { "deck_pick_up" })
        Citizen.Wait(2000)
        TriggerClientEvent("sf-txh:dealerAnims", -1, self.id, { "deck_shuffle" })
        Citizen.Wait(3000)

        for playerIndex, seatIndex in ipairs(self.activePlayers) do
            local source = self.perSeats[seatIndex];
            local hand = self.playerHands[source];

            if hand then
                local playerCards = {};
                for i = 1, 2 do
                    local card = self.deck.pullCard(); 
                    table.insert(playerCards, card);
                    hand.addCard(card);
                end
                -- Animacja dania kart (po to zmienna playerCards)
                TriggerClientEvent("sf-txh:dealerAnims", -1, self.id, { "deck_deal_p02" }, nil, seatIndex)
                TriggerClientEvent("sf-txh:spawnCards", -1, self.id, source, seatIndex, playerCards, "deck_deal_p02")
                Citizen.Wait(2000)
                self.renderPlayerCards()
                Citizen.Wait(1000)
            end
            if(source and not self.removePlayers[source]) then
                TriggerClientEvent("sf-txh:setValues", source, self.board.bet, hand?.bet or 0, self.currentBet, hand?.currentBet, self.autoAction[source])
            end
        end
        self.renderPlayerCards();

        self.currentBet = smallBlind * 2;
        self.startIndex = wrap(self.dealerIndex + 3, #self.activePlayers); 
        TriggerClientEvent("sf-txh:dealerAnims", -1, self.id, { "deck_put_down" })
        Citizen.Wait(1000)
        self.bettingRound(true);

        if not self.moreThanOnePlaying() then
            self.finish();
            return;
        end

        TriggerClientEvent("sf-txh:dealerAnims", -1, self.id, { "deck_pick_up" })
        Citizen.Wait(2000)
        do 
            local boardCards = {};
            for i = 1, 3 do
                local card = self.deck.pullCard();
                table.insert(boardCards, card);
                self.board.addCard(card);
            end
            TriggerClientEvent("sf-txh:dealerAnims", -1, self.id, { "deck_deal_self" })
            TriggerClientEvent("sf-txh:spawnCards", -1, self.id, "dealer", 0, boardCards, "deck_deal_self")
            self.sendEventToPlayers("sf-txh:setComCards", boardCards, true)
            Citizen.Wait(4000)
        end

        self.currentBet = 0;
        self.startIndex = wrap(self.startIndex + 1, #self.activePlayers); 
        TriggerClientEvent("sf-txh:dealerAnims", -1, self.id, { "deck_put_down" })
        Citizen.Wait(1000)
        self.bettingRound(false);

        if not self.moreThanOnePlaying() then
            self.finish();
            return;
        end

        for i = 1, 2 do
            do 
                local boardCards = {};
                local card = self.deck.pullCard();
                table.insert(boardCards, card);
                self.board.addCard(card);
                -- Wyłożenie kolejnych kart na stół (turn/river)
                TriggerClientEvent('sf-txh:dealerAnims', -1, self.id, { "deal_card_self_second_card" }, "anim_casino_b@amb@casino@games@blackjack@dealer")
                TriggerClientEvent("sf-txh:spawnCards", -1, self.id, "dealer", 0, self.board.cards, "deck_deal_self")
                Citizen.Wait(1000)
                self.sendEventToPlayers("sf-txh:setComCards", self.board.cards)
                Citizen.Wait(1000)
            end

            self.currentBet = 0;
            self.startIndex = wrap(self.startIndex + 1, #self.activePlayers); 
            self.bettingRound(false);

            if not self.moreThanOnePlaying() then
                self.finish();
                return;
            end
        end

        self.finish();
    end

    self.bettingRound = function(isFirst)
        local index = self.startIndex;


        for playerIndex, seatIndex in ipairs(self.activePlayers) do
            local hand = self.getHandByIndex(playerIndex);
            local source = self.getSourceByIndex(playerIndex);

            if hand.status ~= "folded" and hand.status ~= "went_all_in" then
                hand.status = "";
            end

            TriggerClientEvent("sf-txh:setValues", source, self.board.bet, hand?.bet or 0, self.currentBet, hand?.currentBet, self.autoAction[source])
        end

        repeat
            local hand = self.getHandByIndex(index);
            local source = self.getSourceByIndex(index);

            local canCheck = self.currentBet == 0 or self.currentBet == hand.currentBet;
            local isBet = self.currentBet == 0;
            local maxBet = Bridge.GetItemCount(source, self.moneyItem);
            local action, declaredAmount;

            if hand.folded or hand.allIn --[[or (hand.currentBet == self.currentBet and self.currentBet ~= 0)]] then
                goto continue; 
            end

            if(self.removePlayers[tonumber(source)] and not hand.folded) then
                hand.setFolded(true)
                hand.status = "folded"
                self.renderPlayerCards()
                goto continue;
            end

            hand.active = true;
            hand.status = "their_turn";
            self.renderPlayerCards();

            TriggerClientEvent('sf-txh:dealerAnims', -1, self.id, { "dealer_focus_player_02_idle_intro"}, "anim_casino_b@amb@casino@games@blackjack@dealer", self.activePlayers[index])
            Citizen.Wait(1500)
            TriggerClientEvent('sf-txh:dealerAnims', -1, self.id, { "dealer_focus_player_02_idle"}, "anim_casino_b@amb@casino@games@blackjack@dealer", self.activePlayers[index])
            Citizen.SetTimeout(5000, function()
                if(not action) then
                    DealerSpeech(self.id, "MINIGAME_DEALER_COMMENT_SLOW")
                end
            end)

            if self.autoAction[source] then
                action = canCheck and "check" or "fold";
                declaredAmount = 0;
                Citizen.Wait(0);
            else
                action, declaredAmount = TriggerClientCallback("sf-txh:requestInteraction", source, isBet, canCheck, maxBet);
            end

            if(not action) then
                action = "fold"
                declaredAmount = 0
            end

            if canCheck and action == "call" then
                action = "fold"
                declaredAmount = 0
            end

            if declaredAmount and declaredAmount < 0 then
                action = "fold";
                print("cheat?");
            end

            if (action == "bet" or action == "raise") and declaredAmount == 0 then
                action = "call";
            end

            if declaredAmount then
                declaredAmount = math.floor(declaredAmount);
            end

            if action == "check" then
                if not canCheck then
                    action = "fold";
                    -- Cheat?
                else
                    -- Animka na check
                    TriggerClientEvent("sf-txh:playerAnims", source, { "request_card" }, "anim_casino_b@amb@casino@games@blackjack@player")
                    Citizen.Wait(1000)
                    hand.status = "checked";
                    goto continue;
                end
            end

            
            if action == "fold" or action == "fold_reveal" then
                hand.setFolded(true);
                hand.revealed = action == "fold_reveal";
                hand.status = "folded";
                -- Animka albo cos fold
                TriggerClientEvent("sf-txh:playCardsAnim", -1, self.id, source, self.activePlayers[index], "cards_pickup")
                TriggerClientEvent("sf-txh:playerAnims", source, { "cards_pickup" })
                Citizen.Wait(1200)
                TriggerClientEvent("sf-txh:playCardsAnim", -1, self.id, source, self.activePlayers[index], "cards_fold", nil, false)
                TriggerClientEvent("sf-txh:playerAnims", source, { "cards_fold" })
                Citizen.Wait(1000)

                if hand.revealed then
                    Citizen.Wait(1000)
                    TriggerClientEvent("sf-txh:playCardsAnim", -1, self.id, source, nil, "reveal_folded_p02", "anim_casino_b@amb@casino@games@threecardpoker@dealer", false, self.activePlayers[index], true)
                    TriggerClientEvent("sf-txh:dealerAnims", -1, self.id, { "reveal_folded_p02" }, "anim_casino_b@amb@casino@games@threecardpoker@dealer", self.activePlayers[index])
                    Citizen.Wait(3000)
                end

                self.renderPlayerCards();
                goto continue;
            end

            if action == "call" then
                local amount = self.currentBet - hand.currentBet;
                local count = Bridge.GetItemCount(source, self.moneyItem);
                hand.status = "called";
                if count <= amount then
                    hand.setAllIn(true);
                    amount = count;
                    TriggerClientEvent('sf-txh:dealerAnims', -1, self.id, { "hit_second_card_player_02"}, "anim_casino_b@amb@casino@games@blackjack@dealer", self.activePlayers[index])
                    Bridge.RemoveItem(source, self.moneyItem, amount)
                    Citizen.Wait(1500)
                    TriggerClientEvent("sf-txh:spawnChip", -1, self.id, "allin", self.activePlayers[index], source, "allin")
                    hand.status = "went_all_in";
                else
                    Bridge.RemoveItem(source, self.moneyItem, amount)
                end
                hand.addBet(amount);
                self.board.addBet(amount);
                -- Animka na call
                TriggerClientEvent("sf-txh:playerAnims", source, { "place_bet_small" }, "anim_casino_b@amb@casino@games@blackjack@player")
                Citizen.Wait(700)
                TriggerClientEvent("sf-txh:spawnChip", -1, self.id, GetClosestBetId(hand.currentBet), self.activePlayers[index], source, "bet")
                goto continue;
            end

            if action == "allin" then
                declaredAmount = 0;
            end

            if action == "bet" or action == "raise" or action == "allin" then
                local count = Bridge.GetItemCount(source, self.moneyItem);
                local amount = (self.currentBet - hand.currentBet) + declaredAmount;
                hand.status = isBet and "betted" or "raised";
                if count <= amount or action == "allin" then
                    hand.setAllIn(true);
                    amount = count;
                    TriggerClientEvent('sf-txh:dealerAnims', -1, self.id, { "hit_second_card_player_02"}, "anim_casino_b@amb@casino@games@blackjack@dealer", self.activePlayers[index])
                    Bridge.RemoveItem(source, self.moneyItem, amount)
                    Citizen.Wait(1500)
                    TriggerClientEvent("sf-txh:spawnChip", -1, self.id, "allin", self.activePlayers[index], source, "allin")
                    hand.status = "went_all_in";
                else
                    Bridge.RemoveItem(source, self.moneyItem, amount)
                end

                hand.addBet(amount);
                self.board.addBet(amount);
                if(hand.currentBet > self.currentBet) then
                    self.currentBet = hand.currentBet;
                    self.startIndex = index;
                end

                TriggerClientEvent("sf-txh:playerAnims", source, { "place_bet_small" }, "anim_casino_b@amb@casino@games@blackjack@player")
                Citizen.Wait(700)
                TriggerClientEvent("sf-txh:spawnChip", -1, self.id, GetClosestBetId(hand.currentBet), self.activePlayers[index], source, "bet")
                goto continue;
            end

            ::continue::
            for playerIndex, seatIndex in ipairs(self.activePlayers) do
                local targetSource = self.perSeats[seatIndex];
                if(targetSource and not self.removePlayers[targetSource]) then
                    local targetHand = self.playerHands[targetSource];

                    TriggerClientEvent("sf-txh:setValues", targetSource, self.board.bet, targetHand?.bet or 0, self.currentBet, targetHand?.currentBet, self.autoAction[targetSource])
                end
            end
            index = wrap(index+1, #self.activePlayers);
            hand.active = false;
            if(hand.status == "their_turn") then
                hand.status = "";
            end
        until(index == self.startIndex or not self.moreThanOnePlaying())

        self.renderPlayerCards();
        local addChips = {}
        for playerIndex, seatIndex in ipairs(self.activePlayers) do
            local hand = self.getHandByIndex(playerIndex);
            if(hand.currentBet and hand.currentBet > 0) then
                TriggerClientEvent('sf-txh:dealerAnims', -1, self.id, { "retrieve_cards_player_02" }, "anim_casino_b@amb@casino@games@blackjack@dealer", seatIndex)
                table.insert(addChips, { GetClosestBetId(hand.currentBet), self.potIndex })
                self.potIndex += 1
                Citizen.Wait(900)
                TriggerClientEvent("sf-txh:removePlayerChips", -1, self.id, self.getSourceByIndex(playerIndex), "bet")
            end
            hand.setCurrentBet(0);
        end

        if(#addChips > 0) then
            TriggerClientEvent("sf-txh:spawnPotBulk", -1, self.id, addChips)
        end
    end

    self.renderPlayerCards = function()
        self.sendEventToPlayers("sf-txh:setOpCards", self.getPlayersCards())
    end

    self.getPlayerInvestments = function()
        local investments = {};

        for playerIndex, seatIndex in pairs(self.activePlayers) do
            local hand = self.getHandByIndex(playerIndex);
            local handRank;
            if self.moreThanOnePlaying() then
                handRank = hand.getScore(self.board);
            else
                handRank = 0;
            end

        
            table.insert(investments, {
                index = playerIndex,
                seat = seatIndex,
                investment = hand.bet,
                handRank = handRank,
                playing = not hand.folded,
            });
        end

        return investments;
    end

    self.findBestHands = function(investments)
        local minVal = -1;
        local minIndexes = {};

        for k,v in pairs(investments) do
            if not v.playing then
                goto continue;
            end

            if minVal == -1 or v.handRank < minVal then
                minVal = v.handRank;
                minIndexes = {};
            end

            if v.handRank == minVal then
                table.insert(minIndexes, k);
            end

            ::continue::
        end

        return minIndexes;
    end

    self.getPlayersCards = function()
        local pArr = {}
        for playerIndex, seatIndex in pairs(self.activePlayers) do
            local hand = self.getHandByIndex(playerIndex);
            local source = self.getSourceByIndex(playerIndex);
            local cards = {};
            if(hand.revealed) then
                cards = hand.cards;
            else
                if(#hand.cards < 1) then
                    cards = { "null", "null" };
                else
                    cards = { "empty", "empty" };
                end
            end
                
            pArr[seatIndex] = { cards = cards, folded = hand.folded, status = hand.status ~= "" and _L(hand.status) or "", active = hand.active, winner = self.winnerStatus[playerIndex], source = tonumber(source)};
        end
        return pArr
    end

    self.finish = function()
        local investments = self.getPlayerInvestments();
        local winners = {};
        TriggerClientEvent("sf-txh:dealerAnims", -1, self.id, { "deck_pick_up" })
        Citizen.Wait(2000)
        if self.moreThanOnePlaying() then
            for playerIndex, seatIndex in pairs(self.activePlayers) do
                local hand = self.getHandByIndex(playerIndex);
                local source = self.getSourceByIndex(playerIndex)

                if hand.revealed or not hand.folded then
                    hand.status = hand.getName(self.board);
                end

                if not hand.folded then
                    hand.revealed = true;
                    TriggerClientEvent("sf-txh:playCardsAnim", -1, self.id, source, nil, "reveal_played_p02", "anim_casino_b@amb@casino@games@threecardpoker@dealer", false, seatIndex, true)
                    TriggerClientEvent("sf-txh:dealerAnims", -1, self.id, { "reveal_played_p02" }, "anim_casino_b@amb@casino@games@threecardpoker@dealer", seatIndex)
                    Citizen.Wait(3000)
                    self.renderPlayerCards();
                end
            end
        end

        while #investments > 1 do
            table.sort(investments, function(a,b) return a.investment < b.investment end);

            local min = investments[1].investment;
            local winnerPot = min * #investments;

            for k,v in pairs(investments) do
                v.investment -= min;
            end

            local bestHandIndexes = self.findBestHands(investments);
            local winValue = math.floor(winnerPot/#bestHandIndexes);
            for _, index in pairs(bestHandIndexes) do 
                if not winners[investments[index].index] then
                    winners[investments[index].index] = 0;
                end

                winners[investments[index].index] += winValue;
            end

            investments = table.filter(investments, function(x) return x.investment > 0 end);
        end

        if #investments == 1 then
            if not winners[investments[1].index] then
                winners[investments[1].index] = 0;
            end

            winners[investments[1].index] += investments[1].investment;
        end

        for k,v in pairs(winners) do
            if v > 0 then
                local source = self.getSourceByIndex(k);
                if(not self.removePlayers[tonumber(source)]) then
                    Bridge.AddItem(source, self.moneyItem, v);
                end
            end
        end

        for playerIndex, seatIndex in pairs(self.activePlayers) do
            local hand = self.getHandByIndex(playerIndex);

            local winAmount = ((winners[playerIndex] or 0) - hand.bet)
            self.winnerStatus[playerIndex] = winAmount >= 0;
            local source = self.getSourceByIndex(playerIndex)
            local reaction
            if(winAmount > hand.bet) then
                reaction = (winAmount > (hand.bet*2)) and "great" or "good"
                self.lastWon[source] = true
            elseif(winAmount == hand.bet) then
                reaction = "impartial"
            elseif(hand.bet ~= 0) then
                reaction = (hand.bet > (self.smallBlind*5)) and "terrible" or "bad"
                self.lastLose[source] = true
            end
            if(self.removePlayers[source] == nil and reaction ~= nil) then
                PlayerReaction(source, reaction)
            end
        end
        TriggerClientEvent("sf-txh:removePlayerChips", -1, self.id, "dealer")
        self.renderPlayerCards();

        for playerIndex, seatIndex in pairs(self.activePlayers) do
            local hand = self.getHandByIndex(playerIndex);
            local source = self.getSourceByIndex(playerIndex)

            if hand.revealed then
                TriggerClientEvent("sf-txh:playCardsAnim", -1, self.id, source, nil, "cards_collect_p02", "anim_casino_b@amb@casino@games@threecardpoker@dealer", false, seatIndex, true)
                TriggerClientEvent("sf-txh:dealerAnims", -1, self.id, { "cards_collect_p02" }, nil, seatIndex)
                Citizen.Wait(1700)
                TriggerClientEvent("sf-txh:removePlayerCards", -1, self.id, source)
            else
                TriggerClientEvent('sf-txh:dealerAnims', -1, self.id, { "retrieve_cards_player_02" }, "anim_casino_b@amb@casino@games@blackjack@dealer", seatIndex)
                Citizen.Wait(800)
                TriggerClientEvent("sf-txh:removePlayerCards", -1, self.id, source)
            end
            self.renderPlayerCards();
        end
        TriggerClientEvent("sf-txh:dealerAnims", -1, self.id, { "deck_put_down" })
        Citizen.Wait(2000)
        if(#self.activePlayers >= 3) then
            TriggerClientEvent('sf-txh:dealerAnims', -1, self.id, { "retrieve_cards_player_02" }, "anim_casino_b@amb@casino@games@blackjack@dealer", self.activePlayers[self.dealerIndex])
            Citizen.Wait(800)
            TriggerClientEvent("sf-txh:removePlayerChips", -1, self.id, self.getSourceByIndex(self.dealerIndex), "special")
        end
        local smallBlindIndex = wrap(self.dealerIndex + 1, #self.activePlayers);
        local bigBlindIndex = wrap(self.dealerIndex + 2, #self.activePlayers);
        TriggerClientEvent('sf-txh:dealerAnims', -1, self.id, { "retrieve_cards_player_02" }, "anim_casino_b@amb@casino@games@blackjack@dealer", self.activePlayers[smallBlindIndex])
        Citizen.Wait(800)
        TriggerClientEvent("sf-txh:removePlayerChips", -1, self.id, self.getSourceByIndex(smallBlindIndex), "special")
        TriggerClientEvent('sf-txh:dealerAnims', -1, self.id, { "retrieve_cards_player_02" }, "anim_casino_b@amb@casino@games@blackjack@dealer", self.activePlayers[bigBlindIndex])
        Citizen.Wait(800)
        TriggerClientEvent("sf-txh:removePlayerChips", -1, self.id, self.getSourceByIndex(bigBlindIndex), "special")
        Citizen.Wait(500)
        for playerIndex, seatIndex in pairs(self.activePlayers) do
            local hand = self.getHandByIndex(playerIndex);
            local source = self.getSourceByIndex(playerIndex)

            if hand.allIn then
                TriggerClientEvent('sf-txh:dealerAnims', -1, self.id, { "retrieve_cards_player_02" }, "anim_casino_b@amb@casino@games@blackjack@dealer", seatIndex)
                Citizen.Wait(800)
                TriggerClientEvent("sf-txh:removePlayerChips", -1, self.id, source)
            end
        end
        self.sendEventToPlayers("sf-txh:gameEnd")
        DealerSpeech(self.id, "MINIGAME_DEALER_ANOTHER_GO")
        if(#self.board.cards > 0) then
            TriggerClientEvent("sf-txh:dealerAnims", -1, self.id, { "cards_collect_self" })
            Citizen.Wait(1200)
            TriggerClientEvent("sf-txh:removePlayerCards", -1, self.id, "dealer")
            Citizen.Wait(1000)
        end
        self.renderPlayersPre()
        self.reset()
    end

    self.handleExit = function(source)
        self.removePlayers[source] = true
    end

    return self
end

function GetBetIdFromAmount(amount)
    for i=1, #Bets do
        if(Bets[i] == amount) then
            return i
        end
    end
end

function PlayerReaction(source, reactionType)
    TriggerClientEvent("sf-txh:playerAnims", source, { "reaction_"..reactionType.."_var_0"..math.random(1, 4) }, "anim_casino_b@amb@casino@games@shared@player@")
end

function wrap(v, w)
    return ((v-1) % w)+1;
end

table.filter = function(t, filterIter)
    local out = {}
  
    for k, v in pairs(t) do
      if filterIter(v, k, t) then table.insert(out, v) end
    end
  
    return out
end