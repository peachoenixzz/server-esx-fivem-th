
function TwitterPostTweet(a, b, c, d, e)
  getUser(d, function(f)
	if f then
		MySQL.Async.fetchAll("INSERT INTO twitter_tweets (`authorId`, `message`, `image`, `realUser`) VALUES(@authorId, @message, @image, @realUser);", {["@authorId"] = f.id, ["@message"] = a, ["@image"] = b, ["@realUser"] = d}, function()
			tweet = {}
			tweet["authorId"] = f.id;
			tweet["message"] = a;
			tweet["image"] = b
			tweet["realUser"] = d;
			tweet["time"] = os.date()
			tweet["author"] = f.author;
			tweet["authorIcon"] = f.authorIcon;
            local iconUser = nil
            if f.authorIcon == nil then iconUser = "https://mongkol.dev/images/logo.png" end
            if f.authorIcon ~= nil then iconUser = f.authorIcon end
			TriggerClientEvent("gcPhone:twitter_newTweets", -1, tweet)
            a = Emojit(a)
			if string.match(b, '?') or string.match(b, 'png') or string.match(b, 'jpeg') or string.match(b, 'jpg') or string.match(b, 'pjg') or string.match(b, 'gif') then
                TriggerClientEvent('chat:addMessage', -1, {
                    template = '<style>@import url(https://fonts.googleapis.com/css2?family=Kanit:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&display=swap);.tweet-img{display:flex;flex-direction:row;margin-bottom:8px;background:linear-gradient(90deg, rgba(29, 161, 243, 1) 0%, rgba(0, 184, 236, 0.6) 100%);opacity:.9;border-radius:7px;width: fit-content;padding:7px;font-family:Kanit,sans-serif !important; align-items: center;}.user-image-img{flex:0 0 50px}.user-image-img img{width:50px;height:50px;border-radius:50%}.tweet-details-img{flex:1;font-size:18px;padding-left:5px;padding-right:5px;color:#fff}.author-username-img{font-size:18px;color:#fff;display: flex;align-items: center;}.post-text-img{margin-top:0px}.post-images-img img{display:inline-block;width:235;height:120px;margin-top:5px;border-radius:7px}</style><div class="tweet-img"><div class="tweet-details-img"><div class="author-username-img"><img src="https://img2.pic.in.th/pic/bird.png" style="width: 20px; height: 20px;margin-right: 4px" /> '..f.author..' : '..a..'</div><div class="post-images-img"><img src="'..b..'" alt="Image 1"></div></div></div>',
                    -- template = '<style>@import url(https://fonts.googleapis.com/css2?family=Kanit:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&display=swap);.tweet-img{display:flex;flex-direction:row;margin-bottom:8px;background:linear-gradient(90deg, rgba(20, 184, 166, 1) 0%, rgba(20, 184, 166, 0.6) 100%);opacity:.9;border-radius:7px;width: fit-content;padding:7px;font-family:Kanit,sans-serif !important;}.user-image-img{flex:0 0 50px}.user-image-img img{width:50px;height:50px;border-radius:50%}.tweet-details-img{flex:1;font-size:18px;padding-left:5px;padding-right:5px;color:#fff}.author-username-img{font-size:18px;color:#fff}.post-text-img{margin-top:0px}.post-images-img img{display:inline-block;width:235;height:120px;margin-top:5px;border-radius:7px}</style><div class="tweet-img"><div class="tweet-details-img"><div class="author-username-img"><i class="fab fa-twitter"></i> '..f.author..' : '..a..'</div><div class="post-images-img"><img src="'..b..'" alt="Image 1"></div></div></div>',
				args = { tweet['author'], b} })
			else
				TriggerClientEvent('chat:addMessage', -1, {
                    template = '<style>@import url(https://fonts.googleapis.com/css2?family=Kanit:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&display=swap);.tweet{display:flex;flex-direction:row;margin-bottom:8px;background:linear-gradient(90deg, rgba(29, 161, 243, 1) 0%, rgba(0, 184, 236, 0.6) 100%);opacity:.9;border-radius:7px;padding:7px;font-family:Kanit,sans-serif !important;width:605px; align-items: center;}.user-image{flex:0 0 50px}.post-date{color:#fff}.user-image img{width:50px;height:50px;border-radius:50%}.tweet-details{flex:1;font-size:18px;padding-left:5px;padding-right:5px;color:#fff;align-items: center;}.author-username{font-size:18px;color:#fff;word-break: break-all;display: flex;align-items: center;}.post-text{margin-top:0px}.post-images img{display:inline-block;width:250px;height:250px;margin-top:20px;border-radius:7px}</style><div class="tweet"><div class="tweet-details"><div class="author-username"><img src="https://img2.pic.in.th/pic/bird.png" style="width: 20px; height: 20px;margin-right: 4px;" /> '..f.author..' : '..a..'</div></div></div>',
                    -- template = '<style>@import url(https://fonts.googleapis.com/css2?family=Kanit:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&display=swap);.tweet{display:flex;flex-direction:row;margin-bottom:8px;background:linear-gradient(90deg, rgba(20, 184, 166, 1) 0%,  rgba(20, 184, 166, 0.6) 100%);opacity:.9;border-radius:7px;padding:7px;font-family:Kanit,sans-serif !important;width:605px;}.user-image{flex:0 0 50px}.post-date{color:#fff}.user-image img{width:50px;height:50px;border-radius:50%}.tweet-details{flex:1;font-size:18px;padding-left:5px;padding-right:5px;color:#fff}.author-username{font-size:18px;color:#fff;word-break: break-all;}.post-text{margin-top:0px}.post-images img{display:inline-block;width:250px;height:250px;margin-top:20px;border-radius:7px}</style><div class="tweet"><div class="tweet-details"><div class="author-username"><i class="fab fa-twitter"></i> '..f.author..' : '..a..'</div></div></div>',
                    args = { tweet['author'],a }})
			end
            local xPlayer = ESX.GetPlayerFromIdentifier(d)
            pcall(function() -- Start log
                exports['azael_dc-serverlogs']:insertData({
                    event = 'TwitterPost',
                    content = ('ผู้เล่น %s ได้ทำการสร้างข้อความบน Twitter ข้อความ : %s, รูป : %s, ชื่อ Twitter: %s'):format(xPlayer.name, a, b, f.author),
                    source = xPlayer.source,
                })
            end) -- End log
			TriggerEvent("gcPhone:twitter_newTweets", tweet)
			end)
		end
	end)
