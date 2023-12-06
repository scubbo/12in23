local Character = {}

local function ability(scores)
  table.sort(scores, function(a, b) return a > b end)
  return scores[1] + scores[2] + scores[3]
end

local function roll_dice()
  local output = {}

  math.randomseed(os.time())
  for i=1, 4 do
    table.insert(output, math.random(1, 6))
  end
  return output
end

local function modifier(input)
  return math.floor((input-10)//2)
end

function Character:new(name)
  local output = {}
  output.name = name 
  output.strength = ability(roll_dice())
  output.dexterity = ability(roll_dice())
  local con = ability(roll_dice())
  output.constitution = con
  output.hitpoints = 10 + modifier(con)

  output.intelligence = ability(roll_dice())
  output.wisdom = ability(roll_dice())
  output.charisma = ability(roll_dice())
  return output
end

return {
  Character = Character,
  ability = ability,
  roll_dice = roll_dice,
  modifier = modifier
}