end

function Emojit(text)
    for i = 1, #emoji do
        for k = 1, #emoji[i][1] do
            text = string.gsub(text, emoji[i][1][k], emoji[i][2])
        end
    end
    return text
end

function TwitterGetTweets(a, b) 
  if a == nil then 
    MySQL.Async.fetchAll([===[SELECT twitter_tweets.*, twitter_accounts.username as author, twitter_accounts.avatar_url as authorIcon FROM twitter_tweets LEFT JOIN twitter_accounts ON twitter_tweets.authorId = twitter_accounts.id ORDER BY time DESC LIMIT 30]===], {}, b) else 
      MySQL.Async.fetchAll([===[SELECT twitter_tweets.*, twitter_accounts.username as author, twitter_accounts.avatar_url as authorIcon, twitter_likes.id AS isLikes FROM twitter_tweets LEFT JOIN twitter_accounts ON twitter_tweets.authorId = twitter_accounts.id LEFT JOIN twitter_likes ON twitter_tweets.id = twitter_likes.tweetId AND twitter_likes.authorId = @accountId ORDER BY time DESC LIMIT 30]===], {["@accountId"] = a}, b) 
    end 
  end


function TwitterGetFavotireTweets(accountId, cb)
    MySQL.Async.fetchAll([===[
      SELECT twitter_tweets.*,
        twitter_accounts.username as author,
        twitter_accounts.avatar_url as authorIcon
      FROM twitter_tweets
        LEFT JOIN twitter_accounts
          ON twitter_accounts.identifier = @accountId
      WHERE realUser = @accountId ORDER BY TIME DESC LIMIT 30
    ]===]
        , {['@accountId'] = accountId}, cb)
end

function getUser(identifier, cb)
    MySQL.Async.fetchAll("SELECT id, username as author, avatar_url as authorIcon FROM twitter_accounts WHERE identifier = @identifier", {
        ['@identifier'] = identifier
    }, function(data)
		if data[1] then
			cb(data[1])
		else
			cb()
		end
	end)
end

function TwitterToogleLike(identifier, tweetId, sourcePlayer)
    getUser(identifier, function(user)
        MySQL.Async.fetchAll('SELECT * FROM twitter_tweets WHERE id = @id', {
            ['@id'] = tweetId
        }, function(tweets)
            if (tweets[1] == nil) then return end
            local tweet = tweets[1]
            MySQL.Async.fetchAll('SELECT * FROM twitter_likes WHERE authorId = @authorId AND tweetId = @tweetId', {
                ['authorId'] = user.id,
                ['tweetId'] = tweetId
            }, function(row)
                if (row[1] == nil) then
                    MySQL.Async.insert('INSERT INTO twitter_likes (`authorId`, `tweetId`) VALUES(@authorId, @tweetId)', {
                        ['authorId'] = user.id,
                        ['tweetId'] = tweetId
                    }, function()
                        MySQL.Async.execute('UPDATE `twitter_tweets` SET `likes`= likes + 1 WHERE id = @id', {
                            ['@id'] = tweet.id
                        }, function()
                            TriggerClientEvent('gcPhone:twitter_updateTweetLikes', -1, tweet.id, tweet.likes + 1)
                            TriggerClientEvent('gcPhone:twitter_setTweetLikes', sourcePlayer, tweet.id, true)
                            TriggerEvent('gcPhone:twitter_updateTweetLikes', tweet.id, tweet.likes + 1)
                            pcall(function() -- Start Log
                                exports['azael_dc-serverlogs']:insertData({
                                    event = 'TwitterLikePost',
                                    content = ('%s ได้ทำการ Like โพสต์ Twitter ของ %s'):format(),
                                    source = xPlayer.source,
                                 })
                             end) -- End Log
                        end)
                    end)
                else
                    MySQL.Async.execute('DELETE FROM twitter_likes WHERE id = @id', {
                        ['@id'] = row[1].id,
                    }, function()
                        MySQL.Async.execute('UPDATE `twitter_tweets` SET `likes`= likes - 1 WHERE id = @id', {
                            ['@id'] = tweet.id
                        }, function()
                            TriggerClientEvent('gcPhone:twitter_updateTweetLikes', -1, tweet.id, tweet.likes - 1)
                            TriggerClientEvent('gcPhone:twitter_setTweetLikes', sourcePlayer, tweet.id, false)
                            TriggerEvent('gcPhone:twitter_updateTweetLikes', tweet.id, tweet.likes - 1)
                        end)
                    end)
                end
            end)
        end)
    end)
end

function TwitterToogleDelete(identifier, tweetId, sourcePlayer)
    MySQL.Async.execute('DELETE FROM twitter_tweets WHERE id = @id', {
        ['@id'] = tweetId,
    }, function()
        TwitterGetFavotireTweets(identifier, function(tweets)
            TriggerClientEvent('gcPhone:twitter_getFavoriteTweets', sourcePlayer, tweets)
        end)
    end)
end

function TwitterShowError(sourcePlayer, title, message)
    TriggerClientEvent('gcPhone:twitter_showError', sourcePlayer, message)
end

function TwitterShowSuccess(sourcePlayer, title, message)
    TriggerClientEvent('gcPhone:twitter_showSuccess', sourcePlayer, title, message)
end

RegisterServerEvent('gcPhone:twitter_login')
AddEventHandler('gcPhone:twitter_login', function(source, identifier)
    local sourcePlayer = tonumber(source)
    getUser(identifier, function(user)
        if user ~= nil then
            TriggerClientEvent('gcPhone:twitter_setAccount', sourcePlayer, user.author, user.authorIcon)
        end
    end)
end)

RegisterServerEvent('gcPhone:twitter_changeUsername')
AddEventHandler('gcPhone:twitter_changeUsername', function(newUsername)
    local sourcePlayer = tonumber(source)
    local identifier = getPlayerID(source)
    getUser(identifier, function(user)
        MySQL.Async.execute("UPDATE `twitter_accounts` SET `username`= @newUsername WHERE identifier = @identifier", {
            ['@identifier'] = identifier,
            ['@newUsername'] = newUsername
        }, function(result)
            if (result == 1) then
                TriggerClientEvent('gcPhone:twitter_setAccount', sourcePlayer, newUsername, user.authorIcon)
            end
        end)
    end)
end)

RegisterServerEvent('gcPhone:twitter_setAvatarUrl')
AddEventHandler('gcPhone:twitter_setAvatarUrl', function(avatarUrl)
    local sourcePlayer = tonumber(source)
    local identifier = getPlayerID(source)
    getUser(identifier, function(user)
        MySQL.Async.execute("UPDATE `twitter_accounts` SET `avatar_url`= @avatarUrl WHERE identifier = @identifier", {
            ['@identifier'] = identifier,
            ['@avatarUrl'] = avatarUrl
        }, function(result)
            if (result == 1) then
                TriggerClientEvent('gcPhone:twitter_setAccount', sourcePlayer, user.author, avatarUrl)
            end
        end)
    end)
end)


RegisterServerEvent('gcPhone:twitter_getTweets')
AddEventHandler('gcPhone:twitter_getTweets', function()
    local sourcePlayer = tonumber(source)
    if username ~= nil and username ~= "" and password ~= nil and password ~= "" then
        getUser(username, password, function(user)
            local accountId = user and user.id
            TwitterGetTweets(accountId, function(tweets)
                TriggerClientEvent('gcPhone:twitter_getTweets', sourcePlayer, tweets)
            end)
        end)
    else
        TwitterGetTweets(nil, function(tweets)
            TriggerClientEvent('gcPhone:twitter_getTweets', sourcePlayer, tweets)
        end)
    end
end)

RegisterServerEvent('gcPhone:twitter_getFavoriteTweets')
AddEventHandler('gcPhone:twitter_getFavoriteTweets', function()
    local sourcePlayer = tonumber(source)
    local srcIdentifier = getPlayerID(source)
    TwitterGetFavotireTweets(srcIdentifier, function(tweets)
        TriggerClientEvent('gcPhone:twitter_getFavoriteTweets', sourcePlayer, tweets)
    end)
end)

RegisterServerEvent('gcPhone:twitter_postTweets')
AddEventHandler('gcPhone:twitter_postTweets', function(message, image)
    local sourcePlayer = tonumber(source)
    local srcIdentifier = getPlayerID(source)
    TwitterPostTweet(message, image, sourcePlayer, srcIdentifier)
end)

RegisterServerEvent('gcPhone:twitter_toogleLikeTweet')
AddEventHandler('gcPhone:twitter_toogleLikeTweet', function(tweetId)
    local sourcePlayer = tonumber(source)
    local srcIdentifier = getPlayerID(source)
    TwitterToogleLike(srcIdentifier, tweetId, sourcePlayer)
end)

RegisterServerEvent('gcPhone:twitter_toggleDeleteTweet')
AddEventHandler('gcPhone:twitter_toggleDeleteTweet', function(tweetId)
    local sourcePlayer = tonumber(source)
    local srcIdentifier = getPlayerID(source)
    TwitterToogleDelete(srcIdentifier, tweetId, sourcePlayer)
end)


--[[
Discord WebHook
set discord_webhook 'https//....' in config.cfg
--]]
function sendDiscordTwitter(tweet)
    local discord_webhook = GetConvar('twitter_discord_webhook', '')
    if discord_webhook == '' then
        return
    end
    local headers = {
        ['Content-Type'] = 'application/json'
    }
    local data = {
        ["username"] = tweet.author,
        ["embeds"] = {{
            ["thumbnail"] = {
                ["url"] = tweet.authorIcon
            },
            ["color"] = 1942002
        }}
    }
    if tweet.image ~= "" then
        data['embeds'][1]['image'] = {['url'] = tweet.image}
    end
    tweet.message = tweet.message:gsub("{{{", ":")
    tweet.message = tweet.message:gsub("}}}", ":")
    data['embeds'][1]['description'] = tweet.message
    PerformHttpRequest(discord_webhook, function(err, text, headers) end, 'POST', json.encode(data), headers)
end
